//
//  Created by Matt Greenfield on 24/05/12
//  Copyright (c) 2012 Big Paua. All rights reserved
//  http://bigpaua.com/
//

#import "ViewController.h"
#import "MGScrollView.h"
#import "MGStyledBox.h"
#import "MGBoxLine.h"

#define ANIM_SPEED 0.6

@implementation ViewController {
    MGScrollView *scroller;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // sue me, Gruber!
    self.view.backgroundColor =
            [UIColor colorWithRed:0.29 green:0.32 blue:0.35 alpha:1];

    UIFont *headerFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];

    // make an MGScrollView for holding boxes
    CGRect frame = CGRectMake(0, 0, 320, 460);
    scroller = [[MGScrollView alloc] initWithFrame:frame];
    [self.view addSubview:scroller];
    scroller.alwaysBounceVertical = YES;
    scroller.delegate = self;

    // add a moveable box
    [self addBox:nil];

    // add a new MGBox to the MGScrollView
    MGStyledBox *box1 = [MGStyledBox box];
    [scroller.boxes addObject:box1];

    // add some MGBoxLines to the box
    MGBoxLine *head1 =
            [MGBoxLine lineWithLeft:@"Left And Right Content" right:nil];
    head1.font = headerFont;
    [box1.topLines addObject:head1];

    UISwitch *toggle = [[UISwitch alloc] initWithFrame:CGRectZero];
    toggle.on = YES;
    MGBoxLine *line1 =
            [MGBoxLine lineWithLeft:@"NSString and UISwitch" right:toggle];
    [box1.topLines addObject:line1];

    MGStyledBox *box2 = [MGStyledBox box];
    [scroller.boxes addObject:box2];

    MGBoxLine *head2 = [MGBoxLine lineWithLeft:@"Multiline Content" right:nil];
    head2.font = headerFont;
    [box2.topLines addObject:head2];

    NSString *blah = @"Multiline content is automatically sized and formatted "
            "given an NSString, UIFont, and desired padding.";
    MGBoxLine *multi = [MGBoxLine multilineWithText:blah font:nil padding:24];
    [box2.topLines addObject:multi];

    MGStyledBox *box3 = [MGStyledBox box];
    [scroller.boxes addObject:box3];

    MGBoxLine *head3 =
            [MGBoxLine lineWithLeft:@"NSStrings, UIImages, and UIViews"
                    right:nil];
    head3.font = headerFont;
    [box3.topLines addObject:head3];

    NSString *lineContentWords =
            @"Content can be arbitrary arrays of elements.\n\n"
                    "UIImages are automatically wrapped in UIImageViews and "
                    "NSStrings are automatically wrapped in UILabels.\n\n"
                    "Content elements are automatically laid out "
                    "according to the line's itemPadding and "
                    "linePadding property values.";
    MGBoxLine *wordsLine =
            [MGBoxLine multilineWithText:lineContentWords font:nil padding:24];
    [box3.topLines addObject:wordsLine];

    UIImage *img = [UIImage imageNamed:@"home"];
    NSArray *imgLineLeft =
            [NSArray arrayWithObjects:img, @"An NSString after a UIImage", nil];
    MGBoxLine *imgLine = [MGBoxLine lineWithLeft:imgLineLeft right:nil];
    [box3.topLines addObject:imgLine];

    // draw all the boxes and animate as appropriate
    [scroller drawBoxesWithSpeed:ANIM_SPEED];
    [scroller flashScrollIndicators];
}

- (void)addBox:(UIButton *)sender {
    MGStyledBox *box = [MGStyledBox box];
    MGBox *parentBox = [self parentBoxOf:sender];
    if (parentBox) {
        int i = [scroller.boxes indexOfObject:parentBox];
        [scroller.boxes insertObject:box atIndex:i + 1];
    } else {
        [scroller.boxes addObject:box];
    }

    UIButton *up = [self button:@"up" for:@selector(moveUp:)];
    UIButton *down = [self button:@"down" for:@selector(moveDown:)];
    UIButton *add = [self button:@"add" for:@selector(addBox:)];
    UIButton *remove = [self button:@"remove" for:@selector(removeBox:)];
    UIButton *shuffle = [self button:@"shuffle" for:@selector(shuffle)];

    NSArray *left = [NSArray arrayWithObjects:up, down, nil];
    NSArray *right = [NSArray arrayWithObjects:shuffle, remove, add, nil];

    MGBoxLine *line = [MGBoxLine lineWithLeft:left right:right];
    [box.topLines addObject:line];

    [scroller drawBoxesWithSpeed:ANIM_SPEED];
    [scroller flashScrollIndicators];
}

- (void)removeBox:(UIButton *)sender {
    MGBox *parentBox = [self parentBoxOf:sender];
    [scroller.boxes removeObject:parentBox];
    [scroller drawBoxesWithSpeed:ANIM_SPEED];
}

- (void)moveUp:(UIButton *)sender {
    MGBox *parentBox = [self parentBoxOf:sender];
    int i = [scroller.boxes indexOfObject:parentBox];
    if (!i) {
        return;
    }
    [scroller.boxes removeObject:parentBox];
    [scroller.boxes insertObject:parentBox atIndex:i - 1];
    [scroller drawBoxesWithSpeed:ANIM_SPEED];
}

- (void)moveDown:(UIButton *)sender {
    MGBox *parentBox = [self parentBoxOf:sender];
    int i = [scroller.boxes indexOfObject:parentBox];
    if (i == [scroller.boxes count] - 1) {
        return;
    }
    [scroller.boxes removeObject:parentBox];
    [scroller.boxes insertObject:parentBox atIndex:i + 1];
    [scroller drawBoxesWithSpeed:ANIM_SPEED];
}

- (MGBox *)parentBoxOf:(UIView *)view {
    while (![view.superview isKindOfClass:[MGBox class]]) {
        if (!view.superview) {
            return nil;
        }
        view = view.superview;
    }
    return (MGBox *)view.superview;
}

- (UIButton *)button:(NSString *)title for:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [button setTitleColor:[UIColor colorWithWhite:0.9 alpha:0.9]
            forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithWhite:0.2 alpha:0.9]
            forState:UIControlStateNormal];
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);
    CGSize size = [title sizeWithFont:button.titleLabel.font];
    button.frame = CGRectMake(0, 0, size.width + 18, 26);
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:selector
            forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 3;
    button.backgroundColor = self.view.backgroundColor;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0, 1);
    button.layer.shadowRadius = 0.8;
    button.layer.shadowOpacity = 0.6;
    return button;
}

- (void)shuffle {
    NSMutableArray *shuffled =
            [NSMutableArray arrayWithCapacity:[scroller.boxes count]];
    for (id box in scroller.boxes) {
        int i = arc4random() % ([shuffled count] + 1);
        [shuffled insertObject:box atIndex:i];
    }
    scroller.boxes = shuffled;
    [scroller drawBoxesWithSpeed:ANIM_SPEED];
}

#pragma mark - UIScrollViewDelegate (for snapping boxes to edges)

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [(MGScrollView *)scrollView snapToNearestBox];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [(MGScrollView *)scrollView snapToNearestBox];
    }
}

@end
