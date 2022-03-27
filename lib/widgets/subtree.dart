import 'package:flutter/material.dart';
import 'package:text_gen/gen/gen.dart';
import 'package:text_gen/widgets/gen_container.dart';

class SubTree extends StatefulWidget {
  const SubTree({
    Key? key,
    required this.gen,
    required this.subGen,
  }) : super(key: key);

  final Gen gen;
  final Gen subGen;

  @override
  _SubTreeState createState() => _SubTreeState();
}

class _SubTreeState extends State<SubTree> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
