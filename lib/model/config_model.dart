

class ConfigModel {
  String? searchUrl;

  ConfigModel({this.searchUrl});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    searchUrl = json['searchUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['searchUrl'] = searchUrl;
    return data;
  }
}
