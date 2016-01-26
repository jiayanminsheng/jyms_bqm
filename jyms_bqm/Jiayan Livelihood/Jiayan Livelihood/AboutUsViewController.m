//
//  AboutUsViewController.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/19.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AFHelper.h"

@interface AboutUsViewController (){
    UITextView *_textView;

}

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
//    [self DownLoadData];
 
}
-(void)creatUI{
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"关于我们";
    UIButton *backBtn= [self creatleftBarButtonItemOfBack];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    //UI搭建
   
    
//    _textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT)];
//    [self.view addSubview:_textView];
    
    
    //获取部分内容
    
    NSString *htmlString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://58.96.186.169:8088/API/basic/NewDetails.aspx?id=2"] encoding:NSUTF8StringEncoding error:nil];
    NSString *fromString=@"</h5>";
    NSString *toString=@"</div>";
    if (!fromString || !toString || fromString.length == 0 || toString.length == 0) {
        
    }
    NSMutableArray *subStringsArray = [[NSMutableArray alloc] init];
    NSString *tempString =htmlString;
    NSRange range = [tempString rangeOfString:fromString];
    while (range.location != NSNotFound) {
        tempString = [tempString substringFromIndex:(range.location + range.length)];
        range = [tempString rangeOfString:toString];
        if (range.location != NSNotFound) {
            [subStringsArray addObject:[tempString substringToIndex:range.location]];
            range = [tempString rangeOfString:fromString];
        }
        else
        {
            break;
        }
    }
    
    NSString *str=subStringsArray[0];
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT)];
    [webView loadHTMLString:str baseURL:[NSURL URLWithString:@"http://58.96.186.169:8088/API/basic/NewDetails.aspx?id=2"]];
    [self.view addSubview:webView];
  
    
   

}
//-(void)DownLoadData{
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setObject:@"b_list" forKey:@"key"];
//    [params setObject:@"2" forKey:@"Id"];
//    [AFHelper PostWithPath:@"/basic/show.ashx" andParameters:params andSuccess:^(id responseObject) {
//        if (responseObject==nil) {
//            return ;
//        }
//        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSArray *listArr=dic[@"list"];
//        NSDictionary *titleDic=listArr[0];
//        NSString *title=titleDic[@"body"];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            _textView.text=title;
//        });
//        
//    } andFailure:^(NSError *error) {
//        
//    }];
//
//
//}
-(void)back{

    [self.navigationController popToRootViewControllerAnimated:NO];

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
