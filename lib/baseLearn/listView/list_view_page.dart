
import 'package:flutter/material.dart';

void main() {
  runApp(
    const ListViewPage()
  );
}

/// 垂直滚动的ListView
class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {

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
        body: ListView(
            children: _buildList(),
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
      margin: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
