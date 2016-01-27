//
//  ProductViewController.m
//  01demo
//
//  Created by bqm on 16/1/26.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "ProductViewController.h"
#import "RDVTabBarController.h"

@interface ProductViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_typeNameOneTableView;
    NSMutableArray *_typeNameOneArr;
    UITableView *_typeNameTwoTableView;
    NSMutableArray *_typeNameTwoArr;
    UITableView *_num_unitTableView;
    NSMutableArray *_num_unitArr;
    UITableView *_price_unitTableView;
    NSMutableArray *_price_unitArr;

}

@end

@implementation ProductViewController
-(void)viewWillAppear:(BOOL)animated{
    self.rdv_tabBarController.tabBarHidden=YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *typeNameOneArray=@[@"1",@"2"];
    NSArray *typeNameTwoArray=@[@"1",@"2",@"3"];
    NSArray *num_unitArray=@[@"1",@"2",@"3",@"4"];
    NSArray *price_unitArray=@[@"1",@"2",@"3",@"4",@"5"];
    _typeNameOneArr=[[NSMutableArray alloc]initWithArray:typeNameOneArray];
    _typeNameTwoArr=[[NSMutableArray alloc]initWithArray:typeNameTwoArray];
    _num_unitArr=[[NSMutableArray alloc]initWithArray:num_unitArray];
    _price_unitArr=[[NSMutableArray alloc]initWithArray:price_unitArray];
    
    // Do any additional setup after loading the view from its nib.
    [self creatUI];
}
-(void)creatUI{
    
    CGRect typeNameOneFrame=self.typeNameLabel1.frame;
    _typeNameOneTableView=[[UITableView alloc]initWithFrame:CGRectMake(typeNameOneFrame.origin.x+typeNameOneFrame.size.width/2.0, typeNameOneFrame.origin.y+typeNameOneFrame.size.height,typeNameOneFrame.size.width, 200) style:UITableViewStylePlain];
    _typeNameOneTableView.delegate=self;
    _typeNameOneTableView.dataSource=self;
    _typeNameOneTableView.backgroundColor=[UIColor clearColor];
    
    CGRect typeNameTwoFrame=self.typeNameLabel2.frame;
    _typeNameTwoTableView=[[UITableView alloc]initWithFrame:CGRectMake(typeNameTwoFrame.origin.x+typeNameTwoFrame.size.width/2.0, typeNameTwoFrame.origin.y+typeNameTwoFrame.size.height,typeNameTwoFrame.size.width, 200) style:UITableViewStylePlain];
    _typeNameTwoTableView.delegate=self;
    _typeNameTwoTableView.dataSource=self;
    _typeNameTwoTableView.backgroundColor=[UIColor clearColor];
    
   
    



}
#pragma mark --选择产品类型
- (IBAction)typeNameOneClicked:(id)sender {
    static int i=0;
    if (i==0) {
        [self.view addSubview:_typeNameOneTableView];
        i=1;
    }else{
        [_typeNameOneTableView removeFromSuperview];
        i=0;
    }
}
#pragma mark --选择产品子类型
- (IBAction)typeNameTwoClicked:(id)sender {
    [_typeNameOneTableView removeFromSuperview];
    static int i=0;
    if (i==0) {
        [self.view addSubview:_typeNameTwoTableView];
        i=1;
    }else{
        [_typeNameTwoTableView removeFromSuperview];
        i=0;
    }

}
#pragma mark --选择产品数量
- (IBAction)num_unitClicked:(id)sender {
    
}
#pragma mark --选择产品价格
- (IBAction)price_unitClicked:(id)sender {
    
}
#pragma mark --同意协议
- (IBAction)agreeClicked:(id)sender {
    
}
#pragma mark --发布
- (IBAction)agreeReleseClicked:(id)sender {
    
}
#pragma mark --回调函数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_typeNameOneTableView) {
        return _typeNameOneArr.count;
    }else if (tableView==_typeNameTwoTableView){
        return _typeNameTwoArr.count;
    }
    return 0;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_typeNameOneTableView) {
        UITableViewCell *cell=[_typeNameOneTableView dequeueReusableCellWithIdentifier:@"typeNameOne"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"typeNameOne"];
            cell.contentView.backgroundColor=[UIColor lightGrayColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text=_typeNameOneArr[indexPath.row];
        return cell;
    }else if (tableView==_typeNameTwoTableView){
        UITableViewCell *cell=[_typeNameTwoTableView dequeueReusableCellWithIdentifier:@"typeNameTwo"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"typeNameTwo"];
            cell.contentView.backgroundColor=[UIColor lightGrayColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text=_typeNameTwoArr[indexPath.row];
        return cell;
    
    }
    return nil;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_typeNameOneTableView) {
        self.typeNameLabel1.text=_typeNameOneArr[indexPath.row];
        [_typeNameOneTableView removeFromSuperview];
    }else if (tableView==_typeNameTwoTableView){
        self.typeNameLabel2.text=_typeNameTwoArr[indexPath.row];
        [_typeNameTwoTableView removeFromSuperview];
    }
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_typeNameOneTableView removeFromSuperview];
    [_typeNameTwoTableView removeFromSuperview];

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
