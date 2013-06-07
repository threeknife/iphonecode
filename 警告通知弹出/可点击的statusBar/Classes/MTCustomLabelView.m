//
//  MTCustomLabelView.m
//  PetFone_EnterPrise_iPhone
//
//  Created by  apple on 11-7-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MTCustomLabelView.h"


@implementation MTCustomLabelView
@synthesize delegate;
@synthesize m_businessData;


//

- (void)dealloc {
    
    self.delegate = nil;
    self.m_businessData = nil;
    
    [super dealloc];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.delegate != nil && [(id)self.delegate respondsToSelector:@selector(didClickOnLabel:)]) {
        [self.delegate didClickOnLabel:self];
    }
}
@end
