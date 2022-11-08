import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/dao/search_dao.dart';
import 'package:my_app/model/search_model.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/widget/search_bar.dart';

/// 图片类型
const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

const URL =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=';

class SearchPage extends StatefulWidget {
  final bool? hideLeft;
  final String searchUrl;
  final String? keyword;
  final String? hint;

  const SearchPage(
      {Key? key, this.hideLeft, this.searchUrl = URL, this.keyword, this.hint})
      : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel? searchModel;
  String? keyword;

  @override
  void initState() {
    if (keyword != null) {
      _onTextChanged(keyword!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _appBar,
        Text(searchModel?.data?[0].url??'')
        // MediaQuery.removePadding(
        //     context: context,
        //     removeTop: true,
        //     child: Expanded(
        //       flex: 1,
        //       child: ListView.builder(
        //           itemCount: searchModel?.data?.length ?? 0,
        //           itemBuilder: (BuildContext context, int position) {
        //             return _item(position);
        //           }),
        //     ))
      ],
    ));
  }

  get _appBar {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              //AppBar渐变遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 60),
            height: 110,
            decoration: const BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              speakClick: _jumpToSpeak,
              rightButtonClick: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              leftButtonClick: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.pop(context);
              },
              onChanged: _onTextChanged,
            ),
          ),
        )
      ],
    );
  }

  void _jumpToSpeak() {}

  /// 文字发生改变
  void _onTextChanged(String text) {
    keyword = text;
    if (kDebugMode) {
      print('onTextChanged$text');
    }
    if (text.isEmpty) {
      setState(() {
        searchModel = null;
      });
      return;
    }

    /// 使用服务器返回的 SearchUrl
    String url = '${HomePage.configModel?.searchUrl ?? widget.searchUrl}$text';
    SearchDao.fetch(url, keyword!).then((model) {
      if (model.keyword == keyword) {
        setState(() {
          searchModel = model;
        });
      }
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }

  Widget _item(int position) {
    return Container();
  }
}
