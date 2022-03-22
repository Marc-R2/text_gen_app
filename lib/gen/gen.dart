library gen;

part 'capsule.dart';
part 'txt.dart';
part 'random.dart';
part 'parser.dart';

abstract class Gen {
  void add(Gen i);

  String buildArguments();

  String? buildVariant(int i);

  int getDepth();
}
