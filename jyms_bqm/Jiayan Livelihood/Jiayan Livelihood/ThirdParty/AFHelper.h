//
//  AFHelper.h
//  LOL
//
//  Created by MS on 15-11-11.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFHelper : NSObject
+(void)GetWithPath:(NSString *)path andParameters:(NSDictionary *)dic andSuccess:(void (^)(id  responseObject))success andFailure:(void (^)(NSError * error))failure;
+(void)PostWithPath:(NSString *)path andParameters:(NSDictionary *)dic andSuccess:(void (^)(id  responseObject))success andFailure:(void (^)(NSError *error))failure;
+(id)isNullValue:(id)value;
@end
