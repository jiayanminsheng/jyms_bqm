//
//  mySaveViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/22.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "mySaveViewController.h"
#import "mySaveFirstViewController.h"
#import "mySaveSecondViewController.h"
#import "mySaveThirdViewController.h"
#import "RDVTabBarController.h"



@interface mySaveViewController ()<UIScrollViewDelegate>{

    UIScrollView *_scrollView;
    UILabel *_label;

}

@end

@implementation mySaveViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rdv_tabBarController.tabBarHidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor=GrayColor;
    [self creatUI];
    
}
-(void)creatUI{
       //导航返回按钮
       self.navigationItem.title=@"我的收藏";
       UIButton *backBtn= [self creatleftBarButtonItemOfBack];
       [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];


        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH,SCREEN_HEIGHT*0.06)];
        view.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view];
        CGFloat differ=(SCREEN_WIDTH-3*SCREEN_WIDTH*0.1799)/4.0;
        //按钮
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(differ,(SCREEN_HEIGHT*0.06-(SCREEN_HEIGHT*0.4527*0.06))/2.0,SCREEN_WIDTH*0.1799,SCREEN_HEIGHT*0.4527*0.06)];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"了解政策.png"] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn1.tag=10;
        [view addSubview:btn1];
    
        UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(btn1.frame.origin.x+btn1.frame.size.width+differ,btn1.frame.origin.y, btn1.frame.size.width, SCREEN_HEIGHT*0.4527*0.06)];
        [btn2 setBackgroundImage:[UIImage imageNamed:@"嘉言民生.png"] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn2.tag=11;
        [view addSubview:btn2];
    
        UIButton *btn3=[[UIButton alloc]initWithFrame:CGRectMake(btn2.frame.origin.x+btn2.frame.size.width+differ, btn1.frame.origin.y, btn1.frame.size.width, SCREEN_HEIGHT*0.4527*0.06)];
        [btn3 setBackgroundImage:[UIImage imageNamed:@"关注三农.png"] forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn3.tag=12;
        [view addSubview:btn3];
    
        //点击指示
        _label=[[UILabel alloc]initWithFrame:CGRectMake(btn1.frame.origin.x, SCREEN_HEIGHT*0.06-2.0, SCREEN_WIDTH*0.1799, 2.0)];
        _label.backgroundColor=UIColorWithRGBA(35, 165, 58, 1);
        [view  addSubview:_label];
    
    //主要滑动视图
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,NAVBAR_HEIGHT+SCREEN_HEIGHT*0.06, SCREEN_WIDTH, SCREEN_HEIGHT-(NAVBAR_HEIGHT+SCREEN_HEIGHT*0.06))];
    //    _scrollView.backgroundColor=[UIColor redColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3,SCREEN_HEIGHT-(NAVBAR_HEIGHT+SCREEN_HEIGHT*0.06));
        [self.view addSubview:_scrollView];
        [self addSubControllers];

    
    
}
-(void)addSubControllers
{
    //子控制器
    mySaveFirstViewController *firstvc=[[mySaveFirstViewController alloc]init];
    firstvc.view.backgroundColor=[UIColor redColor];
    firstvc.view.frame=CGRectMake(SCREEN_WIDTH*0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-(NAVBAR_HEIGHT+SCREEN_HEIGHT*0.06));
    mySaveSecondViewController *secondvc=[[mySaveSecondViewController alloc]init];
    secondvc.view.backgroundColor=[UIColor yellowColor];
    secondvc.view.frame=CGRectMake(SCREEN_WIDTH*1,0, SCREEN_WIDTH, SCREEN_HEIGHT-(NAVBAR_HEIGHT+SCREEN_HEIGHT*0.06));
    mySaveThirdViewController *thirdvc=[[mySaveThirdViewController alloc]init];
    thirdvc.view.backgroundColor=[UIColor greenColor];
    thirdvc.view.frame=CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH,SCREEN_HEIGHT-(NAVBAR_HEIGHT+SCREEN_HEIGHT*0.06));
    [_scrollView addSubview:firstvc.view];
    [_scrollView addSubview:secondvc.view];
    [_scrollView addSubview:thirdvc.view];
    [self addChildViewController:firstvc];
    [self addChildViewController:secondvc];
    [self addChildViewController:thirdvc];
    
}
#pragma mark --按钮事件
-(void)btnClicked:(UIButton *)btn{
    _scrollView.contentOffset=CGPointMake(SCREEN_WIDTH*(btn.tag-10), 0);
    _label.frame=CGRectMake(btn.frame.origin.x, SCREEN_HEIGHT*0.06-2.0, SCREEN_WIDTH*0.1799, 2.0);

}
-(void)back{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}
#pragma mark --滑动回调
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    UIButton *btn=[self.view viewWithTag:index+10];
    _label.frame=CGRectMake(btn.frame.origin.x, SCREEN_HEIGHT*0.06-2.0, SCREEN_WIDTH*0.1799, 2.0);
    
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
