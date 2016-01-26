//
//  ModifyPasswordViewController.h
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/20.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ModifyPasswordViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;

@property (weak, nonatomic) IBOutlet UITextField *NewPassword;

@property (weak, nonatomic) IBOutlet UITextField *NewAgainPassword;
@property (weak, nonatomic) IBOutlet UIButton *sureModifyBtn;

@end
