//
//  HelpModel.h
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/8.
//  Copyright © 2016年 bqm. All rights reserved.
/*
 id : 49
 userid : 6
 questions : "放假？真的假的"
 question_status : 0
 username : "15652286463"
 addtime : "2015-12-31 13:09"
 */

#import <Foundation/Foundation.h>

@interface HelpModel : NSObject
@property (nonatomic,strong) NSNumber *questionID;
@property (nonatomic,strong) NSNumber *userid;
@property (nonatomic,copy) NSString *questions;
@property (nonatomic,strong) NSNumber *question_status;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *addtime;

//回答问题列表
@property (nonatomic,copy) NSString *reply;
@property (nonatomic,copy) NSString *status;
+(HelpModel *)parseWithDic:(NSDictionary *)dic;
@end
