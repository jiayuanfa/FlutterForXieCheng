import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/dao/search_dao.dart';
import 'package:my_app/model/search_model.dart';
import 'package:my_app/pages/speak_page.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/widget/search_bar.dart';
import 'package:my_app/widget/webview.dart';

/// 图片类型
const TYPES = [
  'channelgroup',
  'channelgs',
  'channelplane',
  'channeltrain',
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
        // Text(searchModel?.data?[0].url??'')
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount: searchModel?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int position) {
                    return _item(position);
                  }),
            ))
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

  void _jumpToSpeak() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SpeakPage()));
  }

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

  /// 每一行展示的内容
  _item(int position) {
    if (searchModel == null || searchModel?.data == null) return null;

    SearchItem searchItem = searchModel!.data![position];
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return HiWebView(
              url: searchItem.url,
                title: '详情',
                hideAppBar: false,
                backForbid: false);
          })
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          children: [

            /// 动态图标
            Container(
              margin: const EdgeInsets.all(1),
              child: Image(
                  height: 26,
                  width: 26,
                  // image:AssetImage('images/play.jpeg'),
                  image: AssetImage(_typeImage(searchItem.type))
                ),
            ),

            /// 右边标题和子标题
            Column(
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: _title(searchItem),
                ),
                Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 5),
                    child: _subTitle(searchItem))
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 根据type取出图片
  String _typeImage(String? type) {
    if (type == null) return 'images/type_travelgroup.png';

    String path = 'travelgroup';
    for (var element in TYPES) {
      if (element.contains(type)) {
        path = element;
        break;
      }
    }
    return 'images/type_$path.png';
  }

  /// 右边主Title
  _title(SearchItem? item) {
      if (item == null) return null;
      List<TextSpan> spans = [];
      spans.addAll(_keywordTextSpans(item.word, searchModel!.keyword!));
      spans.add(TextSpan(
          text: ' ${item.districtname ?? ''} ${item.zonename ?? ''}',
          style: const TextStyle(fontSize: 16, color: Colors.grey)));
      return RichText(text: TextSpan(children: spans));
  }

  /// 右边子Title
  /// 直接一个RichText包含两个TextSpan即可
  _subTitle(SearchItem item) {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
          text: item.price ?? '',
          style: const TextStyle(fontSize: 16, color: Colors.orange),
        ),
        TextSpan(
          text: ' ${item.star ?? ''}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        )
      ]),
    );
  }

  /// 核心搜索富文本逻辑
  Iterable<TextSpan> _keywordTextSpans(String? word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.isEmpty) return spans;

    /// 搜索结果 搜索关键字 高亮忽略大小写
    String wordL = word.toLowerCase();
    String keywordL = keyword.toLowerCase();

    /// 搜索关键词分割
    /// 例子：'wordwoc'.split('w') -> [, ord, oc]
    /// @https://www.tutorialspoint.com/tpcg.php?p=wcpcUA
    List<String> arr = wordL.split(keywordL);

    /// 非高亮样式、高亮样式
    TextStyle normalStyle = const TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = const TextStyle(fontSize: 16, color: Colors.orange);

    for (int i = 0; i < arr.length; i++) {

      /// 等于0的时候，假设搜索结果以关键词开头，则数组第一个是空，下方判空了，所以跳过
      /// 假设不是搜索关键词开头，那数组第0位肯定不为空，不能添加，所以略过第0位
      if (i != 0) {

        /// 添加关键词 并染色
        spans.add(TextSpan(
            text: keywordL,
            style: keywordStyle));
      }

      /// 第一位 或者 其他位置 直接取出来添加一个非关键词风格的TextSpan
      String val = arr[i];
      if (val.isNotEmpty) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
