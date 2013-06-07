//
//  GLView.m
//  OpenGLES_Class_01_Demo_01
//
//  Created by cai xuejun on 12-8-23.
//  Copyright (c) 2012年 caixuejun. All rights reserved.
//

#import "GLView.h"
#import "CSMath.h"

// 自定义宏，角度到弧度的转换
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

// 这里定义了一个结构体，用于储存顶点位置坐标（x,y,z）和颜色值（RGBA）
typedef struct{
    CGFloat Position[3];
    CGFloat Color[4];
}Vertex;

// 这是一个三角型
const Vertex Vertices[] = {
    {{0, 0.577, 0}, {1, 0, 0, 1}},
    {{0.5, 0, 0}, {0, 0, 1, 1}},
    {{-0.5, 0, 0}, {0, 1, 0, 1}},
};

// 这里存储了顶点的链接顺序，就想画几何图形一样，不同的顺序会勾勒出不同的形状
const GLubyte Indices[]= {
    0, 1, 2,
};

@implementation GLView

// 这个方法不能少，此时的层是OpenGLES层，不再是原来的层
+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 这里注意调用顺序，还是有一定的逻辑性的，当然可以灵活应用，这么安排只是一个更好的逻辑连贯性
        [self setupLayer];
        [self setupContext];
        [self setupDepthBuffer];
        [self setupRenderBuffer];
        [self setupFrameBuffer];
        [self setupVBOs];
        [self setupDisplayLink];
    }
    return self;
}

- (void)setupLayer
{
    _eaglLayer = (CAEAGLLayer *)self.layer;
    // 为了更好的性能，请设置成YES，至于为什么，很多教程上给出了很好的解释
    _eaglLayer.opaque = YES;
    // 我们设置不保存显示过的帧内容，也是为了内存考虑，记住在移动设备上，内存就和中国的地产一样宝贵
    _eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
}

- (void)setupContext
{
    // 我们这本Demo是用的1.x版本
    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    // 容错处理
    if (!_context || ![EAGLContext setCurrentContext:_context]) {
        [self release];
        return;
    }
}

// 设置渲染缓冲区
- (void)setupRenderBuffer
{
    glGenRenderbuffersOES(1, &viewRenderbuffer);// 创建一个buffer
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);// 绑定buffer
    [_context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:_eaglLayer]; // 渲染储存位置是我们的_eaglLayer
}

// 设置深度缓冲区,其实你仅仅是绘制2D图形的话，这个缓冲区可以忽略
- (void)setupDepthBuffer
{
    glGenRenderbuffersOES(1, &depthRenderbuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
    glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, self.frame.size.width, self.frame.size.height);// 这个深度缓冲是协同渲染一起工作的
}

// 设置帧缓冲区
- (void)setupFrameBuffer
{
    glGenFramebuffersOES(1, &viewFramebuffer);
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    // 渲染的时候加入颜色
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
    // 渲染的时候加入深度
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
    
    // 判断帧缓冲状态是否正常
    if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
    {
        NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return;
    }
}

- (void)setupVBOs
{
	glMatrixMode(GL_PROJECTION);
    glLoadIdentity();

    // 设置视口，一般就是我们屏幕的大小，它就是最终影像投放区域的大小
    CGRect rect = self.bounds;
	glViewport(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    
    // 切换到模型模式，接下去就是给我们的模型定型，关于对模型的操作基本上都是在这个模式下进行的
	glMatrixMode(GL_MODELVIEW);
}

// 渲染，我们没帧都要渲染一次，至于频率么根据设备，但让你也可以应用NSTimer
- (void)render:(CADisplayLink*)displayLink
{
    static CGFloat rot = 0;
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    glMatrixMode(GL_MODELVIEW);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);// 清除颜色和深度
    
    // 以下的3个函数替代glLoadIdentity();
    static Matrix3D    identityMatrix;
    Matrix3DSetIdentity(identityMatrix);
    // 加载单位矩阵
    glLoadMatrixf(identityMatrix);
    
    // 以下的2个函数替代glTranslatef(0.5, 0, 0);
    static Matrix3D    translateMatrix;
    Matrix3DSetTranslation(translateMatrix, 0.5, 0.0, 0.0);
    
    // 因为原来大小不变，这里我们把参数都设为1.0f
    static Matrix3D    scaleMatrix;
    Matrix3DSetScaling(scaleMatrix, 1, 1, 1);
    
    // 我们用一个临时矩阵来存储，移动和大小变换后的矩阵，方面进行旋转变化
    static Matrix3D     tempMatrix;
    Matrix3DMultiply(translateMatrix, scaleMatrix, tempMatrix);
    
    // 以下的2个函数替代glRotatef(rot, 0.0f, 1.0f, 0.0f);
    static Matrix3D    rotationMatrix;
    Matrix3DSetRotationByDegrees(rotationMatrix, rot, 0.0f, 1.0f, 0.0f);
    
    // 最终将临时矩阵和旋转矩阵相乘就得到我们需要的矩阵（综合了移动，比例，旋转）
    static Matrix3D    finalMatrix;
    Matrix3DMultiply(tempMatrix, rotationMatrix, finalMatrix);
    
    // 加载变换后的矩阵
    glLoadMatrixf(finalMatrix);
    
    
    glClearColor(0, 0.4, 0.2, 1);// 背景色渲染
    
    glVertexPointer(3, GL_FLOAT, sizeof(Vertex), &Vertices[0].Position);// 取顶点
	glEnableClientState(GL_VERTEX_ARRAY);// 顶点数组可用
	glColorPointer(4, GL_FLOAT, sizeof(Vertex), &Vertices[0].Color);// 取颜色
	glEnableClientState(GL_COLOR_ARRAY);// 颜色数组可用
    
    glDrawArrays(GL_TRIANGLES, 0, 3);// 这个后面细讲
    
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [_context presentRenderbuffer:GL_RENDERBUFFER_OES];// 将渲染实现出来
    rot += 2;
}

// 让它按设备帧率进行渲染
- (void)setupDisplayLink {
    CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

@end
