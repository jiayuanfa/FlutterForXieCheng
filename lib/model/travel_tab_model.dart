///旅拍类别模型
class TravelTabModel {
  late Map params;
  late String url;
  late List<TravelTab> tabs;

  TravelTabModel({required this.url, required this.tabs});

  TravelTabModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    params = json['params'];
    if (json['tabs'] != null) {
      tabs = List<TravelTab>.empty(growable: true);
      json['tabs'].forEach((v) {
        tabs.add(TravelTab.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['tabs'] = tabs.map((v) => v.toJson()).toList();
    return data;
  }
}

class TravelTab {
  late String labelName;
  late String groupChannelCode;

  TravelTab({required this.labelName, required this.groupChannelCode});

  TravelTab.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['labelName'] = labelName;
    data['groupChannelCode'] = groupChannelCode;
    return data;
  }
}