

import 'package:flutter/material.dart';

/// 定义SearchBar的三种样式：
/// home 首页默认状态下使用的样式
/// homeLight 首页发生上滑后使用的样式
/// normal 为默认情况下使用的样式
enum SearchBarType {home, normal, homeLight}

class SearchBar extends StatefulWidget {

  final bool? enabled;  // 是否禁止输入
  final bool? hideLeft; // 是否隐藏左边控件
  final SearchBarType searchBarType;  // 样式
  final String? hint; // 默认输入框提示文字
  final String? defaultText;  // 默认文字
  final void Function()? leftButtonClick; // 左边按钮点击方法
  final void Function()? rightButtonClick;  // 右边按钮点击方法
  final void Function()? speakClick;  // 语音按钮点击回调方法
  final void Function()? inputBoxClick; // 输入框点击方法
  final ValueChanged<String>? onChanged;  // 文字内容发生变化回调方法

  const SearchBar({
    Key? key,
    this.enabled,
    this.hideLeft,
    this.searchBarType = SearchBarType.normal,
    this.hint,
    this.defaultText,
    this.leftButtonClick,
    this.rightButtonClick,
    this.speakClick,
    this.inputBoxClick,
    this.onChanged}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal ?
    _genNormalSearch() : _genHomeSearch();
  }

  /// 正常情况下的输入框样式
  _genNormalSearch() {
    return Row(
      children: [
        /// 左边按钮
        _wrapTap(
            Container(
              padding: const EdgeInsets.fromLTRB(6, 5, 10, 5),
              child: widget.hideLeft ?? false ? null : const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 26,),
            ),
            widget.leftButtonClick
        ),
        /// 中间输入框
        Expanded(
          flex: 1,
            child: _inputBox(),
        ),
        /// 右边按钮
        _wrapTap(
        Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: const Text(
            '搜索',
            style: TextStyle(color: Colors.blue, fontSize: 17),
          ),
        ),
        widget.rightButtonClick)
      ],
    );
  }

  /// 首页输入样式
  _genHomeSearch() {
    return Row(
      children: [
        /// 左边城市选择按钮
        _wrapTap(
            Container(
              padding: const EdgeInsets.fromLTRB(6, 5, 5, 5),
              child: Row(
                children: [
                  Text('上海', style: TextStyle(fontSize: 14, color: _homeFontColor()), ),
                  Icon(Icons.expand_more, color: _homeFontColor(), size: 22,)
                ],
              ),
            ),
            widget.leftButtonClick
        ),
        /// 中间输入框
        Expanded(
          flex: 1,
          child: _inputBox(),
        ),
        /// 右边消息按钮
        _wrapTap(
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Icon(Icons.comment, color: _homeFontColor(), size: 26,)
            ),
            widget.rightButtonClick)
      ],
    );
  }

  /// 带点击事件回调的Widget封装
  _wrapTap(Widget? child, void Function()? callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback();
        }
      },
      child: child,
    );
  }

  /// 输入框
  _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }

    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(color: inputBoxColor, borderRadius: BorderRadius.circular(widget.searchBarType == SearchBarType.normal? 5 : 15)),
      child: Row(
        children: [
          /// 左边搜索图标
          Icon(Icons.search, size: 20, color: widget.searchBarType == SearchBarType.normal? Color(0xffA9A9A9)
              : Colors.blue,),
          /// 中间输入框
          Expanded(
            flex: 1,
              child: widget.searchBarType == SearchBarType.normal?
                  TextField(
                    controller: _controller,
                    onChanged: _onChanged,
                    autofocus: true,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w300
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 5, bottom: 15, right: 5),
                      border: InputBorder.none,
                      hintText: widget.hint?? '',
                      hintStyle: const TextStyle(fontSize: 15)
                    ),
                  )
                  : _wrapTap(
                  Text(widget.defaultText??'', style: const TextStyle(fontSize: 13, color: Colors.grey),),
                  widget.inputBoxClick
              )
          ),
          /// 右边语音或者删除按钮
          !showClear?
          _wrapTap(
              Icon(
                  Icons.mic, size: 12, color: widget.searchBarType == SearchBarType.normal? Colors.blue : Colors.grey,),
              widget.speakClick) :

          _wrapTap(
              const Icon(Icons.clear, size: 12, color: Colors.grey,),

              /// 点击之后做两件事
              /// 调用Controller的清除 清除输入框内容
              /// 调用onChanged方法 以方便处理输入框文字内容清理之后的其他页面的操作
              () {
                setState(() {
                  _controller.clear();
                });
                _onChanged('');
              }
              )
        ],
      ),
    );
  }

  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight? Colors.black54 : Colors.white;
  }

  void _onChanged(String value) {

  }
}
