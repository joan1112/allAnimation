//
//  ViewController.m
//  AnimationDemo
//
//  Created by qiong on 2019/5/24.
//  Copyright © 2019年 qiong. All rights reserved.
//

#import "ViewController.h"
#import "TLTransition.h"
#import "CustomeViewController.h"
#import "TLAnimator.h"
#import "TLAppStoreListController.h"
#import "FloatViewController.h"
#import "AnimaViewController.h"
#import "TextKITViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *_frameView;
    UIView *_sheetView;
    TLTransition *_transition;

}
@property(strong,nonatomic)UITableView *listTab;
@property(strong,nonatomic)NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"1234";
    [self.view addSubview:self.listTab];
    self.view.backgroundColor = [UIColor whiteColor];
    _data = @[@[@"alert",@"alert1"],@[@"actionSheet"],@[@"open",@"绽放",@"切入",@"右",@"左",@"指定",@"缩放",@"缩放1",@"round",@"抽屉",@"发牌",@"cccc"],@[@"float悬浮"],@[@"kit"]];
}

-(UITableView*)listTab
{
    if (!_listTab) {
        _listTab = [[UITableView alloc]initWithFrame:CGRectMake(0, StauesHeight, tl_ScreenW, tl_ScreenH-StauesHeight) style:UITableViewStyleGrouped];
        _listTab.dataSource = self;
        _listTab.delegate = self;
        _listTab.rowHeight = 50;
        _listTab.estimatedSectionFooterHeight = 0;
    }
    return _listTab;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSArray *arr = _data[indexPath.section];

    cell.textLabel.text = arr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"logo"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
         [self alertType:[tableView cellForRowAtIndexPath:indexPath]];
    }else if (indexPath.section==1){
          [self actionSheetType:[tableView cellForRowAtIndexPath:indexPath]];
    }else if (indexPath.section==2){
        [self presentByTLAnimator:indexPath];
    }else if (indexPath.section==3){
        FloatViewController *floats = [[FloatViewController alloc]init];
        floats.hidesBottomBarWhenPushed = NO;
        self.tabBarController.tabBar.hidden = YES;
        [self pushViewController:floats transitionType:TLTransitionCube direction:TLDirectionToLeft dismissDirection:TLDirectionToRight];

    }else if (indexPath.section==4){
//        AnimaViewController *base = [[AnimaViewController alloc]init];
//        base.hidesBottomBarWhenPushed = NO;
//        self.tabBarController.tabBar.hidden = YES;
//        [self pushViewController:base transitionType:TLTransitionCube direction:TLDirectionToLeft dismissDirection:TLDirectionToRight];
        TextKITViewController *kit = [[TextKITViewController alloc]init];
        [self.navigationController pushViewController:kit animated:YES];;
        
    }
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _data.count;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = _data[section];
    return arr.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
