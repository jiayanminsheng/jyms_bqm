//
//  AnswerDetailViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/13.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "AnswerDetailViewController.h"
#import "RDVTabBarController.h"
#import "AFHelper.h"
#import "HelpModel.h"
#import "HelpAnswerCell.h"
#import "ReplyCell.h"
#import "UserPrefs.h"

@interface AnswerDetailViewController ()<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITextView *_reply;
    UILabel *_placeHolder;
    NSMutableArray *_replyArr;
    UITableView *_tableView;
    UserPrefs *_userPref;
}

@end

@implementation AnswerDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rdv_tabBarController.tabBarHidden=YES;
    self.navigationController.toolbarHidden=NO;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.toolbar.tintColor=[UIColor redColor];
    //注册键盘变化观察对象
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
     name:UIKeyboardWillHideNotification 
     object:nil];
    // Do any additional setup after loading the view.
    [self initData];
    [self creatUI];
    [self DownLoadReplyData];
}
-(void)initData{
    _userPref=[UserPrefs shareUserPrefs];

    _replyArr=[[NSMutableArray alloc]init];

}
-(void)DownLoadReplyData{
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"r_list" forKey:@"key"];
        [params setObject:self.questionModel.questionID forKey:@"ref_id"];
        [AFHelper PostWithPath:@"/basic/show.ashx" andParameters:params andSuccess:^(id responseObject) {
            if (responseObject==nil) {
                return ;
            }
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"error"] intValue]==0) {
                NSArray *replyList=dic[@"list"];
                for (NSDictionary *dict in replyList) {
                    HelpModel *model=[HelpModel parseWithDic:dict];
                    [_replyArr addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
    
    
            }
    
        } andFailure:^(NSError *error) {
            [self showHUDWithMessage:@"请求失败" view:self.view];
        }];

}
-(void)creatUI{
    //返回按钮
    self.navigationItem.hidesBackButton=YES;
    //收藏
    UIButton *saveBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [saveBtn setImage:[UIImage imageNamed:@"收藏.png"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveItem=[[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem=saveItem;
    //工具栏
    CGFloat differ=SCREEN_WIDTH/10;
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, differ, 30)];
    backBtn.tag=20;
    [backBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"提问返回.png"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    _reply=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, differ*4,40)];
    _reply.delegate=self;
    _placeHolder=[[UILabel alloc]initWithFrame:CGRectMake(0, 5,differ*4, 20)];
    _placeHolder.font=[UIFont systemFontOfSize:11.0];
    _placeHolder.text=@"在此输入回复内容";
    _placeHolder.enabled=NO;
    _placeHolder.backgroundColor=[UIColor clearColor];
    [_reply addSubview:_placeHolder];
    UIBarButtonItem *replyItem=[[UIBarButtonItem alloc]initWithCustomView:_reply];
    
    UIButton *sendBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, differ*2, 40)];
    sendBtn.tag=21;
    [sendBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setImage:[UIImage imageNamed:@"发送-.png"] forState:UIControlStateNormal];
    UIBarButtonItem *sendItem=[[UIBarButtonItem alloc]initWithCustomView:sendBtn];
    
    UIButton *shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, differ*1.5, 40)];
    shareBtn.tag=22;
    [shareBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setImage:[UIImage imageNamed:@"分享.png"] forState:UIControlStateNormal];
    UIBarButtonItem *shareItem=[[UIBarButtonItem alloc]initWithCustomView:shareBtn];
    
    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems=@[backItem,space,replyItem,space,sendItem,space,shareItem];
    
    //搭建tableview
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT+5) style:UITableViewStyleGrouped];
    _tableView.tableFooterView = [[UIView alloc] init];
    //解决第一个cell头部留出的空白
    _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.0000001)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=UITableViewAutomaticDimension;//（使用这个默认值自适应高度）
    _tableView.estimatedRowHeight=153;
    [_tableView registerNib:[UINib nibWithNibName:@"HelpAnswerCell" bundle:nil] forCellReuseIdentifier:@"Answer"];
    [_tableView registerNib:[UINib nibWithNibName:@"ReplyCell" bundle:nil] forCellReuseIdentifier:@"Reply"];
    [self.view addSubview:_tableView];
    
}

