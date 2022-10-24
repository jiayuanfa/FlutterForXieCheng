
import 'package:flutter/animation.dart';
import 'package:my_app/baseLearn/oop_learn.dart';

class TestGeneric {
  void start() {
    Cache<String> cache = Cache();
    cache.setItem("cache", "111");
    String result = cache.getItem("cache") as String;
    print(result);

    Cache<int> cache2 = Cache();
    cache2.setItem("cache2", 222);
    int cache2Result = cache2.getItem("cache2") as int;
    print(cache2Result);
  }
}

/// 泛型
/// 通俗理解：解决类、接口、方法的复用性、以及对不特性数据类型的支持
/// 泛型类
/// 作用：提高代码的复用程度
class Cache<T> {
  static final Map<String, Object?> _cached = Map();
  /// 泛型方法
  void setItem(String key, T value) {
    _cached[key] = value as Object;
  }

  Object? getItem(String key) {
    return _cached[key];
  }
}

/// 泛型约束
class Member<T extends Person> {
  T _person;
  Member(this._person);

  String fixedName() {
    print('fixed:${_person.name}');
    return "";
  }
}

