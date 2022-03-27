import 'package:flutter/material.dart';
import 'package:text_gen/gen/gen.dart';

import 'gen_container.dart';

class CapsuleContainer extends StatefulWidget {
  const CapsuleContainer({
    Key? key,
    required this.cap,
    this.allowNavigate = true,
    required this.navigateTo,
  }) : super(key: key);

  final Capsule cap;
  final bool allowNavigate;
  final Function(Gen) navigateTo;

  @override
  _CapsuleContainerState createState() => _CapsuleContainerState();
}

class _CapsuleContainerState extends State<CapsuleContainer> {
  late bool _hovering;

  @override
  void initState() {
    _hovering = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Container for the capsule with rounded corners in blue
    return InkWell(
      onTap: widget.allowNavigate ? () => widget.navigateTo(widget.cap) : null,
      onHover: widget.allowNavigate
          ? (hovering) => setState(() => _hovering = hovering)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 256),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: _hovering ? Colors.blue.shade300 : Colors.blue,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue.shade300, width: 2),
        ),
        // A Row of GenContainer widgets for each of the capsule's encapsulated children
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.cap.encapsulated.map((child) {
            return GenContainer(gen: child, navigateTo: widget.navigateTo);
          }).toList(),
        ),
      ),
    );
  }
}
