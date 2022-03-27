import 'package:flutter/material.dart';
import 'package:text_gen/gen/gen.dart';
import 'package:text_gen/widgets/gen_container.dart';

class SubTree extends StatefulWidget {
  const SubTree({
    Key? key,
    this.gen,
    this.sub,
  }) : super(key: key);

  final Gen? gen;
  final Gen? sub;

  @override
  _SubTreeState createState() => _SubTreeState();
}

class _SubTreeState extends State<SubTree> {
  late TextEditingController _controller;

  Gen? subGen;

  @override
  void initState() {
    subGen = widget.sub;
    _controller = TextEditingController();
    if (subGen != null) _controller.text = subGen!.buildArguments();
    super.initState();
  }

  void navigateTo(Gen gen) {
    // Navigate to MaterialPageRoute
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SubTree(
          gen: widget.gen ?? subGen,
          sub: gen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the path from widget.gen to subGen
            Hero(
              tag: 'GenPath',
              child: Material(
                child: GenPath(
                  gen: widget.gen,
                  sub: subGen,
                  navigateTo: navigateTo,
                ),
              ),
            ),
            Hero(
              tag: 'GenTextField',
              child: Material(
                child: TextField(
                  controller: _controller,
                  onChanged: (_) => setState(() {
                    final newGen = parse(_controller.text);
                    if (newGen != null &&
                        widget.gen != null &&
                        subGen != null) {
                      widget.gen!.replaceByUuid(subGen!.uuid, newGen);
                    }
                    subGen = newGen;
                  }),
                ),
              ),
            ),
            const SizedBox(height: 32),
            subGen != null
                ? Hero(
                    tag: 'GenContainer',
                    child: Material(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: GenContainer(
                          gen: subGen!,
                          allowNavigate: false,
                          navigateTo: navigateTo,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            Expanded(
              child: Hero(
                tag: 'GenTexts',
                child: Material(
                  child: ListView.builder(
                    itemCount: subGen == null ? 1 : subGen!.getDepth(),
                    itemBuilder: (context, index) {
                      if (subGen == null) return const Text("No valid Input");
                      return ListTile(
                        title: SelectableText(
                            '${index + 1}: ${subGen == null ? "Error" : subGen!.buildVariant(index) ?? 'out of range'}'),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenPath extends StatelessWidget {
  const GenPath({
    Key? key,
    this.gen,
    this.sub,
    required this.navigateTo,
  }) : super(key: key);

  final Gen? gen;
  final Gen? sub;
  final Function(Gen) navigateTo;

  @override
  Widget build(BuildContext context) {
    final path = <Widget>[];
    if (gen == null || sub == null || gen == sub) {
      path.add(
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.home, color: Colors.green),
        ),
      );
    } else {
      final genPath = gen!.getPathToUuid(sub!.uuid);

      if (genPath == null) return const Text("No path found");

      for (final part in genPath) {
        if (path.isNotEmpty) {
          path.add(const Icon(Icons.arrow_right));

          String type = 'unknown';

          if (part is Random) type = 'Random';
          if (part is Capsule) type = 'Capsule';
          if (part is Txt) type = 'Word';

          path.add(MaterialButton(
            onPressed: () => part == sub ? null : navigateTo(part),
            child: Text(type),
            color: part == sub ? Colors.green : null,
          ));
        } else {
          path.add(
            IconButton(
              onPressed: () => navigateTo(gen!),
              icon: const Icon(Icons.home),
            ),
          );
        }
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: path,
    );
  }
}
