//
//  BaseViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/12.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()<MBProgressHUDDelegate>{
    
    MBProgressHUD *_HUD;
    
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark --MBProgressHUD
//普通带提示
-(void)showHUDWithTitle:(NSString *)title Message:(NSString *)message view:(UIView *)view{
    _HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    _HUD.delegate = self;
    
    //常用的设置
    //小矩形的背景色
    _HUD.color = [UIColor redColor];//这儿表示无背景
    //显示的文字
    _HUD.labelText = title;
    //细节文字
    _HUD.detailsLabelText = message;
    //是否有庶罩
    _HUD.dimBackground = NO;
    [_HUD hide:YES afterDelay:1];
    
}
//只显示文字
-(void)showHUDWithMessage:(NSString *)message view:(UIView *)view{
    _HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //显示模式
    _HUD.mode = MBProgressHUDModeText;
    _HUD.labelText = message;
    _HUD.margin = 10.0f;
    _HUD.yOffset =0;
    _HUD.removeFromSuperViewOnHide = YES;
    [_HUD hide:YES afterDelay:1];
    
}
//圆形进度条
//-(void)creatUIThird{
//    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:_HUD];
//    // MBProgressHUDModeDeterminateHorizontalBar 水平线的模式
//    //MBProgressHUDModeAnnularDeterminate 圆形的模式
//    // MBProgressHUDModeDeterminate  三角转盘的模式
//    _HUD.mode = MBProgressHUDModeDeterminate;
//    _HUD.delegate = self;
//    _HUD.labelText = @"Loading";
//    [_HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
//    
//}
//-(void) myProgressTask{
//    float progress = 0.0f;
//    while (progress < 1.0f) {
//        progress += 0.01f;
//        _HUD.progress = progress;
//        usleep(50000);
//    }
//    
//}
//显示自定义的view
//-(void)creatUIForth{
//    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:_HUD];
//    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
//    imageview.image=[UIImage imageNamed:@"bg.jpg"];
//    imageview.layer.masksToBounds=YES;
//    imageview.layer.cornerRadius=5.0;
//    _HUD.customView = imageview;
//    // Set custom view mode
//    /*
//     MBProgressHUDModeIndeterminate, 默认的
//     MBProgressHUDModeDeterminate,
//     MBProgressHUDModeDeterminateHorizontalBar,
//     MBProgressHUDModeAnnularDeterminate,
//     MBProgressHUDModeCustomView,
//     MBProgressHUDModeText
//     */
//    
//    _HUD.mode = MBProgressHUDModeCustomView;
//    _HUD.delegate = self;
//    _HUD.labelText = @"Loading.....";
//    _HUD.labelColor=[UIColor blackColor];
//    _HUD.color=[UIColor clearColor];
//    [_HUD show:YES];
////    [_HUD hide:YES afterDelay:3];
//    
//    
//}

//回调方法 隐藏后执行
- (void)hudWasHidden:(MBProgressHUD *)hud{
    
//    BQMLog(@"加载完成");
    
    
}
#pragma mark --navigationItem
-(UIButton *)creatleftBarButtonItemOfBack{
    self.navigationItem.hidesBackButton=YES;
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backBtn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    //调整返回按钮距离左屏幕边的距离
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    
    self.navigationItem.leftBarButtonItems=@[negativeSpacer,backItem];
    return backBtn;
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
