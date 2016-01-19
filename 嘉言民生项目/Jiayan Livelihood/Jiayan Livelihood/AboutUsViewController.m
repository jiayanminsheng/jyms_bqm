//
//  AboutUsViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/19.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.title=@"关于我们";
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backBtn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationController.navigationBar addSubview:backBtn];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backItem;
    
    //UI
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://58.96.186.169:8088/API/basic/NewDetails.aspx?id=2"]]];
    [self.view addSubview:webView];
}
-(void)back{

    [self.navigationController popToRootViewControllerAnimated:NO];

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
