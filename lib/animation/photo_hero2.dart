import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:math' as math;

/// Hero径向动画组件
/// 构造函数通过传递一个tag、事件回调、以及宽度等参数实现
/// 与Hero基础动画不同的地方在于：通过RectTween来实现方形->圆形的转变
/// 通过Navigator.push的PageRouteBuilder实现页面淡入淡出效果
///
/// Photo基本组件
class Photo extends StatelessWidget {
  final String photo;
  final VoidCallback onTap;
  final Color? color;

  const Photo(
      {super.key, required this.photo, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      /// 加入一个带点击事件的组件
      child: InkWell(
          onTap: onTap,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints size) {
              return Image.network(
                photo,
                fit: BoxFit.contain,
              );
            },
          )),
    );
  }
}

/// 造出一个圆形Photo组件
/// 传入原始的组件
class RadialExpansion extends StatelessWidget {
  final double maxRadius;
  final double clipRectSize;
  final Widget child;

  /// clipRectSize 传入一个圆的最大半径，求该圆形的最大内切正方形的边长
  const RadialExpansion(
      {Key? key, required this.maxRadius, required this.child})
      : clipRectSize = 2.0 * maxRadius / math.sqrt2,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

class RadialExpansionDemo extends StatelessWidget {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;

  /// 透明度快出慢进
  static const opacityCurve = Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  const RadialExpansionDemo({Key? key}) : super(key: key);

  /// RectTween 从方形到圆形
  static RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  /// 正方形Widget
  static Widget _buildPage(
      BuildContext context, String imageName, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: kMaxRadius * 2.0,
                height: kMaxRadius * 2.0,
                child: Hero(
                  createRectTween: _createRectTween,
                  tag: imageName,
                  child: RadialExpansion(
                    maxRadius: kMaxRadius,
                    child: Photo(
                      photo: imageName,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      color: null,
                    ),
                  ),
                ),
              ),
              Text(
                description,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  /// 小圆形的Widget
  Widget _buildHero(
      BuildContext context, String imageName, String description) {
    return SizedBox(
      width: kMinRadius * 2.0,
      height: kMinRadius * 2.0,
      child: Hero(
        createRectTween: _createRectTween,
        tag: imageName,
        child: RadialExpansion(
          maxRadius: kMaxRadius,
          child: Photo(
            photo: imageName,
            onTap: () {
              Navigator.push(context, PageRouteBuilder(pageBuilder:
                  (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget? child) {
                      return Opacity(
                          opacity: opacityCurve.transform(animation.value),
                          child: _buildPage(context, imageName, description));
                    });
              }));
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 动画的执行速度
    timeDilation = 3.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Transition Demo'),
      ),
      body: Container(
          padding: const EdgeInsets.all(50.0),
          alignment: FractionalOffset.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHero(
                  context,
                  'http://t13.baidu.com/it/u=3169337030,3414444477&fm=224&app=112&f=JPEG?w=500&h=500',
                  '刻晴'),
              _buildHero(
                  context,
                  'http://t15.baidu.com/it/u=3694547177,1838572404&fm=224&app=112&f=JPEG?w=500&h=500',
                  '甘雨'),
              _buildHero(
                  context,
                  'http://t13.baidu.com/it/u=2314755275,2977887686&fm=224&app=112&f=JPEG?w=500&h=500',
                  '神里'),
            ],
          )),
    );
  }
}
