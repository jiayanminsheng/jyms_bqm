//
//  ProductModel.h
//  Jiayan Livelihood
//
//  Created by bqm on 16/1/29.
//  Copyright © 2016年 bqm. All rights reserved.
/*
 "user_id":1,"typename":null,"num_unit":"箱","price_unit":"元/斤","contact":"老王","phone":"13593038340","describe":"好多水果你吃不吃老王","title":"水果多多","address":null,"addtime":"2016-01-01 00:00"
 */

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
@property (nonatomic,strong)NSNumber *user_id;
@property (nonatomic,copy)NSString *typeName;
@property (nonatomic,copy)NSString *num_unit;
@property (nonatomic,copy)NSString *price_unit;
@property (nonatomic,copy)NSString *contact;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *describe;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *addtime;
+(ProductModel *)parseWithDic:(NSDictionary *)dic;
@end
