//
//  SellViewController.m
//  Jiayan Livelihood
//
//  Created by 费砖烨蛇姬狮 on 16/1/10.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "SellViewController.h"
#import "RDVTabBarController/RDVTabBarController.h"
#import "SellDetailViewController.h"
#import "MXPullDownMenu.h"

@interface SellViewController ()<MXPullDownMenuDelegate,UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating>{
   
    UIView             *_seachview; //搜索栏
    UIView             *_categoryBar;//信息筛选下拉框
    UISearchController *_search;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSMutableArray *_searchArr;
    
}

@end

@implementation SellViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建ui
    [self creatUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
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
    _search = [[UISearchController alloc] initWithSearchResultsController:nil];
    _search.searchBar.frame=CGRectMake(0, SCREEN_HEIGHT*0, SCREEN_WIDTH, 40);
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
    [_seachview addSubview:_search.searchBar];
    [self.sellScrollView addSubview:_seachview];
    [_search.searchBar setSearchBarStyle:UISearchBarStyleMinimal];
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
    [_tableView setBounces:NO];
    [_tableView setBackgroundColor:[UIColor redColor]];
    [self.sellScrollView addSubview:_tableView];
    
    
}

//初始化信息排序下拉框


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
    
    return 5;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdientifer=@"sellTable";//tableview标识符
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableIdientifer];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdientifer];
    }
    
    //设置分割线
    UIView *lineView=[self loadLineView];
    
    //加载图片
    UIImageView *imageView=[self loadImageView];
    
    //加载商品标题
    
    UILabel *labelTitle=[self loadTitle];
    
    //加载商品名称
    UILabel *labelName=[self loadProductName];
    
    //加载商品产地
    UILabel *labelSource=[self loadSource];
    
    //加载商品价格
    UILabel *labelPrice=[self loadPrice];
    
    //加载商品总量
    UILabel *labelAmount=[self loadAmount];
    
    //加载发送时间
    UILabel *labelDate=[self loadDate];
    
    
    
    
    
    
    [cell.contentView addSubview:lineView];
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:labelTitle];
    [cell.contentView addSubview:labelName];
    [cell.contentView addSubview:labelSource];
    [cell.contentView addSubview:labelPrice];
    [cell.contentView addSubview:labelAmount];
    [cell.contentView addSubview:labelDate];
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
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.35f, SCREEN_HEIGHT*0.032f, SCREEN_WIDTH*0.6f, SCREEN_HEIGHT*0.08f)];
    NSString *str=@"山东潍坊县青萝卜，新鲜绿皮甜脆，1万斤出售";
    [labelTitle setFont:[UIFont fontWithName:@"Marion" size:17]];
    [labelTitle setNumberOfLines:0];
    
    NSMutableAttributedString * attributedString=[[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str length])];
    
    [labelTitle setAttributedText:attributedString];
    return labelTitle;
}

//加载产品名称
-(UILabel*) loadProductName
{
    UILabel *productName=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.35f, SCREEN_HEIGHT*0.085f, SCREEN_WIDTH*0.3f, SCREEN_HEIGHT*0.08f)];
    [productName setText:@"青萝卜"];
    [productName setTextColor:[UIColor colorWithRed:8.0f/255.0f green:158.0f/255.0f blue:22.0f/255.0f alpha:1.0f]];
    return  productName;
}

//加载产地
-(UILabel*) loadSource
{
    UILabel *sourceName=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.65f, SCREEN_HEIGHT*0.085f, SCREEN_WIDTH*0.3f, SCREEN_HEIGHT*0.08f)];
    [sourceName setText:@"山东寿光"];
    return  sourceName;
}

//加载产品价格
-(UILabel*) loadPrice
{
    UILabel *labelPrice=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.35f, SCREEN_HEIGHT*0.12f, SCREEN_WIDTH*0.3f, SCREEN_HEIGHT*0.08f)];
    CGFloat  price=3.0;
    NSString *strPrice=[NSString stringWithFormat:@"¥%.02f元／斤",price];
    [labelPrice setText:strPrice];
    [labelPrice setTextColor:[UIColor colorWithRed:8.0f/255.0f green:158.0f/255.0f blue:22.0f/255.0f alpha:1.0f]];
    return labelPrice;
}

//加载产品总量
-(UILabel*) loadAmount
{
    UILabel *labelAmount=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.65f, SCREEN_HEIGHT*0.12f, SCREEN_WIDTH*0.3f, SCREEN_HEIGHT*0.08f)];
    NSInteger  amount=10000;
    NSString *strAmount=[NSString stringWithFormat:@"%ld斤",(long)amount];
    [labelAmount setText:strAmount];
    
    return labelAmount;
    
}

//加载发送时间
-(UILabel*) loadDate
{
    UILabel *labelDate=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.8f, SCREEN_HEIGHT*0.14f, SCREEN_WIDTH*0.3f, SCREEN_HEIGHT*0.08f)];
    NSString *strDate=@"2015-10-10";
    [labelDate setText:strDate];
    [labelDate setFont:[UIFont systemFontOfSize:13]];
    [labelDate setTextColor:[UIColor lightGrayColor]];
    return labelDate;
}







//----------------------------------------------

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
