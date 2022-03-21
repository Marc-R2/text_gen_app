import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  String? txt;
  Gen? parsed;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  Gen? parse(String txt) {
    final chars = txt.split('');
    if (chars.isEmpty || chars[0] != '(') return null;
    Gen? current;
    List<Gen> stack = [];
    for (String i in chars) {
      print('i is: $i');
      if (i == ' ') {
        if (current is Txt) {
          final tmp = stack.last;
          if (tmp is Capsule) tmp.add(current);
          if (tmp is Random) tmp.add(current);
          current = stack.removeLast();
        }
      } else if (i == '(') {
        if (current is Txt) {
          final tmp = stack.last;
          if (tmp is Capsule) tmp.add(current);
          if (tmp is Random) tmp.add(current);
          current = stack.removeLast();
        }
        if (current != null) stack.add(current);
        current = Capsule(encapsulated: []);
      } else if (i == ')') {
        if (current is Txt) {
          final tmp = stack.last;
          if (tmp is Capsule) tmp.add(current);
          if (tmp is Random) tmp.add(current);
          current = stack.removeLast();
        }
        if (stack.isNotEmpty && current != null) {
          stack.last.add(current);
          current = stack.removeLast();
        }
      } else if (i == '{') {
        if (current is Txt) {
          final tmp = stack.last;
          if (tmp is Capsule) tmp.add(current);
          if (tmp is Random) tmp.add(current);
          current = stack.removeLast();
        }
        if (current != null) stack.add(current);
        current = Random(possibilities: []);
      } else if (i == '}') {
        if (current is Txt) {
          final tmp = stack.last;
          if (tmp is Capsule) tmp.add(current);
          if (tmp is Random) tmp.add(current);
          current = stack.removeLast();
        }
        if (stack.isNotEmpty && current != null) {
          stack.last.add(current);
          current = stack.removeLast();
        }
      } else {
        if (current is Txt) {
          current.add(Txt(text: i));
        } else {
          if (current != null) stack.add(current);
          current = Txt(text: i);
        }
      }
    }
    return current;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _controller,
                onChanged: (_) => setState(() {
                  parsed = parse(_controller.text);
                  if(parsed != null) txt = parsed!.buildArguments();
                }),
              ),
              const SizedBox(height: 32),
              Text(_controller.text),
              const SizedBox(height: 32),
              Text(txt ?? "Error"),
              const SizedBox(height: 32),
              Text(parsed == null ? "Error" : parsed!.buildVariant(1)),
              const SizedBox(height: 32),
              Text(parsed == null ? "Error" : parsed!.buildVariant(2)),
              const SizedBox(height: 32),
              Text(parsed == null ? "Error" : parsed!.buildVariant(3)),
              const SizedBox(height: 32),
              Text(parsed == null ? "Error" : parsed!.buildVariant(4)),
              const SizedBox(height: 32),
              Text(parsed == null ? "Error" : parsed!.buildVariant(5)),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

abstract class Gen {
  void add(Gen i);

  String buildArguments();

  String buildVariant(int i);

  int getDepth();
}

class Txt extends Gen {
  String text;

  Txt({required this.text});

  @override
  void add(Gen i) {
    if (i is Txt) text += i.text;
  }

  @override
  String buildArguments() {
    return text;
  }

  @override
  String toString() => 'Txt($text)';

  @override
  String buildVariant(i) => text;

  @override
  int getDepth() => 1;
}

class Capsule extends Gen {
  List<Gen> encapsulated;

  Capsule({required this.encapsulated});

  @override
  void add(Gen i) => encapsulated.add(i);

  @override
  String buildArguments() {
    print(this);
    final buffer = StringBuffer();
    for (final element in encapsulated) {
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(element.buildArguments());
    }
    return '($buffer)';
  }

  @override
  String toString() => 'Capsule(${getDepth()})$encapsulated';

  @override
  String buildVariant(i) {
    final buffer = StringBuffer();
    int depth = 1;
    for (final element in encapsulated) {
      if(element is Txt) buffer.write('${element.buildVariant(i - depth)} ');
      if(element is Random) buffer.write(element.buildVariant(i - depth));
      if(element is Capsule) buffer.write(element.buildVariant(i - depth));
      depth *= element.getDepth();
    }
    print('var($i): $this => $buffer');
    return buffer.toString();
  }

  @override
  int getDepth() {
    int depth = 1;
    for (final element in encapsulated) {
      depth *= element.getDepth();
    }
    return depth;
  }
}

class Random extends Gen {
  List<Gen> possibilities;

  Random({required this.possibilities});

  @override
  void add(Gen i) => possibilities.add(i);

  @override
  String buildArguments() {
    final buffer = StringBuffer();
    for (final element in possibilities) {
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(element.buildArguments());
    }
    return '{$buffer}';
  }

  @override
  String buildVariant(int i) {
    int depth = 1;
    for (final element in possibilities) {
      depth += element.getDepth();
      if(depth > i) {
        print('var($i): $this => ${element.buildVariant(i - depth)}');
        return element.buildVariant(i - depth);
      }
    }
    return "out of range";
  }

  @override
  int getDepth() {
    int depth = 0;
    for (final element in possibilities) {
      depth += element.getDepth();
    }
    return depth;
  }

  @override
  String toString() => 'Random(${getDepth()})$possibilities';
}
