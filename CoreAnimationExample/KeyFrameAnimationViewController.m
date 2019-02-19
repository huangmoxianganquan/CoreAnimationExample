//
//  KeyFrameAnimationViewController.m
//  CoreAnimationExample
//
//  Created by Macbook tianfu on 2019/2/19.
//  Copyright © 2019 商圈网络. All rights reserved.
//

#import "KeyFrameAnimationViewController.h"

#define angleToRadians(angle) ((angle) / 180.0 *M_PI)

@interface KeyFrameAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *ValuesAnimBtn;
@property (weak, nonatomic) IBOutlet UIButton *PathsAnimBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation KeyFrameAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)ValusAnimClick:(id)sender {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.repeatDuration = MAXFLOAT;
    // 和下面三句代码等价
//    anim.values = @[@angleToRadians(-6),@angleToRadians(6),@angleToRadians(-6)];
    anim.values = @[@angleToRadians(-6),@angleToRadians(6)];
    // 动画反转
    anim.autoreverses = YES;
    // 加速2倍
    anim.speed = 2;
    [self.iconView.layer addAnimation:anim forKey:nil];
}

- (IBAction)PathsAnimClick:(id)sender {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 200)];
    [path addCurveToPoint:CGPointMake(300, 200) controlPoint1:CGPointMake(180, 100) controlPoint2:CGPointMake(200, 300)];

    // 绘制小车的layer
    CALayer *carLayer = [CALayer layer];
    carLayer.contents = (__bridge id)[UIImage imageNamed:@"car.png"].CGImage;
    carLayer.frame = CGRectMake(50-36, 200-36, 36, 36);
    carLayer.anchorPoint = CGPointMake(0.5, 0.8);
    [self.view.layer addSublayer:carLayer];

    // 绘制曲线的layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];

    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    // 设置曲线
    anim.path = path.CGPath;
    anim.duration = 4.0f;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    // 跟着曲线的方向移动
    anim.rotationMode = kCAAnimationRotateAuto;
    [carLayer addAnimation:anim forKey:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
