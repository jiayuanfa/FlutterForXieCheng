
class CommonModel {
  String? icon;
  String? title;
  String url = "";
  String? statusBarColor;
  bool? hideAppBar;

  CommonModel(
      {this.icon, this.title, required this.url, this.statusBarColor, this.hideAppBar});

  CommonModel.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
    statusBarColor = json['statusBarColor'];
    hideAppBar = json['hideAppBar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['title'] = title;
    data['url'] = url;
    data['statusBarColor'] = statusBarColor;
    data['hideAppBar'] = hideAppBar;
    return data;
  }
}
