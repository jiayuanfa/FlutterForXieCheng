import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/travel_model.dart';

///旅拍页接口

var Params = {
  "districtId": -1,
  "groupChannelCode": "RX-OMF",
  "type": null,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": 0,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {'cid': "09031014111431397988"},
  "contentType": "json"
};

class TravelDao {

  static Future<TravelItemModel> fetch(String url, Map params,
      String groupChannelCode, int pageIndex, int pageSize) async {
    Map paramsMap = params['pagePara'];//固定携带的额外参数参数，不需变更
    paramsMap['pageIndex'] = pageIndex; //分页请求的页码
    paramsMap['pageSize'] = pageSize; //每页显示的条数
    params['groupChannelCode'] =
        groupChannelCode; //频道码，在travel_tab_model.dart的TravelTab中有定义
    var uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelItemModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel');
    }
  }
}
