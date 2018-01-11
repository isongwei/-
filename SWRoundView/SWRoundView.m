//
//  SWRoundView.m
//  SWRoundView
//
//  Created by iSongWei on 2018/1/11.
//  Copyright © 2018年 iSong. All rights reserved.
//

#import "SWRoundView.h"


#define degreesToRadians(x) (M_PI*(x/180.0)) //把角度转换成PI的方式
#define KScreenWidth ([[UIScreen mainScreen]bounds].size.width)
#define KScreenHeight ([[UIScreen mainScreen]bounds].size.height)

static CGFloat  progressLineWidth = 10;  // 外圆进度的线宽

IB_DESIGNABLE
@interface SWRoundView ()

@property (nonatomic,assign)CGFloat startAngle;  // 开始的弧度
@property (nonatomic,assign)CGFloat endAngle;  // 结束的弧度





@property (nonatomic,assign)CGFloat centerX;  // 中心点 x
@property (nonatomic,assign)CGFloat centerY;  // 中心点 y


@property (nonatomic,strong)CAShapeLayer *baseLayer;  // 进度progressLayer
@property (nonatomic,strong)CAShapeLayer *progressLayer;  // 进度progressLayer
@property (nonatomic,strong)CAGradientLayer *colorLayer;  // 进度progressLayer

@property (nonatomic,assign)CGFloat progressRadius; // 半径

@property (nonatomic,assign) float ratio;  // 记录百分比 用于数字跳动



@end

@implementation SWRoundView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    
}



-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    
    _startAngle =  -225;  // 启始角度
    _endAngle = 45;  // 结束角度
    
    _centerX = self.bounds.size.width*0.5;  // 控制圆盘的X轴坐标
    _centerY = _centerX  ; // 控制圆盘的Y轴坐标
    
    
    _progressRadius = self.bounds.size.width*0.5-20;
    //底部的
    [self drawBaseProgressLayer];
    [self.layer addSublayer:_baseLayer];
    //动的
    [self drawProgressLayer];
    
    
    //变的
    [self drawColorLayer];
    [_colorLayer setMask:_progressLayer];
    [self.layer addSublayer:_colorLayer];
    
    
    
}

#pragma mark - ===============变化的层===============
- (CAShapeLayer *)drawProgressLayer
{
    
    _progressLayer = [CAShapeLayer new];
    _progressLayer.frame = self.bounds;
    //圆环
    _progressLayer.strokeColor = [UIColor redColor].CGColor;
    //填充
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    
    
    
    
    
    
    _progressLayer.lineWidth = progressLineWidth;
    
    //控制线的比例
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd =   0.5;
    //圆角
    _progressLayer.lineCap = kCALineCapRound;
    
    
//如果想显示为齿轮状态，则打开这段代码
//    _progressLayer.lineCap = kCALineCapButt;
//    _progressLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5], nil];
    

   // 线
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY ) radius:_progressRadius  startAngle:degreesToRadians(_startAngle) endAngle:degreesToRadians(_endAngle)  clockwise:YES];
    _progressLayer.path = bezierPath.CGPath;
    
    return _progressLayer;
    
}

#pragma mark - ===============base的层===============
- (CAShapeLayer *)drawBaseProgressLayer
{
    
    _baseLayer = [CAShapeLayer new];
    _baseLayer.frame = self.bounds;
    //圆环
    _baseLayer.strokeColor = [UIColor grayColor].CGColor;
    //填充
    _baseLayer.fillColor = [UIColor clearColor].CGColor;
    _baseLayer.lineWidth = 3;
    
    //控制线的比例
    
    //圆角
    _baseLayer.lineCap = kCALineCapRound;
    
    
    
    // 线
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY ) radius:_progressRadius  startAngle:degreesToRadians(_startAngle) endAngle:degreesToRadians(_endAngle)  clockwise:YES];
    _baseLayer.path = bezierPath.CGPath;
    
    
    return _baseLayer;
    
}




#pragma mark - ===============颜色变化的===============
-(CAGradientLayer *)drawColorLayer{

    // 线
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY ) radius:_progressRadius  startAngle:degreesToRadians(_startAngle) endAngle:degreesToRadians(_endAngle)  clockwise:YES];

    _colorLayer = [CAGradientLayer layer];
    _colorLayer.frame = self.bounds;
    
    _colorLayer.shadowPath = bezierPath.CGPath;
    
    _colorLayer.colors =  [NSMutableArray arrayWithObjects:
                                      (id)[UIColor redColor].CGColor,
                                      (id)[UIColor yellowColor].CGColor,
                                      (id)[UIColor greenColor].CGColor,
                           
                                      nil];
    [_colorLayer setStartPoint:CGPointMake(0, 1)];
    [_colorLayer setEndPoint:CGPointMake(1, 0)];
   

    return _colorLayer;

}

#pragma mark - ===============动画===============

@synthesize percent = _percent;
-(CGFloat)percent{
    return  self.percent;
}


- (void)setPercent:(CGFloat)percent
{
    
    if (percent > 1) {
        percent = 1;
    }else if (percent < 0){
        percent = 0;
    }
    self.ratio = percent * 100;
    
    _percent = percent;
    [self shapeChange];
    
}

- (void)shapeChange
{
    
//    _progressLayer.strokeEnd = 0 ;
    [UIView animateWithDuration:0.8 animations:^{
        _progressLayer.strokeEnd = _percent;
    }];
    
}


@end
