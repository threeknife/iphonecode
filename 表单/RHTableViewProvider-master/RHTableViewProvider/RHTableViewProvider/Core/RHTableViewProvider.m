//
//  RHTableProvider.m
//  RHKit
//
//  Created by Rob Hayward on 11/01/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "RHTableViewProvider.h"
#import "RHTableViewProviderCell.h"
#import "RHTableViewProviderRefreshView.h"
#import "RHTableViewProviderSection.h"
#import "NSDictionary+RHTVP.h"

NSString *const RHTableViewProviderSectionHeader = @"RHTableViewProviderSectionHeader";
NSString *const RHTableViewProviderSectionFooter = @"RHTableViewProviderSectionFooter";
NSString *const RHTableViewProviderSectionRows = @"RHTableViewProviderSectionRows";

@interface RHTableViewProvider ()
{
  BOOL _hasSections;
  NSInteger _totalItems;
}
@property (strong, nonatomic) NSMutableArray *content;

@end

@implementation RHTableViewProvider

+ (UITableView *)tableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style forSuperView:(UIView *)view
{
  UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
  [view addSubview:tableView];
  return tableView;
}

- (id)initWithTableView:(UITableView *)aTableView delegate:(id<RHTableViewProviderDelegate>)aDelegate
{
  self = [self initWithTableView:aTableView delegate:aDelegate customise:NO];
  if (self) { }
  return self;
}

- (id)initWithTableView:(UITableView *)aTableView delegate:(id<RHTableViewProviderDelegate>)aDelegate customise:(BOOL)customise
{
  self = [super init];
  if (self)
  {
    NSParameterAssert(aTableView);
    NSParameterAssert(aDelegate);
    [self setTableView:aTableView];
    [self setDelegate:aDelegate];
    [self setShouldDrawCustomViews:customise];
    [self setup];
  }
  return self;
}

#pragma mark - Getters

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
  id object = nil;
  
  if (self.fetchedResultsController)
  {
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
  }
  
  NSDictionary *section = [self.content objectAtIndex:indexPath.section];
  NSArray *rows = [section valueForKey:RHTableViewProviderSectionRows];
  object = [rows objectAtIndex:indexPath.row];
  return object;
}

- (id)objectForSectionAtIndex:(NSInteger)index header:(BOOL)header
{
  if (self.fetchedResultsController)
  {
    if (header)
    {
      id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:index];
      return [sectionInfo name];
    }
    return nil;
  }
  
  NSDictionary *section = [self.content objectAtIndex:index];
  if (header) {
    return [section objectForKeyNotNull:RHTableViewProviderSectionHeader];
  }
  return [section objectForKeyNotNull:RHTableViewProviderSectionFooter];
}

- (NSIndexPath *)indexPathOfFirstRow
{
  return [NSIndexPath indexPathForItem:0 inSection:0];
}

- (NSIndexPath *)indexPathOfLastRow
{
  if (_indexPathOfLastRow != nil) {
    return _indexPathOfLastRow;
  }
  
  NSInteger section = [self.content count];
  if (section > 0) { section -= 1; }
  NSInteger count = [[[self.content objectAtIndex:section] objectForKey:RHTableViewProviderSectionRows] count];
  if (count > 1) { count -= 1; }
  self.indexPathOfLastRow = [NSIndexPath indexPathForItem:count inSection:section];
  return _indexPathOfLastRow;
}

- (BOOL)isIndexPathFirstRowOfSection:(NSIndexPath *)indexPath
{
  if (indexPath.row == 0) { return YES; }
  return NO;
}

- (BOOL)isIndexPathLastRowOfSection:(NSIndexPath *)indexPath
{
  if (self.fetchedResultsController) {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:indexPath.section];
    NSInteger count = [sectionInfo numberOfObjects];
    if (indexPath.row == (count - 1)) { return YES; }
    return NO;
  }
  
  NSInteger count = [[[self.content objectAtIndex:indexPath.section] objectForKey:RHTableViewProviderSectionRows] count];
  if (indexPath.row == (count - 1)) { return YES; }
  return NO;
}

