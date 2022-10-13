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
    return Container(
      child: const Text('常用数据类型，请查看控制台输出'),
    );
  }
}

void _numType() {
  num num1 = -1.0;  // 数字类型的父类
  num num2 = 2;   //
  int int1 = 3; // 只能是整数
  double d1 = 0.68; // 双精度
  if (kDebugMode) {
    print("num1:$num1 num2:$num2 int:$int1 double:$d1");
  }
}
