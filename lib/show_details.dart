import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'apply_for_response.dart';
import 'result_to_text.dart';
import 'json_structure.dart';
import 'package:share/share.dart';

import 'sputil.dart';

List<Widget> getGradeStar(double score, double _total) {
  int total = _total.toInt();
  List<Widget> _list = List<Widget>();
  for (var i = 0; i < total; i++) {
    double factor = (score - i);
    if (factor >= 1) {
      factor = 1.0;
    } else if (factor < 0) {
      factor = 0;
    }
    Stack _st = Stack(
      children: <Widget>[
        Icon(
          Icons.star,
          color: Colors.grey,
        ),
        ClipRect(
            child: Align(
          alignment: Alignment.topLeft,
          widthFactor: factor,
          child: Icon(
            Icons.star,
            color:
                (score / _total >= 0.67) ? Colors.redAccent : Colors.blueAccent,
          ),
        ))
      ],
    );
    _list.add(_st);
  }
  return _list;
}

void sendEmail(String email) => launch("mailto:$email");

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key, @required this.resultInfo}) : super(key: key);
  final ResultInfo resultInfo;
  @override
  State<StatefulWidget> createState() {
    return new _DetailsPageState();
  }
}

class _DetailsPageState extends State<DetailsPage> {
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  var _contentController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    int _selectType;
    return new Scaffold(
        appBar: AppBar(
          title: Text('分析结果'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.feedback),
              textTheme: ButtonTextTheme.primary,
              color: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return SimpleDialog(
                        children: <Widget>[
                          DropdownButtonHideUnderline(
                              child: new DropdownButton(
                            items: [
                              new DropdownMenuItem(
                                child: new Text('5星 最高'),
                                value: 5,
                              ),
                              new DropdownMenuItem(
                                child: new Text('4星'),
                                value: 4,
                              ),
                              new DropdownMenuItem(
                                child: new Text('3星'),
                                value: 3,
                              ),
                              new DropdownMenuItem(
                                child: new Text('2星'),
                                value: 2,
                              ),
                              new DropdownMenuItem(
                                child: new Text('1星 最低'),
                                value: 1,
                              ),
                            ],
                            hint: new Text('请选择评分星级'),
                            onChanged: (value) {
                              setState(() {
                                _selectType = value;
                              });
                            },
//              isExpanded: true,
                            value: _selectType,
                            elevation: 24, //设置阴影的高度
                            style: new TextStyle(
                              //设置文本框里面文字的样式
                              color: Color(0xff4a4a4a),
                              fontSize: 12,
                            ),
                            isDense:
                                true, //减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                            iconSize: 40.0,
                          )),
                          TextField(
                            style: hintTips,
                            controller: _contentController,
                            decoration: new InputDecoration(
                              hintText: "反馈内容",
                              labelText: "请输入反馈内容",
                              //prefixIcon: Icon(Icons.person),
                            ),
                            //obscureText: true,
                          ),
                          FlatButton(
                            child: Text('提交'),
                            onPressed: () async {
                              String a = await sharedGetString('name');
                              print(a);
                              print(widget.resultInfo.userid);
                              print(_selectType);
                              print(_contentController.text);
                              getFeedback(a,widget.resultInfo.userid,_selectType,_contentController.text);
                            },
                          )
                        ],
                      );
                    });
              },
              label: Text('反馈'),
            ),
            FlatButton.icon(
              icon: Icon(Icons.share),
              textTheme: ButtonTextTheme.primary,
              color: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Share.share(resultToData(widget.resultInfo));
              },
              label: Text('分享'),
            )
          ],
        ),
        body: Center(
            child: ListView.builder(
          itemCount: widget.resultInfo.details.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0)
              return SizedBox(
                child: Card(
                    elevation: 15.0,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(14.0))), //设置圆角
                    child: new Column(children: <Widget>[
                      new ListTile(
                        title: (widget.resultInfo.username == null)
                            ? null
                            : new Text('微博用户${widget.resultInfo.username}的分析结果',
                                style:
                                    new TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: new Text('ID:${widget.resultInfo.userid}'),
                        leading: new Icon(
                          Icons.person,
                          color: Colors.blue[500],
                        ),
                      ),
                      (widget.resultInfo.errorInfo == null)
                          ? SizedBox(
                              height: 0.0,
                              width: 0.0,
                            )
                          : ListTile(
                              title: new Text('分析过程有错误信息',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w500)),
                              subtitle: new Text(widget.resultInfo.errorInfo,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w400)),
                              leading: new Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                      (widget.resultInfo.totalMark == null)
                          ? SizedBox(
                              height: 0.0,
                              width: 0.0,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("综合指数"),
                                Row(
                                    children: getGradeStar(
                                        widget.resultInfo.totalMark,
                                        widget.resultInfo.largestMark)),
                                Text(
                                    "${widget.resultInfo.totalMark}/${widget.resultInfo.largestMark}")
                              ],
                            ),
                      SizedBox(height: 20),
                    ])),
              );
            else
              return SizedBox(
                  child: Card(
                elevation: 15.0,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(14.0))), //设置圆角
                child: new Column(
                  children: <Widget>[
                    new ListTile(
                      title: new Text(widget.resultInfo.details[index - 1].item,
                          style: new TextStyle(fontWeight: FontWeight.w500)),
                      subtitle: Row(
                          children: getGradeStar(
                              widget.resultInfo.details[index - 1].mark,
                              widget
                                  .resultInfo.details[index - 1].largestMark)),
                      leading: new Icon(
                        Icons.announcement,
                        color: Colors.blue[500],
                      ),
                      trailing: Text(
                          "${widget.resultInfo.details[index - 1].mark.toString()}/${widget.resultInfo.details[index - 1].largestMark.toString()}"),
                    ),
                    new Divider(),
                    (widget.resultInfo.details[index - 1].children == null)
                        ? SizedBox(width: 0.0, height: 0.0)
                        : Column(
                            children: List.generate(
                                widget.resultInfo.details[index - 1].children
                                    .length, (i) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                      "${widget.resultInfo.details[index - 1].children[i].item}:${widget.resultInfo.details[index - 1].children[i].mark}/${widget.resultInfo.details[index - 1].children[i].largestMark}"),
                                  Row(
                                      children: getGradeStar(
                                          widget.resultInfo.details[index - 1]
                                              .children[i].mark,
                                          widget.resultInfo.details[index - 1]
                                              .children[i].largestMark)),
                                ],
                              );
                            }),
                          ),
                    new ListTile(
                      title: new Text(
                          widget.resultInfo.details[index - 1].describe,
                          style: new TextStyle(fontWeight: FontWeight.w500)),
                      leading: new Icon(
                        Icons.info,
                        color: Colors.blue[500],
                      ),
                    ),
                  ],
                ),
              ));
          },
        )));
  }
}
