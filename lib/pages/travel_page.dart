import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/travel_tab_page.dart';

import '../dao/travel_tab_dao.dart';
import '../model/travel_tab_model.dart';
import 'package:underline_indicator/underline_indicator.dart';

class TravelPage extends StatefulWidget {

  const TravelPage({Key? key}) : super(key: key);

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage>
    with TickerProviderStateMixin {
  late TabController _controller;  /// 用来关联Tab和TabBarView的Controller
  List<TravelTab> tabs = [];
  late TravelTabModel travelTabModel;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      _controller = TabController(
          length: model.tabs.length, vsync: this); //fix tab label 空白问题
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30),

          /// 使用TabBar组件实现可以左右滑动的Tab
          child: TabBar(
              controller: _controller,
              isScrollable: true,
              labelColor: Colors.black,
              labelPadding: const EdgeInsets.fromLTRB(20, 0, 10, 5),

              /// Tab下划线使用的是三方组件
              indicator: const UnderlineIndicator(
                  strokeCap: StrokeCap.round,
                  borderSide: BorderSide(
                    color: Color(0xff2fcfbb),
                    width: 3,
                  ),
                  insets: EdgeInsets.only(bottom: 10)),
              tabs: tabs.map<Tab>((TravelTab tab) {
                return Tab(
                  text: tab.labelName,
                );
              }).toList()),
        ),

        /// 下方铺满的内容View
        Flexible(
            child: TabBarView(
              controller: _controller,
              children: tabs.map((tab) {
                return TravelTabPage(
                  travelUrl: travelTabModel.url,
                  params: travelTabModel.params,
                  groupChannelCode: tab.groupChannelCode,
                );
              }).toList(),
            )
        )
      ],
    ));
  }
}
