
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImagePlaceholderPage extends StatefulWidget {
  const ImagePlaceholderPage({Key? key}) : super(key: key);

  @override
  State<ImagePlaceholderPage> createState() => _ImagePlaceholderPageState();
}

class _ImagePlaceholderPageState extends State<ImagePlaceholderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Placeholder 设置'),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: _imageFromUrlAndCache(),
    );
  }

  /// 从Url加载图片并缓存
  _imageFromUrlAndCache() {
      return Center(
        child: CachedNetworkImage(
          placeholder: (context, url) => CircularProgressIndicator(),
          imageUrl: 'https://t7.baidu.com/it/u=2077212613,1695106851&fm=193&f=GIF',
        ),
      );
  }

  /// 从url加载图片
  _imageFromUrl() {
    return Stack(
      children: <Widget>[
        const Center(
          child: CircularProgressIndicator(),
        ),
        Center(
          // child: FadeInImage.memoryNetwork(
          //     placeholder: kTransparentImage,
          //     image: 'https://t7.baidu.com/it/u=2077212613,1695106851&fm=193&f=GIF'),
          child: FadeInImage.assetNetwork(
              placeholder: 'images/loading.gif',
              image: 'https://t7.baidu.com/it/u=2077212613,1695106851&fm=193&f=GIF'),
        ),
      ],
    );
  }
}
