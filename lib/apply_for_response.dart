import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'sputil.dart';

import 'json_structure.dart';

class ApplyInfo {
  String userName;
  String passWordEncrypted;
  String wbUserID;

  ApplyInfo({this.userName, this.passWordEncrypted, this.wbUserID});
}

Future<ResultInfo> getResponse(ApplyInfo param) async {
  BaseOptions options = BaseOptions(
    baseUrl: 'http://114.116.230.217:4300',
    connectTimeout: 12000,
    receiveTimeout: 12000,
  );

  Dio dio = new Dio(options);
  Response response;
  ResultInfo resultInfo;
  try {
    response = await dio.get("/summary?id=" + param.wbUserID);
  } catch (e) {
    resultInfo = ResultInfo(errorInfo: '由于服务器错误，未能得出分析结果，请重新查询，或更换其他微博ID尝试。我们会尽快修复此问题。',details: List<Details>());
    return resultInfo;
  }
  print(json.encode(response.data));
  resultInfo = ResultInfo.fromJson(response.data);

  
  List<String> data = await sharedGetData('history');
  if(data==null)
    data=new List<String>();
  data.add(json.encode(resultInfo));
  sharedAddAndUpdate('history', List, data);

  
  return resultInfo;
}
Future<LoginInfo> getLoginInfo(String name,String password) async {
  BaseOptions options = BaseOptions(
    baseUrl: 'http://114.116.230.217:4300',
    connectTimeout: 12000,
    receiveTimeout: 12000,
  );

  Dio dio = new Dio(options);
  Response response;
  LoginInfo loginInfo;
  try {
    response = await dio.get("/login?id=" + name+"&passwd="+password);
  } catch (e) {
    loginInfo = LoginInfo(error:'upload_network_error');
    return loginInfo;
  }
  print(json.encode(response.data));
  loginInfo = LoginInfo.fromJson(response.data);
  if(loginInfo.error==null && loginInfo.result=='succeed'){
    sharedAddAndUpdate('name', String,name);
    sharedAddAndUpdate('password', String,password);
  }
  return loginInfo;
}
Future<LoginInfo> getRegisterInfo(String name,String password,String email) async {
  BaseOptions options = BaseOptions(
    baseUrl: 'http://114.116.230.217:4300',
    connectTimeout: 12000,
    receiveTimeout: 12000,
  );

  Dio dio = new Dio(options);
  Response response;
  LoginInfo loginInfo;
  try {
    response = await dio.get("/register?id=" + name+"&passwd="+password+"&email="+email);
  } catch (e) {
    loginInfo = LoginInfo(error:'upload_network_error');
    return loginInfo;
  }
  print(json.encode(response.data));
  loginInfo = LoginInfo.fromJson(response.data);
  return loginInfo;
}
Future<LoginInfo> getChangePassInfo(String id,String oldpass,String newpass) async {
  BaseOptions options = BaseOptions(
    baseUrl: 'http://114.116.230.217:4300',
    connectTimeout: 12000,
    receiveTimeout: 12000,
  );

  Dio dio = new Dio(options);
  Response response;
  LoginInfo loginInfo;
  try {
    response = await dio.get("/change_passwd?id=" + id+"&passwd_old="+oldpass+"&passwd_new="+newpass);
  } catch (e) {
    loginInfo = LoginInfo(error:'upload_network_error');
    return loginInfo;
  }
  print(json.encode(response.data));
  loginInfo = LoginInfo.fromJson(response.data);
  
  sharedAddAndUpdate('password', String,newpass);
  return loginInfo;
}
getFeedback(String userid,String wbid,int score,String info) async {
  BaseOptions options = BaseOptions(
    baseUrl: 'http://114.116.230.217:4300',
    connectTimeout: 12000,
    receiveTimeout: 12000,
  );

  Dio dio = new Dio(options);
  Response response;
  try {
    response = await dio.get("/feedback?userid=" + userid+"&wbid="+wbid+"&score="+score.toString()+"&info="+info);
  } catch (e) {
    return;
  }
  print('res:');
  print(response);
  return;
}
