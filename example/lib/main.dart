import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:xsigninstall_flutter_plugin/xsigninstall_flutter_plugin.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter2',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter2'),
        ),
        body: new Center(
          child: new MyContainer(),
        ),
      ),
    );
  }
}

class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Text("MyText HelloWorld");
  }
}


class MyContainer extends StatelessWidget {
  final _xinstall = XsigninstallFlutterPlugin();

  @override
  Widget build(BuildContext context) {
    _xinstall.setWakeupHandler((params) {print("wakeupparams--$params");});
    return new Container(
      child:new Column(children: [
        new RaisedButton(onPressed: reportRegister,child: new Text("reportRegister"),),
        new RaisedButton(onPressed: setInstallParams,child: new Text("setInstallParams"),),
      ],)
    );
  }

  void reportRegister() {
    print("reportRegister");
    _xinstall.reportRegister();
  }

  void setInstallParams() {
    print("setInstallParams");
    _xinstall.getInstallParams((params) {print("install--$params");});
  }

}