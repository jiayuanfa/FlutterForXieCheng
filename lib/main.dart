import 'package:flutter/material.dart';
import 'package:my_app/data_type.dart';
import 'package:my_app/generic_learn.dart';
import 'package:my_app/oop_learn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter必备Dart基础',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter必备Dart基础'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    learnOOP();

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          children: const <Widget>[
            // DataType()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void learnOOP() {
    Student.doPrint('learnOOP');

    /// 创建Student实例
    Student student = Student('清华', 'Jack', 18);
    student.school = '985';
    print(student.toString());

    Student student2 = Student('北大', 'Tom', 16, city: '北京', country: '中国');
    student2.school = '985';
    print(student2.toString());

    // 抽象类的使用
    StudyFlutter studyFlutter = StudyFlutter();
    studyFlutter.study();

    // 多继承

    // 方法
    FunctionLearn functionLearn = FunctionLearn();
    int result = functionLearn.sum(1, 2);
    print(result);

    // 泛型
    TestGeneric testGeneric = TestGeneric();
    testGeneric.start();

    // 泛型约束
    Member<Student> member = Member(Student("清华", "发哥", 18));
    member.fixedName();
  }
}
