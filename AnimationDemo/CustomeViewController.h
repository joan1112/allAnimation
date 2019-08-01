//
//  CustomeViewController.h
//  AnimationDemo
//
//  Created by qiong on 2019/5/28.
//  Copyright © 2019年 qiong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomeViewController : UIViewController
@property(nonatomic, assign) BOOL isShowImage;
@property(nonatomic, assign) BOOL isShowBtn;
@property(nonatomic, copy) NSString *imgName;
@property(nonatomic, strong)UIImageView *imgView;
@end

NS_ASSUME_NONNULL_END
