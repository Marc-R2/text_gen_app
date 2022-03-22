part of 'gen.dart';

class Random extends Gen {
  List<Gen> possibilities;

  Random({required this.possibilities});

  @override
  void add(Gen i) => possibilities.add(i);

  @override
  String buildArguments() {
    final buffer = StringBuffer();
    for (final element in possibilities) {
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(element.buildArguments());
    }
    return '{$buffer}';
  }

  @override
  String? buildVariant(int i) {
    int depth = 1;
    for (final element in possibilities) {
      depth += element.getDepth();
      if(depth > i) {
        print('var($i): $this => ${element.buildVariant(i - depth)}');
        return element.buildVariant(i - depth);
      }
    }
    return null;
  }

  @override
  int getDepth() {
    int depth = 0;
    for (final element in possibilities) {
      depth += element.getDepth();
    }
    return depth;
  }

  @override
  String toString() => 'Random(${getDepth()})$possibilities';
}
