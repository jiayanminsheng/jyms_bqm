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

-(void) saveUserName:(NSString*)name;
-(NSString*) getUserName;

-(void) saveUserPassword:(NSString*)passwd;
-(NSString*) getUserPassword;

-(void) saveuserNickname:(NSString*) nickname;
-(NSString*) getUserNickname;

-(void) saveuserID:(NSString*) ID;
-(NSString*) getuserID;

-(void)clearLoginInfo;
@end
