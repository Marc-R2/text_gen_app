import 'package:flutter/material.dart';
import 'package:text_gen/gen/gen.dart';

import 'gen_container.dart';

class RandomContainer extends StatefulWidget {
  const RandomContainer({Key? key, required this.rand}) : super(key: key);

  final Random rand;

  @override
  _RandomContainerState createState() => _RandomContainerState();
}

class _RandomContainerState extends State<RandomContainer> {
  @override
  Widget build(BuildContext context) {
    // Container for the Random with rounded corners in red
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.red.shade300,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.shade500, width: 2),
      ),
      // A Column of GenContainer widgets for each of the random's possibilities children
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.rand.possibilities.map((child) {
          return GenContainer(gen: child);
        }).toList(),
      ),
    );
  }
}
