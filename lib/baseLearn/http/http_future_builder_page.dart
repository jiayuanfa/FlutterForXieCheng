//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// void main() => runApp(const FutureBuilderPage());
//
// class FutureBuilderPage extends StatefulWidget {
//   const FutureBuilderPage({Key? key}) : super(key: key);
//
//   @override
//   State<FutureBuilderPage> createState() => _FutureBuilderPageState();
// }
//
// class _FutureBuilderPageState extends State<FutureBuilderPage> {
//
//   String showResponse = '';
//   Future<CommonModel> fetchPost() async{
//     /// url 需要解析成 Uri
//     var url = Uri.parse('http://www.devio.org/io/flutter_app/json/test_common_model.json');
//     final response = await http.get(url);
//
//     /// 使用Dart语言自带的json转换框架将请求结果转换为json
//     /// 解决中文乱码问题
//     Utf8Decoder utf8decoder = const Utf8Decoder();
//     final result = json.decode(utf8decoder.convert(response.bodyBytes));
//
//     /// 将json转换为模型
//     return CommonModel.fromJson(result);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Http'),
//         ),
//         /// 使用FutureBuilder进行HTTP请求
//           /// future 注意这个参数
//         body: FutureBuilder<CommonModel>(
//           future: fetchPost(),
//           builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
//             switch (snapshot.connectionState) {
//               case ConnectionState.none:
//                 return const Text('Input a url to start');
//               case ConnectionState.waiting:
//                 return const Center(child: CircularProgressIndicator());
//               case ConnectionState.active:
//                 return const Text('');
//               case ConnectionState.done:
//                 if (snapshot.hasError) {
//                   return Text('${snapshot.error}', style: const TextStyle(color: Colors.red),);
//                 } else {
//                   return Column(
//                     children: [
//                       Text('icon:${snapshot.data?.icon}'),
//                       Text('statusBarColor:${snapshot.data?.statusBarColor}'),
//                       Text('title:${snapshot.data?.title}'),
//                       Text('url:${snapshot.data?.url}'),
//                     ],
//                   );
//                 }
//                 break;
//             }
//           },
//         )
//       ),
//     );
//   }
// }
//
// class CommonModel {
//   final String icon;
//   final String title;
//   final String url;
//   final String statusBarColor;
//   final bool hideAppBar;
//
//   CommonModel({this.icon = '', this.title = '', this.url = '', this.statusBarColor = '', this.hideAppBar = false});
//
//   factory CommonModel.fromJson(Map<String, dynamic> json) {
//     return CommonModel(
//         icon: json['icon'],
//         title: json['title'],
//         url: json['url'],
//         statusBarColor: json['statusBarColor'],
//         hideAppBar: json['hideAppBar']);
//   }
// }
