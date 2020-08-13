#import "XsigninstallFlutterPlugin.h"
#import "XSignInstallSDK.h"


@interface XsigninstallFlutterPlugin()<XSignInstallDelegate>
@property (strong, nonatomic) FlutterMethodChannel * flutterMethodChannel;
@end



@implementation XsigninstallFlutterPlugin

static id shared;

- (instancetype)init {
    if (self = [super init]) {
        NSString *appKey = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"XSignInstallAppKey"];
        NSLog(@"appKey:%@",appKey);
        [XSignInstallSDK registerXInstallSDK:appKey delegate:self];
        #warning remove dispatch_after
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self getWakeUpParams:@{@"abc":@"123"}];
        });
    }
    shared = self;
    return  self;
}

+ (BOOL)handLinkURL:(NSURL *)url {
    return [XSignInstallSDK handLinkURL:url];
}

+ (BOOL)continueUserActivity:(NSUserActivity *)userActivity {
    return [XSignInstallSDK continueUserActivity:userActivity];
}

- (void)getWakeUpParams:(NSDictionary *_Nullable)params {
    [self.flutterMethodChannel invokeMethod:@"onWakeupParams" arguments:params];
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"xsigninstall_flutter_plugin"
                                     binaryMessenger:[registrar messenger]];
    XsigninstallFlutterPlugin* instance = [[XsigninstallFlutterPlugin alloc] init];
    instance.flutterMethodChannel = channel;
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"reportRegister" isEqualToString:call.method]) {
        NSLog(@"iOS start Handle method:%@  arguments:%@",call.method,call.arguments);
        [XSignInstallSDK reportRegister];
    }
    else if ([@"getInstallParams" isEqualToString:call.method]) {
        NSLog(@"iOS start Handle method:%@  arguments:%@",call.method,call.arguments);
#warning remove dispatch_after
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.flutterMethodChannel invokeMethod:@"onInstallParams" arguments:@{@"abc":@"1234"}];
        });
        [XSignInstallSDK getInstallParams:^(NSDictionary * _Nullable dic) {
            [self.flutterMethodChannel invokeMethod:@"onInstallParams" arguments:dic];
        }];
    }
    else {
        NSLog(@"iOS start Handle method:%@  arguments:%@",call.method,call.arguments);
        result(FlutterMethodNotImplemented);
    }
}

@end
