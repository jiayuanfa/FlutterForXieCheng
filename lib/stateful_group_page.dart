import 'package:flutter/material.dart';
import 'package:my_app/data_type.dart';
import 'package:my_app/generic_learn.dart';
import 'package:my_app/oop_learn.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

void main() {
  runApp(const StatefulGroup());
}

class StatefulGroup extends StatefulWidget {
  const StatefulGroup({Key? key}) : super(key: key);

  @override
  State<StatefulGroup> createState() => _StatefulGroupState();
}

class _StatefulGroupState extends State<StatefulGroup> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 20);
    return MaterialApp(
      title: 'StatefulWidget与基础组件',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('StatefulWidget与基础组件')),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.grey),
              activeIcon: Icon(Icons.home, color: Colors.blue),
              label: '首页',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list, color: Colors.grey),
                activeIcon: Icon(Icons.list, color: Colors.blue),
                label: '列表'),
          ],
        ),
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          child: Text('点我'),
        ),
        body: _currentIndex == 0
            ? RefreshIndicator(
                onRefresh: _handleRefresh,
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Text('I am a text', style: textStyle),
                          const Text('I am a text'),
                          const Icon(Icons.android,
                              size: 50, color: Colors.red),
                          const CloseButton(),
                          const BackButton(),
                          const Chip(
                            avatar: Icon(Icons.photo),
                            label: Text('StatefulWidget与基础组件'),
                          ),
                          const Divider(
                            height: 50, // 容器的高度
                            indent: 50, // 左边距
                            color: Colors.orange,
                          ),

                          /// Card : 带有圆角、阴影、边框效果的卡片
                          Card(
                            color: Colors.blue,
                            elevation: 10, // 阴影
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Text('I am a Card', style: textStyle),
                            ),
                          ),
                          const AlertDialog(
                            title: Text('盘他！'),
                            content: Text('你这个糟老头子坏得很'),
                          )
                        ],
                      ),
                    ),
                    Image.network(
                        'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.daimg.com%2Fuploads%2Fallimg%2F210114%2F1-210114151951.jpg&refer=http%3A%2F%2Fimg.daimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1668570386&t=2379ce7e4f93f0cd74422e9d7e0c6ef4',
                      width: 200,
                      height: 200,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          hintText: '请输入',
                          hintStyle: TextStyle(fontSize: 15)
                      ),
                    ),
                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(color: Colors.lightBlueAccent),
                      child: PageView(
                        children: <Widget>[
                          _item('Page1', Colors.deepPurple),
                          _item('Page2', Colors.green),
                          _item('Page3', Colors.red)
                        ],
                      ),
                    )
                  ],
                ))
            : Column(
          children: <Widget>[
            const Text('列表'),

            /// 一个可以拉伸填满高度的组件
            Expanded(
                child: Container(
              decoration: const BoxDecoration(color: Colors.red),
                  child: const Text('拉伸填满高度'),
            )),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(microseconds: 2000));
    return;
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
}
