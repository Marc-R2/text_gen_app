
import 'package:flutter/material.dart';
import 'package:text_gen/gen/gen.dart';
import 'package:text_gen/widgets/capsule_container.dart';
import 'package:text_gen/widgets/random_container.dart';
import 'package:text_gen/widgets/txt_container.dart';

class GenContainer extends StatelessWidget {
  const GenContainer({Key? key, required this.gen}) : super(key: key);

  final Gen gen;

  @override
  Widget build(BuildContext context) {
    if(gen is Capsule) return CapsuleContainer(cap: gen as Capsule);
    if(gen is Random) return RandomContainer(rand: gen as Random);
    if(gen is Txt) return TxtContainer(txt: gen as Txt);
    return const Text('Unknown gen type');
  }
}
