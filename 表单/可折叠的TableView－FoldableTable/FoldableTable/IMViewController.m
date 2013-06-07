//
//  IMViewController.m
//  FoldableTable
//
//  Created by huogh on 12-12-26.
//  Copyright (c) 2012年 infomedia. All rights reserved.
//

#import "IMViewController.h"


#define IMRowHeight     44
#define IMRowSubHeight  120

@interface IMItem : NSObject
{
    NSString            *_title;
    NSString            *_subTitle;
    BOOL                _isOpen;
}

@property (nonatomic, strong)   NSString    *title;
@property (nonatomic, strong)   NSString    *subTitle;
@property (nonatomic, assign)   BOOL        isOpen;

@end

@implementation IMItem
@synthesize title = _title;
@synthesize subTitle = _subTitle;
@synthesize isOpen = _isOpen;

- (id)init {
    self = [super init];
    if (self) {
        _isOpen = NO;
    }
    
    return self;
}

@end

@interface IMRowView : UIView
{
    UILabel     *_titleLabel;
    UILabel     *_subTitleLabel;
    BOOL        _isOpen;
    
    IMItem      *_item;
}
@property (nonatomic, assign)   BOOL    isOpen;
@property (nonatomic, strong)   IMItem  *item;
@end

@implementation IMRowView
@synthesize isOpen = _isOpen;
@synthesize item = _item;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
    }
    
    return self;
}

- (void)setIsOpen:(BOOL)isOpen {
    _isOpen = isOpen;
    if (_isOpen) {
        if (_subTitleLabel == nil) {
            _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, IMRowHeight, self.bounds.size.width, IMRowSubHeight)];
            _subTitleLabel.backgroundColor = [UIColor lightGrayColor];
            _subTitleLabel.textColor = [UIColor purpleColor];
            _subTitleLabel.textAlignment = UITextAlignmentCenter;
            _subTitleLabel.font = [UIFont systemFontOfSize:40];
        }
        
        _titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, IMRowHeight);
        
        if (_subTitleLabel.superview == nil) {
            [self addSubview:_subTitleLabel];
        }
    }
    else {
        _titleLabel.frame = self.bounds;
        if (_subTitleLabel.superview) {
            [_subTitleLabel removeFromSuperview];
        }
    }
}

- (void)setItem:(IMItem *)item {
    _item = item;
    self.isOpen = item.isOpen;
    _titleLabel.text = item.title;
    _subTitleLabel.text = item.subTitle;
}

@end

@interface IMViewController ()

@end

@implementation IMViewController
{
    NSIndexPath     *_opendIndexPath;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _dataArray = [[NSMutableArray alloc] init];
    IMItem *item = nil;
    for (int i = 1; i <= 20; i++) {
        item = [[IMItem alloc] init];
        item.title = [NSString stringWithFormat:@"title:%d", i];
        item.subTitle = [NSString stringWithFormat:@"subTitle:%d", i];
        [_dataArray addObject:item];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height-44) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reusedCellID = @"reusedCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedCellID];
    IMRowView *rowView = nil;
    IMItem *item = [_dataArray objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        rowView = [[IMRowView alloc] initWithFrame:CGRectMake(0, 0, 320, item.isOpen?IMRowHeight+IMRowSubHeight:IMRowHeight)];
        rowView.tag = 2012;
        [cell.contentView addSubview:rowView];
    }
    
    rowView = (IMRowView*)[cell.contentView viewWithTag:2012];
    rowView.frame = CGRectMake(0, 0, 320, item.isOpen?IMRowHeight+IMRowSubHeight:IMRowHeight);
    rowView.item = item;
    
    return cell;
}

#pragma mark - UITableViewDelegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    IMItem *item = [_dataArray objectAtIndex:indexPath.row];
    return item.isOpen?IMRowHeight+IMRowSubHeight:IMRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    IMItem *item = nil;
    if (_opendIndexPath) {
        if (_opendIndexPath.row == indexPath.row) {
            item = [_dataArray objectAtIndex:_opendIndexPath.row];
            item.isOpen = NO;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_opendIndexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            _opendIndexPath = nil;
        }
        else {
            item = [_dataArray objectAtIndex:_opendIndexPath.row];
            item.isOpen = NO;
            item = [_dataArray objectAtIndex:indexPath.row];
            item.isOpen = YES;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_opendIndexPath, indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            _opendIndexPath = indexPath;
        }
    }
    else {
        item = [_dataArray objectAtIndex:indexPath.row];
        item.isOpen = YES;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        _opendIndexPath = indexPath;
    }
    
}

@end
