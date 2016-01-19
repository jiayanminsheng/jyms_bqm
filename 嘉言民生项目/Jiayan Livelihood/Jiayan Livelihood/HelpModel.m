//
//  HelpModel.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/8.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "HelpModel.h"

@implementation HelpModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"]){
        self.questionID = value;
    }
}

-(id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

// 具体解析
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(HelpModel *)parseWithDic:(NSDictionary *)dic
{
    HelpModel * model = [[HelpModel alloc] initWithDic:dic];
    return model;
}

@end
