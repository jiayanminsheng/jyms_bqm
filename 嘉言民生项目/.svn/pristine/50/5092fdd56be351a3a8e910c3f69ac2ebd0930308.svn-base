//
//  BuyViewController.m
//  Jiayan Livelihood
//
//  Created by 费砖烨蛇姬狮 on 16/1/10.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "BuyViewController.h"
#import "BQMImageView.h"

@interface BuyViewController ()

@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatUI];
    
}
#pragma mark --UI
-(void)creatUI{
    UIImageView *bg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2*self.view.frame.size.height/3.0)];
    bg.backgroundColor=[UIColor greenColor];
    [self.view addSubview:bg];
    
    NSArray *iconArr=@[[UIImage imageNamed:@"TianMao.png"],[UIImage imageNamed:@"TaoBao.png"],[UIImage imageNamed:@"JingDong.png"],[UIImage imageNamed:@"GanJi.png"],[UIImage imageNamed:@"1HaoDian.png"],[UIImage imageNamed:@"GuoHongShangCheng200x200.png"],[UIImage imageNamed:@"GuoHongShangCheng200x200.png"],[UIImage imageNamed:@"58.png"],[UIImage imageNamed:@"SuNing.png"],[UIImage imageNamed:@"GuoMei.png"],[UIImage imageNamed:@"WeiPinHui.png"],[UIImage imageNamed:@"DangDang.png"]];
    CGFloat width=(SCREEN_WIDTH-50)/4;
    for (int i=0; i<12; i++) {
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((i%4+1)*10+(i%4)*width,(i/4+1)*10+(i/4)*width, width, width)];
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=width/2.0;
        btn.tag=i+1;
        btn.backgroundColor=[UIColor redColor];
        
        if (i/4==1) {
            btn.frame=CGRectMake((i%4+1)*10+(i%4)*width,(i/4)*10+20+(i/4)*width, width, width);
        }
        if (i/4==2) {
            btn.frame=CGRectMake((i%4+1)*10+(i%4)*width,(i/4)*20+10+(i/4)*width, width, width);
        }
        if (i!=5 && i!=6) {
            [btn setImage:iconArr[i] forState:UIControlStateNormal];
             [self.view addSubview:btn];
        }else{
            UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(25+2*width-((width+40)/2.0), 5+width, width+40, width+40)];
            btn.backgroundColor=[UIColor greenColor];
            btn.layer.masksToBounds=YES;
            btn.layer.cornerRadius=btn.frame.size.width/2.0;
            [btn setImage:iconArr[5] forState:UIControlStateNormal];
            [self.view addSubview:btn];
        
        }
       
    }
    
    BQMImageView *ADImageView=[[BQMImageView alloc]initWithFrame:CGRectMake(0, 50+3*width, SCREEN_WIDTH, self.view.frame.size.height/3.0)];
    ADImageView.backgroundColor=[UIColor redColor];
    ADImageView.image=[UIImage imageNamed:@"720x280活动图.png"];
    [ADImageView addTarget:self action:@selector(ADclicked:)];
    [self.view addSubview:ADImageView];


}
-(void)ADclicked:(BQMImageView *)imageView{

    BQMLog(@"广告被点击");

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
