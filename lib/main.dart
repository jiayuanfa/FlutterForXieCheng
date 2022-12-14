import 'package:flutter/material.dart';
import 'package:my_app/animation/app_logo_page.dart';
import 'package:my_app/animation/photo_hero.dart';
import 'package:my_app/animation/photo_hero2.dart';
import 'package:my_app/baseLearn/app_lifecycle.dart';
import 'package:my_app/baseLearn/data_type.dart';
import 'package:my_app/baseLearn/flutter_layout_page.dart';
import 'package:my_app/baseLearn/generic_learn.dart';
import 'package:my_app/baseLearn/gesture_page.dart';
import 'package:my_app/baseLearn/launcher_page.dart';
import 'package:my_app/baseLearn/less_group_page.dart';
import 'package:my_app/baseLearn/oop_learn.dart';
import 'package:my_app/baseLearn/photo_app_page.dart';
import 'package:my_app/baseLearn/plugin_use.dart';
import 'package:my_app/baseLearn/stateful_group_page.dart';
import 'package:my_app/baseLearn/res_page.dart';
import 'package:my_app/baseLearn/flutter_widget_lifecycle.dart';
import 'package:my_app/baseLearn/Image_placeholder_page.dart';
import 'package:my_app/animation/animation_widget_page.dart';
import 'package:my_app/animation/animation_builder_page.dart';
import 'package:my_app/navigator/tab_navigator.dart';

void main() {
  runApp(const TripApp());
}

/// 携程APP
class TripApp extends StatefulWidget {
  const TripApp ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TripAppState();
}

class _TripAppState extends State<TripApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '携程',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TabNavigator(),
    );
  }
}

/// 学习功能页面
class DynamicTheme extends StatefulWidget {
  const DynamicTheme({Key? key}) : super(key: key);

  @override
  State<DynamicTheme> createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
// This widget is the root of your application.

  Brightness _brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '创建和使用Flutter的路由和导航',
      theme: ThemeData(
        // fontFamily: 'RubikMonoOne', // 全局更换字体
        brightness: _brightness,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('创建和使用Flutter的路由和导航'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_brightness == Brightness.light) {
                        _brightness = Brightness.dark;
                      } else {
                        _brightness = Brightness.light;
                      }
                    });
                  },
                  child: const Text('切换模式ABC',
                      style: TextStyle(fontFamily: 'RubikMonoOne')),
                ),
                const RouteNavigator(),
              ],
            ),
          )),

      /// 路由注册
      routes: <String, WidgetBuilder>{
        'plugin': (BuildContext context) => const PluginUse(),
        'less': (BuildContext context) => const LessGroupPage(),
        'ful': (BuildContext context) => const StatefulGroupPage(),
        'layout': (BuildContext context) => const FlutterLayoutPage(),
        'gesture': (BuildContext context) => const GesturePage(),
        'res': (BuildContext context) => const ResPage(),
        // 'launcher': (BuildContext context) => const LauncherPage(),
        'widgetLifecycle': (BuildContext context) => const WidgetLifecycle(),
        'appLifecycle': (BuildContext context) => const AppLifecycle(),
        'photoApp': (BuildContext context) => const PhotoApp(),
        'ImagePlaceholderPage': (BuildContext context) =>
            const ImagePlaceholderPage(),
        'logoAnimation': (BuildContext context) => const AppLogoAnimation(),
        'animationWidget': (BuildContext context) =>
            const AnimationWidgetPage(),
        'animationBuilder': (BuildContext context) =>
            const AnimationBuilderPage(),
        'heroBasicAnimation': (BuildContext context) => const HeroAnimation(),
        'RadialExpansionDemo': (BuildContext context) => const RadialExpansionDemo()
      },
    );
  }
}

class RouteNavigator extends StatefulWidget {
  const RouteNavigator({Key? key}) : super(key: key);

  @override
  State<RouteNavigator> createState() => _RouteNavigatorState();
}

class _RouteNavigatorState extends State<RouteNavigator> {
  bool byName = false;

  @override
  Widget build(BuildContext context) {
    return _content();
  }

  _content() {
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
        _item('GestureDetector', const GesturePage(), 'gesture'),
        _item('资源文件使用', const ResPage(), 'res'),
        // _item('打开第三方APP', const LauncherPage(), 'launcher'),
        _item('Flutter Widget生命周期', const WidgetLifecycle(), 'widgetLifecycle'),
        _item('App生命周期', const AppLifecycle(), 'appLifecycle'),
        _item('photoApp', const PhotoApp(), 'photoApp'),
        _item('ImagePlaceholderPage', const ImagePlaceholderPage(),
            'ImagePlaceholderPage'),
        _item('logoAnimation', const AppLogoAnimation(), 'logoAnimation'),
        _item(
            'animationWidget', const AnimationWidgetPage(), 'animationWidget'),
        _item('animationBuilder', const AnimationBuilderPage(),
            'animationBuilder'),
        _item('heroBasicAnimation', const HeroAnimation(), 'heroBasicAnimation'),
        _item('RadialExpansionDemo', const RadialExpansionDemo(), 'RadialExpansionDemo')
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
