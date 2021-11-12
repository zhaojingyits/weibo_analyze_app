import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'sputil.dart';
void sendEmail(String email) => launch("mailto:$email");
void about(BuildContext ctx) {
   //sharedDeleteData('history');
  showAboutDialog(
      context: ctx,
      applicationIcon: Icon(Icons.bubble_chart),
      applicationName: '微博水军研究',
      applicationVersion: "1.0",
      children: [
        Text('小组成员：赵敬一 冉玉婷 崔琦萱 彭雪淳'),
        Divider(),
        FlatButton.icon(
              icon: Icon(Icons.feedback),
              onPressed: () {
                sendEmail('zhaojingyits@foxmail.com');
              },
              label: Text('邮件反馈'),
            ),
      ]);
}