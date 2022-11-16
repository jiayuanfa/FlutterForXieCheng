import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/travel_tab_model.dart';

///旅拍类别接口
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    var url = Uri.parse('http://www.devio.org/io/flutter_app/json/travel_page.json');
    final response = await http
        .get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel_page.json');
    }
  }
}