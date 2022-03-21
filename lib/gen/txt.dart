part of 'gen.dart';

class Txt extends Gen {
  String text;

  Txt({required this.text});

  @override
  void add(Gen i) {
    if (i is Txt) text += i.text;
  }

  @override
  String buildArguments() {
    return text;
  }

  @override
  String toString() => 'Txt($text)';

  @override
  String buildVariant(i) => text;

  @override
  int getDepth() => 1;
}