- (BOOL)isCellSingleInSectionForIndexPath:(NSIndexPath *)indexPath
{
  if (self.fetchedResultsController) {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:indexPath.section];
    NSInteger count = [sectionInfo numberOfObjects];
    if (count > 1) {
      return NO;
    }
    return YES;
  }
  
  NSInteger count = [[[self.content objectAtIndex:indexPath.section] objectForKey:RHTableViewProviderSectionRows] count];
  if (count > 1) {
    return NO;
  }
  return YES;
}

- (CGFloat)cellWidth
{
  if (!self.tableView.style == UITableViewStyleGrouped) { return self.tableView.frame.size.width; }
  else
  {
    return (self.tableView.frame.size.width - ((self.tableView.frame.size.width * GROUPED_CELL_WIDTH_MULTIPLIER) * 2));
  }
}

- (NSMutableArray *)contentWithSections:(NSArray *)theContent
{
  NSMutableArray *mutable = [NSMutableArray arrayWithCapacity:0];
  NSMutableDictionary *section = [NSMutableDictionary dictionaryWithCapacity:0];
  [section setObject:[theContent mutableCopy] forKey:RHTableViewProviderSectionRows];
  [mutable addObject:section];
  return mutable;
}

#pragma mark - Delete

- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath
{
  if (self.fetchedResultsController)
  {
    id object = [self objectAtIndexPath:indexPath];
    [self.context deleteObject:object];
    return;
  }
  NSMutableDictionary *section =  [NSMutableDictionary dictionaryWithDictionary:[self.content objectAtIndex:indexPath.section]];
  NSMutableArray *rows = [NSMutableArray arrayWithArray:[section valueForKey:RHTableViewProviderSectionRows]];
  id object = [rows objectAtIndex:indexPath.row];
  if (object) {
    [rows removeObjectAtIndex:indexPath.row];
  }
  [section setValue:rows forKey:RHTableViewProviderSectionRows];
  [self.content replaceObjectAtIndex:indexPath.section withObject:section];
}

#pragma mark - Setters

- (void)setContent:(NSArray *)theContent withSections:(BOOL)sections
{
  _hasSections = sections;
  
  if (theContent == nil)
  {
    self.content = [NSMutableArray arrayWithCapacity:0];
  }
  else
  {
    if (_hasSections) {
      self.content = [theContent mutableCopy];
    } else {
      self.content = [self contentWithSections:theContent];
    }
  }
  [self reload];
}

- (void)setContentWithFetchRequest:(NSFetchRequest *)aFetchRequest context:(NSManagedObjectContext *)aContext
{
  [self setContentWithFetchRequest:aFetchRequest sectionKeyPath:nil context:aContext];
}

- (void)setContentWithFetchRequest:(NSFetchRequest *)aFetchRequest sectionKeyPath:(NSString *)keyPath context:(NSManagedObjectContext *)aContext
{
  self.fetchRequest = aFetchRequest;
  self.context = aContext;
  self.fetchedResultsController = nil;
  self.sectionKeyPath = keyPath;
  if (self.sectionKeyPath) { _hasSections = YES; } else { _hasSections = NO; }
  
  NSError *error = nil;
  
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);
	}
  
  [self reload];
}

#pragma mark - Total Items Count

- (void)updateTotalItems
{
  _totalItems = [self totalItemsCount];
}

- (NSInteger)totalItemsCount
{
  if (self.fetchedResultsController)
  {
    return [[self.fetchedResultsController fetchedObjects] count];
  }
  
  NSInteger count = 0;
  
  for (NSDictionary *section in self.content) {
    count += [[section valueForKey:RHTableViewProviderSectionRows] count];
  }
  
  return count;
}

- (BOOL)hasContent {
  
  if (self.fetchedResultsController)
  {
    if ([[self.fetchedResultsController fetchedObjects] count] > 0) {
      return YES;
    }
    return NO;
  }
  
  if (self.content) {
    if ([self.content count] > 0) {
      return YES;
    }
  }
  
  return NO;
}

