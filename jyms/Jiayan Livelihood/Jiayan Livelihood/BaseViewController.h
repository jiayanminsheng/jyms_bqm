//
//  BaseViewController.h
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/12.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
-(void)showHUDWithTitle:(NSString *)title Message:(NSString *)message view:(UIView *)view;
-(void)showHUDWithMessage:(NSString *)message view:(UIView *)view;

-(UIButton *)creatleftBarButtonItemOfBack;

@end
