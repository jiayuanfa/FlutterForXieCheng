
/// 定义一个Dart类，所有的类都继承自Object
class Person {
  String? name;
  int? age;
  Person(this.name, this.age);

  /// 重写父类方法
  @override
  String toString() {
    return 'name:$name, age:$age';
  }
}

class Student extends Person {

  String? _school;  // 私有变量
  String? city;
  String? country;

  /// 通过get、set方法来访问类的私有字段
  String? get school => _school;
  set school(String? value) {
    _school = value;
  }

  /// 继承Person
  /// this._school 自有参数
  /// this.city 可选参数
  /// this.country 默认参数
  Student(this._school, String? name, int? age, {this.city, this.country = 'China'})
      : super(name, age) {

    print('构造方法体不是必须的');
  }

  /// 命名构造方法
  Student.cover(Student stu): super(stu.name, stu.age) {
    print('明明构造方法');
  }

  /// 命名工厂构造方法 factory [类名+.+方法名]
  /// 它可以有返回值，而且不需要将类的final变量所谓参数，是提供一种灵活获取类的方式
  factory Student.stu(Student stu) {
    return Student(stu._school, stu.name, stu.age);
  }

  /// 静态方法
  static doPrint(String str) {
    print('doPrint:$str');
  }

  @override
  String toString() {
    return 'country:$country, name:$name, age:$age, school:$school';
  }
}

/// 工厂构造方法（单例模式的提现）
// class Logger {
//   static Logger? _cache;
//
//   factory Logger() {
//     if (_cache == null) {
//       _cache = Logger._internal;
//     }
//     return _cache;
//   }
//   Logger._internal;
// }