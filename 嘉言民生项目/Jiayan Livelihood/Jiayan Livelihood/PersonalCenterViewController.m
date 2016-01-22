//
//  PersonalCenterViewController.m
//  01demo
//
//  Created by bqm on 16/1/21.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "UserPrefs.h"
#import "LoginViewController.h"
#import "ModifyPasswordViewController.h"

@interface PersonalCenterViewController (){

      UserPrefs *_userPref;
}

@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=GrayColor;
    //设置用户昵称
    _userPref=[UserPrefs shareUserPrefs];
    if ([_userPref getUserName]) {
        self.userNick.text=[_userPref getUserName];
    }else{
        //注销登录   直接返回个人中心  个人信息为空时候的数据显示
        self.userNick.text=@"用户昵称";
        
    }
    //设置退出登录
    self.exitBtn.layer.masksToBounds=YES;
    self.exitBtn.layer.cornerRadius=10;
    self.exitBtn.backgroundColor=UIColorWithRGBA(35, 165, 58, 1);
    if ([_userPref getUserName]) {
        [self.exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    }else{
        [self.exitBtn setTitle:@"点击登录" forState:UIControlStateNormal];
        
    }
    //

    

    
}

- (IBAction)getHeaderImage:(id)sender {
}
 //修改密码
- (IBAction)ModifyPassword:(id)sender {
    ModifyPasswordViewController *modifyVC=[[ModifyPasswordViewController alloc]init];
    [self.navigationController pushViewController:modifyVC animated:YES];
}
//我的收藏
- (IBAction)mySave:(id)sender {
    
}
//我的买卖
- (IBAction)myBusiness:(id)sender {
    
}
//我的帮助
- (IBAction)myHelp:(id)sender {
    
}
//我的分享
- (IBAction)myShare:(id)sender {
    //https://itunes.apple.com/us/app/jian-kang-dian-di/id1059336307?l=zh&ls=1&mt=8
    //https://itunes.apple.com/us/app/niu-qi-pei/id979472604?mt=8
    //https://itunes.apple.com/us/app/yun-cheng-ren-er/id955261029?mt=8
    
    
}
//客服
- (IBAction)customerService:(id)sender {
    
}
//关于我们
- (IBAction)aboutUs:(id)sender {
    
}
//点击退出登录
- (IBAction)loginOutBtn:(id)sender {
    static int i=0;
    if (![_userPref getUserName]) {
        i=1;
    }
    if (i==0) {
        //清除用户信息
        [_userPref clearLoginInfo];
        self.userNick.text=@"用户昵称";
        i=1;
    }else{
        //使用type字段标示注销登录   进入tabbarcontroller直接index为4（选中个人中心）
        LoginViewController *vc=(LoginViewController *)self.parentViewController.navigationController.viewControllers[0];
        vc.type=1;
        [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
        
        i=0;
        
    }

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
