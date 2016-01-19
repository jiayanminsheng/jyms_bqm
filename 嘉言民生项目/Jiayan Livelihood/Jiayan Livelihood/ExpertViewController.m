//
//  ExpertViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/7.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "ExpertViewController.h"
#import "MXPullDownMenu.h"

@interface ExpertViewController ()<MXPullDownMenuDelegate,UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tableView;
    NSMutableArray *_dataArr;
}

@end

@implementation ExpertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=GrayColor;
    [self creatUI];
    
}
#pragma mark --UI
-(void)creatUI{
    //下拉菜单
    NSArray *testArray;
    testArray = @[@[@"所在地区",@"1",@"2"], @[@"擅长领域", @"禽畜养殖", @"种植技术",@"林业技术",@"渔业养殖",@"综合技术"],@[@"系统排序",@"服务人数",@"用户评价"]];
    
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:UIColorWithRGBA(35, 165, 58, 1)];
    menu.delegate = self;
    menu.frame = CGRectMake(0, 0, menu.frame.size.width, menu.frame.size.height);
    [self.view addSubview:menu];
    
    //搭建tableview
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, menu.frame.size.height+10, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-NAVBAR_HEIGHT-SCREEN_HEIGHT/10.0-(menu.frame.size.height+10)) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];


}
#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    //刷新数据,修改数据源
       NSLog(@"%ld -- %ld", column, row);
    
    

}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
    
}

#pragma mark --UITableViewDelegate


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
