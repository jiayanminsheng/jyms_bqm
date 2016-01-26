//
//  UIViewController+sellDetailViewController.m
//  Jiayan Livelihood
//
//  Created by Lance on 1/20/16.
//  Copyright © 2016 bqm. All rights reserved.
//

#import "SellDetailViewController.h"
#import "RDVTabBarController/RDVTabBarController.h"

@interface SellDetailViewController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIScrollView *mainView;

@end



@implementation SellDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self rmTabbar];     //去除tabbar
    [self loadMainView]; //加载主滚动页面
    [self loadProcutImg];//加载商品图片
    [self loadAbsInfoView];//加载产品概述信息
    [self loadDetailInfoView];//加载产品详细信息
    
}

//去除tabbar
-(void)rmTabbar
{
    [self.parentViewController.rdv_tabBarController setTabBarHidden:true];
}


//加载主视图滚动条
-(void)loadMainView
{
    CGRect rect=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.mainView=[[UIScrollView alloc]initWithFrame:rect];
    CGSize size=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*1.6);
    [self.mainView setContentSize:size];
    [self.mainView setBounces:NO];
    [self.mainView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mainView];
}

//加载商品图片
-(void)loadProcutImg
{
  CGRect rect=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.25f);
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:rect];
    [imgView setImage:[UIImage imageNamed:@"product1"]];
    [self.mainView addSubview:imgView];
}

//加载产品概述信息部分
-(void)loadAbsInfoView
{
    CGRect rect=CGRectMake(0,SCREEN_HEIGHT*0.25f, SCREEN_WIDTH, SCREEN_HEIGHT*0.6f);
    UIView *absView=[[UIView alloc]initWithFrame:rect];
    [self.mainView addSubview:absView];
    
    UILabel      *title=[self loadTitle];
    UILabel      *price=[self loadPrice];
    UILabel      *source=[self loadSource];
    UILabel      *date=[self loadDate];
    UIView       *line=[self loadLine];
    UITableView  *info=[self loadInfo];
    
    [absView addSubview:title];
    [absView addSubview:price];
    [absView addSubview:source];
    [absView addSubview:date];
    [absView addSubview:line];
    [absView addSubview:info];
}

-(void)loadDetailInfoView
{
    CGRect rect=CGRectMake(0,SCREEN_HEIGHT*0.57f, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIView *detailView=[[UIView alloc]initWithFrame:rect];
    
    UIView *dTitle   = [self loadDetailTitle];  //图文详细标题
    UIView *dContent = [self loadDetailContent];
    [detailView addSubview:dTitle];
    [detailView addSubview:dContent];
    [self.mainView addSubview:detailView];
}

//加载产品标题

-(UILabel*)  loadTitle
{
    CGRect rect=CGRectMake(SCREEN_WIDTH*0.05f,0, SCREEN_WIDTH*0.9, SCREEN_HEIGHT*0.05f);
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:rect];
    NSString *str=@"山东潍坊县青萝卜，新鲜绿皮甜脆，1万斤出售";
    [labelTitle setFont:[UIFont fontWithName:@"Marion" size:16]];
    [labelTitle setNumberOfLines:0];
    [labelTitle setText:str];
    return labelTitle;
}

//加载产品价格
-(UILabel*) loadPrice
{
    CGRect rect=CGRectMake(SCREEN_WIDTH*0.05f, SCREEN_HEIGHT*0.05f, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.05f);
    UILabel *labelPrice=[[UILabel alloc]initWithFrame:rect];
    CGFloat  price=3.0;
    NSString *strPrice=[NSString stringWithFormat:@"¥%.02f元／斤",price];
    [labelPrice setText:strPrice];
    [labelPrice setTextColor:[UIColor colorWithRed:8.0f/255.0f green:158.0f/255.0f blue:22.0f/255.0f alpha:1.0f]];
    return labelPrice;
}

//加载产地
-(UILabel*) loadSource
{
    CGRect rect=CGRectMake(SCREEN_WIDTH*0.05f, SCREEN_HEIGHT*0.10f, SCREEN_WIDTH*0.2, SCREEN_HEIGHT*0.02f);
    UILabel *sourceName=[[UILabel alloc]initWithFrame:rect];
    [sourceName setFont:[UIFont systemFontOfSize:12]];
    [sourceName setTextColor:[UIColor lightGrayColor]];
    [sourceName setText:@"山东寿光"];
    return  sourceName;
}

//加载发送时间
-(UILabel*) loadDate
{
    CGRect rect=CGRectMake(SCREEN_WIDTH*0.7f, SCREEN_HEIGHT*0.10f, SCREEN_WIDTH*0.2, SCREEN_HEIGHT*0.015f);
    UILabel *labelDate=[[UILabel alloc]initWithFrame:rect];
    NSString *strDate=@"2015-10-10";
    [labelDate setText:strDate];
    [labelDate setFont:[UIFont systemFontOfSize:12]];
    [labelDate setTextColor:[UIColor lightGrayColor]];
    return labelDate;
}

