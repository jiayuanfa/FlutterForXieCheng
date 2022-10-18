
import 'package:flutter/material.dart';

class GesturePage extends StatefulWidget {
  const GesturePage({Key? key}) : super(key: key);

  @override
  State<GesturePage> createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {

  String _printString = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('手势检测'),
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: FractionallySizedBox(
          widthFactor: 1,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      _printMsg('点击');
                    },
                    onDoubleTap: () => _printMsg('双击'),
                    onLongPress: () => _printMsg('长按'),
                    onTapDown: (e) => _printMsg('按下'),
                    onTapUp: (e) => _printMsg('抬起'),
                    onTapCancel: () => _printMsg('取消'),

                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _printMsg(String msg) {
    setState(() {
      _printString += ', ${msg}';
    });

  }
}
