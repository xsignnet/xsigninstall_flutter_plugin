#import "XsigninstallFlutterPlugin.h"
#import "XSignInstallSDK.h"


@interface XsigninstallFlutterPlugin()<XSignInstallDelegate>
@property (strong, nonatomic) FlutterMethodChannel * flutterMethodChannel;
@end



@implementation XsigninstallFlutterPlugin

static id shared;

- (instancetype)init {
    if (self = [super init]) {
        [XSignInstallSDK initWithDelegate:self];
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
        [XSignInstallSDK reportRegister];
    }
    else if ([@"getInstallParams" isEqualToString:call.method]) {
        NSLog(@"ios getInstall");
        [XSignInstallSDK getInstallParams:^(NSDictionary * _Nullable dic) {
            NSLog(@"abcde");
            NSLog(@"%@",dic);
            [self.flutterMethodChannel invokeMethod:@"onInstallParams" arguments:dic];
        }];
    }
    else {
        result(FlutterMethodNotImplemented);
    }
}

@end
