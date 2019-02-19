//
//  ImplicitAnimationViewController.m
//  CoreAnimationExample
//
//  Created by 清风 on 2019/2/18.
//  Copyright © 2019 商圈网络. All rights reserved.
//

#import "ImplicitAnimationViewController.h"

@interface ImplicitAnimationViewController ()//<CALayerDelegate>
@property (nonatomic,strong) CALayer *layer;
@property (weak, nonatomic) IBOutlet UIButton *defaultAnimationBtn;
@property (weak, nonatomic) IBOutlet UIButton *modifyDurationBtn;
@property (weak, nonatomic) IBOutlet UIButton *modifyActionBtn;

@end

@implementation ImplicitAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.layer = [CALayer layer];
    self.layer.frame = CGRectMake(200, 100, 100, 100);
    //self.layer.delegate = self;
    self.layer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer addSublayer:self.layer];
}

- (IBAction)defaultClick:(id)sender {
    // 隐式动画：不指定任何动画类型，在改变CALayer的属性时，Core Animation来决定如何并且何时去做动画。
    // 默认时间为0.25s，必须是独立的CALyaer才能做隐式动画，UIView的Layer不能做隐式动画。
    self.layer.frame = CGRectMake(200, 400, 100, 100);
}

- (IBAction)modifyDuration:(id)sender {
    // 事务处理 可以修改隐式动画的时间 commit的做动画
    [CATransaction begin];
    // 设置动画时间
    [CATransaction setAnimationDuration:2];
    self.layer.frame = CGRectMake(200, 400, 100, 100);
    [CATransaction commit];
}

- (IBAction)modifyAction:(id)sender {
    // 通过设置action字典自定义动画行为
    self.layer.backgroundColor = [UIColor redColor].CGColor;
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    self.layer.actions = @{@"backgroundColor":transition};
}

//#pragma mark - CALayerDelegate
//- (id <CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event{
//    CATransition *transition = [CATransition animation];
//    transition.type = kCATransitionFade;
//    return transition;
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 隐式动画：不指定任何动画类型，在改变CALayer的属性时，Core Animation来决定如何并且何时去做动画。
    // 默认时间为0.25s，必须是独立的CALyaer才能做隐式动画，UIView的Layer不能做隐式动画。
    self.layer.frame = CGRectMake(200, 100, 100, 100);
    self.layer.backgroundColor = [UIColor yellowColor].CGColor;
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
