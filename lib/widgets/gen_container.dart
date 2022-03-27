import 'package:flutter/material.dart';
import 'package:text_gen/gen/gen.dart';
import 'package:text_gen/widgets/capsule_container.dart';
import 'package:text_gen/widgets/random_container.dart';
import 'package:text_gen/widgets/txt_container.dart';

class GenContainer extends StatelessWidget {
  const GenContainer({
    Key? key,
    required this.gen,
    this.allowNavigate = true,
    required this.navigateTo,
  }) : super(key: key);

  final Gen gen;
  final bool allowNavigate;
  final Function(Gen) navigateTo;

  @override
  Widget build(BuildContext context) {
    if (gen is Capsule) {
      return CapsuleContainer(
        cap: gen as Capsule,
        allowNavigate: allowNavigate,
        navigateTo: navigateTo,
      );
    } else if (gen is Random) {
      return RandomContainer(
        rand: gen as Random,
        allowNavigate: allowNavigate,
        navigateTo: navigateTo,
      );
    } else if (gen is Txt) {
      return TxtContainer(
        txt: gen as Txt,
        allowNavigate: allowNavigate,
        navigateTo: navigateTo,
      );
    }
    return const Text('Unknown gen type');
  }
}
