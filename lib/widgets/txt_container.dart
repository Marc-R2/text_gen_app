import 'package:flutter/material.dart';
import 'package:text_gen/gen/gen.dart';

class TxtContainer extends StatefulWidget {
  const TxtContainer({
    Key? key,
    required this.txt,
    this.allowNavigate = true,
    required this.navigateTo,
  }) : super(key: key);

  final Txt txt;
  final bool allowNavigate;
  final Function(Gen) navigateTo;

  @override
  _TxtContainerState createState() => _TxtContainerState();
}

class _TxtContainerState extends State<TxtContainer> {
  @override
  Widget build(BuildContext context) {
    // Container for the Txt with rounded corners in green
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
          widget.txt.text,
          style: const TextStyle(
            fontSize: 16,
            //fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
