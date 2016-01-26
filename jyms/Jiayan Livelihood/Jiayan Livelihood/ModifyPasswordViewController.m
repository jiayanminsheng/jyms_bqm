//
//  ModifyPasswordViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/20.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "ModifyPasswordViewController.h"

@interface ModifyPasswordViewController ()

@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=GrayColor;
    [self creatUI];
}
-(void)creatUI{
    self.sureModifyBtn.layer.masksToBounds=YES;
    self.sureModifyBtn.layer.cornerRadius=5;
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.title=@"密码修改";
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backBtn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    //调整返回按钮距离左屏幕边的距离
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    
    self.navigationItem.leftBarButtonItems=@[negativeSpacer,backItem];

}
-(void)back{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}
- (IBAction)ModifyPassword:(id)sender {
    
    
    
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
