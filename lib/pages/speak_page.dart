import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/search_page.dart';
import 'package:my_app/plugin/asr_manager.dart';

class SpeakPage extends StatefulWidget {
  const SpeakPage({Key? key}) : super(key: key);

  @override
  State<SpeakPage> createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage>
    with SingleTickerProviderStateMixin {
  String speakResult = '';
  String speakTips = '长按说话';

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    /// 监听动画状态
    /// 完成之后，倒回去
    /// 结束之后，重新开始
    /// 循环播放效果
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _topItem(),
              _bottomItem(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _topItem() {
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: Text('你可以这样说',
                style: TextStyle(fontSize: 16, color: Colors.black54))),
        const Text('故宫门票\n北京一日游\n迪士尼乐园',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            )),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            speakResult,
            style: const TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }

  _bottomItem() {
    /// 横向充满
    return FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: [
          /// 可点击的按钮
          /// 顶部文字
          GestureDetector(
            onTapDown: (e) {
              _speakStart();
            },
            onTapUp: (e) {
              _speakStop();
            },
            onTapCancel: () {
              _speakStop();
            },
            child: Center(
              child: Column(
                children: [
                  /// 顶部文字
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      speakTips,
                      style: const TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                  ),

                  /// 下方按钮动画执行区域
                  Stack(
                    children: [
                      const SizedBox(
                        //占坑，避免动画执行过程中导致父布局大小变得
                        height: MIC_SIZE,
                        width: MIC_SIZE,
                      ),
                      Center(
                          child: AnimationMic(
                        animation,
                      )),
                    ],
                  )
                ],
              ),
            ),
          ),

          /// 右下角关闭按钮
          Positioned(
            right: 0,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                size: 30,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 开始讲话
  /// 开始动画
  _speakStart() {
    controller.forward();
    setState(() {
      speakTips = '识别中...';
    });
    AsrManager.start().then((text){
      if (text.isNotEmpty) {
        setState(() {
          speakResult = text;
        });
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            SearchPage(
              keyword: text
            )));
      }
    }).catchError((e) {
      if (kDebugMode) {
        print("----------$e");
      }
    });
  }

  /// 结束
  _speakStop() {
    setState(() {
      speakTips = '长按说话';
    });
    controller.reset();
    controller.stop();
    AsrManager.stop();
  }
}

/// 动画类
const double MIC_SIZE = 80;

class AnimationMic extends AnimatedWidget {
  /// 透明度变化 区间 [1, 0.5]
  /// 大小变化 区间 [本身大小，本身大小-20]
  static final _opacityTween = Tween<double>(begin: 1, end: 0.5);
  static final _sizeTween = Tween<double>(begin: MIC_SIZE, end: MIC_SIZE - 20);

  /// 构造方法 需要传入一个animation
  const AnimationMic(Animation<double> animation, {Key? key})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(

        /// 宽高为Tween的数据
        width: _sizeTween.evaluate(animation),
        height: _sizeTween.evaluate(animation),

        /// 蓝色背景
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(MIC_SIZE / 2),
        ),

        /// 居中图标
        child: const Icon(
          Icons.mic,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
