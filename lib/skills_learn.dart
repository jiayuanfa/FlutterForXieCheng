/// 面向对象的编程技巧
/// 一：封装、继承、多态
/// 模块封装、代码封装、类封装、方法封装、目的：易用、扩展
/// 方法代码<100行
/// 二：点点点的习惯
/// 万物皆对象
/// 一点查看属性、方法
/// 二点看源码
/// 三点探究竟


void main() {
  List? list;
  print("fage");

  /// 安全调用
  print(list?.length);

  /// 为表达式设置默认值
  print(list?.length??-1);

  /// 简化判断
  list = [];
  list.add(0);
  list.add('');
  list.add(null);
  if (list[0] == 0 || list[0] == '' || list[0] == null) {
    print('list[0] is empty');
  }

  if ([null, '', 0].contains(list[0])) {
    print('list[0] is empty');
  }
}