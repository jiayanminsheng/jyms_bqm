//
//  startViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/6.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "startViewController.h"
//#import "RootViewController.h"
#import "LoginViewController.h"

@interface startViewController ()

@end

@implementation startViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor=[UIColor redColor];
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.contentSize=CGSizeMake(self.view.bounds.size.width*3, self.view.bounds.size.height);
    scrollView.bounces=NO;
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    
    for (int i=0; i<3; i++) {
        NSString *imageName=[NSString stringWithFormat:@"引导页%d.png",i+1];
        UIImage *image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        imageView.userInteractionEnabled=YES;
        imageView.image=image;
        [scrollView addSubview:imageView];
        
        if (i==2) {
            UIPanGestureRecognizer *tap=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(presentRootViewController:)];
            [imageView addGestureRecognizer:tap];
           
        }
        
    }
}

-(void)presentRootViewController:(UITapGestureRecognizer *)tap{

    LoginViewController *loginVC=[[LoginViewController alloc]init];
    UINavigationController *loginNC=[[UINavigationController alloc]initWithRootViewController:loginVC];
    loginNC.navigationBarHidden=YES;
    [self presentViewController:loginNC animated:NO completion:nil];

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
