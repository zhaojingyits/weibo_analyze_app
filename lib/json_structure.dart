class ResultInfo {
  String userid;
  String username;
  String errorInfo;
  double totalMark;
  double largestMark;
  List<Details> details;

  ResultInfo(
      {this.userid,
      this.username,
      this.totalMark,
      this.largestMark,
      this.errorInfo,
      this.details});

  ResultInfo.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['username'];
    totalMark = json['total_mark'].toDouble();
    largestMark = json['largest_mark'].toDouble();
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    errorInfo=json['error_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['username'] = this.username;
    data['total_mark'] = this.totalMark.toDouble();
    data['largest_mark'] = this.largestMark.toDouble();
    data['error_info'] = this.errorInfo;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String item;
  double mark;
  double largestMark;
  String describe;
  List<Children> children;

  Details(
      {this.item, this.mark, this.largestMark, this.describe, this.children});

  Details.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    mark = json['mark'].toDouble();
    largestMark = json['largest_mark'].toDouble();
    describe = json['describe'];
    if (json['children'] != null) {
      children = new List<Children>();
      json['children'].forEach((v) {
        children.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    data['mark'] = this.mark.toDouble();
    data['largest_mark'] = this.largestMark.toDouble();
    data['describe'] = this.describe;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String item;
  double mark;
  double largestMark;

  Children({this.item, this.mark, this.largestMark});

  Children.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    mark = json['mark'];
    largestMark = json['largest_mark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    data['mark'] = this.mark.toDouble();
    data['largest_mark'] = this.largestMark.toDouble();
    return data;
  }
}
class LoginInfo {
  String error;
  String result;

  LoginInfo({this.error, this.result});

  LoginInfo.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['result'] = this.result;
    return data;
  }
}
