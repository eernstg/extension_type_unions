[![Build Status](https://github.com/lrhn/charcode/workflows/Dart%20CI/badge.svg)](https://github.com/lrhn/charcode/actions?query=workflow%3A"Dart+CI")
[![Pub](https://img.shields.io/pub/v/charcode.svg)](https://pub.dev/packages/charcode)
[![package publisher](https://img.shields.io/pub/publisher/charcode.svg)](https://pub.dev/packages/charcode/publisher)

# Inline Union Types

Support for union types in Dart has been requested at least [since 2012](https://github.com/dart-lang/language/issues/1222). This repository provides a very basic level of support for union types in Dart.

There are several different ways to define the notion of a union type. Here is how to understand union types in the context of this package:

A union type is a type which is created by taking the union of several other types. At the conceptual level, we could use a notation like `int | String` to denote the union of the types `int` and `String`. (Note that this package does _not_ support new syntax for union types, this notation is only used to talk about the meaning of union types.) The basic semantics of a union type is that an object has the union type iff it has any of the types that we're taking the union of. For example, `1` has type `int | String`, and so does `'Hello'`.

This package supports union types that are **untagged**: There is no wrapper object or any other kind of run-time entity that keeps track of the operand type which was used to justify the typing of a given object. So if you have an expression of type `Object | num` and the value has run-time type `int` then you can't tell whether it's considered to have that union type because it's a `num`, or because it's an `Object`.

The kind of union type which is supported by this package does not have any of the algebraic properties that one would normally expect. In particular, there is no support for computing the traditional subtype relationships (such that `int | String` is the same type as `String | int`, and `int` and `String` are both subtypes of `int | String`, etc). Similarly, there is no support for detecting (and acting on) the otherwise standard property that `Object | num` is the same as `Object`.

Those properties would certainly be supported by an actual language mechanism, but this package just provides a very simple version of union types where these algebraic properties are considered unknown. In general, these union types are unrelated, except for standard covariance (e.g., `int | Car | Never` is a subtype of `num | Vehicle | String`, assuming that `Car` is a subtype of `Vehicle`).

Now please forget about the nice, conceptual notation `T1 | T2`. The actual notation for that union type with this package is `Union2<T1, T2>`. For example:

```dart
import 'package:inline_union_type/inline_union_type.dart';

int f(Union2<int, String> x) {
  return x.split(
    (i) => i + 1,
    (s) => s.length,
  );
}

void main() {
  print(f(Union2<int, String>.from1(1)));
  print(f(Union2<int, String>.from2('Hello')));
}
```

