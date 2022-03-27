import 'package:text_gen/widgets/gen_container.dart';

import 'gen/gen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              onChanged: (_) => setState(() {
                parsed = parse(_controller.text);
                if (parsed != null) txt = parsed!.buildArguments();
              }),
            ),
            const SizedBox(height: 32),
            //Text(txt ?? "Error"),
            parsed != null
                ? Expanded(
                    child: SingleChildScrollView(
                      child: GenContainer(
                        gen: parsed!,
                      ),
                    ),
                  )
                : const SizedBox(),
            // child: ListView.builder(
            //                 itemCount: parsed == null ? 1 : parsed!.getDepth() + 1,
            //                 itemBuilder: (context, index) {
            //                   if (parsed == null) return const Text("No valid Input");
            //                   return ListTile(
            //                     title: SelectableText(parsed == null ? "Error" : parsed!.buildVariant(index) ?? 'out of range'),
            //                   );
            //                 },
            //               ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
