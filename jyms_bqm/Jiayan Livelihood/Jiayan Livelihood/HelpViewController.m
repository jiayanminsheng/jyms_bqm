//
//  HelpViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/5.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "HelpViewController.h"
#import "AnswerViewController.h"
#import "ExpertViewController.h"
#import "ReleaseViewController.h"


@interface HelpViewController ()<UIScrollViewDelegate>{
    UIButton *_releaseBtn;
    UIScrollView *_scrollView;
    UILabel *_label;
    NSArray *_btnArr;
    NSArray *_btnSelArr;
    AnswerViewController *_answerVC;
}


@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=GrayColor;
    [self creatUI];
   
    
}
-(void)creatUI{
    //navBarItem
    _releaseBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    _releaseBtn.tag=3;
    [_releaseBtn setImage:[UIImage imageNamed:@"发布按钮.png"] forState:UIControlStateNormal];
    [_releaseBtn addTarget:self action:@selector(releaseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:_releaseBtn];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    _btnArr=@[[UIImage imageNamed:@"问答平台.png"],[UIImage imageNamed:@"专家热线.png"]];
    _btnSelArr=@[[UIImage imageNamed:@"问答平台xz.png"],[UIImage imageNamed:@"专家热线选中态.png"]];
    for (int i=0; i<2; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2.0+0.5)*i, NAVBAR_HEIGHT, SCREEN_WIDTH/2.0-0.5, SCREEN_HEIGHT/13.0)];
        btn.backgroundColor=[UIColor whiteColor];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(SCREEN_HEIGHT/20.0f,SCREEN_WIDTH/3.0f , SCREEN_HEIGHT/20.0f,SCREEN_WIDTH/3.0f)];
        if (i==0) {
            
            [btn setImage:_btnSelArr[i] forState:UIControlStateNormal];
        }else{
            [btn setImage:_btnArr[i] forState:UIControlStateNormal];
        }
        
        btn.tag=i+1;
        [self.view addSubview:btn];
    }
    //点击指示
    _label=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/6.0,NAVBAR_HEIGHT+SCREEN_HEIGHT/13.0-2.0, SCREEN_WIDTH/6.0, 2.0)];
    _label.backgroundColor=UIColorWithRGBA(35, 165, 58, 1);
    [self.view addSubview:_label];
    
    
    //主要滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT+SCREEN_HEIGHT/13.0+1.0, SCREEN_WIDTH, SCREEN_HEIGHT-(NAVBAR_HEIGHT+SCREEN_HEIGHT/13.0+1.0))];
//    _scrollView.backgroundColor=[UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2,SCREEN_HEIGHT-(NAVBAR_HEIGHT+SCREEN_HEIGHT/13.0+1.0));
    [self.view addSubview:_scrollView];
    [self addSubControllers];
    

}
-(void)addSubControllers
{
    _answerVC=[[AnswerViewController alloc]init];
    _answerVC.view.frame=CGRectMake(SCREEN_WIDTH*0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-(NAVBAR_HEIGHT+SCREEN_HEIGHT/13.0+1.0));
    ExpertViewController *expertVC=[[ExpertViewController alloc]init];
    expertVC.view.frame=CGRectMake(SCREEN_WIDTH*1, 0, SCREEN_WIDTH, SCREEN_HEIGHT-(NAVBAR_HEIGHT+SCREEN_HEIGHT/13.0+1.0));
    [_scrollView addSubview:_answerVC.view];
    [_scrollView addSubview:expertVC.view];
    [self addChildViewController:_answerVC];
    [self addChildViewController:expertVC];
    
}
#pragma mark --按钮事件
-(void)releaseBtnClicked:(UIButton *)btn{
//    BQMLog(@"发布按钮被点击");
   
    //push动画 从下面弹出
    CATransition *transition = [CATransition animation];
    
    transition.duration =0.0f;
    
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    transition.type = kCATransitionPush;
    
    transition.subtype = kCATransitionFromTop;
    
    transition.delegate = self;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    
    ReleaseViewController *releaseVC=[[ReleaseViewController alloc]init];
    
    [self.navigationController pushViewController:releaseVC animated:NO];
    


}
-(void)btnClicked:(UIButton *)btn{
    [btn setImage:_btnSelArr[btn.tag-1] forState:UIControlStateNormal];
    _scrollView.contentOffset=CGPointMake(SCREEN_WIDTH*(btn.tag-1), 0);
    
    //点击问答平台
    if (btn.tag==1) {
        [_scrollView addSubview:_answerVC.view];
        [self addChildViewController:_answerVC];
        
        
        _label.frame=CGRectMake(SCREEN_WIDTH/6.0,NAVBAR_HEIGHT+SCREEN_HEIGHT/13.0-2.0, SCREEN_WIDTH/6.0, 2.0);
        UIButton *expertBtn=[self.view viewWithTag:btn.tag+1];
        [expertBtn setImage:_btnArr[btn.tag] forState:UIControlStateNormal];
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:_releaseBtn];
        self.navigationItem.rightBarButtonItem=rightItem;
        
        
    }
    //点击专家热线
    if (btn.tag==2) {
        //搜索控制器的改变
        [_answerVC removeFromParentViewController];
        [_answerVC.view removeFromSuperview];
        
        
        _label.frame=CGRectMake(SCREEN_WIDTH/2.0+SCREEN_WIDTH/6.0,NAVBAR_HEIGHT+SCREEN_HEIGHT/13.0-2.0, SCREEN_WIDTH/6.0, 2.0);
        UIButton *answerBtn=[self.view viewWithTag:btn.tag-1];
        [answerBtn setImage:_btnArr[btn.tag-2] forState:UIControlStateNormal];
        //移除发布按钮
        self.navigationItem.rightBarButtonItem=nil;
        
        
    }

}
#pragma mark --滑动回调
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    UIButton *btn=[self.view viewWithTag:index+1];
    [btn setImage:_btnSelArr[btn.tag-1] forState:UIControlStateNormal];
    //点击问答平台
    if (btn.tag==1) {
        [_scrollView addSubview:_answerVC.view];
        [self addChildViewController:_answerVC];

        
        
        _label.frame=CGRectMake(SCREEN_WIDTH/6.0,NAVBAR_HEIGHT+SCREEN_HEIGHT/13.0-2.0, SCREEN_WIDTH/6.0, 2.0);
        UIButton *expertBtn=[self.view viewWithTag:btn.tag+1];
        [expertBtn setImage:_btnArr[btn.tag] forState:UIControlStateNormal];
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:_releaseBtn];
        self.navigationItem.rightBarButtonItem=rightItem;
        
    }
    //点击专家热线
    if (btn.tag==2) {
        
        [_answerVC removeFromParentViewController];
        [_answerVC.view removeFromSuperview];
        
        
        _label.frame=CGRectMake(SCREEN_WIDTH/2.0+SCREEN_WIDTH/6.0,NAVBAR_HEIGHT+SCREEN_HEIGHT/13.0-2.0, SCREEN_WIDTH/6.0, 2.0);
        UIButton *answerBtn=[self.view viewWithTag:btn.tag-1];
        [answerBtn setImage:_btnArr[btn.tag-2] forState:UIControlStateNormal];
        //移除发布按钮
        self.navigationItem.rightBarButtonItem=nil;
        
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
