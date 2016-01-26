//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//
#import "RDVTabBarController.h"
#import "SDCycleScrollView.h"


#define UIColorWithRGBA(r,g,b,a)        [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define GrayColor                       [UIColor colorWithRed:235/255.0f green:235/255.0f blue:241/255.0f alpha:1]
#define SCREEN_WIDTH                    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                   ([UIScreen mainScreen].bounds.size.height)
#define NAVBAR_HEIGHT                    64
#define TABBAR_HEIGHT                    49

#define IS_IPHONE                       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH               (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_4_OR_LESS             (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
