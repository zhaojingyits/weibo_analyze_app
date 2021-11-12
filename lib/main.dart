import 'package:flutter/material.dart';
import 'about_dialog.dart';
//import 'apply_for_response.dart';
import 'history_page.dart';
import 'search_page.dart';
//import 'show_details.dart';

import 'login.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '微博水军研究',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '微博水军研究1.0'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    int _tabIndex = 0;
    var appBarTitles = ['查询', '历史记录'];
    var _pageList;
    void initData() {
    _pageList = [
      new SearchPage(),
      new HistoryPage(),
    ];
  }
    Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff1296db)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff515151)));
    }
  }
  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.lock_open),
            label: Text('登录'),
            textTheme: ButtonTextTheme.primary,
            color: Colors.transparent,
            highlightColor: Colors.transparent,
            //elevation: 0.0,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.info),
            label: Text('关于'),
            textTheme: ButtonTextTheme.primary,
            color: Colors.transparent,
            highlightColor: Colors.transparent,
            //elevation: 0.0,
            onPressed: () {
              about(context);
            },
          )
        ],
      ),
      body: _pageList[_tabIndex],
      bottomNavigationBar: new BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: Icon(Icons.search), title: getTabTitle(0)),
            new BottomNavigationBarItem(
                icon: Icon(Icons.history), title: getTabTitle(1)),
          ],
          type: BottomNavigationBarType.fixed,
          //默认选中首页
          currentIndex: _tabIndex,
          iconSize: 24.0,
          //点击事件
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        )
    );
  }
}
