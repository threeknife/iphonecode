//
//  GLView.h
//  OpenGLES_Class_01_Demo_01
//
//  Created by cai xuejun on 12-8-23.
//  Copyright (c) 2012年 caixuejun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface GLView : UIView
{
    CAEAGLLayer *_eaglLayer;// OpenGL层，这是用来渲染显示等等的
    EAGLContext *_context;// 环境上下文
    
    GLuint viewRenderbuffer;// 渲染缓冲区
    GLuint viewFramebuffer;// 帧缓冲区
    GLuint depthRenderbuffer;// 深度缓冲区，启用这个缓冲是让图像具有3D的效果
}

@end