-(void)clicked:(UIButton *)btn{
    switch (btn.tag) {
        case 20:
            //返回
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        case 21:
            //发送
            [self replyEvent];
//            _reply.text=nil;
            [_reply resignFirstResponder];
            
            break;
        case 22:
            //分享
            
            
            break;
            
        default:
            break;
    }

}
#pragma mark --发送事件
-(void)replyEvent{
    NSString *userID=[_userPref getuserID];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"r_add" forKey:@"key"];
    [params setObject:self.questionModel.questionID forKey:@"ref_id"];
    [params setObject:_reply.text forKey:@"reply"];
    [params setObject:userID forKey:@"user_id"];
    [AFHelper PostWithPath:@"/basic/show.ashx" andParameters:params andSuccess:^(id responseObject) {
        if (responseObject==nil) {
            return ;
        }
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error"] intValue]==0) {
            [self showHUDWithMessage:@"发送成功" view:self.view];
            
            
        }else{
            [self showHUDWithMessage:@"请输入您要咨询的问题" view:self.view];
            
        }
        
    } andFailure:^(NSError *error) {
        [self showHUDWithMessage:@"请求失败" view:self.view];
    }];
    
    //处理新增的问题  tableview新增一组
    
    NSString *userName=[_userPref getUserName];
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    date = [formatter stringFromDate:[NSDate date]];
    
    NSDictionary *dic=@{@"reply":_reply.text,@"username":userName,@"addtime":date};
    HelpModel *model=[HelpModel parseWithDic:dic];
    [_replyArr insertObject:model atIndex:0 ];
    dispatch_async(dispatch_get_main_queue(), ^{
        _reply.text=nil;
        [_tableView reloadData];
    });




}
-(void)saveBtnClicked:(UIButton *)btn{
//收藏事件
    



}
//实现UITextView的代理
-(void)textViewDidChange:(UITextView *)textView
{
   
    if (textView.text.length == 0) {
        _placeHolder.text = @"在此输入回复内容";
    }else{
        _placeHolder.text = @"";
    }

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [_reply resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)sender {
    //取出键盘的高度
    NSValue *endValue=sender.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect rect;
    [endValue getValue:&rect];
    //键盘弹出动画时间
    NSNumber *duration=sender.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    double animationDuration=[duration doubleValue];
    //是让toolbar实现动画 改变toolbar的center值
    [UIView animateWithDuration:animationDuration animations:^{
        CGPoint centerPoint=self.navigationController.toolbar.center;
        centerPoint.y=self.view.frame.size.height-rect.size.height-self.navigationController.toolbar.frame.size.height/2;
        self.navigationController.toolbar.center=centerPoint;
    }];
    
}

-(void)keyboardWillHide:(NSNotification *)sender
{
    //键盘弹出动画时间
    NSNumber *duration=sender.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    double animationDuration=[duration doubleValue];
    //是让toolbar实现动画 改变toolbar的center值
    [UIView animateWithDuration:animationDuration animations:^{
        self.navigationController.toolbar.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-22);
    }];
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        HelpAnswerCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"Answer"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell refreshHelpCellWithModel:self.questionModel];
        NSArray *arr=[self.questionModel.addtime componentsSeparatedByString:@" "];
        cell.releasetimeLabel.text=arr[0];
        return cell;
    }
    ReplyCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"Reply"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    HelpModel *model=_replyArr[indexPath.section-1];
    [cell refreshHelpCellWithModel:model];
    
    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _replyArr.count+1;
    
}

#pragma mark --UITableViewDelegate
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 150;
//
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0 || section==1) {
        return 20;
    }
    return 0.0000001;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==_replyArr.count-1        || section==0) {
        return 0.0000001;
    }
    return 10;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *headerTitle=@[@"问题:",@"回答:"];
    if (section==0 || section==1) {
        UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,0, 20)];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
        label.layer.masksToBounds=YES;
        label.layer.cornerRadius=2.0;
        label.backgroundColor=UIColorWithRGBA(35, 165, 58, 1);
        label.text=headerTitle[section];
        [headerView addSubview:label];
        return headerView;
    }
    return nil;

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
