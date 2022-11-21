
import 'package:flutter/material.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/my_page.dart';
import 'package:my_app/pages/search_page.dart';
import 'package:my_app/pages/travel_page.dart';

/// 导航框架的搭建
class TabNavigator extends StatefulWidget {
  const TabNavigator ({Key? key}) : super(key: key);

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {

  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;

  /// 使用PageController传入PageView即可实现对PageView内部的StatefulWidgetPage进行控制
  final PageController _controller = PageController(
      initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 使用PageView实现N个子页面可切换
      body: PageView(
        controller: _controller,
        /// 禁止左右滑动
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          HomePage(),
          SearchPage(
            hideLeft: true,
          ),
          TravelPage(),
          MyPage()
        ],
      ),
      /// 使用BottomNavigationBar对底部的Tab进行控制
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        /// 使用该属性使得Tab下面的文字一直展示
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomItem('首页', Icons.home),
          _bottomItem('搜索', Icons.search),
          _bottomItem('旅拍', Icons.camera_alt),
          _bottomItem('我的', Icons.account_circle),
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _activeColor),
        activeIcon: Icon(icon, color: _activeColor),
        label: title
    );
  }
}
