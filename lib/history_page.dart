import 'dart:convert';

import 'package:flutter/material.dart';
import 'json_structure.dart';
import 'show_details.dart';
import 'sputil.dart';

Future<List<String>> getHistoryData() => sharedGetStringList('history');

class HistoryPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return new HistoryPageState();
  }
}

enum Action { Ok, Cancel }

class HistoryPageState extends State<HistoryPage> {
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: FloatingActionButton(
          tooltip: '清空历史记录',
          child: Icon(Icons.delete),
          onPressed: () async {
            final action = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('提示'),
                    content: Text('是否清空记录？'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('取消'),
                        onPressed: () {
                          Navigator.pop(context, Action.Cancel);
                        },
                      ),
                      FlatButton(
                        child: Text('确认'),
                        onPressed: () {
                          Navigator.pop(context, Action.Ok);
                        },
                      ),
                    ],
                  );
                });
            switch (action) {
              case Action.Ok:
                setState(() {
                  sharedDeleteData('history');
                });
                break;
              case Action.Cancel:
                break;
              default:
            }
          }),
      body: SafeArea(
        child: FutureBuilder<List<String>>(
          future: getHistoryData(),
          builder: (context, historydata) {
            if (historydata.hasData) {
              return ListView.builder(
                  itemCount: historydata.data.length,
                  itemBuilder: (context, index) {
                    var resultInfo = ResultInfo.fromJson(json.decode(
                        historydata.data[historydata.data.length - 1 - index]));
                    return Card(
                        elevation: 15.0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0))), //设置圆角
                        child: ListTile(
                          title: (resultInfo.username == null)
                              ? null
                              : new Text(
                                  '用户:${resultInfo.username}  指数:${resultInfo.totalMark.toString()}/${resultInfo.largestMark.toString()}',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w500)),
                          subtitle: Text('ID:${resultInfo.userid}'),
                          leading:
                              (resultInfo.totalMark / resultInfo.largestMark >=
                                      0.6)
                                  ? Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    )
                                  : Icon(Icons.person, color: Colors.blue),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailsPage(
                                resultInfo: resultInfo,
                              );
                            }));
                          },
                        ));
                  });
            }
            return ListView(
              children: <Widget>[
                ListTile(
                  title: Text('还没有内容'),
                )
              ],
            );
          },
        ),
      ));
}
