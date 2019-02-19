//
//  TransitionViewController.m
//  CoreAnimationExample
//
//  Created by Macbook tianfu on 2019/2/19.
//  Copyright © 2019 商圈网络. All rights reserved.
//

#import "TransitionViewController.h"

@interface TransitionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSArray *imgs;
@property (nonatomic, assign) NSInteger index;
@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _imgs = @[@"view0", @"view1" ,@"view2"];
    _index = 0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _index++;
    if (_index == 3) {
        _index = 0;
    }
    NSString *imgName = _imgs[_index];
    _imageView.image = [UIImage imageNamed:imgName];
    CATransition *anim = [CATransition animation];
    anim.type = @"suckEffect";
    //anim.type = kCATransitionPush;
    anim.subtype = kCATransitionFromLeft;
    anim.duration = .5;
    //    anim.startProgress = .2;
    //    anim.endProgress = .5;
    [_imageView.layer addAnimation:anim forKey:nil];
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
