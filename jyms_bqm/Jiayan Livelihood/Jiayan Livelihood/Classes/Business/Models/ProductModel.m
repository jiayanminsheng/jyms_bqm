//
//  ProductModel.m
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/29.
//  Copyright © 2016年 bqm. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"typename"]){
        self.typeName = value;
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

+(ProductModel *)parseWithDic:(NSDictionary *)dic
{
    ProductModel * model = [[ProductModel alloc] initWithDic:dic];
    return model;
}

@end
