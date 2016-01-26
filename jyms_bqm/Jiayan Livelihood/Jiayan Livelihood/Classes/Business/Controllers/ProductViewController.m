//
//  ProductViewController.m
//  01demo
//
//  Created by bqm on 16/1/26.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "ProductViewController.h"
#import "RDVTabBarController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController
-(void)viewWillAppear:(BOOL)animated{
    self.rdv_tabBarController.tabBarHidden=YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
