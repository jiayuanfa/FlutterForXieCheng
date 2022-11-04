
import 'package:flutter/material.dart';
import 'package:my_app/baseLearn/http/http_future_builder_page.dart';
import 'package:my_app/model/grid_nav_model.dart';
import 'package:my_app/widget/webview.dart';

import '../model/common_model.dart';

class LocalNav extends StatelessWidget {

  final List<CommonModel> localNavList;

  const LocalNav({Key? key, required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (localNavList == null) return null;
    List<Widget> items = [];
    for (var element in localNavList) {
      items.add(_item(context, element));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return HiWebView(
                  url: model.url,
                  statusBarColor: model.statusBarColor,
                  hideAppBar: model.hideAppBar,
                  backForbid: false,
                );
              }));
      },
      child: Column(
        children: [
          Image.network(
            model.icon??'',
            width: 32,
            height: 32,
          ),
          Text(
            model.title??'',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
