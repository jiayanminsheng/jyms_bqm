//
//  PersonalCenterViewController.h
//  01demo
//
//  Created by bqm on 16/1/21.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterViewController : UIViewController
@property (nonatomic,strong)UIImage * headerImage;
@property (weak, nonatomic) IBOutlet UIButton *headerBtn;

@property (weak, nonatomic) IBOutlet UILabel *userNick;


@property (weak, nonatomic) IBOutlet UIButton *exitBtn;

@end
