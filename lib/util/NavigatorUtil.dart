import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class NavigatorUtil {

  /// 跳转页面的方法封装
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
