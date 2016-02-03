//
//  LoginViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/6.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "RootViewController.h"
#import "AFHelper.h"
#import "UserPrefs.h"
#import "BQMImageView.h"



@interface LoginViewController ()

@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.type==1) {
        BQMImageView *backBtn=[[BQMImageView alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
        backBtn.image=[UIImage imageNamed:@"Safari-Forward.png"];
        [backBtn addTarget:self action:@selector(gotoRootVC)];
        [self.topImageView addSubview:backBtn];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topImageView.userInteractionEnabled=YES;
    self.type=0;
    // Do any additional setup after loading the view from its nib.
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --登录
- (IBAction)loginBtn:(id)sender {
    if (_userTextField.text.length!=0 && _passwordTextField.text.length!=0) {
        
        NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
        [params setObject:@"authorize" forKey:@"key"];
        [params setObject:_userTextField.text forKey:@"u_id"];
        [params setObject:_passwordTextField.text forKey:@"u_pwd"];
        [AFHelper PostWithPath:@"/oauth/authorize.ashx" andParameters:params andSuccess:^(id  responseObject) {
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            BQMLog(@"%@",dic);
            if ([dic[@"error"] isEqual:@0]) {
                NSDictionary *userList=dic[@"list"];
                
                //保存登录信息  dic[@"list"]
                UserPrefs *userPrefs=[UserPrefs shareUserPrefs];
                [userPrefs saveUserName:_userTextField.text];
                [userPrefs saveUserPassword:_passwordTextField.text];
                [userPrefs saveuserID:userList[@"id"]];
                //头像
//                [userPrefs saveuserheaderImage:<#(NSData *)#>];
                
                [self showHUDWithMessage:@"登录成功" view:self.view];
                [self performSelector:@selector(gotoRootVC) withObject:nil afterDelay:1];
            }else{
                [self showHUDWithMessage:dic[@"message"] view:self.view];
            }
            
        } andFailure:^(NSError *error) {
            [self showHUDWithMessage:@"网络超时" view:self.view];
        }];
 
    }else{
            [self showHUDWithMessage:@"用户名或密码不可以为空" view:self.view];
    
    }
    
    //测试
//    [self performSelector:@selector(gotoRootVC) withObject:nil afterDelay:1];
    
    
}
-(void)gotoRootVC{
    RootViewController *rootVC=[[RootViewController alloc]init];
    rootVC.type=self.type;
//    [self presentViewController:rootVC animated:NO completion:nil];
    [self.navigationController pushViewController:rootVC animated:YES];


}

#pragma mark --注册
- (IBAction)registerBtn:(id)sender {
//    BQMLog(@"注册");
    _userTextField.text=nil;
    _passwordTextField.text=nil;
    RegisterViewController *registerVC=[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //结束编辑状态
    [self.view endEditing:YES];

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
