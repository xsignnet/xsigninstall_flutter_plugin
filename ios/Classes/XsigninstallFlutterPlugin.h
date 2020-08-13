#import <Flutter/Flutter.h>

@interface XsigninstallFlutterPlugin : NSObject<FlutterPlugin>

/// 处理 URI schemes
/// @param url 系统回调传回的URL
/// @return bool  URL是否被XSignInstallSDK识别
+ (BOOL)handLinkURL:(NSURL *_Nonnull)url;


/// 处理 通用链接
/// @param userActivity 存储了页面信息，包括url
/// @return bool  URL是否被XSignInstallSDK识别
+ (BOOL)continueUserActivity:(NSUserActivity *_Nonnull)userActivity;

@end
