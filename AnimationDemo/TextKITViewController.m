//
//  TextKITViewController.m
//  AnimationDemo
//
//  Created by qiong on 2019/6/25.
//  Copyright © 2019 qiong. All rights reserved.
//

#import "TextKITViewController.h"
#import <WebKit/WebKit.h>
@interface TextKITViewController ()
@property (nonatomic, strong) UITextView *textV;
@end

@implementation TextKITViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _textV = [[UITextView alloc]initWithFrame:CGRectMake(tl_StatusBarH, 88, tl_ScreenW-20, 300)];
   // [self.view addSubview:_textV];
    [self.textV.textStorage beginEditing];


    [self.textV.textStorage endEditing];
    
    self.textV.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    NSString *str = @"<header><style> img{max-width:379.000000px !important;height:auto;display:inline-block;vertical-align: middle;} </style></header>答案: <img src='http://api.sijiedu.com/api/statics/word/4a7559e16f42be97976451b3e008874a/image2_crop.png'><br><br> 原式<img src='http://api.sijiedu.com/api/statics/word/4a7559e16f42be97976451b3e008874a/image3_crop.png'><br><img src='http://api.sijiedu.com/api/statics/word/4a7559e16f42be97976451b3e008874a/image4_crop.png'><br>";
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, attStr.length)];
    self.textV.attributedText = attStr;
    WKWebView *wk = [[WKWebView alloc]initWithFrame:CGRectMake(30, 100, 400, 400)];
    [wk loadHTMLString:str baseURL:nil];
    [self.view addSubview:wk];
    
//    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 110)];
//    img.image= [UIImage imageNamed:@"gift_icon"];
////    img.backgroundColor = [UIColor redColor];
//    [self.textV addSubview:img];
//
//
//    CGRect rect = CGRectMake(100, 100, 100, 100);
//    //设置环绕的路径
//    UIBezierPath * path = [UIBezierPath bezierPathWithRect:rect]; self.textV.textContainer.exclusionPaths = @[path];
//
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