#pragma mark - Reload

- (void)reload
{
  self.indexPathOfLastRow = nil;
  
  BOOL hasContent = [self hasContent];
  if (hasContent) {
    [self displayWithData];
    [self updateTotalItems];
    [self.tableView reloadData];
  } else {
    [self displayWithoutData];
  }
}

- (void)reloadVisibleCells
{
  NSArray *visibleCells = self.tableView.visibleCells;
  for (RHTableViewProviderCell *cell in visibleCells)
  {
    id object = [self objectAtIndexPath:cell.indexPath];
    [cell populateWithObject:object];
  }
}

#pragma mark - Display State

- (void)displayWithData
{
  [self.emptyView setHidden:YES];
  [self.tableView setHidden:NO];
}

- (void)displayWithoutData
{
  [self.tableView setHidden:YES];
  [self.emptyView setHidden:NO];
}

- (Class)tableCellClassForContentOption {
  
  return [RHTableViewProviderCell class];
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Subclass the provider to implement this functionality
  return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSInteger count = 0;
  if (self.fetchedResultsController)
  {
    id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    count = [sectionInfo numberOfObjects];
    return count;
  }
  
  NSMutableDictionary *sectionContent = [self.content objectAtIndex:section];
  count = [[sectionContent valueForKey:RHTableViewProviderSectionRows] count];
  return count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  NSInteger count = 0;
  if (self.fetchedResultsController)
  {
    count = [[self.fetchedResultsController sections] count];
    return count;
  }
  count = [self.content count];
  return count;
}

- (CGFloat)heightForSectionAtIndex:(NSInteger)index header:(BOOL)header
{
  CGFloat height = 0.0f;
  
  if (_hasSections) { height = self.defaultSectionHeight; }
  
  Class viewClass = [self tableSectionViewClassForSection:index header:header];
  if (viewClass)
  { return [viewClass height]; }
  else
  {
    id object = [self objectForSectionAtIndex:index header:header];
    if (!object) { height = 0.0f; }
  }
  return height;
}

