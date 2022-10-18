import 'package:flutter/material.dart';
import 'package:my_app/data_type.dart';
import 'package:my_app/flutter_layout_page.dart';
import 'package:my_app/generic_learn.dart';
import 'package:my_app/less_group_page.dart';
import 'package:my_app/oop_learn.dart';
import 'package:my_app/plugin_use.dart';
import 'package:my_app/stateful_group_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '创建和使用Flutter的路由和导航',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('创建和使用Flutter的路由和导航'),
        ),
        body: const RouteNavigator(),
      ),
      /// 路由注册
      routes: <String, WidgetBuilder>{
        'plugin': (BuildContext context) => const PluginUse(),
        'less': (BuildContext context) => const LessGroupPage(),
        'ful': (BuildContext context) => const StatefulGroupPage(),
        'layout': (BuildContext context) => const FlutterLayoutPage(),
      },
    );
  }
}

class RouteNavigator extends StatefulWidget {
  const RouteNavigator({super.key});

  @override
  State<RouteNavigator> createState() => _RouteNavigatorState();
}

class _RouteNavigatorState extends State<RouteNavigator> {
  bool byName = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SwitchListTile(
            title: Text('${byName ? '' : '不'}通过路由名称跳转'),
            value: byName,
            onChanged: (value) {
              setState(() {
                byName = value;
              });
            }),
        _item('StatelessWidget组件', const LessGroupPage(), 'less'),
        _item('StatefulWidget组件', const StatefulGroupPage(), 'ful'),
        _item('插件使用', const PluginUse(), 'plugin'),
        _item('flutterLayout', const FlutterLayoutPage(), 'layout'),
      ],
    );
  }

  /// 路由跳转方法
  _item(String title, page, String routeName) {
    return ElevatedButton(
      onPressed: () {
        if (byName) {
          /// 前提：注册了路由，通过注册的路由名字进行跳转
          Navigator.pushNamed(context, routeName);
        } else {
          /// 未注册路由 直接通过组件跳转
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        }
      },
      child: Text(title),
    );
  }
}
