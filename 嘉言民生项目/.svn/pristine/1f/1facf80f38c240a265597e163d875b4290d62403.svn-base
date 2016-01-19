//
//  BusinessViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/5.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "BusinessViewController.h"
#import "BuyViewController.h"
#import "SellViewController.h"

@interface BusinessViewController ()<UIScrollViewDelegate>{
     UIButton *_releaseBtn;
    UIScrollView *_scrollView;
    UILabel *_label;
    NSArray *_btnArr;
    NSArray *_btnSelArr;
    SellViewController *_sellVC;
}


@end

@implementation BusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
   //我要买和我要卖
    _btnArr=@[[UIImage imageNamed:@"我要买.png"],[UIImage imageNamed:@"我要卖.png"]];
    _btnSelArr=@[[UIImage imageNamed:@"我要买选中态.png"],[UIImage imageNamed:@"我要卖选中态.png"]];
    for (int i=0; i<2; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2.0+0.5)*i, NAVBAR_HEIGHT, SCREEN_WIDTH/2.0-0.5, NAVBAR_HEIGHT)];
        btn.backgroundColor=[UIColor whiteColor];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [btn setImage:_btnSelArr[i] forState:UIControlStateNormal];
        }else{
            [btn setImage:_btnArr[i] forState:UIControlStateNormal];
        }
        
        btn.tag=i+1;
        [self.view addSubview:btn];
    }
    //点击指示
    _label=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/6.0,2*NAVBAR_HEIGHT-2.0, SCREEN_WIDTH/6.0, 2.0)];
    _label.backgroundColor=UIColorWithRGBA(35, 165, 58, 1);
    [self.view addSubview:_label];
    
    
    //主要滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 2*NAVBAR_HEIGHT+2.0, SCREEN_WIDTH,SCREEN_HEIGHT-2*NAVBAR_HEIGHT-TABBAR_HEIGHT-2.0)];
//    _scrollView.backgroundColor=[UIColor redColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2,SCREEN_HEIGHT-2*NAVBAR_HEIGHT-TABBAR_HEIGHT-2.0);
    [self.view addSubview:_scrollView];
    [self addSubControllers];
    
    
}
-(void)addSubControllers
{
    BuyViewController *buyVC=[[BuyViewController alloc]init];
    buyVC.view.frame=CGRectMake(SCREEN_WIDTH*0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-2*NAVBAR_HEIGHT-TABBAR_HEIGHT-2.0);
    _sellVC=[[SellViewController alloc]init];
    _sellVC.view.frame=CGRectMake(SCREEN_WIDTH*1, 0, SCREEN_WIDTH, SCREEN_HEIGHT-2*NAVBAR_HEIGHT-TABBAR_HEIGHT-2.0);
    [_scrollView addSubview:buyVC.view];
    [_scrollView addSubview:_sellVC.view];
    [self addChildViewController:buyVC];
    [self addChildViewController:_sellVC];
    
}
#pragma mark --按钮事件
-(void)releaseBtnClicked:(UIButton *)btn{
    BQMLog(@"发布按钮被点击");
    
    
}
-(void)btnClicked:(UIButton *)btn{
    [btn setImage:_btnSelArr[btn.tag-1] forState:UIControlStateNormal];
    _scrollView.contentOffset=CGPointMake(SCREEN_WIDTH*(btn.tag-1), 0);
    
    //点击我要买
    if (btn.tag==1) {
        [_sellVC removeFromParentViewController];
        [_sellVC.view removeFromSuperview];
        
        
        _label.frame=CGRectMake(SCREEN_WIDTH/6.0,NAVBAR_HEIGHT+SCREEN_HEIGHT/10.0-2.0, SCREEN_WIDTH/6.0, 2.0);
        UIButton *buyBtn=[self.view viewWithTag:btn.tag+1];
        [buyBtn setImage:_btnArr[btn.tag] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem=nil;
        
        
        
    }
    //点击我要卖
    if (btn.tag==2) {
        [_scrollView addSubview:_sellVC.view];
        [self addChildViewController:_sellVC];
        
        _label.frame=CGRectMake(SCREEN_WIDTH/2.0+SCREEN_WIDTH/6.0,NAVBAR_HEIGHT+SCREEN_HEIGHT/10.0-2.0, SCREEN_WIDTH/6.0, 2.0);
        UIButton *sellBtn=[self.view viewWithTag:btn.tag-1];
        [sellBtn setImage:_btnArr[btn.tag-2] forState:UIControlStateNormal];
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:_releaseBtn];
        self.navigationItem.rightBarButtonItem=rightItem;
        
    }
    
    
    
    
}
#pragma mark --滑动回调
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    UIButton *btn=[self.view viewWithTag:index+1];
    [btn setImage:_btnSelArr[btn.tag-1] forState:UIControlStateNormal];
    //点击我要买
    if (btn.tag==1) {
        [_sellVC removeFromParentViewController];
        [_sellVC.view removeFromSuperview];
        
        
        _label.frame=CGRectMake(SCREEN_WIDTH/6.0,NAVBAR_HEIGHT+SCREEN_HEIGHT/10.0-2.0, SCREEN_WIDTH/6.0, 2.0);
        UIButton *buyBtn=[self.view viewWithTag:btn.tag+1];
        [buyBtn setImage:_btnArr[btn.tag] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem=nil;
        
        
    }
    //点击我要卖
    if (btn.tag==2) {
        [_scrollView addSubview:_sellVC.view];
        [self addChildViewController:_sellVC];
        
        
        _label.frame=CGRectMake(SCREEN_WIDTH/2.0+SCREEN_WIDTH/6.0,NAVBAR_HEIGHT+SCREEN_HEIGHT/10.0-2.0, SCREEN_WIDTH/6.0, 2.0);
        UIButton *sellBtn=[self.view viewWithTag:btn.tag-1];
        [sellBtn setImage:_btnArr[btn.tag-2] forState:UIControlStateNormal];
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:_releaseBtn];
        self.navigationItem.rightBarButtonItem=rightItem;
        
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