#pragma mark - Sections

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return [self heightForSectionAtIndex:section header:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
  return [self heightForSectionAtIndex:section header:NO];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
  return self.sectionIndexTitles;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  if (self.fetchedResultsController) { return nil; } // TODO.. Implement!
  return [self objectForSectionAtIndex:section header:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
  if (self.fetchedResultsController) { return nil; } // TODO.. Implement!
  return [self objectForSectionAtIndex:section header:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  Class viewClass = [self tableSectionViewClassForSection:section header:YES];
  if (!viewClass) {
    return nil;
  }
  id <RHTableViewProviderSection> view = [[viewClass alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, [viewClass height])];
  
  id object = [self objectForSectionAtIndex:section header:YES];
  [view populateWithObject:object];
  
  return (UIView *)view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
  Class viewClass = [self tableSectionViewClassForSection:section header:NO];
  if (!viewClass) {
    return nil;
  }
  id <RHTableViewProviderSection> view = [[viewClass alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, [viewClass height])];
  
  id object = [self objectForSectionAtIndex:section header:NO];
  [view populateWithObject:object];
  
  return (UIView *)view;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
  if ([view conformsToProtocol:@protocol(RHTableViewProviderSection)]) {
    [(id <RHTableViewProviderSection>)view willDisplay];
  }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
  if ([view conformsToProtocol:@protocol(RHTableViewProviderSection)]) {
    [(id <RHTableViewProviderSection>)view willDisplay];
  }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
  if ([view conformsToProtocol:@protocol(RHTableViewProviderSection)]) {
    [(id <RHTableViewProviderSection>)view didEndDisplay];
  }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
  if ([view conformsToProtocol:@protocol(RHTableViewProviderSection)]) {
    [(id <RHTableViewProviderSection>)view didEndDisplay];
  }
}

#pragma mark - Rows

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  CGFloat height = 44.0f;
  if (_shouldDrawCustomViews)
  {
    height = [[self tableCellClassForRowAtIndexPath:indexPath] height];
  }
  return height;
}

#pragma mark - Cells

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ([cell isKindOfClass:[RHTableViewProviderCell class]])
  {
    [(RHTableViewProviderCell *)cell willDisplay];
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  id object = [self objectAtIndexPath:indexPath];
  Class cellClass = [self tableCellClassForRowAtIndexPath:indexPath];
  NSString *identifier = NSStringFromClass(cellClass);
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil) {
    cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  
  if ([cell isKindOfClass:[RHTableViewProviderCell class]])
  {
    [(RHTableViewProviderCell *)cell setParentTableView:_tableView];
    [(RHTableViewProviderCell *)cell setupView];
    
    if      ([self isCellSingleInSectionForIndexPath:indexPath]) { [(RHTableViewProviderCell *)cell setCellType:RHTableViewProviderCellTypeSingle]; }
    else if ([self isIndexPathFirstRowOfSection:indexPath]) { [(RHTableViewProviderCell *)cell setCellType:RHTableViewProviderCellTypeFirst]; }
    else if ([self isIndexPathLastRowOfSection:indexPath]) { [(RHTableViewProviderCell *)cell setCellType:RHTableViewProviderCellTypeLast]; }
    else {  [(RHTableViewProviderCell *)cell setCellType:RHTableViewProviderCellTypeMiddle]; }
    
    if (self.tableView.style == UITableViewStyleGrouped) { [(RHTableViewProviderCell *)cell group]; }
    else { [(RHTableViewProviderCell *)cell unGroup]; }
    
    [(RHTableViewProviderCell *)cell setCornerRadius:self.groupedCellCornerRadius];
    [(RHTableViewProviderCell *)cell setIndexPath:indexPath];
    [(RHTableViewProviderCell *)cell populateWithObject:object];
  }
  else
  {
    cell.textLabel.text = object;
  }
  
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Subclass the provider to implement this functionality
  return 0;
}

#pragma mark - Row Selection

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Subclass the provider to implement this functionality
  return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  if ([self.delegate respondsToSelector:@selector(RHTableViewProvider:didSelectRowAtIndexPath:)])
  {
    [self.delegate RHTableViewProvider:self didSelectRowAtIndexPath:indexPath];
  }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Subclass the provider to implement this functionality
  return indexPath;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Subclass the provider to implement this functionality
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
  [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - Row Highlight

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Subclass the provider to implement this functionality
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Subclass the provider to implement this functionality
}

#pragma mark - Custom Views

- (Class)tableCellClassForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (!_shouldDrawCustomViews) { return [UITableViewCell class]; }
  
  NSString *name = nil;
  if ([self.delegate respondsToSelector:@selector(tableCellClassForRowAtIndexPath:)]) {
    name = [self.delegate tableCellClassForRowAtIndexPath:indexPath];
  }
  if (name == nil)
  {
    if (self.tableView.style == UITableViewStyleGrouped) {
      name = self.defaultGroupedCellClassName;
    } else { name = self.defaultCellClassName; }
  }
  return NSClassFromString(name);
}

- (Class)tableSectionViewClassForSection:(NSInteger)section header:(BOOL)header
{
  if (!_shouldDrawCustomViews) { return nil; }
  
  id object = [self objectForSectionAtIndex:section header:header];
  if (!object) {
    return nil;
  }
  
  NSString *name = nil;
  
  if (header)
  {
    if (self.tableView.style == UITableViewStylePlain) { name = self.defaultSectionHeaderViewClassName; }
    else { name = name = self.defaultGroupedSectionHeaderViewClassName; }
    
    if ([self.delegate respondsToSelector:@selector(tableSectionHeaderViewClassForSection:)])
    {
      name = [self.delegate tableSectionHeaderViewClassForSection:section];
    }
  }
  else
  {
    if (self.tableView.style == UITableViewStylePlain) { name = self.defaultSectionFooterViewClassName; }
    else { name = name = self.defaultGroupedSectionFooterViewClassName; }
    
    if ([self.delegate respondsToSelector:@selector(tableSectionFooterViewClassForSection:)]) {
      name = [self.delegate tableSectionFooterViewClassForSection:section];
    }
  }
  
  if (name != nil) {
    return NSClassFromString(name);
  }
  
  return nil;
}

