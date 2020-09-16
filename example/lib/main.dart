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
    _xinstall.setWakeupHandler((Map<String, dynamic> params) {print("wakeupparams--$params");showAlertDialog(context, "wakeupparams--$params");});
    return new Container(
      child:new Column(children: [
        new RaisedButton(onPressed: reportRegister,child: new Text("reportRegister"),),
        new RaisedButton(
          onPressed: () {
            print("getInstallPressed!");
            setInstallParams(context);
          },
          child: new Text("setInstallParams"),
        ),
      ],)
    );
  }

  void reportRegister() {
    print("reportRegister");
    _xinstall.reportRegister();
  }

  void setInstallParams(BuildContext context) {
    print("setInstallParams");
    _xinstall.getInstallParams((Map<String, dynamic> params) {print("install--$params");showAlertDialog(context, "installparams--$params");});
  }

  void showAlertDialog(BuildContext context, String msg) {
  showDialog(
      context: context,
      builder: (_) => new AlertDialog(
          title: new Text("Dialog Title"),
          content: new Text(msg),
          actions:<Widget>[
            new FlatButton(child:new Text("CANCEL"), onPressed: (){
              Navigator.of(context).pop();

            },),
            new FlatButton(child:new Text("OK"), onPressed: (){
              Navigator.of(context).pop();

            },)
          ]

      ));
}

}