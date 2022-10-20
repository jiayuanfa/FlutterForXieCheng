
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


/// Hero组件
/// 构造函数通过传递一个tag、事件回调、以及宽度等参数实现
class PhotoHero extends StatelessWidget {

  final String photo;
  final VoidCallback onTap;
  final double width;

  const PhotoHero({super.key, required this.photo, required this.onTap, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          /// 加入一个带点击事件的组件
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  const HeroAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /// 动画的执行速度
    timeDilation = 3.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero basic animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo: 'https://t7.baidu.com/it/u=3457623669,1227791043&fm=193&f=GIF',
          width: 300,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Flippers page'),
                    ),
                    body: Container(
                      color: Colors.lightBlueAccent,
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.topLeft,
                      child: PhotoHero(
                        photo: 'https://t7.baidu.com/it/u=3457623669,1227791043&fm=193&f=GIF',
                        width: 100,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                }));
          },
        ),
      ),
    );
  }
}

