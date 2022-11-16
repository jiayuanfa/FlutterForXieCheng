///旅拍页模型
class TravelItemModel {
  late int totalCount;
  List<TravelItem>? resultList;

  //命名构造方法
  TravelItemModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['resultList'] != null) {
      resultList = List<TravelItem>.empty(growable: true);
      json['resultList'].forEach((v) {
        resultList!.add(TravelItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    data['resultList'] = resultList!.map((v) => v.toJson()).toList();
    return data;
  }
}

class TravelItem {
  late int type;
  late Article article;

  TravelItem(this.type, this.article);

  TravelItem.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    article = Article.fromJson(json['article']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['article'] = article.toJson();
    return data;
  }
}

class Article {
  late int articleId;
  String? articleType;
  late int productType;
  late int sourceType;
  late String articleTitle;
  Author? author;
  late List<Images> images;
  late bool hasVideo;
  late int readCount;
  late int likeCount;
  late int commentCount;
  late List<Urls> urls;
  late List<void> tags;
  late List<Topics> topics;
  List<Pois?>? pois;
  late String publishTime;
  late String publishTimeDisplay;
  late String shootTime;
  late String shootTimeDisplay;
  late int level;
  late String distanceText;
  late bool isLike;
  late int imageCounts;
  late bool isCollected;
  late int collectCount;
  late int articleStatus;
  late String poiName;

  Article(
      this.articleId,
      this.articleType,
      this.productType,
      this.sourceType,
      this.articleTitle,
      this.author,
      this.images,
      this.hasVideo,
      this.readCount,
      this.likeCount,
      this.commentCount,
      this.urls,
      this.tags,
      this.topics,
      this.pois,
      this.publishTime,
      this.publishTimeDisplay,
      this.shootTime,
      this.shootTimeDisplay,
      this.level,
      this.distanceText,
      this.isLike,
      this.imageCounts,
      this.isCollected,
      this.collectCount,
      this.articleStatus,
      this.poiName);

  Article.fromJson(Map<String, dynamic> json) {
    articleId = json['articleId'];
    articleType = json['articleType'];
    productType = json['productType'];
    sourceType = json['sourceType'];
    articleTitle = json['articleTitle'];
    author =
    json['author'] != null ? Author.fromJson(json['author']) : null;
    if (json['images'] != null) {
      images = List<Images>.empty(growable: true);
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
    hasVideo = json['hasVideo'];
    readCount = json['readCount'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    if (json['urls'] != null) {
      urls = List<Urls>.empty(growable: true);
      json['urls'].forEach((v) {
        urls.add(Urls.fromJson(v));
      });
    }
    if (json['topics'] != null) {
      topics = List<Topics>.empty(growable: true);
      json['topics'].forEach((v) {
        topics.add(Topics.fromJson(v));
      });
    }
    if (json['pois'] != null) {
      pois = List<Pois>.empty(growable: true);
      json['pois'].forEach((v) {
        pois!.add(Pois.fromJson(v));
      });
    }
    publishTime = json['publishTime'];
    publishTimeDisplay = json['publishTimeDisplay'];
    shootTime = json['shootTime'];
    shootTimeDisplay = json['shootTimeDisplay'];
    level = json['level'];
    distanceText = json['distanceText'];
    isLike = json['isLike'];
    imageCounts = json['imageCounts'];
    isCollected = json['isCollected'];
    collectCount = json['collectCount'];
    articleStatus = json['articleStatus'];
    poiName = json['poiName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['articleId'] = articleId;
    data['articleType'] = articleType;
    data['productType'] = productType;
    data['sourceType'] = sourceType;
    data['articleTitle'] = articleTitle;
    if (author != null) {
      data['author'] = author?.toJson();
    }
    data['images'] = images.map((v) => v.toJson()).toList();
    data['hasVideo'] = hasVideo;
    data['readCount'] = readCount;
    data['likeCount'] = likeCount;
    data['commentCount'] = commentCount;
    data['urls'] = urls.map((v) => v.toJson()).toList();
    data['topics'] = topics.map((v) => v.toJson()).toList();
    data['pois'] = pois!.map((v) => v?.toJson()).toList();
    data['publishTime'] = publishTime;
    data['publishTimeDisplay'] = publishTimeDisplay;
    data['shootTime'] = shootTime;
    data['shootTimeDisplay'] = shootTimeDisplay;
    data['level'] = level;
    data['distanceText'] = distanceText;
    data['isLike'] = isLike;
    data['imageCounts'] = imageCounts;
    data['isCollected'] = isCollected;
    data['collectCount'] = collectCount;
    data['articleStatus'] = articleStatus;
    data['poiName'] = poiName;
    return data;
  }
}

class Author {
  late int authorId;
  late String nickName;
  late String clientAuth;
  late String jumpUrl;
  CoverImage? coverImage;
  int? identityType;
  late String tag;

  Author(this.authorId, this.nickName, this.clientAuth, this.jumpUrl,
      this.coverImage, this.identityType, this.tag);

  Author.fromJson(Map<String, dynamic> json) {
    authorId = json['authorId'];
    nickName = json['nickName'];
    clientAuth = json['clientAuth'];
    jumpUrl = json['jumpUrl'];
    coverImage = json['coverImage'] != null
        ? CoverImage.fromJson(json['coverImage'])
        : null;
    identityType = json['identityType'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authorId'] = authorId;
    data['nickName'] = nickName;
    data['clientAuth'] = clientAuth;
    data['jumpUrl'] = jumpUrl;
    if (coverImage != null) {
      data['coverImage'] = coverImage?.toJson();
    }
    data['identityType'] = identityType;
    data['tag'] = tag;
    return data;
  }
}

class CoverImage {
  late String dynamicUrl;
  late String originalUrl;

  CoverImage(this.dynamicUrl, this.originalUrl);

  CoverImage.fromJson(Map<String, dynamic> json) {
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dynamicUrl'] = dynamicUrl;
    data['originalUrl'] = originalUrl;
    return data;
  }
}

class Images {
  late int imageId;
  late String dynamicUrl;
  late String originalUrl;
  late double width;
  late double height;
  late int mediaType;
  bool? isWaterMarked;

  Images(this.imageId, this.dynamicUrl, this.originalUrl, this.width,
      this.height, this.mediaType, this.isWaterMarked);

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
    width = json['width'];
    height = json['height'];
    mediaType = json['mediaType'];
    isWaterMarked = json['isWaterMarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageId'] = imageId;
    data['dynamicUrl'] = dynamicUrl;
    data['originalUrl'] = originalUrl;
    data['width'] = width;
    data['height'] = height;
    data['mediaType'] = mediaType;
    data['isWaterMarked'] = isWaterMarked;
    return data;
  }
}

class Urls {
  late String version;
  late String appUrl;
  late String h5Url;
  late String wxUrl;

  Urls(this.version, this.appUrl, this.h5Url, this.wxUrl);

  Urls.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    appUrl = json['appUrl'];
    h5Url = json['h5Url'];
    wxUrl = json['wxUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    data['appUrl'] = appUrl;
    data['h5Url'] = h5Url;
    data['wxUrl'] = wxUrl;
    return data;
  }
}

class Topics {
  late int topicId;
  late String topicName;
  late int level;

  Topics(this.topicId, this.topicName, this.level);

  Topics.fromJson(Map<String, dynamic> json) {
    topicId = json['topicId'];
    topicName = json['topicName'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topicId'] = topicId;
    data['topicName'] = topicName;
    data['level'] = level;
    return data;
  }
}

class Pois {
  late int poiType;
  late int poiId;
  late String poiName;
  int? businessId;
  late int districtId;
  PoiExt? poiExt;
  late int source;
  late int isMain;
  late bool isInChina;
  String? countryName;

  Pois(this.poiType, this.poiId, this.poiName, this.businessId, this.districtId,
      this.poiExt, this.source, this.isMain, this.isInChina, this.countryName);

  Pois.fromJson(Map<String, dynamic> json) {
    poiType = json['poiType'];
    poiId = json['poiId'];
    poiName = json['poiName'];
    businessId = json['businessId'];
    districtId = json['districtId'];
    poiExt =
    json['poiExt'] != null ? PoiExt.fromJson(json['poiExt']) : null;
    source = json['source'];
    isMain = json['isMain'];
    isInChina = json['isInChina'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['poiType'] = poiType;
    data['poiId'] = poiId;
    data['poiName'] = poiName;
    data['businessId'] = businessId;
    data['districtId'] = districtId;
    if (poiExt != null) {
      data['poiExt'] = poiExt!.toJson();
    }
    data['source'] = source;
    data['isMain'] = isMain;
    data['isInChina'] = isInChina;
    data['countryName'] = countryName;
    return data;
  }
}

class PoiExt {
  late String h5Url;
  late String appUrl;

  PoiExt(this.h5Url, this.appUrl);

  PoiExt.fromJson(Map<String, dynamic> json) {
    h5Url = json['h5Url'];
    appUrl = json['appUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['h5Url'] = h5Url;
    data['appUrl'] = appUrl;
    return data;
  }
}
