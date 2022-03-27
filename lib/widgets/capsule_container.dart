import 'package:flutter/material.dart';
import 'package:text_gen/gen/gen.dart';

import 'gen_container.dart';

class CapsuleContainer extends StatefulWidget {
  const CapsuleContainer({Key? key, required this.cap}) : super(key: key);

  final Capsule cap;

  @override
  _CapsuleContainerState createState() => _CapsuleContainerState();
}

class _CapsuleContainerState extends State<CapsuleContainer> {
  @override
  Widget build(BuildContext context) {
    // Container for the capsule with rounded corners in blue
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade300, width: 2),
      ),
      // A Row of GenContainer widgets for each of the capsule's encapsulated children
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.cap.encapsulated.map((child) {
          return GenContainer(gen: child);
        }).toList(),
      ),
    );
  }
}
