

import 'package:flutter/material.dart';
import 'package:my_app/widget/webview.dart';

import '../model/common_model.dart';

class SubNav extends StatelessWidget {

  final List<CommonModel> subNavList;

  const SubNav({Key? key, required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6)
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    for (var element in subNavList) { 
      items.add(_item(context, element));
    }
    /// 计算出每一行的显示数量
    int separate = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, subNavList.length),
          ),
        )
      ],
    );
  }

  _item(BuildContext context, CommonModel model) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return HiWebView(
                  url: model.url,
                  title: model.title,
                  statusBarColor: model.statusBarColor,
                  hideAppBar: false,
                  backForbid: false,
                );
              }));
        },
        child: Column(
          children: [
            Image.network(
              model.icon??'',
              width: 18,
              height: 18,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 3),
              child: Text(
                model.title??'',
                style: const TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

}
