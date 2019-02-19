//
//  AnimationGroupViewController.m
//  CoreAnimationExample
//
//  Created by Macbook tianfu on 2019/2/19.
//  Copyright © 2019 商圈网络. All rights reserved.
//

#import "AnimationGroupViewController.h"

@interface AnimationGroupViewController ()

@end

@implementation AnimationGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self animationGroup];
}

- (void)animationGroup{
    //    曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 200)];
    [path addCurveToPoint:CGPointMake(300, 200) controlPoint1:CGPointMake(180, 100) controlPoint2:CGPointMake(200, 300)];
    //需要添加在layer上
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];

    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 60, 60);
    colorLayer.position = CGPointMake(50, 200);
    colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:colorLayer];

    //    过山车的动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.path = path.CGPath;
    //    anim.duration = 4.0f;
    //    anim.removedOnCompletion = NO;
    //    anim.fillMode = kCAFillModeForwards;
    //    anim.rotationMode = kCAAnimationRotateAuto;
    //    [colorLayer addAnimation:anim forKey:nil];
    //    改变大小
    CABasicAnimation *sizeAnim = [CABasicAnimation animation];
    sizeAnim.keyPath = @"transform.scale";
    sizeAnim.toValue = @.5;
    //    sizeAnim.duration = 4.0;
    //    sizeAnim.fillMode = kCAFillModeForwards;
    //    sizeAnim.removedOnCompletion = NO;
    //
    //    [colorLayer addAnimation:sizeAnim forKey:nil];

    //    修改颜色
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];

    CABasicAnimation *colorAnim = [CABasicAnimation animation];
    colorAnim.keyPath = @"backgroundColor";
    colorAnim.toValue = (id)color.CGColor;
    //    colorAnim.duration = 4.0f;
    //    colorAnim.fillMode = kCAFillModeForwards;
    //    colorAnim.removedOnCompletion = NO;
    //    [colorLayer addAnimation:colorAnim forKey:nil];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[anim, sizeAnim, colorAnim];
    group.duration = 4.0f;
    //group.timeOffset = 3;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [colorLayer addAnimation:group forKey:nil];
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
