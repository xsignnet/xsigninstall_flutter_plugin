import 'dart:async';

import 'package:flutter/services.dart';

typedef Future<dynamic> Handler(Map<String, dynamic> data);
typedef ParamsHandler = void Function(Map<String, dynamic> params);

class XsigninstallFlutterPlugin {
  ParamsHandler _wakeupHandler = (params) => {};
  ParamsHandler _installHandler = (params) => {};

  XsigninstallFlutterPlugin(){
    _channel.setMethodCallHandler(_callHandler);
  }

  static const MethodChannel _channel =
      const MethodChannel('xsigninstall_flutter_plugin');

  Future<Null> _callHandler(MethodCall call) {
    Map<String, dynamic> params = call.arguments.cast<String, dynamic>();
    switch (call.method) {
      case "onWakeupParams":
        print("onWakeup");
        _wakeupHandler(params);
        break;
      case "onInstallParams":
        print("onInstall");
        _installHandler(params);
        break;
      default:
        break;
    }
    return Future.value(null);
  }

  void reportRegister() {
    _channel.invokeMethod("reportRegister");
  }

  void getInstallParams(ParamsHandler installHandler) {
    _installHandler = installHandler;
    _channel.invokeMethod("getInstallParams");
  }

  void setWakeupHandler(ParamsHandler wakeupHandler) {
    _wakeupHandler = wakeupHandler;
  }

}
