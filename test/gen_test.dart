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

  /// Test the permutation function in the Capsule class
  group('Capsule.permutation', () {
    group('1 List', () {
      late List<String> list;

      setUpAll(() {
        list = ['A', 'B', 'C'];
      });

      test('1 List(0)', () {
        final List<String> res = Capsule.permutation(0, [list]);
        print(res);
        expect(res, ['A']);
      });

      test('1 List(1)', () {
        final List<String> res = Capsule.permutation(1, [list]);
        print(res);
        expect(res, ['B']);
      });

      test('1 List(2)', () {
        final List<String> res = Capsule.permutation(2, [list]);
        print(res);
        expect(res, ['C']);
      });
    });

    group('2 Lists', () {
      late List<String> list1;
      late List<String> list2;

      setUpAll(() {
        list1 = ['A', 'B', 'C'];
        list2 = ['D', 'E', 'F'];
      });

      test('2 Lists(0)', () {
        final List<String> res = Capsule.permutation(0, [list1, list2]);
        print(res);
        expect(res, ['A', 'D']);
      });

      test('2 Lists(1)', () {
        final List<String> res = Capsule.permutation(1, [list1, list2]);
        print(res);
        expect(res, ['B', 'D']);
      });

      test('2 Lists(2)', () {
        final List<String> res = Capsule.permutation(2, [list1, list2]);
        print(res);
        expect(res, ['C', 'D']);
      });

      test('2 Lists(3)', () {
        final List<String> res = Capsule.permutation(3, [list1, list2]);
        print(res);
        expect(res, ['A', 'E']);
      });

      test('2 Lists(4)', () {
        final List<String> res = Capsule.permutation(4, [list1, list2]);
        print(res);
        expect(res, ['B', 'E']);
      });

      test('2 Lists(5)', () {
        final List<String> res = Capsule.permutation(5, [list1, list2]);
        print(res);
        expect(res, ['C', 'E']);
      });

      test('2 Lists(6)', () {
        final List<String> res = Capsule.permutation(6, [list1, list2]);
        print(res);
        expect(res, ['A', 'F']);
      });

      test('2 Lists(7)', () {
        final List<String> res = Capsule.permutation(7, [list1, list2]);
        print(res);
        expect(res, ['B', 'F']);
      });

      test('2 Lists(8)', () {
        final List<String> res = Capsule.permutation(8, [list1, list2]);
        print(res);
        expect(res, ['C', 'F']);
      });

      test('2 Lists(9)', () {
        final List<String> res = Capsule.permutation(9, [list1, list2]);
        print(res);
        expect(res, ['A', 'D']);
      });
    });

    group('3 Lists', () {
      late List<String> list1;
      late List<String> list2;
      late List<String> list3;

      setUpAll(() {
        list1 = ['A', 'B', 'C'];
        list2 = ['D', 'E', 'F'];
        list3 = ['G', 'H', 'I'];
      });

      test('3 Lists(0)', () {
        final List<String> res = Capsule.permutation(0, [list1, list2, list3]);
        expect(res, ['A', 'D', 'G']);
      });

      test('3 Lists(1)', () {
        final List<String> res = Capsule.permutation(1, [list1, list2, list3]);
        expect(res, ['B', 'D', 'G']);
      });

      test('3 Lists(2)', () {
        final List<String> res = Capsule.permutation(2, [list1, list2, list3]);
        expect(res, ['C', 'D', 'G']);
      });

      test('3 Lists(3)', () {
        final List<String> res = Capsule.permutation(3, [list1, list2, list3]);
        expect(res, ['A', 'E', 'G']);
      });

      test('3 Lists(4)', () {
        final List<String> res = Capsule.permutation(4, [list1, list2, list3]);
        expect(res, ['B', 'E', 'G']);
      });

      test('3 Lists(5)', () {
        final List<String> res = Capsule.permutation(5, [list1, list2, list3]);
        expect(res, ['C', 'E', 'G']);
      });

      test('3 Lists(6)', () {
        final List<String> res = Capsule.permutation(6, [list1, list2, list3]);
        expect(res, ['A', 'F', 'G']);
      });

      test('3 Lists(7)', () {
        final List<String> res = Capsule.permutation(7, [list1, list2, list3]);
        expect(res, ['B', 'F', 'G']);
      });

      test('3 Lists(8)', () {
        final List<String> res = Capsule.permutation(8, [list1, list2, list3]);
        expect(res, ['C', 'F', 'G']);
      });

      test('3 Lists(9)', () {
        final List<String> res = Capsule.permutation(9, [list1, list2, list3]);
        expect(res, ['A', 'D', 'H']);
      });

      test('3 Lists(10)', () {
        final List<String> res = Capsule.permutation(10, [list1, list2, list3]);
        expect(res, ['B', 'D', 'H']);
      });

      test('3 Lists(11)', () {
        final List<String> res = Capsule.permutation(11, [list1, list2, list3]);
        expect(res, ['C', 'D', 'H']);
      });

      test('3 Lists(12)', () {
        final List<String> res = Capsule.permutation(12, [list1, list2, list3]);
        expect(res, ['A', 'E', 'H']);
      });

      test('3 Lists(13)', () {
        final List<String> res = Capsule.permutation(13, [list1, list2, list3]);
        expect(res, ['B', 'E', 'H']);
      });

      test('3 Lists(14)', () {
        final List<String> res = Capsule.permutation(14, [list1, list2, list3]);
        expect(res, ['C', 'E', 'H']);
      });

      test('3 Lists(15)', () {
        final List<String> res = Capsule.permutation(15, [list1, list2, list3]);
        expect(res, ['A', 'F', 'H']);
      });

      test('3 Lists(16)', () {
        final List<String> res = Capsule.permutation(16, [list1, list2, list3]);
        expect(res, ['B', 'F', 'H']);
      });

      test('3 Lists(17)', () {
        final List<String> res = Capsule.permutation(17, [list1, list2, list3]);
        expect(res, ['C', 'F', 'H']);
      });

      test('3 Lists(18)', () {
        final List<String> res = Capsule.permutation(18, [list1, list2, list3]);
        expect(res, ['A', 'D', 'I']);
      });

      test('3 Lists(19)', () {
        final List<String> res = Capsule.permutation(19, [list1, list2, list3]);
        expect(res, ['B', 'D', 'I']);
      });

      test('3 Lists(20)', () {
        final List<String> res = Capsule.permutation(20, [list1, list2, list3]);
        expect(res, ['C', 'D', 'I']);
      });

      test('3 Lists(21)', () {
        final List<String> res = Capsule.permutation(21, [list1, list2, list3]);
        expect(res, ['A', 'E', 'I']);
      });

      test('3 Lists(22)', () {
        final List<String> res = Capsule.permutation(22, [list1, list2, list3]);
        expect(res, ['B', 'E', 'I']);
      });

      test('3 Lists(23)', () {
        final List<String> res = Capsule.permutation(23, [list1, list2, list3]);
        expect(res, ['C', 'E', 'I']);
      });

      test('3 Lists(24)', () {
        final List<String> res = Capsule.permutation(24, [list1, list2, list3]);
        expect(res, ['A', 'F', 'I']);
      });

      test('3 Lists(25)', () {
        final List<String> res = Capsule.permutation(25, [list1, list2, list3]);
        expect(res, ['B', 'F', 'I']);
      });

      test('3 Lists(26)', () {
        final List<String> res = Capsule.permutation(26, [list1, list2, list3]);
        expect(res, ['C', 'F', 'I']);
      });

      test('3 Lists(27)', () {
        final List<String> res = Capsule.permutation(27, [list1, list2, list3]);
        expect(res, ['A', 'D', 'G']);
      });

    });
  });
}
