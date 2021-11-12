import 'package:flutter/material.dart';
import 'package:wbanalyse/sputil.dart';
import 'show_details.dart';
import 'about_dialog.dart';
import 'apply_for_response.dart';

class SearchPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return new SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  var buttonColor = Colors.green;
  var buttonText = '查询';
  var leftRightPadding = 30.0;
  var topBottomPadding = 4.0;
  var buttonIcon = Icons.search;
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  var _newPass2Controller = new TextEditingController();
  var _oldPassController = new TextEditingController();
  var _newPass1Controller = new TextEditingController();
  var _userNameController = new TextEditingController();
  Widget build(BuildContext context) => Center(
        child: Column(
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
                onPressed: () {
                  about(context);
                },
              ),
            ),
            Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 50.0, leftRightPadding, 10.0),
              child: RaisedButton(
                child: Text('查看登录状态'),
                onPressed: () async {
                  String a = await sharedGetString('name');
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          content: Text('已登录用户：' + a),
                          title: Text('登录状态'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return SimpleDialog(
                                          title: Text('注册'),
                                          children: <Widget>[
                                            TextField(
                                              style: hintTips,
                                              controller: _oldPassController,
                                              decoration: new InputDecoration(
                                                hintText: "原密码",
                                                labelText: "请输入原密码",
                                                //prefixIcon: Icon(Icons.person),
                                              ),
                                              obscureText: true,
                                            ),
                                            TextField(
                                              style: hintTips,
                                              controller: _newPass1Controller,
                                              decoration: new InputDecoration(
                                                hintText: "新密码",
                                                labelText: "请输入新密码",
                                                //prefixIcon: Icon(Icons.lock),
                                              ),
                                              obscureText: true,
                                            ),
                                            TextField(
                                              style: hintTips,
                                              controller: _newPass2Controller,
                                              decoration: new InputDecoration(
                                                hintText: "确认新密码",
                                                labelText: "请再次输入密码",
                                                //prefixIcon: Icon(Icons.lock),
                                              ),
                                              obscureText: true,
                                            ),
                                            FlatButton(
                                              child: Text('立即修改密码'),
                                              onPressed: () async {
                                                if (_newPass1Controller.text !=
                                                    _newPass2Controller.text) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (ctx) {
                                                        return AlertDialog(
                                                          title: Text('修改出错'),
                                                          content:
                                                              Text('两次密码不一致'),
                                                          actions: <Widget>[
                                                            FlatButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Text('确定')),
                                                          ],
                                                        );
                                                      });
                                                } else {
                                                  var res =
                                                      await getChangePassInfo(
                                                          a,
                                                          _oldPassController
                                                              .text,
                                                          _newPass1Controller
                                                              .text);
                                                  if (res.error != null) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (ctx) {
                                                          String errorInfo;
                                                          switch (res.error) {
                                                            case "user_not_exists":
                                                              errorInfo =
                                                                  '错误：用户不存在';
                                                              break;
                                                            case "password_invalid":
                                                              errorInfo =
                                                                  '错误：密码错误';
                                                              break;
                                                            case 'upload_network_error':
                                                              errorInfo =
                                                                  '错误：网络错误';
                                                              break;
                                                            default:
                                                              errorInfo =
                                                                  '错误：未知错误' +
                                                                      res.error;
                                                              break;
                                                          }
                                                          return AlertDialog(
                                                            title: Text('注册出错'),
                                                            content:
                                                                Text(errorInfo),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      '确定')),
                                                            ],
                                                          );
                                                        });
                                                  } else if (res.result ==
                                                      'succeed') {
                                                    showDialog(
                                                        context: context,
                                                        builder: (ctx) {
                                                          return AlertDialog(
                                                            title:
                                                                Text('密码修改成功'),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      '确定')),
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
                                child: Text('修改密码')),
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('确定')),
                          ],
                        );
                      });
                },
              ),
            ),
            Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 50.0, leftRightPadding, topBottomPadding),
              child: new TextField(
                style: hintTips,
                controller: _userNameController,
                decoration: new InputDecoration(
                  hintText: "请输入微博ID",
                  labelText: "待查询微博ID",
                  prefixIcon: Icon(Icons.person),
                ),
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
                      setState(() {
                        buttonColor = Colors.pink;
                        buttonText = '查询中';
                        buttonIcon = Icons.schedule;
                      });
                      var res = await getResponse(new ApplyInfo(
                          userName: "name",
                          passWordEncrypted: "passwd",
                          wbUserID: _userNameController.text));
                      setState(() {
                        buttonColor = Colors.green;
                        buttonText = '查询';
                        buttonIcon = Icons.search;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailsPage(
                          resultInfo: res,
                        );
                      }));
                    },
                    child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              buttonIcon,
                              color: Colors.white,
                            ),
                            Text(
                              buttonText,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            )
                          ],
                        ))),
              ),
            ),
          ],
        ),
      );
}
