//
//  SellViewController.m
//  Jiayan Livelihood
//
//  Created by 费砖烨蛇姬狮 on 16/1/10.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "SellViewController.h"
#import "RDVTabBarController.h"
#import "SellDetailViewController.h"
#import "MXPullDownMenu.h"
#import "AFHelper.h"
#import "ProductModel.h"
#import "MJRefresh.h"

@interface SellViewController ()<MXPullDownMenuDelegate,UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating>{
   
   
    UIView             *_categoryBar;//信息筛选下拉框
    
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSMutableArray *_searchArr;
    
    NSString *str;
    
    //存储问题的数组
    NSMutableArray *_predicateArr;
    
    BOOL isChanged;
    
}

@end

@implementation SellViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    isChanged=NO;
    [self initData];
    //创建ui
    [self creatUI];
    //下载数据
    [self DownLoadData];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.rdv_tabBarController.tabBarHidden=NO;
    //显示tabbar
    [self displayTabbar];
}

-(void)displayTabbar
{
     [self.parentViewController.rdv_tabBarController setTabBarHidden:NO];
    
}
#pragma mark --UI
-(void)creatUI{
    //搭建搜索视图
    //1.示例化
    _seachview=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0, SCREEN_WIDTH, SCREEN_HEIGHT*0.06f)];
    [_seachview setBackgroundColor:[UIColor whiteColor]];
    __search = [[UISearchController alloc] initWithSearchResultsController:nil];
    __search.searchBar.frame=CGRectMake(0, SCREEN_HEIGHT*0, SCREEN_WIDTH, 40);
    //3.点击搜索框不隐藏navigationBar
    __search.hidesNavigationBarDuringPresentation = NO;
    //4.是否隐藏背景（灰色透明的背景）
    __search.dimsBackgroundDuringPresentation = NO;
    //5.修改外面的颜色
    __search.searchBar.barTintColor=[UIColor whiteColor];
    //6.修改里面的颜色
    [__search.searchBar layoutSubviews];//加载所有视图
    for (UIView *subView in [[__search.searchBar.subviews lastObject] subviews]) {
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField *textField=(UITextField *)subView;
            textField.backgroundColor=GrayColor;
        }
    }
    //7.设置代理
    __search.searchResultsUpdater = self;
    __search.delegate = self;
    [_seachview addSubview:__search.searchBar];
    [self.sellScrollView addSubview:_seachview];
    [__search.searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    //[_search.searchBar setBackgroundColor:[UIColor redColor]];
    //[_search.searchBar.layer setBorderColor:[UIColor blueColor].CGColor];
    //[_search.searchBar.layer setBorderWidth:0.0f];
    //[self.view bringSubviewToFront:_search.searchBar];
    //下拉菜单
    NSArray *testArray;
    testArray = @[@[@"产品分类",@"1",@"2"], @[@"产品产地", @"1", @"2",@"3",@"4",@"5"],@[@"系统排序",@"1",@"2"]];
    
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:UIColorWithRGBA(35, 165, 58, 1)];
    menu.delegate = self;
    menu.frame = CGRectMake(0,SCREEN_HEIGHT*0.06f, menu.frame.size.width, menu.frame.size.height);
    [self.sellScrollView addSubview:menu];
    
    //搭建tableview
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, menu.frame.size.height+SCREEN_HEIGHT*0.06f, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-NAVBAR_HEIGHT-SCREEN_HEIGHT/10.0-(menu.frame.size.height+10)) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.01f, 0.01f)];
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.01f, 0.01f)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    //[_tableView setBounces:NO];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    [_tableView.header beginRefreshing];
    _tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //判断搜索处于编辑状态，下拉的时候不重新下载数据，不刷新tableview
        if (!(__search.searchBar.showsCancelButton)) {
            
            [self DownLoadData];
        }else{
            [_tableView.header endRefreshing];
        }
        
    }];
    
    [self.sellScrollView addSubview:_tableView];
    
    
}

//初始化信息排序下拉框


