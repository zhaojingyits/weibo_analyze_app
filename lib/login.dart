import 'package:flutter/material.dart';
import 'apply_for_response.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  //static const LOGO = "images/oschina.png";

  var _userPassController = new TextEditingController();
  var _userNameController = new TextEditingController();
  var _newNameController = new TextEditingController();
  var _newPass1Controller = new TextEditingController();
  var _newPass2Controller = new TextEditingController();
  var _newEmailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var buttonColor = Colors.green;
    var buttonText = '马上登录';
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("登录", style: new TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        body: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 50.0, leftRightPadding, 10.0),
              child: FlatButton.icon(
                icon: Icon(
                  Icons.bubble_chart,
                  size: 60.0,
                ),
                label: Text(
                  '微博水军研究',
                  textScaleFactor: 2.3,
                ),
                textTheme: ButtonTextTheme.accent,
                color: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {},
              ),
            ),
            Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 50.0, leftRightPadding, 10.0),
              child: RaisedButton(
                child: Text('注册'),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return SimpleDialog(
                          title: Text('注册'),
                          children: <Widget>[
                            TextField(
                              style: hintTips,
                              controller: _newNameController,
                              decoration: new InputDecoration(
                                hintText: "用户名",
                                labelText: "请输入用户名",
                                prefixIcon: Icon(Icons.person),
                              ),
                              //obscureText: true,
                            ),
                            TextField(
                              style: hintTips,
                              controller: _newPass1Controller,
                              decoration: new InputDecoration(
                                hintText: "密码",
                                labelText: "请输入密码",
                                prefixIcon: Icon(Icons.lock),
                              ),
                              obscureText: true,
                            ),
                            TextField(
                              style: hintTips,
                              controller: _newPass2Controller,
                              decoration: new InputDecoration(
                                hintText: "重复密码",
                                labelText: "请再次输入密码",
                                prefixIcon: Icon(Icons.lock),
                              ),
                              obscureText: true,
                            ),
                            TextField(
                              style: hintTips,
                              controller: _newEmailController,
                              decoration: new InputDecoration(
                                hintText: "邮箱",
                                labelText: "请输入电子邮箱",
                                prefixIcon: Icon(Icons.email),
                              ),
                              //obscureText: true,
                            ),
                            FlatButton(
                              child: Text('立即注册'),
                              onPressed: () async {
                                if (_newPass1Controller.text !=
                                    _newPass2Controller.text) {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          title: Text('注册出错'),
                                          content: Text('两次密码不一致'),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('确定')),
                                          ],
                                        );
                                      });
                                } else {
                                  var res = await getRegisterInfo(
                                      _newNameController.text,
                                      _newPass1Controller.text,
                                      _newEmailController.text);
                                  if (res.error != null) {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          String errorInfo;
                                          switch (res.error) {
                                            case "user_not_exists":
                                              errorInfo = '错误：用户不存在';
                                              break;
                                            case "password_invalid":
                                              errorInfo = '错误：密码错误';
                                              break;
                                            case 'upload_network_error':
                                              errorInfo = '错误：网络错误';
                                              break;
                                            default:
                                              errorInfo = '错误：未知错误' + res.error;
                                              break;
                                          }
                                          return AlertDialog(
                                            title: Text('注册出错'),
                                            content: Text(errorInfo),
                                            actions: <Widget>[
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('确定')),
                                            ],
                                          );
                                        });
                                  } else if (res.result == 'succeed') {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            title: Text('注册成功'),
                                            content: Text('用户名：' +
                                                _newNameController.text),
                                            actions: <Widget>[
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('确定')),
                                            ],
                                          );
                                        });
                                  }
                                }
                              },
                            )
                          ],
                        );
                      });
                },
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 50.0, leftRightPadding, topBottomPadding),
              child: new TextField(
                style: hintTips,
                controller: _userNameController,
                decoration: new InputDecoration(
                  hintText: "用户名",
                  labelText: "请输入用户名",
                  prefixIcon: Icon(Icons.person),
                ),
                //obscureText: true,
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 30.0, leftRightPadding, topBottomPadding),
              child: new TextField(
                style: hintTips,
                controller: _userPassController,
                decoration: new InputDecoration(
                  hintText: "密码",
                  labelText: "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
            ),
            new Container(
              width: 360.0,
              margin: new EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
              padding: new EdgeInsets.fromLTRB(leftRightPadding,
                  topBottomPadding, leftRightPadding, topBottomPadding),
              child: new Card(
                color: buttonColor,
                elevation: 6.0,
                child: new FlatButton(
                    onPressed: () async {
                      print("the name is" + _userNameController.text);
                      print("the pass is" + _userPassController.text);
                      setState(() {
                        buttonColor = Colors.pink;
                        buttonText = '登录中';
                      });
                      var res = await getLoginInfo(
                          _userNameController.text, _userPassController.text);
                      if (res.error != null) {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              String errorInfo;
                              switch (res.error) {
                                case "user_not_exists":
                                  errorInfo = '错误：用户不存在';
                                  break;
                                case "password_invalid":
                                  errorInfo = '错误：密码错误';
                                  break;
                                case 'upload_network_error':
                                  errorInfo = '错误：网络错误';
                                  break;
                                default:
                                  errorInfo = '错误：未知错误' + res.error;
                                  break;
                              }
                              return AlertDialog(
                                title: Text('登录出错'),
                                content: Text(errorInfo),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('确定')),
                                ],
                              );
                            });
                      }
                      if (res.result == 'succeed') {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text('登录成功'),
                                content:
                                    Text('用户名：' + _userNameController.text),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('确定')),
                                ],
                              );
                            });
                      }
                      setState(() {
                        buttonColor = Colors.green;
                        buttonText = '马上登录';
                      });
                    },
                    child: new Padding(
                      padding: new EdgeInsets.all(10.0),
                      child: new Text(
                        buttonText,
                        style:
                            new TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    )),
              ),
            )
          ],
        ));
  }
}
