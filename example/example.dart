import 'package:inline_union_type/inline_union_type.dart';

// Use `split`: Must receive a callback for every case, in order.

int doSplit(Union2<int, String> u) => u.split(
  (i) => i,
  (s) => s.length,
);

// Use `splitNamed`: Can handle subset of cases, otherwise calls `onOther`.

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
  // We can introduce union typed expressions by calling a constructor.
  // The constructor `UnionN.inK` injects a value of the `K`th type argument
  // to a union type `UnionN` with `N` type arguments. For example,
  // `Union2<int, String>.in1` turns an `int` into a `Union2<int, String>`.
  print(doSplit(Union2.in1(10))); // Prints '10'.
  print(doSplit(Union2.in2('10'))); // '2'.

  // We can also use the extension getters `asUnionNK` where `N` is the arity
  // of the union (the number of operands) and `K` is the position of the type
  // argument describing the actual value. So, `asUnion21` for an `int` which
  // gets the type `Union2<int, Never>` (which will work as a `Union2<int, S>`
  // for any `S`).
  print(doSplit(10.asUnion21)); // '10'.
  print(doSplit('10'.asUnion22)); // '2'.
  print(doSplitNamed(10.asUnion21)); // '10'.
  print(doSplitNamed('10'.asUnion22)); // '2'.
  print(doSplitNamedOther(10.asUnion21)); // '42'.

  // We can't prevent the introduction of invalid union values, because it is
  // always possible to force the type by an explicit cast. This case can be
  // handled in a `splitNamed` invocation as shown in `doSplitNamedInvalid`.
  var u = true as Union2<int, String>;
  print(doSplitNamedInvalid(u)); // '-1'.

  // We can detect these cases, if we suspect that they will ever arise.
  print(u.isValid); // 'false'.
}
