//
//  UserPrefs.m
//  Pet
//
//  Created by walter on 5/8/15.
//  Copyright (c) 2015 Mituan. All rights reserved.
//

#import "UserPrefs.h"

@interface UserPrefs ()
@property NSUserDefaults * userDefaults;
@property NSString *userNameKey;
@property NSString * userPasswordKey;
@property NSString * userNicknameKey;
@property NSString *userIDKey;
@property NSString *userHeaderImageKey;
@end


@implementation UserPrefs

static UserPrefs* instance;


+(UserPrefs*) shareUserPrefs
{
    if(instance == NULL)
    {
        instance = [[UserPrefs alloc] init];
    }
    
    return instance;
}

- (instancetype)init
{
    _userDefaults = [NSUserDefaults standardUserDefaults];
    _userPasswordKey = @"password";
    _userNameKey = @"user";
    _userIDKey=@"id";
    _userNicknameKey = @"nickname";
    _userHeaderImageKey=@"headerimage";
    return [super init];
}
-(void) saveUserName:(NSString *)name
{
    [_userDefaults setObject:name forKey:_userNameKey];
    [_userDefaults synchronize];
}
-(NSString*) getUserName
{
    return [_userDefaults stringForKey:_userNameKey];
}

-(void) saveUserPassword:(NSString*)passwd
{
    [_userDefaults setObject:passwd forKey:_userPasswordKey];
    [_userDefaults synchronize];
}
-(NSString*) getUserPassword

{
    return [_userDefaults stringForKey:_userPasswordKey];
}

-(void) saveuserNickname:(NSString*) nickname
{
    [_userDefaults setObject:nickname forKey:_userNicknameKey];
    [_userDefaults synchronize];
}
-(NSString*) getUserNickname
{
    return [_userDefaults stringForKey:_userNicknameKey];
}
-(void) saveuserID:(NSString*) ID{
    [_userDefaults setObject:ID forKey:_userIDKey];
    [_userDefaults synchronize];

}
-(NSString*) getuserID{
    return [_userDefaults stringForKey:_userIDKey];

}
-(void) saveuserheaderImage:(NSData*) headerImage{
    [_userDefaults setObject:headerImage forKey:_userHeaderImageKey];
    [_userDefaults synchronize];

}
-(NSData*) getheaderImage{

    return [_userDefaults objectForKey:_userHeaderImageKey];

}

-(void)clearLoginInfo
{
    [_userDefaults removeObjectForKey:_userPasswordKey];
    [_userDefaults removeObjectForKey:_userNameKey];
    [_userDefaults removeObjectForKey:_userNicknameKey];
    [_userDefaults removeObjectForKey:_userIDKey];
    [_userDefaults removeObjectForKey:_userHeaderImageKey];
    [_userDefaults synchronize];
}
@end
