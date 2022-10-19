import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// 空StatefulWidget实现
class PhotoApp extends StatefulWidget {
  const PhotoApp({Key? key}) : super(key: key);

  @override
  State<PhotoApp> createState() => _PhotoAppState();
}

class _PhotoAppState extends State<PhotoApp> {

  final List<XFile> _images = []; // 照片数组

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('相片APP'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        /// 把Stack数组扔到Wrap中
        /// 实现了动态排列、换行的操作
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: _genImages(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: '选择图片',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  /// 把插件选择的图片整理成一个Stack组件的数组
  _genImages() {
    return _images.map((file) {
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.file(File(file.path), width: 120, height: 90, fit: BoxFit.fitWidth),
          ),
          Positioned(
            right: 5,
              top: 5,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    _images.remove(file);
                  });
                },
                child: ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(color: Colors.black54),
                    child: const Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
        ],
      );
    }).toList();
  }

  /// 底部选择弹窗
  _pickImage() {
    showModalBottomSheet(
        context: context,
        builder: (context) =>
            SizedBox(
              height: 120,
              child: Column(
                children: <Widget>[
                  _item('拍照', true),
                  _item('从相册选择', false)
                ],
              ),
            ));
  }

  /// 底部选择弹窗列表行组件
  _item(String title, bool isTakePhoto) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(isTakePhoto ? Icons.camera_alt : Icons.photo_library),
        title: Text(title),
        onTap: () => getImage(isTakePhoto),
      ),
    );
  }

  /// 使用插件从相册或者相机中拿到图片
  Future getImage(bool isTakePhoto) async {
    Navigator.pop(context);
    var image = await ImagePicker().pickImage(
        source: isTakePhoto ? ImageSource.camera : ImageSource.gallery);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

}
