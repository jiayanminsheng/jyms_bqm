//
//  SellViewController.m
//  Jiayan Livelihood
//
//  Created by 费砖烨蛇姬狮 on 16/1/10.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "SellViewController.h"
#import "MXPullDownMenu.h"

@interface SellViewController ()<MXPullDownMenuDelegate,UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating>{
   
    UISearchController *_search;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSMutableArray *_searchArr;
}

@end

@implementation SellViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _search.searchBar.hidden=NO;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _search.searchBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=GrayColor;
    [self creatUI];
}
#pragma mark --UI
-(void)creatUI{
    //搭建搜索视图
    //1.示例化
    _search = [[UISearchController alloc] initWithSearchResultsController:nil];
    _search.searchBar.frame=CGRectMake(0, 0, SCREEN_WIDTH, 40);
    //3.点击搜索框不隐藏navigationBar
    _search.hidesNavigationBarDuringPresentation = NO;
    //4.是否隐藏背景（灰色透明的背景）
    _search.dimsBackgroundDuringPresentation = NO;
    //5.修改外面的颜色
    _search.searchBar.barTintColor=[UIColor whiteColor];
    //6.修改里面的颜色
    [_search.searchBar layoutSubviews];//加载所有视图
    for (UIView *subView in [[_search.searchBar.subviews lastObject] subviews]) {
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField *textField=(UITextField *)subView;
            textField.backgroundColor=GrayColor;
        }
    }
    
    
    //7.设置代理
    _search.searchResultsUpdater = self;
    _search.delegate = self;
    [self.view addSubview:_search.searchBar];
    //下拉菜单
    NSArray *testArray;
    testArray = @[@[@"产品分类",@"1",@"2"], @[@"产品产地", @"1", @"2",@"3",@"4",@"5"],@[@"系统排序",@"1",@"2"]];
    
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:UIColorWithRGBA(35, 165, 58, 1)];
    menu.delegate = self;
    menu.frame = CGRectMake(0,40, menu.frame.size.width, menu.frame.size.height);
    [self.view addSubview:menu];
    
    //搭建tableview
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, menu.frame.size.height+10, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-NAVBAR_HEIGHT-SCREEN_HEIGHT/10.0-(menu.frame.size.height+10)) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    
}
#pragma mark --数据初始化
-(void)initData{
    
    _dataArr=[[NSMutableArray alloc]init];
    _searchArr=[[NSMutableArray alloc]init];
    
    
    
    
}
#pragma mark  --下载数据
-(void)DownLoadData{
    
    //使用searchArray专门负责数据的刷新
    _searchArr=_dataArr;
    
}

#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    //刷新数据,修改数据源
    NSLog(@"%ld -- %ld", (long)column, (long)row);
    
    
    
}
#pragma mark --UISearchResultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    //输关键字实时调用
    //    BQMLog(@"正在搜索");
    
    
    
}
#pragma mark --UISearchControllerDelegate
//searchController已经消失的时候调用这个方法
- (void)didDismissSearchController:(UISearchController *)searchController{
    _searchArr=_dataArr;
    
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _searchArr.count;
    
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
