
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 轮播图
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_app/dao/home_dao.dart';
import 'package:my_app/model/grid_nav_model.dart';
import 'package:my_app/model/home_model.dart';
import 'package:my_app/model/sales_box_model.dart';
import 'package:my_app/widget/grid_nav.dart';
import 'package:my_app/widget/loading_container.dart';
import 'package:my_app/widget/local_nav.dart';
import 'package:my_app/widget/sales_box.dart';
import 'package:my_app/widget/sub_nav.dart';

import '../model/common_model.dart';
import '../widget/webview.dart';
const APP_SCROLL_OFFSET = 150;

class HomePage extends StatefulWidget {
  const HomePage ({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String responseStr = '';
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  GridNavModel? gridNavModel;
  List<CommonModel> subList = [];
  SalesBoxModel? salesBoxModel;

  bool _loading = true;

  @override
  void initState() {
    _handleRefresh();
    super.initState();
  }

  Future<void> _handleRefresh() async {
    try {
      HomeModel homeModel = await HomeDao.fetch();
      setState(() {
        responseStr = homeModel.config.searchUrl ?? "";
        bannerList = homeModel.bannerList;
        localNavList = homeModel.localNavList;
        gridNavModel = homeModel.gridNav;
        subList = homeModel.subNavList;
        salesBoxModel = homeModel.salesBox;
        _loading = false;
        if (kDebugMode) {
          print('loadData$_loading');
          print('handleRefresh');
        }
      });
    } catch (e) {
      setState() {
        _loading = false;
      }
    }
    return;
  }

  /// 列表滚动回调
  double appBarAlpha = 0;
  _scroll(offset) {
    // if (kDebugMode) {
    //   print(offset);
    // }
    double alpha = offset / APP_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });

    // if (kDebugMode) {
    //   print('Alpha值为$appBarAlpha');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 通过MediaQuery.removePadding移除ListView自带的Padding以实现沉浸式顶部的效果
      /// removeTop: true 移除顶部的Padding
      /// 通过Stack实现AppBar覆盖效果，进而实现列表上下滚动改变Banner以及AppBar的透明度
      backgroundColor: const Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              /// 监听ListView的滚动
                /// RefreshIndicator 下拉刷新
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
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
                    /// 这里return false 表示不消耗掉滑动事件 让别的组件也可以监听到
                    /// 这里如果返回了true 则表示消耗掉滑动 别的组件就不能监听到了
                    return false;
                  },
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 160,
                        /// 内容为ListView才能滚动
                        /// 并实现监听ListView的上下棍
                        child: Swiper(
                          itemCount: bannerList.length,
                          autoplay: true,
                          /// item构建返回一个Image
                          itemBuilder: (BuildContext context, int index) {
                            CommonModel bannerModel = bannerList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return HiWebView(
                                    url: bannerModel.url,
                                    title: bannerModel.title,
                                    statusBarColor: bannerModel.statusBarColor,
                                    hideAppBar: false,
                                    backForbid: false,
                                  );
                                }));
                              },
                              child: Image.network(
                                bannerModel.icon??'',
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                          /// 指示器
                          pagination: const SwiperPagination(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
                        child: LocalNav(localNavList: localNavList),
                      ),

                      /// 不等于空 使用!强拆包 进行布局
                      if (gridNavModel != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                          child: GridNav(gridNavModel: gridNavModel!),
                        ),
                      if (subList != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                          child: SubNav(subNavList: subList),
                        ),
                      if (salesBoxModel != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                          child: SalesBox(salesBoxModel: salesBoxModel!),
                        ),
                    ],
                  ),
                ),
              )
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
        ),
      )
    );
  }
}