#pragma mark - PullToRefresh

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  CGFloat contentOffsetY = scrollView.contentOffset.y;
  if (contentOffsetY < -self.pullToRefreshDistance) {
    if (self.shouldPullToRefresh) {
      [self pullToRefresh];
    }
  }
}

- (void)pullToRefresh
{
  if (!self.pullToRefreshView)
  {
    self.pullToRefreshView = [[RHTableViewProviderRefreshView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.pullToRefreshDistance)];
  }
  
  if (_pullToRefreshTimer) { [_pullToRefreshTimer invalidate]; }
  
  [[(UIViewController *)self.delegate view] addSubview:self.pullToRefreshView];
  
  [UIView animateWithDuration:0.25 animations:^{
    
    [self.tableView setFrame:CGRectMake(0.0f, self.pullToRefreshDistance, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
    
  } completion:^(BOOL finished) {
    
    self.pullToRefreshTimer = [NSTimer scheduledTimerWithTimeInterval:self.pullToRefreshTimeout target:self selector:@selector(pullToRefreshCancel) userInfo:nil repeats:NO];
  }];
  
  if ([self.delegate respondsToSelector:@selector(RHTableViewProviderDidPullToRefresh:)]) {
    [self.delegate RHTableViewProviderDidPullToRefresh:self];
  }
}

- (void)pullToRefreshCancel
{
  [_pullToRefreshView removeFromSuperview];
  [_pullToRefreshTimer invalidate];
  
  [UIView animateWithDuration:0.25 animations: ^{
    [self.tableView setFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
  } completion:nil];
  if ([self.delegate respondsToSelector:@selector(RHTableViewProviderDidCancelPullToRefresh:)]) {
    [self.delegate RHTableViewProviderDidCancelPullToRefresh:self];
  }
}

- (void)pullToRefreshComplete
{
  [self.pullToRefreshView removeFromSuperview];
  [UIView animateWithDuration:0.25 animations:^{
    [self.tableView setFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
  } completion:nil];
}

#pragma mark - Core Data

- (NSFetchedResultsController *)fetchedResultsController
{
  if (self.fetchRequest == nil) { return nil; }
  if (_fetchedResultsController != nil) { return _fetchedResultsController; }
  
  NSString *cacheName = nil;
  NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest managedObjectContext:self.context sectionNameKeyPath:self.sectionKeyPath cacheName:cacheName];
  self.fetchedResultsController = theFetchedResultsController;
  self.fetchedResultsController.delegate = self;
  
  return _fetchedResultsController;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
  // Subclass the provider to implement this functionality
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
  // Subclass the provider to implement this functionality
}

#pragma mark - Setup

- (void)setup
{
  [self setupTableView];
  [self setupDefaults];
}

- (void)setupTableView
{
  [_tableView setDataSource:self];
  [_tableView setDelegate:self];
  [_tableView setTableFooterView:[UIView new]];
  if (_shouldDrawCustomViews) {
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  }
}

- (void)setupDefaults
{
  self.pullToRefreshDistance = 70.0f;
  self.pullToRefreshTimeout = 10.0f;
  self.defaultSectionHeight = 30.0f;
  self.groupedCellCornerRadius = 10.0f;
  self.defaultCellClassName = @"RHTableViewProviderCellDefault";
  self.defaultGroupedCellClassName = @"RHTableViewProviderCellGroupedDefault";
  self.defaultSectionHeaderViewClassName = @"RHTableViewProviderSectionViewDefault";
  self.defaultSectionFooterViewClassName = @"RHTableViewProviderSectionViewDefault";
  self.defaultGroupedSectionHeaderViewClassName = @"RHTableViewProviderSectionViewGroupedDefault";
  self.defaultGroupedSectionFooterViewClassName = @"RHTableViewProviderSectionViewGroupedDefault";
}

@end
