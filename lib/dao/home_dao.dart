
import 'dart:convert';

import '../model/home_model.dart';
import 'package:http/http.dart' as http;

const HOME_URL = 'https://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao {
  static Future<HomeModel> fetch() async {
    var url = Uri.parse(HOME_URL);

    var header = {
      'Access-Control-Allow-Origin': '*',
      "Accept": "application/json"
    };

    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder();  // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}