import 'package:extension_type_unions/extension_type_unions.dart';
import 'package:test/test.dart';

int doSplit(Union2<int, String> u) => u.split(
      (i) => i,
      (s) => s.length,
    );

int? doSplitNamed(Union2<int, String> u) => u.splitNamed(
      on1: (i) => i,
      on2: (s) => s.length,
    );

int? doSplitNamedOther(Union2<int, String> u) => u.splitNamed(
      on2: (s) => s.length,
      onOther: (_) => 42,
    );

int? doSplitNamedInvalid(Union2<int, String> u) => u.splitNamed(
      onInvalid: (_) => -1,
    );

void main() {
  test('split', () {
    expect(doSplit(Union2.in1(10)), 10);
    expect(doSplit(Union2.in2('10')), 2);

    expect(doSplit(10.u21), 10);
    expect(doSplit('10'.u22), 2);
  });
  test('splitNamed', () {
    expect(doSplitNamed(Union2.in1(10)), 10);
    expect(doSplitNamed(Union2.in2('10')), 2);
    expect(doSplitNamedOther(Union2.in1(10)), 42);
    expect(doSplitNamedInvalid(true as Union2<int, String>), -1);

    expect(doSplitNamed(10.u21), 10);
    expect(doSplitNamed('10'.u22), 2);
    expect(doSplitNamedOther(10.u21), 42);
    expect(doSplitNamedInvalid(true as Union2<int, String>), -1);
  });
}
