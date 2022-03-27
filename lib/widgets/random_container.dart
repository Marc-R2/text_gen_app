import 'package:flutter/material.dart';
import 'package:text_gen/gen/gen.dart';

import 'gen_container.dart';

class RandomContainer extends StatefulWidget {
  const RandomContainer({
    Key? key,
    required this.rand,
    this.allowNavigate = true,
    required this.navigateTo,
  }) : super(key: key);

  final Random rand;
  final bool allowNavigate;
  final Function(Gen) navigateTo;

  @override
  _RandomContainerState createState() => _RandomContainerState();
}

class _RandomContainerState extends State<RandomContainer> {
  late bool _hovering;

  @override
  void initState() {
    _hovering = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Container for the Random with rounded corners in red
    return InkWell(
      onTap: widget.allowNavigate
          ? () => widget.navigateTo(widget.rand)
          : null,
      onHover: widget.allowNavigate
          ? (hovering) => setState(() => _hovering = hovering)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 256),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: _hovering ? Colors.red.shade300 : Colors.red.shade500,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.red.shade500, width: 2),
        ),
        // A Column of GenContainer widgets for each of the random's possibilities children
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.rand.possibilities.map((child) {
            return GenContainer(gen: child, navigateTo: widget.navigateTo);
          }).toList(),
        ),
      ),
    );
  }
}
