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
#import "AboutUsViewController.h"
#import "mySaveViewController.h"
#import "RDVTabBarController.h"
#import "MyBusinessViewController.h"
#import "MyHelpViewController.h"

@interface PersonalCenterViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate>{

      UserPrefs *_userPref;
}

@end

@implementation PersonalCenterViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rdv_tabBarController.tabBarHidden=NO;
}

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
    //设置头像
    if ( [_userPref getheaderImage]) {
        UIImage *headerImage=[UIImage imageWithData:[_userPref getheaderImage]];
        [self.headerBtn setBackgroundImage:headerImage forState:UIControlStateNormal];
        
    }else{
        [self.headerBtn setBackgroundImage:[UIImage imageNamed:@"关于我们.png"] forState:UIControlStateNormal];
        
    }
    
    

}
//修改xib文件内容
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

    //设置头像
//        BQMLog(@"H:%f   W:%f",self.headerBtn.bounds.size.height,self.headerBtn.bounds.size.width);

    self.headerBtn.layer.masksToBounds=YES;
    self.headerBtn.layer.cornerRadius=self.headerBtn.bounds.size.height/2.0;
    //设置退出登录
    self.exitBtn.layer.masksToBounds=YES;
    self.exitBtn.layer.cornerRadius=10;
    self.exitBtn.backgroundColor=UIColorWithRGBA(35, 165, 58, 1);
    if ([_userPref getUserName]) {
        [self.exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    }else{
        [self.exitBtn setTitle:@"点击登录" forState:UIControlStateNormal];
        
    }


}
#pragma mark --修改头像
- (IBAction)getHeaderImage:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册中选取",nil];
    actionSheet.tag = 1001;
    [actionSheet showInView:self.view];
    
}
// UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 2) {
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    if (buttonIndex == 0) {
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }else if (buttonIndex == 1){
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else{
        
        return;
    }
    picker.allowsEditing = YES;
    picker.delegate =self;
    [self presentViewController:picker animated:YES completion:NULL];
}
// UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //上传图片到服务器。
    // 改变图片的大小再上传
    CGSize itemSize = CGSizeMake(512, 512);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [image drawInRect:imageRect];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.headerImage = image;
    //保存头像
    NSData *imageData=UIImageJPEGRepresentation(image, 0.5);
    [_userPref saveuserheaderImage:imageData];
    [self.headerBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --修改密码
- (IBAction)ModifyPassword:(id)sender {
    ModifyPasswordViewController *modifyVC=[[ModifyPasswordViewController alloc]init];
    [self.navigationController pushViewController:modifyVC animated:YES];
}
#pragma mark --我的收藏
- (IBAction)mySave:(id)sender {
    mySaveViewController *mySaveVC=[[mySaveViewController alloc]init];
    [self.navigationController pushViewController:mySaveVC animated:YES];
    
}
#pragma mark --我的买卖
- (IBAction)myBusiness:(id)sender {
    MyBusinessViewController *mySaveVC=[[MyBusinessViewController alloc]init];
    [self.navigationController pushViewController:mySaveVC animated:YES];
    
}
#pragma mark --我的帮助
- (IBAction)myHelp:(id)sender {
    MyHelpViewController *mySaveVC=[[MyHelpViewController alloc]init];
    [self.navigationController pushViewController:mySaveVC animated:YES];
}
#pragma mark --我的分享
- (IBAction)myShare:(id)sender {
    //https://itunes.apple.com/us/app/jian-kang-dian-di/id1059336307?l=zh&ls=1&mt=8
    //https://itunes.apple.com/us/app/niu-qi-pei/id979472604?mt=8
    //https://itunes.apple.com/us/app/yun-cheng-ren-er/id955261029?mt=8
    
    
    
}
#pragma mark --客服
- (IBAction)customerService:(id)sender {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://10086"]]];
    [self.view addSubview:webView];
}
#pragma mark --关于我们
- (IBAction)aboutUs:(id)sender {
    AboutUsViewController *aboutVC=[[AboutUsViewController alloc]init];
    [self.navigationController pushViewController:aboutVC animated:YES];
}
#pragma mark --点击退出登录
- (IBAction)loginOutBtn:(id)sender {
   
   
       static int i=0;
    if (![_userPref getUserName]) {
        i=1;
    }
    if (i==0) {
        //清除用户信息
        [_userPref clearLoginInfo];
        [self.exitBtn setTitle:@"点击登录" forState:UIControlStateNormal];
        self.userNick.text=@"用户昵称";
        [self.headerBtn setBackgroundImage:[UIImage imageNamed:@"关于我们.png"] forState:UIControlStateNormal];
        
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
