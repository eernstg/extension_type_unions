import 'package:inline_union_type/inline_union_type.dart';
import 'package:test/test.dart';

int doSplit(Union<int, String> u) => u.split(
  (i) => i,
  (s) => s.length,
);

int doSplitNamed(Union<int, String> u) => u.splitNamed(
  on1: (i) => i,
  on2: (s) => s.length,
);

int doSplitNamedInvalid(Union<int, String> u) => u.splitNamed(
  onInvalid: (_) => -1,
);

int doSplitNamedOther(Union<int, String> u) => u.splitNamed(
  on2: (s) => s.length,
  onOther: (_) => 42,
);

void main() {
  test('split', () {
    expect(doSplit(Union2.in1(10)), 10);
    expect(doSplit(Union2.in2('10')), 2);
  });
  test('splitNamed', () {
    expect(doSplitNamed(Union2.in1(10)), 10);
    expect(doSplitNamed(Union2.in2('10')), 2);
    expect(doSplitNamedOther(Union2.in2(10)), 42);
    expect(doSplitNamedInvalid(true as Union2<int, String>), -1);
  });
}