//加载分隔线
-(UIView*)loadLine
{
    CGRect rect=CGRectMake(0, SCREEN_HEIGHT*0.13f,SCREEN_WIDTH, SCREEN_HEIGHT*0.02f);
    UIView * lineView=[[UIView alloc]initWithFrame:rect];
    [lineView setBackgroundColor:GrayColor];
    
    return lineView;
}
//---------------------------------------------------------------------------------------------
//加载产品信息列表
-(UITableView*)loadInfo
{
     CGRect rect=CGRectMake(0, SCREEN_HEIGHT*0.15f,SCREEN_WIDTH, SCREEN_HEIGHT*0.3f);
     UITableView *tableInfo=[[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    tableInfo.delegate=self;
    tableInfo.dataSource=self;
    tableInfo.userInteractionEnabled=NO;
    //[tableInfo.layer setBorderWidth:20.0f];
    tableInfo.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.01f, 0.01f)];
    tableInfo.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.01f, 0.01f)];
     return tableInfo;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdientifer=@"infoTable";//tableview标识符
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableIdientifer];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdientifer];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;

    }
    
    switch (indexPath.row)
    {
        case 0:
              {
                  UILabel *name=   [self loadName:@"产品类型"];
                  UILabel *content=[self loadContent:@"粮食"];
                  [cell.contentView addSubview:name];
                  [cell.contentView addSubview:content];
              }
               break;
        case 1:
              {
                  UILabel *name=[self loadName:@"产品名称"];
                  UILabel *content=[self loadContent:@"玉米"];
                  [cell.contentView addSubview:name];
                   [cell.contentView addSubview:content];
              }
               break;
        case 2:
              {
                 UILabel *name=[self loadName:@"产品数量"];
                 UILabel *content=[self loadContent:@"一万斤"];
                 [cell.contentView addSubview:name];
                  [cell.contentView addSubview:content];
              }
              break;
        case 3:
             {
                 UILabel *name=[self loadName:@"联系人"];
                 UILabel *content=[self loadContent:@"张某某"];
                 [cell.contentView addSubview:name];
                 [cell.contentView addSubview:content];
             }
               break;
        case 4:
              {
                 UILabel *name=[self loadName:@"联系电话"];
                 UILabel *content=[self loadContent:@"15678912345"];
                 [cell.contentView addSubview:name];
                 [cell.contentView addSubview:content];
              }
               break;
        default:NSLog(@"ERROR");break;
    }
    
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  SCREEN_HEIGHT*0.06f;
}



//加载名称
-(UILabel*)loadName:(NSString*)name
{
    CGRect   rect = CGRectMake(SCREEN_WIDTH*0.05f,0, SCREEN_WIDTH*0.9f,SCREEN_HEIGHT*0.05f );
    UILabel *labelName = [[UILabel alloc]initWithFrame:rect];
    [labelName setText:name];
    [labelName setTextColor:[UIColor lightGrayColor]];
    return labelName;
}

-(UILabel*)loadContent:(NSString*)content
{
    CGRect   rect = CGRectMake(SCREEN_WIDTH*0.3f,0, SCREEN_WIDTH*0.9f,SCREEN_HEIGHT*0.05f );
    UILabel *labelContent = [[UILabel alloc]initWithFrame:rect];
    [labelContent setText:content];
    [labelContent setTextColor:[UIColor lightGrayColor]];
    return labelContent;
}
    


//--------------------------------------------------------------------------------------------

//图文介绍标题
-(UIView*)loadDetailTitle
{
    CGRect rect=CGRectMake(0, SCREEN_HEIGHT*0.13f,SCREEN_WIDTH, SCREEN_HEIGHT*0.05f);
    UIView * titleView=[[UIView alloc]initWithFrame:rect];
    [titleView setBackgroundColor:GrayColor];
   
    CGRect rect2=CGRectMake(SCREEN_WIDTH*0.05f, SCREEN_HEIGHT*0.01f,SCREEN_WIDTH*0.2f, SCREEN_HEIGHT*0.03f);
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:rect2];
    [titleLabel setText:@"图文介绍"];
    [titleLabel setTextColor:[UIColor grayColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [titleView addSubview:titleLabel];
    
    return titleView;
}

//图文介绍内容
-(UIView*)loadDetailContent
{
    CGRect rect=CGRectMake(0, SCREEN_HEIGHT*0.18f,SCREEN_WIDTH, SCREEN_HEIGHT);
    UIView * contentView=[[UIView alloc]initWithFrame:rect];
    
    //文字
    CGRect rect2=CGRectMake(SCREEN_WIDTH*0.05f, SCREEN_HEIGHT*0.01f,SCREEN_WIDTH*0.9f, SCREEN_HEIGHT*0.23f);
    
    UILabel *contentLabel=[[UILabel alloc]initWithFrame:rect2];
    [contentLabel setText:@"      潍县萝卜，又称潍坊萝卜，是山东省著名萝卜优良品种，俗称高脚青或潍县青萝卜，因原产于山东潍县而得名，已有300多年的栽培历史。潍县萝卜皮色深绿，肉质翠绿，香辣脆甜，多汁味美，具有浓郁独特的地方风味和鲜明的地域特点，是享誉国内外的名特优地方品种。素有“烟台苹果、莱阳梨，不如潍县萝卜皮”之说，深受人们的喜爱。2006年，国家质检总局批准对潍县萝卜实施地理标志产品保护。"];
    [contentLabel setTextColor:[UIColor grayColor]];
    [contentLabel setNumberOfLines:0];
    [contentLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [contentView addSubview:contentLabel];
    
    CGRect rect3=CGRectMake(SCREEN_WIDTH*0.05f, SCREEN_HEIGHT*0.24f,SCREEN_WIDTH*0.9f, SCREEN_HEIGHT*0.23f);
    UIImageView *img1=[[UIImageView alloc]initWithFrame:rect3];
    [img1 setImage:[UIImage imageNamed:@"product2"]];
    
    CGRect rect4=CGRectMake(SCREEN_WIDTH*0.05f, SCREEN_HEIGHT*0.50f,SCREEN_WIDTH*0.9f, SCREEN_HEIGHT*0.23f);
    UIImageView *img2=[[UIImageView alloc]initWithFrame:rect4];
    [img2 setImage:[UIImage imageNamed:@"product3"]];
    
    [contentView addSubview:img1];
    [contentView addSubview:img2];
    
    
    return contentView;
}

@end
