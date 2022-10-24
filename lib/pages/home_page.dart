
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 轮播图
import 'package:flutter_swiper/flutter_swiper.dart';
const APP_SCROLL_OFFSET = 150;

class HomePage extends StatefulWidget {
  const HomePage ({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List _imageUrls = [
    'https://t7.baidu.com/it/u=2961459243,2146986594&fm=193&f=GIF',
    'https://t7.baidu.com/it/u=434014116,2108959724&fm=193&f=GIF',
    'https://t7.baidu.com/it/u=4141604674,3317329080&fm=193&f=GIF'
  ];

  /// 列表滚动回调
  double appBarAlpha = 0;
  _scroll(offset) {
    if (kDebugMode) {
      print(offset);
    }
    double alpha = offset / APP_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });

    if (kDebugMode) {
      print('Alpha值为$appBarAlpha');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 通过MediaQuery.removePadding移除ListView自带的Padding以实现沉浸式顶部的效果
      /// removeTop: true 移除顶部的Padding
      /// 通过Stack实现AppBar覆盖效果，进而实现列表上下滚动改变Banner以及AppBar的透明度
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            /// 监听ListView的滚动
            child: NotificationListener(
              onNotification: (scrollNotification) {
                /// 判断是不是滚动类
                /// 并且是ListView在滚动 scrollNotification.depth == 0 也就是第0个元素滚动的时候 我们再监听
                /// 就实现了监听ListView的滚动
                if (scrollNotification is ScrollUpdateNotification
                    && scrollNotification.depth == 0) {
                  /// 滚动且是列表滚动的时候
                  _scroll(scrollNotification.metrics.pixels);
                }
                return true;
              },
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 250,
                    /// 内容为ListView才能滚动
                    /// 并实现监听ListView的上下棍
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      /// item构建返回一个Image
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _imageUrls[index],
                          fit: BoxFit.fill,
                        );
                      },
                      /// 指示器
                      pagination: const SwiperPagination(),
                    ),
                  ),
                  const SizedBox(
                    height: 800,
                    child: ListTile(
                      title: Text('哈哈'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Opacity(
              opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          )],
      )
    );
  }
}
