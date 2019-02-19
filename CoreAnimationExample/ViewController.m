//
//  ViewController.m
//  CoreAnimationExample
//
//  Created by Macbook tianfu on 2019/2/18.
//  Copyright © 2019 商圈网络. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

    self.dataSource = [NSMutableArray arrayWithObjects:@"隐式动画",@"基础动画",@"关键帧动画",@"转场动画",@"动画组", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCellId"];
    }
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:[self getAnimationControllerWithIndex:indexPath.row] animated:YES];
}

- (UIViewController *)getAnimationControllerWithIndex:(NSInteger)index{
    UIViewController *controller = nil;
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    switch (index) {
        case 0: // 隐式动画
            controller = [story instantiateViewControllerWithIdentifier:@"ImplicitAnimationViewController"];
            break;
        case 1: // 基础动画
            controller = [story instantiateViewControllerWithIdentifier:@"BasicAnimationViewController"];
            break;
        case 2: // 关键帧动画
            controller = [story instantiateViewControllerWithIdentifier:@"KeyFrameAnimationViewController"];
            break;
        case 3: // 动画组
            controller = [story instantiateViewControllerWithIdentifier:@"TransitionViewController"];
            break;
        case 4: // 动画组
            controller = [story instantiateViewControllerWithIdentifier:@"AnimationGroupViewController"];
            break;
        default:
            controller = [story instantiateViewControllerWithIdentifier:@"ImplicitAnimationViewController"];
            break;
    }
    return controller;
}


@end
