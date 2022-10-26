
import 'package:flutter/material.dart';

void main() {
  runApp(const GridViewPage());
}

class GridViewPage extends StatefulWidget {
  const GridViewPage({Key? key}) : super(key: key);

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {

  static const cityNames = [ '北京', '上海', '广州', '深圳', '杭州', '苏州', '成都', '武汉', '郑州', '洛阳', '厦门', '青岛', '拉萨' ];

  @override
  Widget build(BuildContext context) {
    const title = '网格布局';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        /// 使用GridView.count实现
        /// crossAxisCount设置一行显示多少列
        body: GridView.count(
            crossAxisCount: 3,
          children: _buildGridViewListWidget(),
        ),
      ),
    );
  }

  List<Widget> _buildGridViewListWidget() {
    return cityNames.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(color: Colors.lightBlueAccent),
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      child: Text(city, style: const TextStyle(fontSize: 30), textAlign: TextAlign.center,),
    );
  }
}
