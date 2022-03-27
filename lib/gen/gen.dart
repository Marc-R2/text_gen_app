library gen;

import 'package:uuid/uuid.dart';

part 'capsule.dart';

part 'txt.dart';

part 'random.dart';

part 'parser.dart';

void main() {
  final cap = parse('(Guten morgen {Marc ()})');
  if (cap != null) {
    final depth = cap.getDepth();
    print(depth);

    final variant = cap.buildVariant(0);
    print(variant);
  } else {
    print('no match');
  }
}

abstract class Gen {
  void add(Gen i);

  String buildArguments();

  String? buildVariant(int i);

  int getDepth();

  String? _uuid;

  String get uuid => _uuid ??= const Uuid().v4();

  Gen? getByUuid(String uuid);

  /// Replaces the existing element with [uuid] with [newGen].
  bool replaceByUuid(String uuid, Gen newGen);

  List<Gen>? getPathToUuid(String uuid);
}
