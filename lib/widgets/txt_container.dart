import 'package:flutter/material.dart';
import 'package:text_gen/text_gen.dart';

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
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.txt.text);
    super.initState();
  }

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
        // SizedBox(
        //           height: 20,
        //           width: 64,
        //           child: TextField(
        //             expands: false,
        //             controller: _controller,
        //             onChanged: (value) {
        //               widget.txt.text = value;
        //             },
        //             style: const TextStyle(
        //               fontSize: 16,
        //               //fontWeight: FontWeight.bold,
        //               color: Colors.white,
        //             ),
        //           ),
        //         ),
      ),
    );
  }
}
