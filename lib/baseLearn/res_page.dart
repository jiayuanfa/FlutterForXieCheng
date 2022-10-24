
import 'package:flutter/material.dart';

/// 资源文件的使用
class ResPage extends StatefulWidget {
  const ResPage({Key? key}) : super(key: key);
  @override
  State<ResPage> createState() => _ResPageState();
}

class _ResPageState extends State<ResPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('资源文件的使用'),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text('资源文件的使用', style: TextStyle(fontSize: 20)),
          Image(
            width: 100,
            height: 100,
            image: AssetImage('images/play.jpeg'),
          )
        ],
      ),
    );
  }
}
