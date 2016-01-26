//
//  RegisterViewController.h
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/6.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *userTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField2;

@end
