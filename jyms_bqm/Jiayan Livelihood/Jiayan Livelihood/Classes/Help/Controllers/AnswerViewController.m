//
//  AnswerViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/7.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "AnswerViewController.h"
#import "HelpAnswerCell.h"
#import "AFHelper.h"
#import "HelpModel.h"
#import "RDVTabBarController.h"
#import "MJRefresh.h"
#import "AnswerDetailViewController.h"

@interface AnswerViewController ()<UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate>{
    UISearchController *_search;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSMutableArray *_searchArr;
    //存储问题的数组
    NSMutableArray *_predicateArr;
}

@end

@implementation AnswerViewController
-(void)viewWillAppear:(BOOL)animated{
 [super viewWillAppear:animated];

   self.rdv_tabBarController.tabBarHidden = NO;
    _search.searchBar.hidden=NO;
    self.navigationController.toolbarHidden=YES;

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _search.searchBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=GrayColor;
    [self initData];
    [self creatUI];
    [self DownLoadData];
}
#pragma mark --数据初始化
-(void)initData{

   
    _searchArr=[[NSMutableArray alloc]init];
    _predicateArr=[[NSMutableArray alloc]init];



}
#pragma mark  --下载数据
-(void)DownLoadData{
     _dataArr=[[NSMutableArray alloc]init];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"q_list" forKey:@"key"];
    [AFHelper PostWithPath:@"/basic/show.ashx" andParameters:params andSuccess:^(id responseObject) {
        
        if (!responseObject) {
            return ;
        }
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        BQMLog(@"%@",dic);
        if ([dic[@"error"] intValue]==0) {
            NSArray *listArr=dic[@"list"];
            for (NSDictionary *dict in listArr) {
                HelpModel *model=[HelpModel parseWithDic:dict];
                [_dataArr addObject:model];
                [_predicateArr addObject:model.questions];
            }
            [_tableView.header endRefreshing];
            //使用searchArray专门负责数据的刷新
            _searchArr=_dataArr;
        dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
        });
        }
        
        
    } andFailure:^(NSError *error) {
       
        [self showHUDWithMessage:@"请求超时" view:self.view];
    }];

   
   
}

#pragma mark   --UI

-(void)creatUI{
    //搭建搜索视图
    //1.示例化
    _search = [[UISearchController alloc] initWithSearchResultsController:nil];
    _search.searchBar.frame=CGRectMake(0, 0, SCREEN_WIDTH, 40);
    _search.searchBar.showsCancelButton=NO;
    
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
    
    
    //搭建tableview
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-NAVBAR_HEIGHT-40-SCREEN_HEIGHT/10.0) style:UITableViewStyleGrouped];
    _tableView.tableFooterView = [[UIView alloc] init];
    //解决第一个cell头部留出的空白
    _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.0000001)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=UITableViewAutomaticDimension;//（使用这个默认值自适应高度）
    _tableView.estimatedRowHeight=153;
    [_tableView registerNib:[UINib nibWithNibName:@"HelpAnswerCell" bundle:nil] forCellReuseIdentifier:@"Answer"];
     [_tableView.header beginRefreshing];
    _tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //判断搜索处于编辑状态，下拉的时候不重新下载数据，不刷新tableview
        if (!(_search.searchBar.showsCancelButton)) {
            
            [self DownLoadData];
        }else{
        [_tableView.header endRefreshing];
        }
    }];
    [self.view addSubview:_tableView];
    

}


#pragma mark --UISearchResultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{

    //输关键字实时调用
    NSString * str = searchController.searchBar.text;
    //沙漏，用来筛选数据
    //NSPredicate
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",str];
    //在问题的数组中(_predicateArr)中通过指定的筛选条件去筛选出数据，把筛选到的符合条件的数据放到一个数组中返回
    NSArray * array = [_predicateArr filteredArrayUsingPredicate:pre];
//    BQMLog(@"＝＝＝＝＝＝＝%ld",array.count);
    //暂时存放根据问题对应的model
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    for (NSString *questions in array) {
        for (HelpModel *model in _dataArr) {
            if ([questions isEqualToString:model.questions]) {
                [arr addObject:model];
            }
        }
        
    }
    _searchArr=[[NSMutableArray alloc]initWithArray:arr];
    [_tableView reloadData];
   
}
#pragma mark --UISearchControllerDelegate
//searchController已经消失的时候调用这个方法
- (void)didDismissSearchController:(UISearchController *)searchController{
    _searchArr=_dataArr;
    [_tableView reloadData];
    
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpAnswerCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"Answer"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    HelpModel *model=_searchArr[indexPath.section];
    [cell refreshHelpCellWithModel:model];
    return cell;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _searchArr.count;

}

#pragma mark --UITableViewDelegate
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 150;
//
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0000001;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==_searchArr.count-1) {
        return 0.0000001;
    }
    return 10;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _search.searchBar.hidden=YES;
    HelpModel *model=_searchArr[indexPath.section];
    AnswerDetailViewController *detailVC=[[AnswerDetailViewController alloc]init];
    detailVC.navigationItem.title=[NSString stringWithFormat:@"%@%@",model.username,@"的问题"];
    detailVC.questionModel=model;
    [self.navigationController pushViewController:detailVC animated:NO];
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
