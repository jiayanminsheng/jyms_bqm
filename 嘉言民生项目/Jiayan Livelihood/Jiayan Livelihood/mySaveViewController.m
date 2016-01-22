//
//  mySaveViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/22.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "mySaveViewController.h"


@interface mySaveViewController ()

@end

@implementation mySaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.toolbarHidden=NO;
    self.navigationController.toolbar.frame=CGRectMake(0, 64, SCREEN_WIDTH,SCREEN_HEIGHT*0.06);
    
    
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
