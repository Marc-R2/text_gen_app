import 'package:flutter_test/flutter_test.dart';
import 'package:text_gen/gen/gen.dart';

import 'package:text_gen/main.dart';

void main() {
  group('Random - Simple', () {
    late Random rand;

    setUpAll(() {
      rand = Random(possibilities: [
        Txt(text: 'ABC'),
        Txt(text: 'DEF'),
        Txt(text: 'HIJ'),
      ]);
    });

    test('Depth', () => expect(rand.getDepth(), 3));

    test('Random(1) => ABC', () => expect(rand.buildVariant(1), 'ABC'));
    test('Random(2) => DEF', () => expect(rand.buildVariant(2), 'DEF'));
    test('Random(3) => HIJ', () => expect(rand.buildVariant(3), 'HIJ'));
    test('Random(4) => null', () => expect(rand.buildVariant(4), null));
  });

  group('Capsule - Simple', () {
    late Capsule cap;

    setUpAll(() {
      cap = Capsule(encapsulated: [
        Txt(text: 'ABC'),
        Txt(text: 'DEF'),
        Txt(text: 'HIJ'),
      ]);
    });

    test('Depth', () => expect(cap.getDepth(), 1));

    test('Random(1) => ABC', () => expect(cap.buildVariant(1), 'ABC DEF HIJ'));
    test('Random(2) => null', () => expect(cap.buildVariant(2), null));
    test('Random(3) => null', () => expect(cap.buildVariant(3), null));
    test('Random(4) => null', () => expect(cap.buildVariant(4), null));
  });

  group('Capsule(Txt Random(3) Txt)', () {
    late Capsule cap;

    setUpAll(() {
      cap = Capsule(encapsulated: [
        Txt(text: 'ABC'),
        Random(possibilities: [
          Txt(text: 'AB'),
          Txt(text: 'CD'),
          Txt(text: 'EF'),
        ]),
        Txt(text: 'HIJ'),
      ]);
    });

    test('Depth', () => expect(cap.getDepth(), 3));

    test('Random(1)', () => expect(cap.buildVariant(1), 'ABC AB HIJ'));
    test('Random(2)', () => expect(cap.buildVariant(2), 'ABC CD HIJ'));
    test('Random(3)', () => expect(cap.buildVariant(3), 'ABC EF HIJ'));
    test('Random(4) => null', () => expect(cap.buildVariant(4), null));
  });
}
