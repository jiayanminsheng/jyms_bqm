//
//  SellViewController.h
//  Jiayan Livelihood
//
//  Created by 费砖烨蛇姬狮 on 16/1/10.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SellViewController : BaseViewController
    @property (nonatomic,strong) UIScrollView   *sellScrollView;
    @property (nonatomic,strong) UISearchController *_search;
    @property (nonatomic,strong )UIView             *seachview; //搜索栏
@end
