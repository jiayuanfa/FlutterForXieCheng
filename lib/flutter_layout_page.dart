import 'package:flutter/material.dart';
import 'package:my_app/data_type.dart';
import 'package:my_app/generic_learn.dart';
import 'package:my_app/oop_learn.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

void main() {
  runApp(const FlutterLayoutPage());
}

class FlutterLayoutPage extends StatefulWidget {
  const FlutterLayoutPage({Key? key}) : super(key: key);

  @override
  State<FlutterLayoutPage> createState() => _FlutterLayoutPageState();
}

class _FlutterLayoutPageState extends State<FlutterLayoutPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 20);
    return MaterialApp(
      title: '如何进行Flutter布局开发？',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('如何进行Flutter布局开发？')),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /// 圆角
                  ClipOval(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                          'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fi.qqkou.com%2Fi%2F0a2425698567x1999344470b253.jpg&refer=http%3A%2F%2Fi.qqkou.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1668591799&t=5ad64a19b1044f34595c951fb65dd7da'
                      ),
                    ),
                  ),

                  /// 带透明度的圆角方形
                  Padding(padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Opacity(
                        opacity: 0.6,
                        child: Image.network(
                            'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fi.qqkou.com%2Fi%2F0a2425698567x1999344470b253.jpg&refer=http%3A%2F%2Fi.qqkou.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1668591799&t=5ad64a19b1044f34595c951fb65dd7da',
                            width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              /// 叠加效果布局组件
              Stack(
                children: <Widget>[
                  Image.network(
                      'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fi.qqkou.com%2Fi%2F0a2425698567x1999344470b253.jpg&refer=http%3A%2F%2Fi.qqkou.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1668591799&t=5ad64a19b1044f34595c951fb65dd7da',
                    width: 100,
                    height: 100,
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Image.network(
                    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Flmg.jj20.com%2Fup%2Fallimg%2F4k%2Fs%2F02%2F2109242332225H9-0-lp.jpg&refer=http%3A%2F%2Flmg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1668653536&t=1d61d30f28f155d66d124c7120536d7b',
                    width: 36,
                    height: 36,
                  ),)
                ],
              ),

              /// 创建一个wrap布局，从左到右排列，自动换行
              Wrap(
                spacing: 10,
                runSpacing: 0,
                children: <Widget>[
                  _chip('Flutter'),
                  _chip('进阶'),
                  _chip('实战'),
                  _chip('携程'),
                  _chip('App')
                ],
              ),
              Container(
                height: 100,
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: Colors.transparent),
                child: PhysicalModel(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.antiAlias, // 抗锯齿
                  child: PageView(
                    children: <Widget>[
                      _item('Page1', Colors.deepPurple),
                      _item('Page2', Colors.green),
                      _item('Page3', Colors.red)
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.greenAccent),
                      child: const Text('宽度撑满'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _item(String title, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }

  _chip(String label) {
    return Chip(
      label: Text(label),
      avatar: CircleAvatar(
        backgroundColor: Colors.blue.shade900,
        child: Text(
          label.substring(0, 1),
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}

