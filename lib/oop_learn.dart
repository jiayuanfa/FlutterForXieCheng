
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

/// 抽象类
abstract class Study {
  void study(); /// 抽象方法（有抽象方法的类一定是抽象类）
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

/// 继承抽象类，必须实现抽象类的方法，否则则必须是抽象类
class StudyFlutter extends Study {
  @override
  void study() {
    print('Learn flutter');

    FunctionLearn functionLearn = FunctionLearn();
    functionLearn._learn();
  }
}

/// mixin 多继承
/// 多继承是为了有多个类的能力
/// 为我们现在已经有的类，增加别的类的特性
class Test extends Person with Study {
  Test(super.name, super.age);

  @override
  void study() {
  }
}

/// 方法学习
class FunctionLearn {

  /// 相加
  int sum(int val1, int val2) {
    return val1 + val2;
  }

  /// 私有方法
  /// 作用域是当前文件
  _learn() {

  }

  /// 匿名方法、lanmda
  anonymousFunction() {
    List list = ["私有方法", "匿名方法"];
    list.forEach((element) {
      print(element);
    });
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
