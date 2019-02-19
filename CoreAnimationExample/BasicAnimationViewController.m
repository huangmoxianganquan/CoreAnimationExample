//
//  BasicAnimationViewController.m
//  CoreAnimationExample
//
//  Created by 清风 on 2019/2/18.
//  Copyright © 2019 商圈网络. All rights reserved.
//

/*

 动画三步骤：
 1.初始化动画对象
 2.设置需要修改的动画属性的值
 3.把动画添加到layer（所有的动画都是添加在layer上，不是view）

 */

#import "BasicAnimationViewController.h"

@interface BasicAnimationViewController ()<CAAnimationDelegate>
@property (nonatomic,strong) UIView *greenView;
@property (nonatomic,strong) CALayer *colorLayer;
@property (weak, nonatomic) IBOutlet UIButton *modifyFrameBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeColorBtn;
@end

@implementation BasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.greenView = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    self.greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.greenView];

    UITapGestureRecognizer *greenViewGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(greenViewGesClick:)];
    [self.greenView addGestureRecognizer:greenViewGes];

    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 350, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.view.layer addSublayer:self.colorLayer];
}

- (void)greenViewGesClick:(UITapGestureRecognizer *)greenViewGes{
    NSLog(@"触摸了greenView");


}

- (IBAction)modifyFrameBtnClick:(id)sender {
    CABasicAnimation *anim = [CABasicAnimation animation];
    // CABasicAnimation属性
    anim.toValue = @400;
    // 父类CAPropertyAnimation属性
    anim.keyPath = @"position.y";
    // 基类CAAnimation
    // 基类CAAnimation 结束后不移除动画
    anim.removedOnCompletion = NO;
    // 协议CAMediaTiming添加的属性 kCAFillModeForwards保持动画最后的状态
    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    [_greenView.layer addAnimation:anim forKey:nil];
}

- (IBAction)changeColorClick:(id)sender {
    //create a new random color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    CABasicAnimation *animation = [CABasicAnimation new];
    animation.toValue = (__bridge id)color.CGColor;
    animation.keyPath = @"backgroundColor";
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    [self applyBasicAnimation:animation toLayer:self.colorLayer];
    //[self.colorLayer addAnimation:animation forKey:@"backgroundColor"];
}

- (void)applyBasicAnimation:(CABasicAnimation *)animation toLayer:(CALayer *)layer
{
    // 需要将初始值设置为layer呈现层的值，否则动画起始值还是最初layer的初始值，效果不对
    animation.fromValue = [layer.presentationLayer ?: layer valueForKeyPath:animation.keyPath];
    //为了不受隐式动画干扰，禁用隐式动画，虽然通常显式动画会覆盖隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    //[layer setValue:animation.toValue forKeyPath:animation.keyPath];
    [CATransaction commit];
    [layer addAnimation:animation forKey:nil];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}

// 恢复到原来的位置
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CABasicAnimation *anim = [CABasicAnimation animation];
    // CABasicAnimation属性
    anim.toValue = @150;
    // 父类CAPropertyAnimation属性
    anim.keyPath = @"position.y";
    // 基类CAAnimation 结束后不移除动画
    anim.removedOnCompletion = NO;
    // 协议CAMediaTiming添加的属性 kCAFillModeForwards保持动画最后的状态
    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    [_greenView.layer addAnimation:anim forKey:nil];
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
