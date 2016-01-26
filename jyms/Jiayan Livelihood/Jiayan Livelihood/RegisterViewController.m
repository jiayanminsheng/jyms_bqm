//
//  RegisterViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/6.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "AFHelper.h"
#import "LoginViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    
}

#pragma mark --返回登录页面
- (IBAction)backLoginBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark --注册
- (IBAction)registerBtn:(id)sender {
    if (_userTextField.text.length==0) {
        [self showHUDWithMessage:@"用户名不能为空" view:self.view];
        return;
    }
    if (_passwordTextField.text.length==0) {
        [self showHUDWithMessage:@"密码不能为空" view:self.view];
        return;
    }
    if (_passwordTextField.text.length<6 || _passwordTextField.text.length>20) {
        [self showHUDWithMessage:@"密码由6-20英文字母、数字或符号组成" view:self.view];
        return;
    }
    if (![_passwordTextField.text isEqualToString:_passwordTextField2.text]) {
        [self showHUDWithMessage:@"密码不一致" view:self.view];
        return;
    }
    BQMLog(@"%@%@",_userTextField.text,_passwordTextField.text);
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"reg_info" forKey:@"key"];
    [params setObject:_userTextField.text forKey:@"Moblie"];
    [params setObject:_passwordTextField.text forKey:@"pwd"];
    [AFHelper PostWithPath:@"/oauth/authorize.ashx" andParameters:params andSuccess:^(id responseObject) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        BQMLog(@"%@",dic);
        if ([dic[@"error"] isEqual:@0]) {
            [self showHUDWithMessage:@"注册成功" view:self.view];
            [self performSelector:@selector(gotoLoginVC) withObject:nil afterDelay:1];
        }else{
        [self showHUDWithMessage:@"用户已存在" view:self.view];
        
        }
        
    } andFailure:^(NSError *error) {
        [self showHUDWithMessage:@"请求超时" view:self.view];
    }];
    
    
}
-(void)gotoLoginVC{
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
