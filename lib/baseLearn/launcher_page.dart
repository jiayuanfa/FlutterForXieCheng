//
// import 'package:flutter/material.dart';
//
// import 'package:url_launcher/url_launcher.dart';
//
// /// 打开第三方应用
// class LauncherPage extends StatefulWidget {
//   const LauncherPage({Key? key}) : super(key: key);
//   @override
//   State<LauncherPage> createState() => _LauncherPageState();
// }
//
// class _LauncherPageState extends State<LauncherPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('打开第三方应用'),
//         leading: GestureDetector(
//           onTap: (){
//             Navigator.pop(context);
//           },
//           child: const Icon(Icons.arrow_back),
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           const Text('打开第三方应用', style: TextStyle(fontSize: 20)),
//           ElevatedButton(
//               onPressed: () => _launchUrl(),
//             child: const Text('Show Flutter HomePage'),
//           ),
//           ElevatedButton(
//               onPressed: () => _openMap(),
//               child: const Text('Open map'))
//         ],
//       ),
//     );
//   }
//
//   /// 通过浏览器打开
//   Future<void> _launchUrl() async {
//     final Uri url = Uri.parse('https://flutter.dev');
//     if (!await launchUrl(url)) {
//       throw 'Could not launch $url';
//     }
//   }
//
//   /// 打开地图
//   Future<void> _openMap() async {
//     // Android
//     Uri url = Uri.parse('geo:52.32,4.917');
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url);
//     } else {
//       // iOS
//       url = Uri.parse('http://map.apple.com/?ll=52.32,4.917');
//       if (await canLaunchUrl(url)) {
//         await launchUrl(url);
//       } else {
//         throw 'Could not launch $url';
//       }
//     }
//   }
// }
