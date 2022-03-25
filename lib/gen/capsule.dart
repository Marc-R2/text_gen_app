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
    if (i > getDepth()) return null;
    final buffer = StringBuffer();
    int depth = 1;
    for (final element in encapsulated) {
      if (buffer.isNotEmpty) buffer.write(' ');
      if (element is Txt) buffer.write(element.buildVariant(i - depth));
      if (element is Random) buffer.write(element.buildVariant(i - depth));
      if (element is Capsule) buffer.write(element.buildVariant(i - depth));
      depth *= element.getDepth();
    }
    print('var($i): $this => $buffer');
    return buffer.toString();
  }

  /// Returns the nth permutation from multiple lists
  /// [lists] is the list of lists
  /// [i] is the index of the current list
  /// [n] is the number of the wanted permutation
  static List<String> permutation(int n, List<List<String>> lists, [int i = 0]) {
    if (i == lists.length) return [];
    final list = lists[i];
    final length = list.length;
    final index = n % length;
    final result = list[index];
    final next = n ~/ length;
    return [result, ...permutation(next, lists, i + 1)];
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
