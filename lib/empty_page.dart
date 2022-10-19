
import 'package:flutter/material.dart';

/// 空StatefulWidget实现
class EmptyStatefulWidgetPage extends StatefulWidget {
  const EmptyStatefulWidgetPage({Key? key}) : super(key: key);
  @override
  State<EmptyStatefulWidgetPage> createState() => _EmptyStatefulWidgetPageState();
}

class _EmptyStatefulWidgetPageState extends State<EmptyStatefulWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('空StatefulWidget实现'),
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
          Text('空StatefulWidget实现', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
