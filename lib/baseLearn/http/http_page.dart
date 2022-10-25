
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const HttpPage());

class HttpPage extends StatefulWidget {
  const HttpPage({Key? key}) : super(key: key);

  @override
  State<HttpPage> createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {

  String showResponse = '';
  Future<CommonModel> fetchPost() async{
    /// url 需要解析成 Uri
    var url = Uri.parse('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    final response = await http.get(url);

    /// 使用Dart语言自带的json转换框架将请求结果转换为json
    final result = json.decode(response.body);

    /// 将json转换为模型
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Http'),
        ),
        body: Column(
          children: <Widget>[
            InkWell(
              onTap: (){
                fetchPost().then((CommonModel value) {
                  setState(() {
                    showResponse = '请求结果haha: \n hideAppBar: ${value.hideAppBar} \nicon:${value.icon} ';
                  });
                });
              },
              child: const Text(
                '点我le',
                style: TextStyle(fontSize: 26),
              ),
            ),
            Text(showResponse),
          ],
        ),
      ),
    );
  }
}

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel({this.icon = '', this.title = '', this.url = '', this.statusBarColor = '', this.hideAppBar = false});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
        icon: json['icon'],
        title: json['title'],
        url: json['url'],
        statusBarColor: json['statusBarColor'],
        hideAppBar: json['hideAppBar']);
  }
}
