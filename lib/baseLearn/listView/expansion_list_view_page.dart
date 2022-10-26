
import 'package:flutter/material.dart';

void main(){
  runApp(ExpansionTileListViewPage());
}

class ExpansionTileListViewPage extends StatefulWidget {
  const ExpansionTileListViewPage({Key? key}) : super(key: key);

  @override
  State<ExpansionTileListViewPage> createState() => _ExpansionTileListViewPageState();
}

class _ExpansionTileListViewPageState extends State<ExpansionTileListViewPage> {

  static const cityNames = {
    '北京': ['东城区', '西城区', '朝阳区', '丰台区', '石景山区', '海淀区', '顺义区'],
    '上海': ['黄浦区', '徐汇区', '长宁区', '静安区', '普陀区', '闸北区', '虹口区'],
    '广州': ['越秀', '海珠', '荔湾', '天河', '白云', '黄埔', '南沙', '番禺'],
    '深圳': ['南山', '福田', '罗湖', '盐田', '龙岗', '宝安', '龙华'],
    '杭州': ['上城区', '下城区', '江干区', '拱墅区', '西湖区', '滨江区'],
    '苏州': ['姑苏区', '吴中区', '相城区', '高新区', '虎丘区', '工业园区', '吴江区']
  };

  @override
  Widget build(BuildContext context) {
    const title = '列表的展开与收起';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView(
          children: _buildListWidget(),
        ),
      ),
    );
  }

  /// 一级列表构造器
  List<Widget>_buildListWidget() {
    List<Widget> widgets = [];
    for (var key in cityNames.keys) {
      widgets.add(_item(key, cityNames[key]!));
    }
    return widgets;
  }

  /// 一级列表item构造器
  Widget _item(String city, List<String> subCities) {
    return ExpansionTile(
        title: Text(
          city,
          style: const TextStyle(color: Colors.black54, fontSize: 20),
        ),
      children: subCities.map((subCity) => _buildSubCityWidget(subCity)).toList(),
    );
  }

  /// 二级列表Item构造器
  Widget _buildSubCityWidget(String subCity) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(color: Colors.lightBlueAccent),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: Text(subCity, textAlign: TextAlign.left,),
      ),
    );
  }
}
