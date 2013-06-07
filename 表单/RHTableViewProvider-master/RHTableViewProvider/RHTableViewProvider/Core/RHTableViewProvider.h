//
//  RHTableViewProvider.h
//  RHTableViewProvider
//
//  Created by Rob Hayward on 11/01/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import "RHTableViewProviderDelegate.h"
#import "RHTableViewProviderCell.h"

#import "RHTableViewProviderSectionViewDefault.h"
#import "RHTableViewProviderSectionViewGroupedDefault.h"
#import "RHTableViewProviderCellGroupedDefault.h"
#import "RHTableViewProviderEmptyViewDefault.h"
#import "RHTableViewProviderCellDefault.h"

#define GROUPED_CELL_WIDTH_MULTIPLIER 0.03f

extern NSString *const RHTableViewProviderSectionHeader;
extern NSString *const RHTableViewProviderSectionFooter;
extern NSString *const RHTableViewProviderSectionRows;

@interface RHTableViewProvider : NSObject <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (assign, nonatomic) id <RHTableViewProviderDelegate> delegate;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *sectionIndexTitles;

@property (strong, nonatomic) UIView *emptyView;
@property (assign, nonatomic) BOOL shouldPullToRefresh;
@property (assign, nonatomic) BOOL shouldDrawCustomViews;
@property (strong, nonatomic) UIView *pullToRefreshView;
@property (assign, nonatomic) CGFloat groupedCellCornerRadius;
@property (strong, nonatomic) NSTimer *pullToRefreshTimer;

@property (assign, nonatomic) CGFloat pullToRefreshDistance;
@property (assign, nonatomic) CGFloat pullToRefreshTimeout;
@property (assign, nonatomic) CGFloat defaultSectionHeight;

@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSString *sectionKeyPath;

@property (strong, nonatomic) NSString *defaultCellClassName;
@property (strong, nonatomic) NSString *defaultGroupedCellClassName;
@property (strong, nonatomic) NSString *defaultSectionHeaderViewClassName;
@property (strong, nonatomic) NSString *defaultSectionFooterViewClassName;
@property (strong, nonatomic) NSString *defaultGroupedSectionHeaderViewClassName;
@property (strong, nonatomic) NSString *defaultGroupedSectionFooterViewClassName;

@property (strong, nonatomic) NSIndexPath *indexPathOfFirstRow;
@property (strong, nonatomic) NSIndexPath *indexPathOfLastRow;

+ (UITableView *)tableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style forSuperView:(UIView *)view;

- (id)initWithTableView:(UITableView *)aTableView delegate:(id<RHTableViewProviderDelegate>)aDelegate;
- (id)initWithTableView:(UITableView *)aTableView delegate:(id<RHTableViewProviderDelegate>)aDelegate customise:(BOOL)customise;

- (void)setup;

- (void)setContent:(NSArray *)theContent withSections:(BOOL)sections;
- (void)setContentWithFetchRequest:(NSFetchRequest *)aFetchRequest context:(NSManagedObjectContext *)aContext;
- (void)setContentWithFetchRequest:(NSFetchRequest *)aFetchRequest sectionKeyPath:(NSString *)keyPath context:(NSManagedObjectContext *)aContext;

- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath;

- (id)objectForSectionAtIndex:(NSInteger)index header:(BOOL)header;

- (Class)tableCellClassForRowAtIndexPath:(NSIndexPath *)indexPath;
- (Class)tableCellClassForContentOption;
- (Class)tableSectionViewClassForSection:(NSInteger)section header:(BOOL)header;

- (void)reload;
- (void)reloadVisibleCells;
- (void)displayWithoutData;
- (void)displayWithData;
- (BOOL)hasContent;
- (NSIndexPath *)indexPathOfFirstRow;
- (NSIndexPath *)indexPathOfLastRow;
- (BOOL)isIndexPathFirstRowOfSection:(NSIndexPath *)indexPath;
- (BOOL)isIndexPathLastRowOfSection:(NSIndexPath *)indexPath;

- (CGFloat)cellWidth;

- (void)pullToRefreshComplete;
- (void)pullToRefreshCancel;

@end
