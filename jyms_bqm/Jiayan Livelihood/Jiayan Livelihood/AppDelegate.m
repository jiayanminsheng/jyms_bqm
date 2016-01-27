//v1.02

#import "AppDelegate.h"
//#import "RootViewController.h"
#import "startViewController.h"
#import "LoginViewController.h"
#import "AFNetworking.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）sdk头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信sdk头文件
#import <WXApi.h>

//新浪微博sdk头文件
#import <WeiboSDK.h>

//新浪微博sdk需要在项目Build Setting中Other Linker Flags添加 "-ObjC"

//人人sdk头文件
#import <RennSDK/RennSDK.h>


@interface AppDelegate ()<UIAlertViewDelegate>

@property (nonatomic,strong)AFNetworkReachabilityManager *manager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     //设置navBar
    [self configNavBar];
    [self checkNetstatu];
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    //记录启动次数
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *str=[defaults objectForKey:@"X7"];
    if (str.length==0) {
        [defaults setObject:@"first" forKey:@"X7"];
        [defaults synchronize];
        startViewController *startVC=[[startViewController alloc]init];
        self.window.rootViewController=startVC;
    }else{
        LoginViewController *loginVC=[[LoginViewController alloc]init];
//        HomeVC *homeVC=[[HomeVC alloc]init];
        UINavigationController *loginNC=[[UINavigationController alloc]initWithRootViewController:loginVC];
        loginNC.navigationBarHidden=YES;
        self.window.rootViewController=loginNC;
    }
    
    
    [self.window makeKeyAndVisible];
    
    //---------------------------------------
    //shareSDK部分
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    
    [ShareSDK registerApp:@"iosv1101"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeRenren),
                            @(SSDKPlatformTypeGooglePlus)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             case SSDKPlatformTypeRenren:
                 [ShareSDKConnector connectRenren:[RennClient class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeRenren:
                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                                               authType:SSDKAuthTypeBoth];
        
                 break;

             default:
                 break;
         }
     }];
    
    
    //----------------------------------------
    return YES;
}

#pragma mark - NavBar设置

-(void)configNavBar
{
    // 设置导航栏title颜色
    NSDictionary * textA = @{
                             NSFontAttributeName : [UIFont systemFontOfSize:18],
                             NSForegroundColorAttributeName : [UIColor whiteColor],
                             };
    [[UINavigationBar appearance] setTitleTextAttributes:textA];
    // 设置所有导航背景颜色
    [[UINavigationBar appearance] setBarTintColor:UIColorWithRGBA(35, 165, 58, 1)];
    
    // 状态栏 设置
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
}
#pragma mark - 检测网络状态
-(void)checkNetstatu{
    //1.创建网络监听对象
    _manager = [AFNetworkReachabilityManager sharedManager];
    //2.设置网络状态改变回调
    [_manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown          = -1,  // 未知
         AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
         AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
         AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
         */
        NSString *tipStr=[[NSString alloc]init];
        switch (status) {
            case 0:
              
                tipStr=@"当前无网络连接";
                break;
            case 1:
               
                tipStr=@"当前网络状态是3G";
                break;
            case 2:
             
                tipStr=@"当前网络状态是WiFi";
                break;
            default:
              
                tipStr=@"当前网络状态未知，查看网络设置";
                break;
        }
//        UIAlertView *tipMes=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:tipStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
//        [tipMes show];
    }];
    
    // 3.开始监听
//    [_manager startMonitoring];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [_manager stopMonitoring];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
