import 'package:inline_union_type/inline_union_type.dart';

// Use `split` to discriminate: Receive a callback for every case, in order.

int doSplit(Union2<int, String> u) => u.split(
  (i) => i,
  (s) => s.length,
);

// Use `splitNamed`: Can handle subset of cases, has `onOther`, may return null.

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
  print(doSplit(Union2.in2('ab'))); // '2'.

  // We can also use the extension getters `asUnionNK` where `N` is the arity
  // of the union (the number of operands) and `K` is the position of the type
  // argument describing the actual value. So `asUnion21` on an `int` returns a
  // result of type `Union2<int, Never>` (which will work as a `Union2<int, S>`
  // for any `S`).
  print(doSplit(10.asUnion21)); // '10'.
  print(doSplit('ab'.asUnion22)); // '2'.
  print(doSplitNamed(10.asUnion21)); // '10'.
  print(doSplitNamed('ab'.asUnion22)); // '2'.
  print(doSplitNamedOther(10.asUnion21)); // '42'.

  // It is a compile-time error to create a union typed value with wrong types.
  // Union2<int, String> u1 = Union2.in1(true); // Error.
  // Union2<int, String> u2 = Union2.in2(true); // Error.
  // Union2<int, String> u3 = true.asUnion21; // Error.
  // Union2<int, String> u4 = true.asUnion22; // Error.

  // However, we can't prevent the introduction of invalid union values,
  // because it is always possible to force the type by an explicit cast. This
  // situation can be handled in a `splitNamed` invocation as shown in
  // `doSplitNamedInvalid`, and it can be detected using `isValid`.
  // If it is not detected, `split` will throw.
  var u = true as Union2<int, String>; // Bad, but no error.
  print(doSplitNamedInvalid(u)); // '-1'.
  print(u.isValid); // 'false'.
  // doSplit(u); // Throws.
}
