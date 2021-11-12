import 'json_structure.dart';

bool stringValid(String s) => (s == '' || s == null || s == ' ') ? false : true;
String resultToData(ResultInfo res) {
  String s = "【微博水军分析】";
  if (stringValid(res.userid) && stringValid(res.username))
    s += "${res.username}(ID:${res.userid})分析结果:\n";
  if (stringValid(res.errorInfo)) s += '(分析出错:+${res.errorInfo})\n';
  if (res.totalMark != null && res.largestMark != null)
    s += '分数：' +
        res.totalMark.toString() +
        '/' +
        res.largestMark.toString() +
        '\n';
  if (res.details != null && res.details.isEmpty == false) {
    s += '【分析项目】\n';
    for (Details det in res.details) {
      //String item;  double mark;  double largestMark;  String describe;
      if (stringValid(det.item)) s += det.item;
      if (det.mark != null && det.largestMark != null)
        s += ' 分数：' + det.mark.toString() + '/' + det.largestMark.toString();
      if (stringValid(det.describe)) s += ' (${det.describe})';
      s += '\n';
    }
  }
  return s;
}
