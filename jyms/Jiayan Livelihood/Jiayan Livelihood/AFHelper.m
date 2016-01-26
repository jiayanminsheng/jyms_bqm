//
//  AFHelper.m
//  LOL
//
//  Created by MS on 15-11-11.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "AFHelper.h"
#import "AFNetworking.h"

@implementation AFHelper
//GET请求二次封装
+(void)GetWithPath:(NSString *)path andParameters:(NSDictionary *)dic andSuccess:(void (^)(id  responseObject))success andFailure:(void (^)(NSError * error))failure
{
    NSString *url=[NSString stringWithFormat:@"%@%@",BaseUrl,path];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];

}
//POST请求二次封装
+(void)PostWithPath:(NSString *)path andParameters:(NSDictionary *)dic andSuccess:(void (^)(id  responseObject))success andFailure:(void (^)(NSError *error))failure
{
    NSString *url=[NSString stringWithFormat:@"%@%@",BaseUrl,path];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
}
//[[dic objectForKey:@"article_id"] isEqual:[NSNull null]] ? @"":[dic objectForKey:@"article_id"]
//如果服务器返回值有null
+(id)isNullValue:(id)value{
    
    return [value isEqual:[NSNull null]] ? nil:value;

}
@end
