
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 常用数据类型
class DataType extends StatefulWidget {
  const DataType({Key? key}) : super(key: key);

  @override
  State<DataType> createState() => _DataTypeState();
}

class _DataTypeState extends State<DataType> {
  @override
  Widget build(BuildContext context) {
    _numType();
    stringType();
    boolType();
    listType();
    mapType();
    return Container(
      child: const Text('常用数据类型，请查看控制台输出'),
    );
  }

  /// 数字类型
  void _numType() {
    num num1 = -1.0; // 数字类型的父类
    num num2 = 2; //
    int int1 = 3; // 只能是整数
    double d1 = 0.68; // 双精度
    if (kDebugMode) {
      print("num1:$num1 num2:$num2 int:$int1 double:$d1");

      print(num1.abs()); // 求绝对值
      print(num1.toInt()); // 转换为int类型
      print(num1.toDouble()); // 转换为double类型
    }
  }

  /// 字符串类型
  stringType() {
    String str1 = '字符串';
    String str2 = "双引号";
    String str3 = 'str1: $str1 str2:$str2';
    // ignore: prefer_interpolation_to_compose_strings
    String str4 = 'str1: ' + str1 + " str2:" + str2;
    String str5 = '常用数据类型，请看控制台输出';
    if (kDebugMode) {
      print(str3);
    }
    if (kDebugMode) {
      print(str4);
      print(str5.substring(1, 5)); // 通过下标截取指定内容
      print(str5.indexOf("类型")); // 判断指定内容的下标位置
      print(str5.startsWith("常", 0)); // 判断一个字符串的指定位置是不是以指定内容开始
      print(str5.replaceAll("常", "用")); // 把指定内容，全部替换为指定内容
      print(str5.contains("控制台")); // 判断字符串是否包含指定内容
      print(str5.split("，")); // 把一个字符串通过指定内容分割成若干个字符串数组
      print(str5);
    }
  }

  /// bool 类型
  boolType() {
    bool success = true;
    bool fail = false;
    if (kDebugMode) {
      print(success);
      print(fail);
      print(success || fail);
      print(success && fail);
    }
  }

  /// list集合
  listType() {
    List list = [1, 2, 3, '集合'];
    List<int> list1 = [1, 2, 3];
    list.add('发哥');

    List list3 = [];
    list3.addAll(list);

    if (kDebugMode) {
      print(list);
      for (int i = 0; i < list.length; i++) {
        print(list[i]);
      }
      for (var obj in list) {
        print(obj);
      }
      list.forEach((element) {
        print(element);
      });
    }

    list.remove('发哥');
    print(list);

    list.insert(0, '海立婷');
    print(list);

    List list4 = list.sublist(0, 2);
    print(list4);

    int index = list.indexOf("海立婷");
    print(index);

  }

  /// map
  mapType() {
    Map map = {'xiaoming': '小明', 'xiaohong': '小红'};
    print(map);

    Map map1 = {};
    map1['xiaoming'] = '小明';
    map1['xiaohong'] = '小红';
    print(map1);

    map.forEach((key, value) {
      print('$key $value');
    });

    Map map2 = map.map((key, value){
        return MapEntry(value, key);
    });
    print(map2);

    for(var key in map.keys) {
      print('$key : ${map[key]}');
    }
  }
}
