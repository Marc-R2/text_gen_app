part of 'gen.dart';

class Capsule extends Gen {
  List<Gen> encapsulated;

  Capsule({required this.encapsulated});

  @override
  void add(Gen i) => encapsulated.add(i);

  @override
  String buildArguments() {
    print(this);
    final buffer = StringBuffer();
    for (final element in encapsulated) {
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(element.buildArguments());
    }
    return '($buffer)';
  }

  @override
  String toString() => 'Capsule(${getDepth()})$encapsulated';

  @override
  String? buildVariant(i) {
    if(i > getDepth()) return null;
    final buffer = StringBuffer();
    int depth = 1;
    for (final element in encapsulated) {
      if(buffer.isNotEmpty) buffer.write(' ');
      if(element is Txt) buffer.write(element.buildVariant(i - depth));
      if(element is Random) buffer.write(element.buildVariant(i - depth));
      if(element is Capsule) buffer.write(element.buildVariant(i - depth));
      depth *= element.getDepth();
    }
    print('var($i): $this => $buffer');
    return buffer.toString();
  }

  @override
  int getDepth() {
    int depth = 1;
    for (final element in encapsulated) {
      depth *= element.getDepth();
    }
    return depth;
  }
}
