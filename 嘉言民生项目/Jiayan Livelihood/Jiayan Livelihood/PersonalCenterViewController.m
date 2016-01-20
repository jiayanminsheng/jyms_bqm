//
//  PersonalCenterViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/5.
//  Copyright © 2016年 bqm. All rights reserved.
/*
 关于分割线不存在是因为模拟器和电脑分辨率不同的关系，调试将模拟器的scale设为100%
 */

#import "PersonalCenterViewController.h"
#import "UserPrefs.h"
#import "LoginViewController.h"
#import "RootViewController.h"
#import "BQMImageView.h"
#import "AboutUsViewController.h"

@interface PersonalCenterViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *_imageArr;
    NSMutableArray *_titleArr;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    UserPrefs *_userPref;
    
}

@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    // Do any additional setup after loading the view from its nib.
    _userPref=[UserPrefs shareUserPrefs];
    _imageArr=@[[UIImage imageNamed:@"密码修改.png"],[UIImage imageNamed:@"密码修改.png"],[UIImage imageNamed:@"我的收藏.png"],[UIImage imageNamed:@"我的买卖.png"],[UIImage imageNamed:@"我的帮助.png"],[UIImage imageNamed:@"分享.png"],[UIImage imageNamed:@"客服.png"],[UIImage imageNamed:@"关于我们.png"]];
   
    if ([_userPref getUserName]) {
         NSArray *titleArray=@[[_userPref getUserName],@"密码修改",@"我的收藏",@"我的买卖",@"我的帮助",@"我要分享",@"客服电话:400-111-1111",@"关于我们"];
        _titleArr=[[NSMutableArray alloc]initWithArray:titleArray];
    }else{
        NSArray *titleArray=@[@"用户昵称",@"密码修改",@"我的收藏",@"我的买卖",@"我的帮助",@"我要分享",@"客服电话:400-111-1111",@"关于我们"];
        _titleArr=[[NSMutableArray alloc]initWithArray:titleArray];
    
    }
    
    [self creatUI];
    
   
}
-(void)creatUI{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorColor=GrayColor;
    _tableView.bounces=NO;
    _tableView.separatorInset=UIEdgeInsetsMake(1, 0, 1, 0);
    [self.view addSubview:_tableView];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else if (section==1) {
        return 3;
    }else
        return 3;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.textLabel.font=[UIFont systemFontOfSize:14.0f];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
           cell.imageView.transform=CGAffineTransformMakeScale(2, 2);
           cell.textLabel.font=[UIFont systemFontOfSize:16.0f];
            if (![_userPref getUserName]) {
                [_titleArr setObject:@"用户昵称" atIndexedSubscript:0];
            }
        }
        cell.imageView.image=_imageArr[indexPath.row];
        cell.textLabel.text=_titleArr[indexPath.row];
        
        return cell;
        
    }else if (indexPath.section==1){
        cell.imageView.image=_imageArr[indexPath.row+2];
        cell.textLabel.text=_titleArr[indexPath.row+2];
        return cell;
    }else if (indexPath.section==2){
        cell.imageView.image=_imageArr[indexPath.row+5];
        cell.textLabel.text=_titleArr[indexPath.row+5];
        return cell;
    }
    return nil;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return 50;
    }else
       return 5;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0000001;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0 && indexPath.row==0) {
        return 2*(SCREEN_HEIGHT-TABBAR_HEIGHT)/13;
    }
    return (SCREEN_HEIGHT-TABBAR_HEIGHT)/13;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==2) {
        UIView *view=[[UIView alloc]init];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(20, 10, SCREEN_WIDTH-40, 40);
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=10;
        btn.backgroundColor=UIColorWithRGBA(35, 165, 58, 1);
        if ([_userPref getUserName]) {
             [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        }else{
        [btn setTitle:@"点击登录" forState:UIControlStateNormal];
        
        }
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(exitBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        return view;
    }
    return nil;

}
#pragma mark --cell点击

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0 && indexPath.row==1) {
        //修改密码
    }
    if (indexPath.section==1) {
        switch (indexPath.row) {
            case 0:
                //我的收藏
                break;
            case 1:
                //我的买卖
                break;
            case 2:
                //我的帮助
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section==2) {
        switch (indexPath.row) {
            case 0:
                //我要分享
                
                break;
            case 1:{
                //客服电话
                BQMLog(@"正在打电话");
                UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://10010"]]];
                
            }
                break;
            case 2:{
                //关于我们
                AboutUsViewController *aboutVC=[[AboutUsViewController alloc]init];
                [self.navigationController pushViewController:aboutVC animated:YES];
                
            }
                break;
                
            default:
                break;
        }
    }

}
#pragma mark --点击退出登录
-(void)exitBtn:(UIButton *)btn{
    static int i=0;
    if (![_userPref getUserName]) {
        i=1;
    }
    if (i==0) {
        //清除用户信息
        [_userPref clearLoginInfo];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        i=1;
    }else{
//使用type字段标示注销登录   进入tabbarcontroller直接index为4（选中个人中心）
        LoginViewController *vc=(LoginViewController *)self.parentViewController.navigationController.viewControllers[0];
        vc.type=1;
        
        
        [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
        
        i=0;
    
    }

}
-(void)gotoPersonalCenter{
    RootViewController *rootVC=(RootViewController *)self.parentViewController;
    LoginViewController *vc=(LoginViewController *)self.parentViewController.navigationController.viewControllers[0];
    //    [self presentViewController:rootVC animated:NO completion:nil];
    [vc.navigationController pushViewController:rootVC animated:YES];



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
