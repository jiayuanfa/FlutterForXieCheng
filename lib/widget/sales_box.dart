import 'package:flutter/material.dart';
import 'package:my_app/model/common_model.dart';
import 'package:my_app/model/sales_box_model.dart';
import 'package:my_app/util/NavigatorUtil.dart';
import 'package:my_app/widget/webview.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBoxModel;

  const SalesBox({Key? key, required this.salesBoxModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: _items(context),
    );
  }

  _items(BuildContext context) {

    /// 然后对widget进行布局
    /// 首先添加一个Header
    return Column(
      children: [
        Container(
          height: 44,
          margin: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                salesBoxModel.icon ?? '',
                height: 15,
                fit: BoxFit.fill,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                      colors: [
                    Color(0xffff4e63),
                    Color(0xffff6cc9),
                  ],
                      begin: Alignment.centerLeft, end: Alignment.centerRight),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HiWebView(
                        url: salesBoxModel.moreUrl,
                        title: '更多活动',
                        hideAppBar: false,
                        backForbid: false,
                      );
                    }));
                  },
                  child: const Text(
                    '获取更多福利 >',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),

        /// 下方添加三个Widget即可
        _doubleItem(
            context, salesBoxModel.bigCard1, salesBoxModel.bigCard2, true, false),
        _doubleItem(
            context, salesBoxModel.smallCard1, salesBoxModel.smallCard2, false, false),
        _doubleItem(
            context, salesBoxModel.smallCard3, salesBoxModel.smallCard4, false, false)
      ],
    );
  }

  /// 添加两个Item的方法
  Widget _doubleItem(BuildContext context, CommonModel leftCard,
      CommonModel rightCard, bool isBig, bool isLast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _item(context, leftCard, isBig, true, isLast),
        _item(context, rightCard, isBig, false, isLast),
      ],
    );
  }

  _item(BuildContext context, CommonModel model, bool isBig, bool isLeftCard,
      bool isLast) {
    BorderSide borderSide =
        const BorderSide(width: 0.8, color: Color(0xfff2f2f2));
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(context,
            HiWebView(
              url: model.url,
              title: model.title,
              statusBarColor: model.statusBarColor,
              hideAppBar: false,
              backForbid: false,
            )
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              right: isLeftCard ? borderSide : BorderSide.none,
              bottom: isLast ? BorderSide.none : borderSide),
        ),
        child: Image.network(
          model.icon ?? '',
          /// 获取屏幕高度的技巧
          width: MediaQuery.of(context).size.width / 2 - 10,
          height: isBig ? 129 : 80,
        ),
      ),
    );
  }
}
