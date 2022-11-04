import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 白名单 防止返回的时候跳转到另一个url
const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

/// 起名HiWebView防止和库里的重名
class HiWebView extends StatefulWidget {
  String? url;
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;
  final bool backForbid;

  /// 构造方法
  HiWebView(
      {Key? key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      required this.backForbid})
      : super(key: key) {
    if (url != null && url!.contains('ctrip.com')) {
      //fix 携程H5 http://无法打开问题
      url = url!.replaceAll("http://", 'https://');
      if (kDebugMode) {
        print('htTitleis:$title');
      }
    }
  }

  @override
  State<HiWebView> createState() => _HiWebViewState();
}

class _HiWebViewState extends State<HiWebView> {
  /// 标记是否已经点了返回按钮
  bool exiting = false;

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  /// 判断url是否是以白名单中的任何一个结尾
  _isToMain(String? url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';

    // 返回按钮颜色根据状态栏颜色设置  状态栏白色 返回按钮黑色 状态栏黑色 返回按钮白色
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    /// 给H5设置登录 Cookie 这样下次就不用重复登录了
    var sessionCookie = const WebViewCookie(
      name: 'my_session_cookie',
      value: 'cookie_value',
      domain: 'www.m.ctrip.com',
    );

    return Scaffold(
      body: Column(
        children: [
          /// 此处采用了字符串颜色转16进制颜色技巧
          /// 0x表示十六进制
          /// ff表示Alpha值
          /// 后面六位表示颜色的RGB值
          _appBar(
              Color(int.parse('0xff$statusBarColorStr')), backButtonColor),
          /// 使用Expanded使得WebviewScaffold能够填充满剩余空间
          Expanded(
              child: WebView(
                initialUrl: widget.url,
                initialCookies: [sessionCookie],
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },

                /// 加载进度
                onProgress: (int progress) {
                  if (kDebugMode) {
                    print('WebView is loading (progress : $progress%)');
                  }
                },
                javascriptChannels: <JavascriptChannel>{
                  _toasterJavascriptChannel(context),
                },

                /// 重定向拦截，防止返回不了
                navigationDelegate: (NavigationRequest request) {
                  if (kDebugMode) {
                    print('navigationDelegate url is: ${request.url}}');
                  }
                  bool contain = _isToMain(request.url);
                  if (contain && !exiting) {
                    Navigator.pop(context);
                    exiting = true;
                  }
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  if (kDebugMode) {
                    print('Page started loading: $url');
                  }
                },
                onPageFinished: (String url) {
                  if (kDebugMode) {
                    print('Page finished loading: $url');
                  }
                },
                /// 禁止手势返回
                gestureNavigationEnabled: true,
                backgroundColor: const Color(0x00000000),
              ))
        ],
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  /// appBar构造器
  /// 传入状态栏颜色、返回按钮颜色
  _appBar(Color backgroundColor, Color backButtonColor) {
    /// 如果需要隐藏状态栏Bar 则直接返回一个黑色的高度为30的View即可
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }

    /// 不隐藏 则开始构造appBar
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),

      /// 横向填充满
      child: FractionallySizedBox(
        widthFactor: 1,
        /// 使用Stack控件，表明内部约束都以父视图整体为参照来布局
        child: Stack(
          children: [
            /// 返回Button
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),

            /// 标题
            Positioned(
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    widget.title ?? '',
                    style: TextStyle(color: backButtonColor, fontSize: 20),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
