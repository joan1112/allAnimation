//
//  CustomeViewController.m
//  AnimationDemo
//
//  Created by qiong on 2019/5/28.
//  Copyright © 2019年 qiong. All rights reserved.
//

#import "CustomeViewController.h"

@interface CustomeViewController ()

@end

@implementation CustomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBtn];
    self.navigationItem.title = @"Controller B";
    self.view.backgroundColor = [UIColor grayColor];
    self.imgView.hidden = !_isShowImage;
//    self.presentBtn.hidden = !_isShowBtn;


    if (_isShowBtn) {
        
        UIViewController *vc = [[UIViewController alloc] init];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = vc.view.bounds;
        gradient.colors = [NSArray arrayWithObjects:
                           (id)[UIColor redColor].CGColor,
                           (id)[UIColor greenColor].CGColor,
                           (id)[UIColor blueColor].CGColor, nil];
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(1, 1);
        gradient.locations = @[@0.0, @0.5, @1.0];
        [vc.view.layer addSublayer:gradient];
        
        
        TLAnimatorType type = TLAnimatorTypeSlidingDrawer;
        TLAnimator *animator = [TLAnimator animatorWithType:type];
        animator.transitionDuration = 0.35f;
        
        // 必须初始化的属性
        animator.isPushOrPop = NO;
        animator.interactiveDirectionOfPush = TLDirectionToRight;
        
        [self registerInteractiveTransitionToViewController:vc animator:animator];
    }



}
-(void)creatBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.center = self.view.center;
    btn.bounds = CGRectMake(0, 0, 100, 30);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    
    
    _imgView = [[UIImageView alloc]init];
    [self.view addSubview:_imgView];
    _imgView.image = [UIImage imageNamed:@"logo"];
    _imgView.frame = CGRectMake(0, tl_ScreenH - 210, tl_ScreenW, 210);
}

-(void)dismissVC
{
    if (self.navigationController.childViewControllers.count > 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TLSecondViewControllerDidDealloc" object:nil];
}

@end