#pragma mark - Transitions Of View
// TLPopTypeAlert
- (void)alertType:(UITableViewCell *)sender {
    CGRect bounds = CGRectMake(0, 0, self.view.bounds.size.width * 0.8f, 200.f);
    UIView *bView = [self creatViewWithBounds:bounds color:tl_Color(218, 248, 120)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [bView addGestureRecognizer:tap];
    
    UITextField *textFiled = [[UITextField alloc] init];
    textFiled.backgroundColor = tl_Color(255, 255, 255);
    textFiled.bounds = CGRectMake(0, 0, bView.bounds.size.width * 0.8f, 30.f);
    textFiled.center = CGPointMake(bView.bounds.size.width * 0.5, bView.bounds.size.height * 0.2);
    [bView addSubview:textFiled];
    bView.tag = 1;
    
    if([self.listTab indexPathForCell:sender].row == 0) {
        [TLTransition showView:bView popType:TLPopTypeAlert];
    }else{
        [TLTransition showView:bView popType:TLPopTypeAlert2];
        bView.tag = 2;
    }
}
//
- (void)tap:(UITapGestureRecognizer *)tap {
    [tap.view endEditing:YES];
}

// TLPopTypeActionSheet
- (void)actionSheetType:(UIView *)sender {
    if (_sheetView == nil) {
        CGRect bounds = CGRectMake(0, 0, self.view.bounds.size.width, 500.f);
        UIView *bView = [self creatViewWithBounds:bounds color:tl_Color(248, 218, 200)];
        bView.tag = 3;
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.text = @"通过pan手势改变高度";
        [textLabel sizeToFit];
        textLabel.center = CGPointMake(bView.bounds.size.width * 0.5, 20);
        [bView addSubview:textLabel];
        
        _sheetView = bView;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [_sheetView addGestureRecognizer:pan];
    }
    _transition = [TLTransition showView:_sheetView popType:TLPopTypeActionSheet];
}
-(void)pan:(UIPanGestureRecognizer*)pan
{
    CGPoint point = [pan locationInView:[UIApplication sharedApplication].keyWindow];
    
    CGFloat height = tl_ScreenH - point.y;
    if (height < 100) {
        height = 100;
    }else if (height > tl_ScreenH - 88){
        height = tl_ScreenH - 88;
    }
    
    CGRect rect = _sheetView.bounds;
    rect.size.height = height;
    _sheetView.bounds = rect;
    [_transition updateContentSize];
}

//
- (UIView *)creatViewWithBounds:(CGRect)bounds color:(UIColor *)color {
    UIView *BView = [[UIView alloc] initWithFrame:CGRectZero];
    BView.backgroundColor = color;
    BView.bounds = bounds;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [BView addSubview:titleLabel];
//    _titleLabel = titleLabel;
    titleLabel.text = @"潜移默化";
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = BView.bounds;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(bounds.size.width - 70, 0, 60, 30)];
    [btn setTitle:@"查看代码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
//    [btn addTarget:self action:@selector(showCode:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [BView addSubview:btn];
    
    return BView;
}

#pragma mark TLAnimator(个人收集)
- (void)presentByTLAnimator:(NSIndexPath *)indexPath {
    

    CustomeViewController *vc = [[CustomeViewController alloc] init];
//    vc.isShowBtn = YES;
//    vc.disableInteractivePopGestureRecognizer = YES;
    TLAnimatorType type = TLAnimatorTypeOpen;
    switch (indexPath.row) {
        case 0:
            type = TLAnimatorTypeOpen;
            break;
        case 1:
            type = TLAnimatorTypeOpen2;

            break;
        case 2:
             type = TLAnimatorTypeBevel;
            break;
        case 3:
             type = TLAnimatorTypeTiltRight;
            break;
        case 4:
             type = TLAnimatorTypeTiltLeft;
            break;
        case 5:
             type = TLAnimatorTypeFrame;
            break;
        case 6:
             type = TLAnimatorTypeRectScale;
            break;
        case 7:
            type = TLAnimatorTypeRectScale;
            break;
        case 8:
            type = TLAnimatorTypeCircular;
            break;
        case 9:
            type = TLAnimatorTypeSlidingDrawer;
            break;
        case 10:
            type = TLAnimatorTypeCards;
            break;
        case 11:
        {
            TLAppStoreListController *vc = [TLAppStoreListController new];
            [self presentViewController:vc swipeType:TLSwipeTypeIn presentDirection:TLDirectionToLeft dismissDirection:TLDirectionToLeft completion:nil];
        }
           
            break;
        default:
            break;
    }
    //    vc.imgName = @"modal_animator";
    TLAnimator *animator = [TLAnimator animatorWithType:type];
    //    animator.transitionDuration = 1.f;
    if (type == TLAnimatorTypeSlidingDrawer) {
        type = TLAnimatorTypeTiltRight;
        vc.isShowBtn = YES;
        vc.disableInteractivePopGestureRecognizer = YES;
    }else if (type == TLAnimatorTypeFrame) {

        UITableViewCell *cell = [self.listTab cellForRowAtIndexPath:indexPath];
        CGRect frame = [self.listTab convertRect:cell.frame toView:[UIApplication sharedApplication].keyWindow];
        animator.initialFrame = frame;

    }else if (type == TLAnimatorTypeRectScale) {

        UITableViewCell *cell = [self.listTab cellForRowAtIndexPath:indexPath];
        CGRect frame = [cell convertRect:cell.imageView.frame toView:[UIApplication sharedApplication].keyWindow];
        animator.fromRect = frame;
        animator.toRect = CGRectMake(0, tl_ScreenH - 210, tl_ScreenW, 210);
        animator.isOnlyShowRangeForRect = indexPath.row > TLAnimatorTypeRectScale;
        vc.isShowImage = YES;

    }else if (type == TLAnimatorTypeCircular) {

        UITableViewCell *cell = [self.listTab cellForRowAtIndexPath:indexPath];
        CGPoint center = [self.listTab convertPoint:cell.center toView:[UIApplication sharedApplication].keyWindow];
        center.x = arc4random_uniform(cell.bounds.size.width - 40) + 20;
        animator.center = center;
    }else if (type == TLAnimatorTypeCards) {
        animator.transitionDuration = 1.f;
    }

    [self presentViewController:vc animator:animator completion:^{
        tl_LogFunc;
    }];
}
@end
