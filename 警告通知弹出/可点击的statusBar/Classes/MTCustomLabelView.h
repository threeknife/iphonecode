//
//  MTCustomLabelView.h
//  PetFone_EnterPrise_iPhone
//
//  Created by  apple on 11-7-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol MTCustomLabelViewDelegate;

@interface MTCustomLabelView : UILabel {
    id<MTCustomLabelViewDelegate>   delegate;
    
    
    NSMutableDictionary             *m_businessData;     //保存业务数据对象。

}
@property (nonatomic, retain)   id<MTCustomLabelViewDelegate>   delegate;
@property (nonatomic, retain)   NSMutableDictionary             *m_businessData;


@end


@protocol MTCustomLabelViewDelegate

@optional
-(void)didClickOnLabel:(MTCustomLabelView*)label;

@end

