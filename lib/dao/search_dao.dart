
import 'dart:convert';

import 'package:my_app/model/search_model.dart';
import 'package:http/http.dart' as http;

class SearchDao {
  static Future<SearchModel> fetch(String url, String keyword) async {
    var uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder();  // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));

      // 只有当输入的内容和服务器返回的内容一致的时候 才进行渲染
      SearchModel searchModel = SearchModel.fromJson(result);
      searchModel.keyword = keyword;
      return searchModel;
    } else {
      throw Exception('Failed to load search model');
    }
  }
}