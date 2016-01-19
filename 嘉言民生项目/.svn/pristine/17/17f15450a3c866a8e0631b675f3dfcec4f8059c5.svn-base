//
//  RootViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/5.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "RootViewController.h"
#import "RDVTabBarItem.h"
#import "HomeViewController.h"
#import "PolicyViewController.h"
#import "HelpViewController.h"
#import "BusinessViewController.h"
#import "PersonalCenterViewController.h"
#import "jiayan-swift.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    // 首页
//    HomeViewController *homeVC=[[HomeViewController alloc]init];
//    homeVC.title=@"首页";
    HomeVC *homeVC=[[HomeVC alloc]init];
    UINavigationController *homeNC=[[UINavigationController alloc]initWithRootViewController:homeVC];
    [homeVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    // 政策
//    PolicyViewController *policyVC=[[PolicyViewController alloc]init];
    PolicyVC *policyVC=[[PolicyVC alloc]init];
    policyVC.title=@"了解政策";
    UINavigationController *policyNC=[[UINavigationController alloc]initWithRootViewController:policyVC];
    
    // 帮助
    HelpViewController *helpVC=[[HelpViewController alloc]init];
    helpVC.title=@"需要帮助";
    UINavigationController *helpNC=[[UINavigationController alloc]initWithRootViewController:helpVC];
    
    //我要买卖
    BusinessViewController *businessVC=[[BusinessViewController alloc]init];
    businessVC.title=@"我要买卖";
    UINavigationController *businessNC=[[UINavigationController alloc]initWithRootViewController:businessVC];
    
    // 个人中心
    PersonalCenterViewController *personalCenterVC=[[PersonalCenterViewController alloc]init];
    personalCenterVC.title=@"个人中心";
    UINavigationController *personalCenterNC=[[UINavigationController alloc]initWithRootViewController:personalCenterVC];
    
    
    self.viewControllers = @[homeNC, policyNC, helpNC,businessNC,personalCenterNC];
    if (self.type==1) {
        self.selectedIndex=4;
        
    }

    //设置tabBar
    [self setupTabbar];
    
}

-(void)setupTabbar
{
    // tabbar图片
    NSArray * imageNames = @[@"首页icon",@"了解政策icon",@"需要帮助icon",@"我要买卖icon",@"个人中心icon"];
    
    // tabbar上文字信息
    NSArray * nameArr = @[@"首页", @"了解政策", @"需要帮助", @"我要买卖",@"个人中心"];
    
    NSDictionary * normalTitleAttri = @{NSFontAttributeName : [UIFont systemFontOfSize:9.0f], NSForegroundColorAttributeName :UIColorWithRGBA(47, 47, 47, 1)};
    NSDictionary * selectedTitleAttri = @{NSFontAttributeName : [UIFont systemFontOfSize:9.0f], NSForegroundColorAttributeName : UIColorWithRGBA(35, 165, 58, 1)};
    
    // 下标起始设置
    NSInteger index = 0;
    
    for(RDVTabBarItem * item in self.tabBar.items){
        UIImage * normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_正常状态.png", imageNames[index]]];
        UIImage * selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_选中状态.png", imageNames[index]]];
        
        // 设置文字字号和颜色
        item.selectedTitleAttributes = selectedTitleAttri;
        item.unselectedTitleAttributes = normalTitleAttri;
        
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
        
        // 设置title
        item.title = nameArr[index];
        
        index++;
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
