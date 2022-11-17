import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../dao/travel_dao.dart';
import '../model/travel_model.dart';
import 'package:transparent_image/transparent_image.dart';

// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_nested/flutter_nested.dart';
import '../widget/loading_container.dart';
import '../widget/webview.dart';

const _TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

const PAGE_SIZE = 10;

class TravelTabPage extends StatefulWidget {
  final String? travelUrl;
  final Map params;
  final String groupChannelCode;

  const TravelTabPage(
      {Key? key,
      this.travelUrl,
      required this.params,
      required this.groupChannelCode})
      : super(key: key);

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  List<TravelItem> travelItems = [];
  int pageIndex = 1;

  /// 第一次加载
  bool _loading = true;

  /// 用来监听滚动到底部
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      /// 首次加载
      body: LoadingContainer(
        isLoading: _loading,

        /// 下拉刷新
        child: RefreshIndicator(
          onRefresh: _handleRefresh,

          /// 去掉顶部留白
          child: MediaQuery.removePadding(
              removeTop: true,
              context: context,

              /// 瀑布流
              child: HiNestedScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1),
                  itemCount: travelItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _TravelItem(
                      index: index,
                      item: travelItems[index],
                    );
                  })),
        ),
      ),
    );
  }

  /// 加载数据
  /// 是否加载更多
  void _loadData({loadMore = false}) {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }

    /// travelUrl 通过travelUrl
    /// params
    /// groupChannelCode
    /// pageIndex
    /// PAGE_SIZE
    TravelDao.fetch(widget.travelUrl ?? _TRAVEL_URL, widget.params,
            widget.groupChannelCode, pageIndex, PAGE_SIZE)
        .then((TravelItemModel model) {
      _loading = false;
      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);
        travelItems.addAll(items);
      });
    }).catchError((e) {
      _loading = false;
      if (kDebugMode) {
        print(e);
      }
    });
  }

  /// 数据清洗
  /// 清洗掉article为空的数据
  List<TravelItem> _filterItems(List<TravelItem>? resultList) {
    if (resultList == null) {
      return [];
    }
    List<TravelItem> filterItems = [];
    for (var item in resultList) {
      filterItems.add(item);
    }
    return filterItems;
  }

  /// 下拉刷新
  Future<void> _handleRefresh() async {
    _loadData();
    return;
  }

  @override
  bool get wantKeepAlive => true;
}

/// 瀑布流卡片组件
class _TravelItem extends StatelessWidget {
  final TravelItem item;
  final int? index;

  const _TravelItem({Key? key, this.index, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// 点击跳转WebView
      onTap: () {
        if (item.article.urls.isNotEmpty) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HiWebView(
                        url: item.article.urls[0].h5Url,
                        title: '详情',
                        hideAppBar: false,
                        backForbid: false,
                      )));
        }
      },
      child: Card(
        /// 圆角裁剪
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),

          /// 上下排列
          child: Column(
            /// 内容居左展示
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              /// 图片组件
              _itemImage(context),

              /// 图片下方的两行文字
              Container(
                padding: const EdgeInsets.all(4),
                child: Text(
                  item.article.articleTitle,

                  /// 显示两行 结尾省略号
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),

              /// 文字下边的头像 姓名 等
              _infoText()
            ],
          ),
        ),
      ),
    );
  }

  /// 图片+定位信息
  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          /// 设置最小初始高度，防止动态图片高度时的抖动
          constraints: BoxConstraints(
            minHeight: size.width / 2 - 10,
          ),

          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: item.article.images[0].dynamicUrl,
            fit: BoxFit.cover,
          ),
        ),

        /// 定位信息
        Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),

              /// 左边圆角图片 右边文字
              child: Row(
                children: <Widget>[
                  const Padding(
                      padding: EdgeInsets.only(right: 3),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 12,
                      )),

                  /// LimitedBox 限制最大宽度 超过省略号
                  LimitedBox(
                    maxWidth: 130,
                    child: Text(
                      _poiName(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  String _poiName() {
    return item.article.pois == null || item.article.pois?.length == 0
        ? '未知'
        : item.article.pois?[0]?.poiName ?? '未知';
  }

  /// 头像信息等等
  _infoText() {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              /// 圆角头像
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.article.author?.coverImage?.dynamicUrl ?? "",
                  width: 24,
                  height: 24,
                ),
              ),

              Container(
                padding: const EdgeInsets.all(5),
                width: 90,
                child: Text(
                  item.article.author?.nickName ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              const Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text(
                  item.article.likeCount.toString(),
                  style: const TextStyle(fontSize: 10),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
