//
//  UserPrefs.h
//  Pet
//
//  Created by walter on 5/8/15.
//  Copyright (c) 2015 Mituan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserPrefs : NSObject

+(UserPrefs*) shareUserPrefs;
//用户名
-(void) saveUserName:(NSString*)name;
-(NSString*) getUserName;

//密码
-(void) saveUserPassword:(NSString*)passwd;
-(NSString*) getUserPassword;

//用户id
-(void) saveuserID:(NSString*) ID;
-(NSString*) getuserID;

//用户头像
-(void) saveuserheaderImage:(NSData*) headerImage;
-(NSData*) getheaderImage;

-(void) saveuserNickname:(NSString*) nickname;
-(NSString*) getUserNickname;

-(void)clearLoginInfo;
@end