#pragma mark --数据初始化
-(void)initData{
    
    
    _searchArr=[[NSMutableArray alloc]init];
    _predicateArr=[[NSMutableArray alloc]init];
    
    
    
}
#pragma mark  --下载数据
-(void)DownLoadData{
    _dataArr=[[NSMutableArray alloc]init];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"p_list" forKey:@"key"];
    [AFHelper PostWithPath:@"/basic/show.ashx" andParameters:params andSuccess:^(id responseObject) {
        if (responseObject==nil) {
            return ;
        }
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *listArr=dic[@"list"];
        for (NSDictionary *dict in listArr) {
            ProductModel *model=[ProductModel parseWithDic:dict];
            [_dataArr addObject:model];
            [_predicateArr addObject:model.title];
        }
        [_tableView.header endRefreshing];
        //使用searchArray专门负责数据的刷新
        _searchArr=_dataArr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];

        });
    } andFailure:^(NSError *error) {
        [self showHUDWithMessage:@"网络请求失败" view:self.view];
    }];
    
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
    NSString * str = searchController.searchBar.text;
    //沙漏，用来筛选数据
    //NSPredicate
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",str];
    //在标题的数组中(_predicateArr)中通过指定的筛选条件去筛选出数据，把筛选到的符合条件的数据放到一个数组中返回
    NSArray * array = [_predicateArr filteredArrayUsingPredicate:pre];
    //暂时存放根据问题对应的model
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    for (ProductModel *model in _dataArr) {
        for (NSString *title in array) {
            if ([model.title isEqualToString:title]) {
                [arr addObject:model];
                break;
            }
        }
    }
    _searchArr=[[NSMutableArray alloc]initWithArray:arr];
    isChanged=YES;
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
    
    return _searchArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdientifer=@"sellTable";//tableview标识符
    UITableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:tableIdientifer];
    if (cell==nil||isChanged==YES)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdientifer];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    
     ProductModel *model=_searchArr[indexPath.row];
    
    //设置分割线
    UIView *lineView=[self loadLineView];
    
    //加载图片
    UIImageView *imageView=[self loadImageView];
    
    //加载商品标题
    
    UILabel *labelTitle=[self loadTitle];
    labelTitle.text=model.title;
    
    //加载商品类型
    UILabel *labelName=[self loadProductName];
   labelName.text=model.typeName;
    
    //加载商品产地
    UILabel *labelSource=[self loadSource];
   labelSource.text=model.address;
    
    //加载商品价格
    UILabel *labelPrice=[self loadPrice];
    labelPrice.text=model.price_unit;

    //加载商品总量
    UILabel *labelAmount=[self loadAmount];
    labelAmount.text=model.num_unit;
    
    //加载发送时间
    UILabel *labelDate=[self loadDate];
    NSArray *timeArr=[model.addtime componentsSeparatedByString:@" "];
    labelDate.text=timeArr[0];
    
    
    [cell.contentView addSubview:lineView];
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:labelTitle];
    [cell.contentView addSubview:labelName];
    [cell.contentView addSubview:labelSource];
    [cell.contentView addSubview:labelPrice];
    [cell.contentView addSubview:labelAmount];
    [cell.contentView addSubview:labelDate];
        
        if (_searchArr.count==indexPath.row+1) {
            isChanged=NO;
        }
        
    }


    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT/5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SellDetailViewController *sdVC=[[SellDetailViewController alloc]init];
    [self.navigationController pushViewController:sdVC animated:YES];
}


//----------------------------------------------

//加载分割线
-(UIView*) loadLineView
{
    UIView * lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT*0.01f)];
    [lineView setBackgroundColor:GrayColor];
    
    return lineView;

}

//加载产品图片
-(UIImageView*) loadImageView
{
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT*0.03f,SCREEN_WIDTH*0.3f, SCREEN_HEIGHT*0.15f)];
    [imageView setImage:[UIImage imageNamed:@"veg_img"]];
    return imageView;
}





//加载产品标题

-(UILabel*)  loadTitle
{
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.35f, SCREEN_HEIGHT*0.02f, SCREEN_WIDTH*0.6f, SCREEN_HEIGHT*0.08f)];
    
    if(IS_IPHONE_4_OR_LESS)
    {
        [labelTitle  setFont:[UIFont systemFontOfSize:14]];
    }
    else
    {
        [labelTitle  setFont:[UIFont systemFontOfSize:16]];
    }
    
    
    return labelTitle;
}

//加载产品名称
-(UILabel*) loadProductName
{

    UILabel *productName=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.35f, SCREEN_HEIGHT*0.06f, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.08f)];

    if(IS_IPHONE_4_OR_LESS)
    {
        [productName  setFont:[UIFont systemFontOfSize:13]];
    }
    else
    {
        [productName  setFont:[UIFont systemFontOfSize:15]];
    }
    [productName setTextColor:[UIColor colorWithRed:8.0f/255.0f green:158.0f/255.0f blue:22.0f/255.0f alpha:1.0f]];
    return  productName;
}

//加载产地
-(UILabel*) loadSource
{

    UILabel *sourceName=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.65f, SCREEN_HEIGHT*0.06f, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.08f)];
    if(IS_IPHONE_4_OR_LESS)
    {
        [sourceName  setFont:[UIFont systemFontOfSize:13]];
    }
    else
    {
        [sourceName  setFont:[UIFont systemFontOfSize:15]];
    }

    return  sourceName;
}

//加载产品价格
-(UILabel*) loadPrice
{
    UILabel *labelPrice=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.35f, SCREEN_HEIGHT*0.10f, SCREEN_WIDTH*0.3f, SCREEN_HEIGHT*0.08f)];

    if(IS_IPHONE_4_OR_LESS)
    {
        [labelPrice  setFont:[UIFont systemFontOfSize:12]];
    }
    else
    {
        [labelPrice  setFont:[UIFont systemFontOfSize:14]];
    }
    [labelPrice setTextColor:[UIColor colorWithRed:8.0f/255.0f green:158.0f/255.0f blue:22.0f/255.0f alpha:1.0f]];
    return labelPrice;
}

//加载产品总量
-(UILabel*) loadAmount
{
    UILabel *labelAmount=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.65f, SCREEN_HEIGHT*0.10f, SCREEN_WIDTH*0.3f, SCREEN_HEIGHT*0.08f)];

    if(IS_IPHONE_4_OR_LESS)
    {
        [labelAmount  setFont:[UIFont systemFontOfSize:12]];
    }
    else
    {
        [labelAmount  setFont:[UIFont systemFontOfSize:14]];
    }
    
    return labelAmount;
    
}

//加载发送时间
-(UILabel*) loadDate
{
    UILabel *labelDate=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.75f, SCREEN_HEIGHT*0.12f, SCREEN_WIDTH*0.25f, SCREEN_HEIGHT*0.1f)];

    if(IS_IPHONE_4_OR_LESS)
    {
        [labelDate  setFont:[UIFont systemFontOfSize:9]];
    }
    else
    {
        [labelDate  setFont:[UIFont systemFontOfSize:11]];
    }
    [labelDate setTextColor:[UIColor lightGrayColor]];
    return labelDate;
}







//----------------------------------------------

#pragma mark --UITableViewDelegate

- (void)didReceiveMemoryWarning
{
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
