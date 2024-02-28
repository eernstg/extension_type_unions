// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:extension_type_unions/bounded_extension_type_unions.dart';

// Note that a bounded union type is more verbose to specify, and the developer
// must choose a common supertype manually (that's the first type argument).
// Other things work the same as the plain (unbounded) kind of union types.
// In return we get better run-time type safety.

// A short name for an upper bound of `int` and `String`.

typedef Bound = Comparable<Object>;

// Use `split` to discriminate: Receive a callback for every case, in order.

int doSplit(Union2<Bound, int, String> u) => u.split(
      (i) => i,
      (s) => s.length,
    );

// Use `splitNamed`: Can handle subset of cases, has `onOther`, may return null.

int? doSplitNamed(Union2<Bound, int, String> u) => u.splitNamed(
      on1: (i) => i,
      on2: (s) => s.length,
    );

int? doSplitNamedOther(Union2<Bound, int, String> u) => u.splitNamed(
      on2: (s) => s.length,
      onOther: (_) => 42,
    );

int? doSplitNamedInvalid(Union2<Bound, int, String> u) => u.splitNamed(
      onInvalid: (_) => -1,
    );

void main() {
  // We can introduce union typed expressions by calling a constructor.
  // The constructor `UnionN.inK` injects a value of the `K`th type argument
  // to a union type `UnionN` with `N` type arguments. For example,
  // `Union2<Bound, int, String>.in1` turns an `int` into a
  // `Union2<Bound, int, String>`.
  print(doSplit(Union2.in1(10))); // Prints '10'.
  print(doSplit(Union2.in2('ab'))); // '2'.

  // We can also use the extension getters `uNK` where `N` is the arity of the
  // union (the number of operands) and `K` is the position of the type argument
  // describing the actual value. So `u21` on an `int` returns a result of type
  // `Union2<int, int, Never>`. This expression works as a `Union2<B, int, S>`
  // for any `S` and for any bound `B` because we must have `int <: B` and
  // `S <: B` in order to satisfy the bounds of `Union2`, and in particular
  // `int <: B` ensures that `Union2<int, int, Never> <: Union2<B, int, S>`.
  print(doSplit(10.u21)); // '10'.
  print(doSplit('ab'.u22)); // '2'.
  print(doSplitNamed(10.u21)); // '10'.
  print(doSplitNamed('ab'.u22)); // '2'.
  print(doSplitNamedOther(10.u21)); // '42'.

  // It is a compile-time error to create a union typed value with wrong types.
  // Union2<Bound, int, String> u1 = Union2.in1(true); // Error.
  // Union2<Bound, int, String> u2 = Union2.in2(true); // Error.
  // Union2<Bound, int, String> u3 = true.u21; // Error.
  // Union2<Bound, int, String> u4 = true.u22; // Error.

  // We can't prevent the introduction of invalid union values, but the fact
  // that we have a bound type which is reified allows us to check for that.
  // In other words, `Union2<Bound, int, String>` is restricted to be `int`
  // or `String` at compile time (just like the unbounded version), but it
  // is restricted to be `Bound` at run time (where the unbounded version can
  // be anything whatsoever). This means that it is still possible to create
  // an invalid union value, but it's protected in exactly the same way as the
  // `Bound` type used as a normal type.
  try {
    var u = true as Union2<Bound, int, String>; // Throws.
    print("Never reached, so we won't see $u.");
  } catch (_) {
    print('Caught the exception.');
  }
}
