
import 'package:flutter/material.dart';

void main() {
  runApp(
    const ListViewHorizontalPage()
  );
}

/// 水平滚动的ListView
class ListViewHorizontalPage extends StatefulWidget {
  const ListViewHorizontalPage({Key? key}) : super(key: key);

  @override
  State<ListViewHorizontalPage> createState() => _ListViewHorizontalPageState();
}

class _ListViewHorizontalPageState extends State<ListViewHorizontalPage> {

  List<String> cityNames = ['北京', '上海', '广州', '深圳', '杭州', '苏州', '成都', '武汉', '郑州', '洛阳', '厦门', '青岛', '拉萨'];

  @override
  Widget build(BuildContext context) {
    const title = '水平滚动';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left:20, top: 20,),
            children: _buildList(),
          ),
        ),
        ),
    );
  }

  /// 把String数组转换为Widget数组
  List<Widget> _buildList() {
      return cityNames.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      width: 200,
      margin: const EdgeInsets.only(left:0, bottom: 5, right: 20),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
