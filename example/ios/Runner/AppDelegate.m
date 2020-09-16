#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "xsigninstall_flutter_plugin/XsigninstallFlutterPlugin.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
 

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    //处理通过XSigninstall一键唤起App时传递的数据
    [XsigninstallFlutterPlugin continueUserActivity:userActivity];
    //其他第三方回调；
     return YES;
}

//适用目前所有iOS版本
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //判断是否通过OpenInstall URL Scheme 唤起App
    [XsigninstallFlutterPlugin handLinkURL:url];
    //其他第三方回调；
    return YES;
}
//iOS9以上，会优先走这个方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(nonnull NSDictionary *)options{
    //判断是否通过OpenInstall URL Scheme 唤起App
    [XsigninstallFlutterPlugin handLinkURL:url];
    //其他第三方回调；
     return YES;
}
@end
