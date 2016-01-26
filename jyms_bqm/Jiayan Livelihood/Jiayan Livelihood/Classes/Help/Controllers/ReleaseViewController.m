//
//  ReleaseViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/14.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "ReleaseViewController.h"
#import "RDVTabBarController.h"
#import "AFHelper.h"
#import "UserPrefs.h"

@interface ReleaseViewController ()<UITextViewDelegate>{
    UITextView *_question;
    
}

@end

@implementation ReleaseViewController
-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
    self.rdv_tabBarController.tabBarHidden=YES;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
}
-(void)creatUI{
    //返回按钮
   
    UIButton *backBtn=[self creatleftBarButtonItemOfBack];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //提交按钮
    UIButton *submitBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *submitItem=[[UIBarButtonItem alloc]initWithCustomView:submitBtn];
    self.navigationItem.rightBarButtonItem=submitItem;
    
    self.navigationItem.title=@"描述你的问题";
    
    //问题
    _question=[[UITextView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _question.delegate=self;
    [self.view addSubview:_question];
    UILabel *placeHolder=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    placeHolder.tag=10;
    placeHolder.text=@"在此描述您要咨询的问题内容";
    placeHolder.enabled=NO;
    placeHolder.backgroundColor=[UIColor clearColor];
    [_question addSubview:placeHolder];
    

}
//实现UITextView的代理
-(void)textViewDidChange:(UITextView *)textView
{
    UILabel *label=[self.view viewWithTag:10];
    if (textView.text.length == 0) {
        label.text = @"在此描述您要咨询的问题内容";
    }else{
        label.text = @"";
    } 
}

-(void)backBtnClicked:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)submitBtnClicked:(UIButton *)btn{
    UserPrefs *userpref=[UserPrefs shareUserPrefs];
    NSString * userName=[userpref getUserName];
    NSString *userID=[userpref getuserID];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"q_add" forKey:@"key"];
    [params setObject:userName forKey:@"name"];
    [params setObject:userID forKey:@"Id"];
    [params setObject:_question.text forKey:@"questions"];
    [AFHelper PostWithPath:@"/basic/show.ashx" andParameters:params andSuccess:^(id responseObject) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error"] intValue]==0) {
            [self showHUDWithMessage:@"提交成功！" view:self.view];
        }else{
        
        [self showHUDWithMessage:@"请输入您要咨询的问题" view:self.view];
        }
        
    } andFailure:^(NSError *error) {
        [self showHUDWithMessage:@"请求超时" view:self.view];
    }];
    
   

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
