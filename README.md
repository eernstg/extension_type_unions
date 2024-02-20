<!--
[![Build Status](https://github.com/eernstg/extension_type_unions/workflows/Dart%20CI/badge.svg)](https://github.com/lrhn/charcode/actions?query=workflow%3A"Dart+CI")
[![Pub](https://img.shields.io/pub/v/unline_union_type.svg)](https://pub.dev/packages/extension_type_unions)
[![package publisher](https://img.shields.io/pub/publisher/extension_type_unions.svg)](https://pub.dev/packages/extension_type_unions/publisher)
-->

# Extension Type Unions

Support for union types in Dart has been requested at least [since 2012](https://github.com/dart-lang/language/issues/1222). This repository provides a basic level of support for union types in Dart.

## Union Types, and the kind offered here

There are several different ways to define the notion of a union type. Here is how to understand union types in the context of this package:

A union type is a type which is created by taking the union of several other types. At the conceptual level, we could use a notation like `int | String` to denote the union of the types `int` and `String`. (Note that this package does _not_ support new syntax for union types, this notation is only used to talk about the meaning of union types.) The basic semantics of a union type is that an object has the union type iff it has any of the types that we're taking the union of. For example, `1` has type `int | String`, and so does `'Hello'`.

This package supports union types that are **untagged**: There is no wrapper object or any other kind of run-time entity that keeps track of the operand type which was used to justify the typing of a given object. So if you have an expression of type `Object | num` and the value has run-time type `int` then you can't tell whether it's considered to have that union type because it's a `num`, or because it's an `Object`.

The kind of union type which is supported by this package does not have any of the algebraic properties that one would normally expect. In particular, there is no support for computing the traditional subtype relationships (such that `int | String` is the same type as `String | int`, and `int` and `String` are both subtypes of `int | String`, etc). Similarly, there is no support for detecting (and acting on) the otherwise standard property that `Object | num` is the same as `Object`.

Those properties would certainly be supported by an actual language mechanism, but this package just provides a very simple version of union types where these algebraic properties are considered unknown. In general, these union types are unrelated, except for standard covariance (e.g., `int | Car | Never` is a subtype of `num | Vehicle | String`, assuming that `Car` is a subtype of `Vehicle`).

## Concrete syntax and example

Now please forget about the nice, conceptual notation `T1 | T2`. The actual notation for that union type with this package is `Union2<T1, T2>`. There is a generic extension type for each arity up to 9, that is `Union2, Union3, ... Union9`.

Here is an example showing how it can be used:

```dart
import 'package:extension_type_unions/extension_type_unions.dart';

int f(Union2<int, String> x) => x.split(
      (i) => i + 1,
      (s) => s.length,
    );

void main() {
  print(f(1.u21)); // '2'.
  print(f('Hello'.u22)); // '5'.
}
```

This example illustrates that this kind of union type can be used to declare that a particular formal parameter can be an `int` or a `String`, and nothing else, and it is then possible to pass actual arguments which are of type `int` or `String`, as long as they are explicitly marked as having the union type and being a particular operand (first or second, in this case) of that union type.

The method `split` is used to handle the different cases (when the value of `x` is actually an `int` respectively a `String`). It is safe in the sense that it accepts actual arguments for the operands of the union type; that is, the first argument is a function (a callback) that receives an argument of type `int`, and the second argument is a function that receives an argument of type `String`, and `split` is going to call the one that fits the actual `value`.

The extension getters `u21` and `u22` invoke the corresponding extension type constructors. For example, `1.u21` is the same thing as `Union2<int, Never>.in1(1)`, which may again be understood conceptually as "turn `1` into a value of type `int | Never`, using the first type in the union". Note that this is a subtype of `Union2<int, T>` for any type `T`, which makes it usable, e.g., where a `Union2<int, String>` is expected.

An alternative approach would be to use a plain type test:

```dart
int g(Union2<int, String> x) => switch (x.value) {
      int i => i + 1,
      String s => s.length,
      _ => throw "Unexpected type",
    };
```

This will run just fine, but there is no static type check on the cases: `x.value` has the type `Object?`, and there is no notification (error or warning) if we test for the wrong set of types (say, if we're testing for a `double` and for a `String`, and forget all about `int`).

## Extension Type implications

This package uses extension types in order to implement support for union types. This choice has a few important consequences.

First, there is no run-time cost associated with the use of these union types, compared to the situation where we use a much more general type (say, `dynamic`) and then pass actual arguments of type, say, `int` or `String`. Applied to the example from the previous section, we would get the following variant:

```dart
int h(dynamic x) => switch (x) {
      int() => x + 1,
      String() => x.length,
      _ => throw "Unexpected type",
    };
```

The approach that uses extension types is useful because (1) `g` is just as cheap as `h`, and (2) `g` gives rise to static type checks: It is an error to pass an actual argument to `g` which is not an `int` or a `String` (suitably wrapped up as a `Union2`).

(`f` is probably slightly more expensive than `g` and `h` because it includes the creation and invocation of function literals. However, `f` has better type safety and, arguably, better readability.)

The static type checks are strict, as usual, in that it is a compile-time error to pass, say, an argument of type `Union2<double, String>` to `f` or `g`. This means that we do keep track of the fact that `f` is intended to work on an `int` or on a `String`, and not on any other kind of object.

However, it is always possible to violate the encapsulation of an extension type by applying a type cast to it. This is the basic trade-off which is inherently a property of extension types: There is no wrapper object, we're just using the underlying representation object directly, and the extension type as such is erased and does not exist at run time (it is replaced by its representation type). Here is an example where we obtain an invalid value of type `Union2<int, String>`:

```dart
void main() {
  var invalid = true as Union2<int, String>; // No error here.
  print(invalid.isValid); // We can detect it manually: 'false'.
  try {
    invalid.split((_){}, (_){}); // Throws, because `invalid` is invalid.
  } catch (_) {
    print('Caught validity exception'); // Reached.
  }
}
```

This illustrates that a cast (`as`) to an extension type is possible (it succeeds at run time because the actual object is a `bool`, and the type of the `value` of the extension type is `Object?`). In other words, we can easily obtain an expression of type `Union2<int, String>` whose value isn't any of those two types.

However, the point is that this will only happen if the code uses a type cast, and for an organization or developer who is using 'extension_type_unions' to detect type mismatches, it shouldn't be too difficult to simply avoid having any such type casts.

Moreover, the extension type feature will be supported by a lint which will report the locations where such casts occur.

An alternative approach would be to use a regular class (rather than an extension type) to model each union type. The code would be identical, except that the words `extension type` would be replaced by `class` in the declaration of each class `Union1 .. Union9`, and the constructor would have to be specified in the more verbose syntax which is used for class constructors today. If we had done that then the use of union types would be considerably more expensive at run time, because every union type would be reified as an actual wrapper object.

On the other hand, we would have firm guarantees (no instance of a class `C` can be obtained without running a generative constructor of `C`, and the constructors of the `Union...` classes _do_ check that the given `value` has the required type), i.e., there would never exist an invalid union value. On the other hand, it would be a performance cost (time and space), and the assumption behind this package is that the trade-off associated with the use of extension types is more useful in practice.

## The type Json

This package includes an extension type named `Json` which is used to support an encoding which is typically used when a JSON term is parsed and modeled as an object structure that consists of lists, maps, and certain primitive values. In particular, `jsonDecode` in 'dart:convert' uses this encoding.

This could be modeled as a recursive union type, but not as a plain union type. For example, a `Json` typed value could be a `List<Json>` that contains elements of type `Json` which could in turn be `List<Json>`, and so on. This implies that we cannot describe `Json` as a simple union of other types.

```dart
// Assuming that Dart supports recursive typedefs (but it doesn't).
rec typedef Json =
    Null
  | bool
  | int
  | double
  | List<Json>
  | Map<String, Json>;
```

We could of course say that `Json` is just a plain union with operands `Null`, `bool`, `int`, `double`, `List<dynamic>`, and `Map<String, dynamic>`. However, if we do that then we haven't modeled the constraint that the contents of those collections must again be of type `Json`. So we could have, for example, `<dynamic>[#foo]`, which _should_ be prevented because we don't expect to encounter a `Symbol` in a JSON value.

It is not hard to express the recursive nature of these object graphs in terms of member signatures: We just make sure that a value of type `Json` is typed as a `Map<String, Json>` in the case where it is a map, and so on. This doesn't rely on any special type system magic. It just requires that each recursive type is supported by a corresponding extension type, because `Union6` won't suffice.

## Future extensions

If Dart adds support for [implicit constructors][] then we will be able to avoid the unwieldy syntax at sites where a given expression needs to get a union type:

[implicit constructors]: https://github.com/dart-lang/language/blob/main/working/0107%20-%20implicit-constructors/feature-specification.md

```dart
import 'package:extension_type_unions/extension_type_unions.dart';

int f(Union2<int, String> x) => x.split(
      (i) => i + 1,
      (s) => s.length,
    );

void main() {
  print(f(1)); // '2'.
  print(f('Hello')); // '5'.
}
```

This would work because an expression `e` of type `int` in a location where a `Union2<int, String>` is expected is implicitly rewritten as `Union2<int, String>.in1(e)` if `Union2.in1` is an implicit constructor. Similarly, `'Hello'` would be implicitly rewritten as `Union2<int, String>.in2('Hello')` if `Union2.in2` is implicit.
