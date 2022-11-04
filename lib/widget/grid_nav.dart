
import 'package:flutter/material.dart';
import 'package:my_app/model/common_model.dart';
import 'package:my_app/model/grid_nav_model.dart';
import 'package:my_app/widget/webview.dart';

class GridNav extends StatelessWidget {

  final GridNavModel gridNavModel;

  const GridNav({Key? key, required this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /// 通过PhysicalModel解决圆角不能对子View起作用的问题
    /// 圆角设置为6
    return PhysicalModel(
        color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,

      /// 垂直列表
      /// 接收一个垂直的Nav Widget数组
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  /// 总的布局
  /// 三个
  /// 第二个 和 第三个 区分一下，用于给它添加顶部外边距
  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    items.add(_gridNavItem(context, gridNavModel.hotel, true));
    items.add(_gridNavItem(context, gridNavModel.flight, false));
    items.add(_gridNavItem(context, gridNavModel.travel, false));
    return items;
  }

  /// 单个NavItem
  Widget _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool isFirst) {

      /// 创建个widget数组，装1大2小
      List<Widget> items = [];
      items.add(_mainItem(context, gridNavItem.mainItem));
      items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
      items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));

      /// 创建个expandItems, 保证每个items的宽度是相等的
      List<Widget> expandItems = [];
      for (var element in items) {
        expandItems.add(Expanded(flex: 1,child: element,));
      }

      /// 装到一个水平的容器，返回出去
      /// 拿到开始和结束的渐变色
      Color startColor = Color(int.parse('0xff${gridNavItem.startColor}'));
      Color endColor = Color(int.parse('0xff${gridNavItem.endColor}'));
      return Container(
        height: 88,
        /// 如果不是第一个 添加3的外边距
        margin: isFirst? null : const EdgeInsets.only(top: 3),
        /// 设置渐变背景色
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor]),
        ),
        child: Row(
          children: expandItems,
        ),
      );
  }

  /// 左边的一个大的
  Widget _mainItem(BuildContext context, CommonModel mainItem) {
      return _warpGesture(
          context,
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Image.network(
                mainItem.icon??'',
                fit:BoxFit.contain,
                height: 88,
                width: 121,
                alignment: AlignmentDirectional.bottomEnd,
              ),
              Container(
                margin: const EdgeInsets.only(top: 11),
                child: Text(
                  mainItem.title??'',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              )
            ],
          ),
          mainItem);
  }

  /// 右边的两个小的
  Widget _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem) {
      return Column(
        /// 使用Expanded是为了上下两个比例相等并铺满父视图
        children: [
          Expanded(child: _item(context, topItem, true)),
          Expanded(child: _item(context, bottomItem, false))
        ],
      );
  }

  /// 右边上下排列的单个小Item
  _item(BuildContext context, CommonModel item, bool isTop) {
    BorderSide borderSide = const BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: borderSide, bottom: isTop? borderSide : BorderSide.none),
        ),
        child: _warpGesture(
            context,
            Center(
              child: Text(
                item.title??'',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            item),
      ),
    );
  }

  /// 带手势响应的单个Widget组件
  _warpGesture(BuildContext context, Widget widget, CommonModel commonModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return HiWebView(
                url: commonModel.url,
                title: commonModel.title,
                statusBarColor: commonModel.statusBarColor,
                hideAppBar: false,
                backForbid: false,
              );
            }));
      },
      child: widget,
    );
  }
}
