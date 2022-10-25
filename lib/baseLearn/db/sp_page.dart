
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('shared_preference'),
        ),
        body: const CountWidgetPage(),
      ),
    )
  );
}

/// SharedPreferences的使用
class CountWidgetPage extends StatefulWidget {
  const CountWidgetPage({Key? key}) : super(key: key);

  @override
  State<CountWidgetPage> createState() => _CountWidgetPageState();
}

class _CountWidgetPageState extends State<CountWidgetPage> {

  String countString = '';
  String localCount = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          MaterialButton(
              onPressed: _incrementCounter,
            child: const Text('Increment Counter', style: TextStyle(color: Colors.blue),),
          ),
          MaterialButton(
            onPressed: _getCounter,
            child: const Text('Get Counter', style: TextStyle(color: Colors.blue)),
          ),
          Text(
            countString,
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            localCount,
            style: const TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }


  void _incrementCounter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    /// 修改动态值
    setState(() {
      countString = '${countString}1';
    });
    /// 修改存储值
    int counter = (sharedPreferences.getInt('counter') ?? 0) + 1;
    await sharedPreferences.setInt('counter', counter);
  }

  void _getCounter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      localCount = sharedPreferences.getInt('counter').toString();
    });
  }
}
