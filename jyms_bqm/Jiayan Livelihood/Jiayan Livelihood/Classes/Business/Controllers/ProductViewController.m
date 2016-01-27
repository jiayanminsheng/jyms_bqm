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
    
    CGRect _typeNameOneFrame;
    CGRect _typeNameTwoFrame;
    CGRect _num_unitFrame;
    CGRect _price_unitFrame;

}

@end

@implementation ProductViewController
-(void)viewDidAppear:(BOOL)animated{
    _typeNameOneFrame=self.typeNameLabel1.frame;
    _typeNameTwoFrame=self.typeNameLabel2.frame;
    _num_unitFrame=self.num_unitTextField.frame;
    _price_unitFrame=self.price_unitTextField.frame;
    // 获取xib约束的frame
    [self creatUI];

}
-(void)viewWillAppear:(BOOL)animated{
    self.rdv_tabBarController.tabBarHidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *typeNameOneArray=@[@"粮食",@"水果"];
    NSArray *typeNameTwoArray=@[@"玉米",@"高粱",@"小麦"];
    NSArray *num_unitArray=@[@"斤",@"公斤",@"千克",@"克"];
    NSArray *price_unitArray=@[@"元/斤",@"元/公斤",@"元/千克",@"元/克"];
    _typeNameOneArr=[[NSMutableArray alloc]initWithArray:typeNameOneArray];
    _typeNameTwoArr=[[NSMutableArray alloc]initWithArray:typeNameTwoArray];
    _num_unitArr=[[NSMutableArray alloc]initWithArray:num_unitArray];
    _price_unitArr=[[NSMutableArray alloc]initWithArray:price_unitArray];
    
    // Do any additional setup after loading the view from its nib.
    
}
-(void)creatUI{
    
    //选项下拉框
    _typeNameOneTableView=[[UITableView alloc]initWithFrame:CGRectMake(_typeNameOneFrame.origin.x, _typeNameOneFrame.origin.y+_typeNameOneFrame.size.height,_typeNameOneFrame.size.width, 200) style:UITableViewStylePlain];
//     BQMLog(@"%f %f %f %f",_typeNameOneFrame.origin.x,_typeNameOneFrame.origin.y,_typeNameOneFrame.size.width,_typeNameOneFrame.size.height);
    _typeNameOneTableView.delegate=self;
    _typeNameOneTableView.dataSource=self;
    _typeNameOneTableView.backgroundColor=[UIColor clearColor];
    
    
    _num_unitTableView=[[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-_num_unitFrame.size.width/1.9, _num_unitFrame.origin.y+_num_unitFrame.size.height,_num_unitFrame.size.width/2.0, 200) style:UITableViewStylePlain];
    _num_unitTableView.delegate=self;
    _num_unitTableView.dataSource=self;
    _num_unitTableView.backgroundColor=[UIColor clearColor];
    
    
    _price_unitTableView=[[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-_price_unitFrame.size.width/1.9, _price_unitFrame.origin.y+_price_unitFrame.size.height,_price_unitFrame.size.width/2.0, 200) style:UITableViewStylePlain];
    _price_unitTableView.delegate=self;
    _price_unitTableView.dataSource=self;
    _price_unitTableView.backgroundColor=[UIColor clearColor];
    
    



}
#pragma mark --选择产品类型
- (IBAction)typeNameOneClicked:(id)sender {
    [_typeNameTwoTableView removeFromSuperview];
    [_num_unitTableView removeFromSuperview];
    [_price_unitTableView removeFromSuperview];
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
    [_num_unitTableView removeFromSuperview];
    [_price_unitTableView removeFromSuperview];
    
    static int i=0;
    if (i==0) {
        _typeNameTwoTableView=[[UITableView alloc]initWithFrame:CGRectMake(_typeNameTwoFrame.origin.x, _typeNameTwoFrame.origin.y+_typeNameTwoFrame.size.height,_typeNameTwoFrame.size.width, 200) style:UITableViewStylePlain];
        _typeNameTwoTableView.delegate=self;
        _typeNameTwoTableView.dataSource=self;
        _typeNameTwoTableView.backgroundColor=[UIColor clearColor];
        [self.view addSubview:_typeNameTwoTableView];
        i=1;
    }else{
        [_typeNameTwoTableView removeFromSuperview];
        i=0;
    }

}
#pragma mark --选择产品数量
- (IBAction)num_unitClicked:(id)sender {
    [_typeNameOneTableView removeFromSuperview];
    [_typeNameTwoTableView removeFromSuperview];
    [_price_unitTableView removeFromSuperview];
    static int i=0;
    if (i==0) {
        [self.view addSubview:_num_unitTableView];
        i=1;
    }else{
        [_num_unitTableView removeFromSuperview];
        i=0;
    }
}
#pragma mark --选择产品价格
- (IBAction)price_unitClicked:(id)sender {
    [_typeNameOneTableView removeFromSuperview];
    [_typeNameTwoTableView removeFromSuperview];
    [_num_unitTableView removeFromSuperview];
    static int i=0;
    if (i==0) {
        [self.view addSubview:_price_unitTableView];
        i=1;
    }else{
        [_price_unitTableView removeFromSuperview];
        i=0;
    }

    
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
    }else if (tableView==_num_unitTableView){
        return  _num_unitArr.count;
    
    }else if (tableView==_price_unitTableView){
        return _price_unitArr.count;
    
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
    
    }else if (tableView==_num_unitTableView){
        UITableViewCell *cell=[_num_unitTableView dequeueReusableCellWithIdentifier:@"num_unit"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"num_unit"];
            cell.contentView.backgroundColor=[UIColor lightGrayColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text=_num_unitArr[indexPath.row];
        return cell;
        
    }else if (tableView==_price_unitTableView){
        UITableViewCell *cell=[_price_unitTableView dequeueReusableCellWithIdentifier:@"price_unit"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"price_unit"];
            cell.contentView.backgroundColor=[UIColor lightGrayColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text=_price_unitArr[indexPath.row];
        return cell;
    }
    return nil;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_typeNameOneTableView) {
        [_typeNameTwoArr removeAllObjects];
        if (indexPath.row==0) {
            
            self.typeNameLabel2.text=@"玉米";
            NSArray *typeNameTwoArray=@[@"玉米",@"高粱",@"小麦"];
            _typeNameTwoArr=[[NSMutableArray alloc]initWithArray:typeNameTwoArray];
        }else{
//            [_typeNameTwoArr removeAllObjects];
            self.typeNameLabel2.text=@"苹果";
           NSArray *typeNameTwoArray=@[@"桃子",@"苹果",@"香蕉"];
            
            _typeNameTwoArr=[[NSMutableArray alloc]initWithArray:typeNameTwoArray];
            
        
        }
        BQMLog(@"%@ %@ %@",_typeNameTwoArr[0],_typeNameTwoArr[1],_typeNameTwoArr[2]);
        self.typeNameLabel1.text=_typeNameOneArr[indexPath.row];
        [_typeNameOneTableView removeFromSuperview];
    }else if (tableView==_typeNameTwoTableView){
        self.typeNameLabel2.text=_typeNameTwoArr[indexPath.row];
        [_typeNameTwoTableView removeFromSuperview];
    }else if (tableView==_num_unitTableView){
        self.num_unitLabel.text=_num_unitArr[indexPath.row];
        [_num_unitTableView removeFromSuperview];
        
    }else if (tableView==_price_unitTableView){
        self.price_unitLabel.text=_price_unitArr[indexPath.row];
        [_price_unitTableView removeFromSuperview];
    }
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_typeNameOneTableView removeFromSuperview];
    [_typeNameTwoTableView removeFromSuperview];
    [_num_unitTableView removeFromSuperview];
    [_price_unitTableView removeFromSuperview];

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
