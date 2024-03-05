// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Thrown when an invalid union type value is detected.
///
/// An expression whose static type is a union type of the form
/// `UnionK<X1, ... XK>` and whose value does not have any of the types
/// `X1` .. `XK` is an _invalid_ union type value. This exception is used
/// to report that such a value has been encountered.
class InvalidUnionTypeException implements Exception {
  /// Description of the invalid union type.
  final String type;
  final Object? value;

  InvalidUnionTypeException(this.type, this.value);

  @override
  String toString() => '$type: value has type ${value.runtimeType}';
}

/// Emulate the union of the types [X1] and [X2].
extension type Union2<X1, X2>._(Object? value) {
  /// Create a [Union2] value from the first type argument.
  Union2.in1(X1 this.value);

  /// Create a [Union2] value from the second type argument.
  Union2.in2(X2 this.value);

  /// Return true iff this [Union2] has type [X1] or [X2].
  bool get isValid => value is X1 || value is X2;

  /// Return the [value] if it has type [X1], otherwise null.
  X1? get as1OrNull => value is X1 ? value as X1 : null;

  /// Return the [value] if it has type [X2], otherwise null.
  X2? get as2OrNull => value is X2 ? value as X2 : null;

  /// Return the [value] if it has type [X1], otherwise throw.
  X1 get as1 => value as X1;

  /// Return the [value] if it has type [X2], otherwise throw.
  X2 get as2 => value as X2;

  /// Return type iff the [value] has type [X1].
  bool get is1 => value is X1;

  /// Return type iff the [value] has type [X2].
  bool get is2 => value is X2;

  R split<R>(R Function(X1) on1, R Function(X2) on2) {
    var v = value;
    if (v is X1) return on1(v);
    if (v is X2) return on2(v);
    throw InvalidUnionTypeException(
      "Union2<$X1, $X2>",
      value,
    );
  }

  R? splitNamed<R>({
    R Function(X1)? on1,
    R Function(X2)? on2,
    R Function(Object?)? onOther,
    R Function(Object?)? onInvalid,
  }) {
    var v = value;
    if (v is X1) return (on1 ?? onOther)?.call(v);
    if (v is X2) return (on2 ?? onOther)?.call(v);
    if (onInvalid != null) return onInvalid(v);
    throw InvalidUnionTypeException(
      "Union2<$X1, $X2>",
      value,
    );
  }
}

/// Emulate the union of the types [X1], [X2], and [X3].
extension type Union3<X1, X2, X3>._(Object? value) {
  /// Create a [Union3] value from the first type argument.
  Union3.in1(X1 this.value);

  /// Create a [Union3] value from the second type argument.
  Union3.in2(X2 this.value);

  /// Create a [Union3] value from the third type argument.
  Union3.in3(X3 this.value);

  /// Return true iff this [Union3] has a type in [X1] .. [X3].
  bool get isValid => value is X1 || value is X2 || value is X3;

  /// Return the [value] if it has type [X1], otherwise null.
  X1? get as1OrNull => value is X1 ? value as X1 : null;

  /// Return the [value] if it has type [X2], otherwise null.
  X2? get as2OrNull => value is X2 ? value as X2 : null;

  /// Return the [value] if it has type [X3], otherwise null.
  X3? get as3OrNull => value is X3 ? value as X3 : null;

  /// Return the [value] if it has type [X1], otherwise throw.
  X1 get as1 => value as X1;

  /// Return the [value] if it has type [X2], otherwise throw.
  X2 get as2 => value as X2;

  /// Return the [value] if it has type [X3], otherwise throw.
  X3 get as3 => value as X3;

  /// Return type iff the [value] has type [X1].
  bool get is1 => value is X1;

  /// Return type iff the [value] has type [X2].
  bool get is2 => value is X2;

  /// Return type iff the [value] has type [X3].
  bool get is3 => value is X3;

  R split<R>(
    R Function(X1) on1,
    R Function(X2) on2,
    R Function(X3) on3,
  ) {
    var v = value;
    if (v is X1) return on1(v);
    if (v is X2) return on2(v);
    if (v is X3) return on3(v);
    throw InvalidUnionTypeException(
      "Union3<$X1, $X2, $X3>",
      value,
    );
  }

  R? splitNamed<R>({
    R Function(X1)? on1,
    R Function(X2)? on2,
    R Function(X3)? on3,
    R Function(Object?)? onOther,
    R Function(Object?)? onInvalid,
  }) {
    var v = value;
    if (v is X1) return (on1 ?? onOther)?.call(v);
    if (v is X2) return (on2 ?? onOther)?.call(v);
    if (v is X3) return (on3 ?? onOther)?.call(v);
    if (onInvalid != null) return onInvalid(v);
    throw InvalidUnionTypeException(
      "Union3<$X1, $X2, $X3>",
      value,
    );
  }
}

/// Emulate the union of the types [X1] .. [X4].
extension type Union4<X1, X2, X3, X4>._(Object? value) {
  /// Create a [Union4] value from the first type argument.
  Union4.in1(X1 this.value);

  /// Create a [Union4] value from the second type argument.
  Union4.in2(X2 this.value);

  /// Create a [Union4] value from the third type argument.
  Union4.in3(X3 this.value);

  /// Create a [Union4] value from the fourth type argument.
  Union4.in4(X4 this.value);

  /// Return true iff this [Union4] has a type in [X1] .. [X4].
  bool get isValid => value is X1 || value is X2 || value is X3 || value is X4;

  /// Return the [value] if it has type [X1], otherwise null.
  X1? get as1OrNull => value is X1 ? value as X1 : null;

  /// Return the [value] if it has type [X2], otherwise null.
  X2? get as2OrNull => value is X2 ? value as X2 : null;

  /// Return the [value] if it has type [X3], otherwise null.
  X3? get as3OrNull => value is X3 ? value as X3 : null;

  /// Return the [value] if it has type [X4], otherwise null.
  X4? get as4OrNull => value is X4 ? value as X4 : null;

  /// Return the [value] if it has type [X1], otherwise throw.
  X1 get as1 => value as X1;

  /// Return the [value] if it has type [X2], otherwise throw.
  X2 get as2 => value as X2;

  /// Return the [value] if it has type [X3], otherwise throw.
  X3 get as3 => value as X3;

  /// Return the [value] if it has type [X4], otherwise throw.
  X4 get as4 => value as X4;

  /// Return type iff the [value] has type [X1].
  bool get is1 => value is X1;

  /// Return type iff the [value] has type [X2].
  bool get is2 => value is X2;

  /// Return type iff the [value] has type [X3].
  bool get is3 => value is X3;

  /// Return type iff the [value] has type [X4].
  bool get is4 => value is X4;

  R split<R>(
    R Function(X1) on1,
    R Function(X2) on2,
    R Function(X3) on3,
    R Function(X4) on4,
  ) {
    var v = value;
    if (v is X1) return on1(v);
    if (v is X2) return on2(v);
    if (v is X3) return on3(v);
    if (v is X4) return on4(v);
    throw InvalidUnionTypeException(
      "Union4<$X1, $X2, $X3, $X4>",
      value,
    );
  }

  R? splitNamed<R>({
    R Function(X1)? on1,
    R Function(X2)? on2,
    R Function(X3)? on3,
    R Function(X4)? on4,
    R Function(Object?)? onOther,
    R Function(Object?)? onInvalid,
  }) {
    var v = value;
    if (v is X1) return (on1 ?? onOther)?.call(v);
    if (v is X2) return (on2 ?? onOther)?.call(v);
    if (v is X3) return (on3 ?? onOther)?.call(v);
    if (v is X4) return (on4 ?? onOther)?.call(v);
    if (onInvalid != null) return onInvalid(v);
    throw InvalidUnionTypeException(
      "Union4<$X1, $X2, $X3, $X4>",
      value,
    );
  }
}

/// Emulate the union of the types [X1] .. [X5].
extension type Union5<X1, X2, X3, X4, X5>._(Object? value) {
  /// Create a [Union5] value from the first type argument.
  Union5.in1(X1 this.value);

  /// Create a [Union5] value from the second type argument.
  Union5.in2(X2 this.value);

  /// Create a [Union5] value from the third type argument.
  Union5.in3(X3 this.value);

  /// Create a [Union5] value from the fourth type argument.
  Union5.in4(X4 this.value);

  /// Create a [Union5] value from the fifth type argument.
  Union5.in5(X5 this.value);

  /// Return true iff this [Union5] has a type in [X1] .. [X5].
  bool get isValid =>
      value is X1 || value is X2 || value is X3 || value is X4 || value is X5;

  /// Return the [value] if it has type [X1], otherwise null.
  X1? get as1OrNull => value is X1 ? value as X1 : null;

  /// Return the [value] if it has type [X2], otherwise null.
  X2? get as2OrNull => value is X2 ? value as X2 : null;

  /// Return the [value] if it has type [X3], otherwise null.
  X3? get as3OrNull => value is X3 ? value as X3 : null;

  /// Return the [value] if it has type [X4], otherwise null.
  X4? get as4OrNull => value is X4 ? value as X4 : null;

  /// Return the [value] if it has type [X5], otherwise null.
  X5? get as5OrNull => value is X5 ? value as X5 : null;

  /// Return the [value] if it has type [X1], otherwise throw.
  X1 get as1 => value as X1;

  /// Return the [value] if it has type [X2], otherwise throw.
  X2 get as2 => value as X2;

  /// Return the [value] if it has type [X3], otherwise throw.
  X3 get as3 => value as X3;

  /// Return the [value] if it has type [X4], otherwise throw.
  X4 get as4 => value as X4;

  /// Return the [value] if it has type [X5], otherwise throw.
  X5 get as5 => value as X5;

  /// Return type iff the [value] has type [X1].
  bool get is1 => value is X1;

  /// Return type iff the [value] has type [X2].
  bool get is2 => value is X2;

  /// Return type iff the [value] has type [X3].
  bool get is3 => value is X3;

  /// Return type iff the [value] has type [X4].
  bool get is4 => value is X4;

  /// Return type iff the [value] has type [X5].
  bool get is5 => value is X5;

  R split<R>(
    R Function(X1) on1,
    R Function(X2) on2,
    R Function(X3) on3,
    R Function(X4) on4,
    R Function(X5) on5,
  ) {
    var v = value;
    if (v is X1) return on1(v);
    if (v is X2) return on2(v);
    if (v is X3) return on3(v);
    if (v is X4) return on4(v);
    if (v is X5) return on5(v);
    throw InvalidUnionTypeException(
      "Union5<$X1, $X2, $X3, $X4, $X5>",
      value,
    );
  }

  R? splitNamed<R>({
    R Function(X1)? on1,
    R Function(X2)? on2,
    R Function(X3)? on3,
    R Function(X4)? on4,
    R Function(X5)? on5,
    R Function(Object?)? onOther,
    R Function(Object?)? onInvalid,
  }) {
    var v = value;
    if (v is X1) return (on1 ?? onOther)?.call(v);
    if (v is X2) return (on2 ?? onOther)?.call(v);
    if (v is X3) return (on3 ?? onOther)?.call(v);
    if (v is X4) return (on4 ?? onOther)?.call(v);
    if (v is X5) return (on5 ?? onOther)?.call(v);
    if (onInvalid != null) return onInvalid(v);
    throw InvalidUnionTypeException(
      "Union5<$X1, $X2, $X3, $X4, $X5>",
      value,
    );
  }
}

/// Emulate the union of the types [X1] .. [X6].
extension type Union6<X1, X2, X3, X4, X5, X6>._(Object? value) {
  /// Create a [Union6] value from the first type argument.
  Union6.in1(X1 this.value);

  /// Create a [Union6] value from the second type argument.
  Union6.in2(X2 this.value);

  /// Create a [Union6] value from the third type argument.
  Union6.in3(X3 this.value);

  /// Create a [Union6] value from the fourth type argument.
  Union6.in4(X4 this.value);

  /// Create a [Union6] value from the fifth type argument.
  Union6.in5(X5 this.value);

  /// Create a [Union6] value from the sixth type argument.
  Union6.in6(X6 this.value);

  /// Return true iff this [Union6] has a type in [X1] .. [X6].
  bool get isValid =>
      value is X1 ||
      value is X2 ||
      value is X3 ||
      value is X4 ||
      value is X5 ||
      value is X6;

  /// Return the [value] if it has type [X1], otherwise null.
  X1? get as1OrNull => value is X1 ? value as X1 : null;

  /// Return the [value] if it has type [X2], otherwise null.
  X2? get as2OrNull => value is X2 ? value as X2 : null;

  /// Return the [value] if it has type [X3], otherwise null.
  X3? get as3OrNull => value is X3 ? value as X3 : null;

  /// Return the [value] if it has type [X4], otherwise null.
  X4? get as4OrNull => value is X4 ? value as X4 : null;

  /// Return the [value] if it has type [X5], otherwise null.
  X5? get as5OrNull => value is X5 ? value as X5 : null;

  /// Return the [value] if it has type [X6], otherwise null.
  X6? get as6OrNull => value is X6 ? value as X6 : null;

  /// Return the [value] if it has type [X1], otherwise throw.
  X1 get as1 => value as X1;

  /// Return the [value] if it has type [X2], otherwise throw.
  X2 get as2 => value as X2;

  /// Return the [value] if it has type [X3], otherwise throw.
  X3 get as3 => value as X3;

  /// Return the [value] if it has type [X4], otherwise throw.
  X4 get as4 => value as X4;

  /// Return the [value] if it has type [X5], otherwise throw.
  X5 get as5 => value as X5;

  /// Return the [value] if it has type [X6], otherwise throw.
  X6 get as6 => value as X6;

  /// Return type iff the [value] has type [X1].
  bool get is1 => value is X1;

  /// Return type iff the [value] has type [X2].
  bool get is2 => value is X2;

  /// Return type iff the [value] has type [X3].
  bool get is3 => value is X3;

  /// Return type iff the [value] has type [X4].
  bool get is4 => value is X4;

  /// Return type iff the [value] has type [X5].
  bool get is5 => value is X5;

  /// Return type iff the [value] has type [X6].
  bool get is6 => value is X6;

  R split<R>(
    R Function(X1) on1,
    R Function(X2) on2,
    R Function(X3) on3,
    R Function(X4) on4,
    R Function(X5) on5,
    R Function(X6) on6,
  ) {
    var v = value;
    if (v is X1) return on1(v);
    if (v is X2) return on2(v);
    if (v is X3) return on3(v);
    if (v is X4) return on4(v);
    if (v is X5) return on5(v);
    if (v is X6) return on6(v);
    throw InvalidUnionTypeException(
      "Union6<$X1, $X2, $X3, $X4, $X5, $X6>",
      value,
    );
  }

  R? splitNamed<R>({
    R Function(X1)? on1,
    R Function(X2)? on2,
    R Function(X3)? on3,
    R Function(X4)? on4,
    R Function(X5)? on5,
    R Function(X6)? on6,
    R Function(Object?)? onOther,
    R Function(Object?)? onInvalid,
  }) {
    var v = value;
    if (v is X1) return (on1 ?? onOther)?.call(v);
    if (v is X2) return (on2 ?? onOther)?.call(v);
    if (v is X3) return (on3 ?? onOther)?.call(v);
    if (v is X4) return (on4 ?? onOther)?.call(v);
    if (v is X5) return (on5 ?? onOther)?.call(v);
    if (v is X6) return (on6 ?? onOther)?.call(v);
    if (onInvalid != null) return onInvalid(v);
    throw InvalidUnionTypeException(
      "Union6<$X1, $X2, $X3, $X4, $X5, $X6>",
      value,
    );
  }
}

/// Emulate the union of the types [X1] .. [X7].
extension type Union7<X1, X2, X3, X4, X5, X6, X7>._(Object? value) {
  /// Create a [Union7] value from the first type argument.
  Union7.in1(X1 this.value);

  /// Create a [Union7] value from the second type argument.
  Union7.in2(X2 this.value);

  /// Create a [Union7] value from the third type argument.
  Union7.in3(X3 this.value);

  /// Create a [Union7] value from the fourth type argument.
  Union7.in4(X4 this.value);

  /// Create a [Union7] value from the fifth type argument.
  Union7.in5(X5 this.value);

  /// Create a [Union7] value from the sixth type argument.
  Union7.in6(X6 this.value);

  /// Create a [Union7] value from the seventh type argument.
  Union7.in7(X7 this.value);

  /// Return true iff this [Union7] has a type in [X1] .. [X7].
  bool get isValid =>
      value is X1 ||
      value is X2 ||
      value is X3 ||
      value is X4 ||
      value is X5 ||
      value is X6 ||
      value is X7;

  /// Return the [value] if it has type [X1], otherwise null.
  X1? get as1OrNull => value is X1 ? value as X1 : null;

  /// Return the [value] if it has type [X2], otherwise null.
  X2? get as2OrNull => value is X2 ? value as X2 : null;

  /// Return the [value] if it has type [X3], otherwise null.
  X3? get as3OrNull => value is X3 ? value as X3 : null;

  /// Return the [value] if it has type [X4], otherwise null.
  X4? get as4OrNull => value is X4 ? value as X4 : null;

  /// Return the [value] if it has type [X5], otherwise null.
  X5? get as5OrNull => value is X5 ? value as X5 : null;

  /// Return the [value] if it has type [X6], otherwise null.
  X6? get as6OrNull => value is X6 ? value as X6 : null;

  /// Return the [value] if it has type [X7], otherwise null.
  X7? get as7OrNull => value is X7 ? value as X7 : null;

  /// Return the [value] if it has type [X1], otherwise throw.
  X1 get as1 => value as X1;

  /// Return the [value] if it has type [X2], otherwise throw.
  X2 get as2 => value as X2;

  /// Return the [value] if it has type [X3], otherwise throw.
  X3 get as3 => value as X3;

  /// Return the [value] if it has type [X4], otherwise throw.
  X4 get as4 => value as X4;

  /// Return the [value] if it has type [X5], otherwise throw.
  X5 get as5 => value as X5;

  /// Return the [value] if it has type [X6], otherwise throw.
  X6 get as6 => value as X6;

  /// Return the [value] if it has type [X7], otherwise throw.
  X7 get as7 => value as X7;

  /// Return type iff the [value] has type [X1].
  bool get is1 => value is X1;

  /// Return type iff the [value] has type [X2].
  bool get is2 => value is X2;

  /// Return type iff the [value] has type [X3].
  bool get is3 => value is X3;

  /// Return type iff the [value] has type [X4].
  bool get is4 => value is X4;

  /// Return type iff the [value] has type [X5].
  bool get is5 => value is X5;

  /// Return type iff the [value] has type [X6].
  bool get is6 => value is X6;

  /// Return type iff the [value] has type [X7].
  bool get is7 => value is X7;

  R split<R>(
    R Function(X1) on1,
    R Function(X2) on2,
    R Function(X3) on3,
    R Function(X4) on4,
    R Function(X5) on5,
    R Function(X6) on6,
    R Function(X7) on7,
  ) {
    var v = value;
    if (v is X1) return on1(v);
    if (v is X2) return on2(v);
    if (v is X3) return on3(v);
    if (v is X4) return on4(v);
    if (v is X5) return on5(v);
    if (v is X6) return on6(v);
    if (v is X7) return on7(v);
    throw InvalidUnionTypeException(
      "Union7<$X1, $X2, $X3, $X4, $X5, $X6, $X7>",
      value,
    );
  }

  R? splitNamed<R>({
    R Function(X1)? on1,
    R Function(X2)? on2,
    R Function(X3)? on3,
    R Function(X4)? on4,
    R Function(X5)? on5,
    R Function(X6)? on6,
    R Function(X7)? on7,
    R Function(Object?)? onOther,
    R Function(Object?)? onInvalid,
  }) {
    var v = value;
    if (v is X1) return (on1 ?? onOther)?.call(v);
    if (v is X2) return (on2 ?? onOther)?.call(v);
    if (v is X3) return (on3 ?? onOther)?.call(v);
    if (v is X4) return (on4 ?? onOther)?.call(v);
    if (v is X5) return (on5 ?? onOther)?.call(v);
    if (v is X6) return (on6 ?? onOther)?.call(v);
    if (v is X7) return (on7 ?? onOther)?.call(v);
    if (onInvalid != null) return onInvalid(v);
    throw InvalidUnionTypeException(
      "Union7<$X1, $X2, $X3, $X4, $X5, $X6, $X7>",
      value,
    );
  }
}

/// Emulate the union of the types [X1] .. [X8].
extension type Union8<X1, X2, X3, X4, X5, X6, X7, X8>._(Object? value) {
  /// Create a [Union8] value from the first type argument.
  Union8.in1(X1 this.value);

  /// Create a [Union8] value from the second type argument.
  Union8.in2(X2 this.value);

  /// Create a [Union8] value from the third type argument.
  Union8.in3(X3 this.value);

  /// Create a [Union8] value from the fourth type argument.
  Union8.in4(X4 this.value);

  /// Create a [Union8] value from the fifth type argument.
  Union8.in5(X5 this.value);

  /// Create a [Union8] value from the sixth type argument.
  Union8.in6(X6 this.value);

  /// Create a [Union8] value from the seventh type argument.
  Union8.in7(X7 this.value);

  /// Create a [Union8] value from the eighth type argument.
  Union8.in8(X8 this.value);

  /// Return true iff this [Union8] has a type in [X1] .. [X8].
  bool get isValid =>
      value is X1 ||
      value is X2 ||
      value is X3 ||
      value is X4 ||
      value is X5 ||
      value is X6 ||
      value is X7 ||
      value is X8;

  /// Return the [value] if it has type [X1], otherwise null.
  X1? get as1OrNull => value is X1 ? value as X1 : null;

  /// Return the [value] if it has type [X2], otherwise null.
  X2? get as2OrNull => value is X2 ? value as X2 : null;

  /// Return the [value] if it has type [X3], otherwise null.
  X3? get as3OrNull => value is X3 ? value as X3 : null;

  /// Return the [value] if it has type [X4], otherwise null.
  X4? get as4OrNull => value is X4 ? value as X4 : null;

  /// Return the [value] if it has type [X5], otherwise null.
  X5? get as5OrNull => value is X5 ? value as X5 : null;

  /// Return the [value] if it has type [X6], otherwise null.
  X6? get as6OrNull => value is X6 ? value as X6 : null;

  /// Return the [value] if it has type [X7], otherwise null.
  X7? get as7OrNull => value is X7 ? value as X7 : null;

  /// Return the [value] if it has type [X8], otherwise null.
  X8? get as8OrNull => value is X8 ? value as X8 : null;

  /// Return the [value] if it has type [X1], otherwise throw.
  X1 get as1 => value as X1;

  /// Return the [value] if it has type [X2], otherwise throw.
  X2 get as2 => value as X2;

  /// Return the [value] if it has type [X3], otherwise throw.
  X3 get as3 => value as X3;

  /// Return the [value] if it has type [X4], otherwise throw.
  X4 get as4 => value as X4;

  /// Return the [value] if it has type [X5], otherwise throw.
  X5 get as5 => value as X5;

  /// Return the [value] if it has type [X6], otherwise throw.
  X6 get as6 => value as X6;

  /// Return the [value] if it has type [X7], otherwise throw.
  X7 get as7 => value as X7;

  /// Return the [value] if it has type [X8], otherwise throw.
  X8 get as8 => value as X8;

  /// Return type iff the [value] has type [X1].
  bool get is1 => value is X1;

  /// Return type iff the [value] has type [X2].
  bool get is2 => value is X2;

  /// Return type iff the [value] has type [X3].
  bool get is3 => value is X3;

  /// Return type iff the [value] has type [X4].
  bool get is4 => value is X4;

  /// Return type iff the [value] has type [X5].
  bool get is5 => value is X5;

  /// Return type iff the [value] has type [X6].
  bool get is6 => value is X6;

  /// Return type iff the [value] has type [X7].
  bool get is7 => value is X7;

  /// Return type iff the [value] has type [X8].
  bool get is8 => value is X8;

  R split<R>(
    R Function(X1) on1,
    R Function(X2) on2,
    R Function(X3) on3,
    R Function(X4) on4,
    R Function(X5) on5,
    R Function(X6) on6,
    R Function(X7) on7,
    R Function(X8) on8,
  ) {
    var v = value;
    if (v is X1) return on1(v);
    if (v is X2) return on2(v);
    if (v is X3) return on3(v);
    if (v is X4) return on4(v);
    if (v is X5) return on5(v);
    if (v is X6) return on6(v);
    if (v is X7) return on7(v);
    if (v is X8) return on8(v);
    throw InvalidUnionTypeException(
      "Union8<$X1, $X2, $X3, $X4, $X5, $X6, $X7, $X8>",
      value,
    );
  }

  R? splitNamed<R>({
    R Function(X1)? on1,
    R Function(X2)? on2,
    R Function(X3)? on3,
    R Function(X4)? on4,
    R Function(X5)? on5,
    R Function(X6)? on6,
    R Function(X7)? on7,
    R Function(X8)? on8,
    R Function(Object?)? onOther,
    R Function(Object?)? onInvalid,
  }) {
    var v = value;
    if (v is X1) return (on1 ?? onOther)?.call(v);
    if (v is X2) return (on2 ?? onOther)?.call(v);
    if (v is X3) return (on3 ?? onOther)?.call(v);
    if (v is X4) return (on4 ?? onOther)?.call(v);
    if (v is X5) return (on5 ?? onOther)?.call(v);
    if (v is X6) return (on6 ?? onOther)?.call(v);
    if (v is X7) return (on7 ?? onOther)?.call(v);
    if (v is X8) return (on8 ?? onOther)?.call(v);
    if (onInvalid != null) return onInvalid(v);
    throw InvalidUnionTypeException(
      "Union8<$X1, $X2, $X3, $X4, $X5, $X6, $X7, $X8>",
      value,
    );
  }
}

/// Emulate the union of the types [X1] .. [X9].
extension type Union9<X1, X2, X3, X4, X5, X6, X7, X8, X9>._(Object? value) {
  /// Create a [Union9] value from the first type argument.
  Union9.in1(X1 this.value);

  /// Create a [Union9] value from the second type argument.
  Union9.in2(X2 this.value);

  /// Create a [Union9] value from the third type argument.
  Union9.in3(X3 this.value);

  /// Create a [Union9] value from the fourth type argument.
  Union9.in4(X4 this.value);

  /// Create a [Union9] value from the fifth type argument.
  Union9.in5(X5 this.value);

  /// Create a [Union9] value from the sixth type argument.
  Union9.in6(X6 this.value);

  /// Create a [Union9] value from the seventh type argument.
  Union9.in7(X7 this.value);

  /// Create a [Union9] value from the eighth type argument.
  Union9.in8(X8 this.value);

  /// Create a [Union9] value from the ninth type argument.
  Union9.in9(X9 this.value);

  /// Return true iff this [Union9] has a type in [X1] .. [X9].
  bool get isValid =>
      value is X1 ||
      value is X2 ||
      value is X3 ||
      value is X4 ||
      value is X5 ||
      value is X6 ||
      value is X7 ||
      value is X8 ||
      value is X9;

  /// Return the [value] if it has type [X1], otherwise null.
  X1? get as1OrNull => value is X1 ? value as X1 : null;

  /// Return the [value] if it has type [X2], otherwise null.
  X2? get as2OrNull => value is X2 ? value as X2 : null;

  /// Return the [value] if it has type [X3], otherwise null.
  X3? get as3OrNull => value is X3 ? value as X3 : null;

  /// Return the [value] if it has type [X4], otherwise null.
  X4? get as4OrNull => value is X4 ? value as X4 : null;

  /// Return the [value] if it has type [X5], otherwise null.
  X5? get as5OrNull => value is X5 ? value as X5 : null;

  /// Return the [value] if it has type [X6], otherwise null.
  X6? get as6OrNull => value is X6 ? value as X6 : null;

  /// Return the [value] if it has type [X7], otherwise null.
  X7? get as7OrNull => value is X7 ? value as X7 : null;

  /// Return the [value] if it has type [X8], otherwise null.
  X8? get as8OrNull => value is X8 ? value as X8 : null;

  /// Return the [value] if it has type [X9], otherwise null.
  X9? get as9OrNull => value is X9 ? value as X9 : null;

  /// Return the [value] if it has type [X1], otherwise throw.
  X1 get as1 => value as X1;

  /// Return the [value] if it has type [X2], otherwise throw.
  X2 get as2 => value as X2;

  /// Return the [value] if it has type [X3], otherwise throw.
  X3 get as3 => value as X3;

  /// Return the [value] if it has type [X4], otherwise throw.
  X4 get as4 => value as X4;

  /// Return the [value] if it has type [X5], otherwise throw.
  X5 get as5 => value as X5;

  /// Return the [value] if it has type [X6], otherwise throw.
  X6 get as6 => value as X6;

  /// Return the [value] if it has type [X7], otherwise throw.
  X7 get as7 => value as X7;

  /// Return the [value] if it has type [X8], otherwise throw.
  X8 get as8 => value as X8;

  /// Return the [value] if it has type [X9], otherwise throw.
  X9 get as9 => value as X9;

  /// Return type iff the [value] has type [X1].
  bool get is1 => value is X1;

  /// Return type iff the [value] has type [X2].
  bool get is2 => value is X2;

  /// Return type iff the [value] has type [X3].
  bool get is3 => value is X3;

  /// Return type iff the [value] has type [X4].
  bool get is4 => value is X4;

  /// Return type iff the [value] has type [X5].
  bool get is5 => value is X5;

  /// Return type iff the [value] has type [X6].
  bool get is6 => value is X6;

  /// Return type iff the [value] has type [X7].
  bool get is7 => value is X7;

  /// Return type iff the [value] has type [X8].
  bool get is8 => value is X8;

  /// Return type iff the [value] has type [X9].
  bool get is9 => value is X9;

  R split<R>(
    R Function(X1) on1,
    R Function(X2) on2,
    R Function(X3) on3,
    R Function(X4) on4,
    R Function(X5) on5,
    R Function(X6) on6,
    R Function(X7) on7,
    R Function(X8) on8,
    R Function(X9) on9,
  ) {
    var v = value;
    if (v is X1) return on1(v);
    if (v is X2) return on2(v);
    if (v is X3) return on3(v);
    if (v is X4) return on4(v);
    if (v is X5) return on5(v);
    if (v is X6) return on6(v);
    if (v is X7) return on7(v);
    if (v is X8) return on8(v);
    if (v is X9) return on9(v);
    throw InvalidUnionTypeException(
      "Union9<$X1, $X2, $X3, $X4, $X5, $X6, $X7, $X8, $X9>",
      value,
    );
  }

  R? splitNamed<R>({
    R Function(X1)? on1,
    R Function(X2)? on2,
    R Function(X3)? on3,
    R Function(X4)? on4,
    R Function(X5)? on5,
    R Function(X6)? on6,
    R Function(X7)? on7,
    R Function(X8)? on8,
    R Function(X9)? on9,
    R Function(Object?)? onOther,
    R Function(Object?)? onInvalid,
  }) {
    var v = value;
    if (v is X1) return (on1 ?? onOther)?.call(v);
    if (v is X2) return (on2 ?? onOther)?.call(v);
    if (v is X3) return (on3 ?? onOther)?.call(v);
    if (v is X4) return (on4 ?? onOther)?.call(v);
    if (v is X5) return (on5 ?? onOther)?.call(v);
    if (v is X6) return (on6 ?? onOther)?.call(v);
    if (v is X7) return (on7 ?? onOther)?.call(v);
    if (v is X8) return (on8 ?? onOther)?.call(v);
    if (v is X9) return (on9 ?? onOther)?.call(v);
    if (onInvalid != null) return onInvalid(v);
    throw InvalidUnionTypeException(
      "Union9<$X1, $X2, $X3, $X4, $X5, $X6, $X7, $X8, $X9>",
      value,
    );
  }
}

/// Extension on any type that allows it to be coerced to a union type.
///
/// The extension provides getters named `uNM` where `N` is the arity
/// of the union type and `M` is the number of the type argument which
/// is used for the given value.
///
/// For example `1.u21` is an expression of type `Union2<int, Never>`
/// and `1.u22` is an expression of type `Union2<Never, int>`. Since
/// `Never` is a subtype of all other types, `1.u21` can be used where
/// an expression of type `Union2<int, T>` is required, for any `T`.
extension UnionInjectExtension<X> on X {
  Union2<X, Never> get u21 => Union2.in1(this);
  Union2<Never, X> get u22 => Union2.in2(this);
  Union3<X, Never, Never> get u31 => Union3.in1(this);
  Union3<Never, X, Never> get u32 => Union3.in2(this);
  Union3<Never, Never, X> get u33 => Union3.in3(this);
  Union4<X, Never, Never, Never> get u41 => Union4.in1(this);
  Union4<Never, X, Never, Never> get u42 => Union4.in2(this);
  Union4<Never, Never, X, Never> get u43 => Union4.in3(this);
  Union4<Never, Never, Never, X> get u44 => Union4.in4(this);
  Union5<X, Never, Never, Never, Never> get u51 => Union5.in1(this);
  Union5<Never, X, Never, Never, Never> get u52 => Union5.in2(this);
  Union5<Never, Never, X, Never, Never> get u53 => Union5.in3(this);
  Union5<Never, Never, Never, X, Never> get u54 => Union5.in4(this);
  Union5<Never, Never, Never, Never, X> get u55 => Union5.in5(this);
  Union6<X, Never, Never, Never, Never, Never> get u61 => Union6.in1(this);
  Union6<Never, X, Never, Never, Never, Never> get u62 => Union6.in2(this);
  Union6<Never, Never, X, Never, Never, Never> get u63 => Union6.in3(this);
  Union6<Never, Never, Never, X, Never, Never> get u64 => Union6.in4(this);
  Union6<Never, Never, Never, Never, X, Never> get u65 => Union6.in5(this);
  Union6<Never, Never, Never, Never, Never, X> get u66 => Union6.in6(this);
  Union7<X, Never, Never, Never, Never, Never, Never> get u71 =>
      Union7.in1(this);
  Union7<Never, X, Never, Never, Never, Never, Never> get u72 =>
      Union7.in2(this);
  Union7<Never, Never, X, Never, Never, Never, Never> get u73 =>
      Union7.in3(this);
  Union7<Never, Never, Never, X, Never, Never, Never> get u74 =>
      Union7.in4(this);
  Union7<Never, Never, Never, Never, X, Never, Never> get u75 =>
      Union7.in5(this);
  Union7<Never, Never, Never, Never, Never, X, Never> get u76 =>
      Union7.in6(this);
  Union7<Never, Never, Never, Never, Never, Never, X> get u77 =>
      Union7.in7(this);
  Union8<X, Never, Never, Never, Never, Never, Never, Never> get u81 =>
      Union8.in1(this);
  Union8<Never, X, Never, Never, Never, Never, Never, Never> get u82 =>
      Union8.in2(this);
  Union8<Never, Never, X, Never, Never, Never, Never, Never> get u83 =>
      Union8.in3(this);
  Union8<Never, Never, Never, X, Never, Never, Never, Never> get u84 =>
      Union8.in4(this);
  Union8<Never, Never, Never, Never, X, Never, Never, Never> get u85 =>
      Union8.in5(this);
  Union8<Never, Never, Never, Never, Never, X, Never, Never> get u86 =>
      Union8.in6(this);
  Union8<Never, Never, Never, Never, Never, Never, X, Never> get u87 =>
      Union8.in7(this);
  Union8<Never, Never, Never, Never, Never, Never, Never, X> get u88 =>
      Union8.in8(this);
  Union9<X, Never, Never, Never, Never, Never, Never, Never, Never> get u91 =>
      Union9.in1(this);
  Union9<Never, X, Never, Never, Never, Never, Never, Never, Never> get u92 =>
      Union9.in2(this);
  Union9<Never, Never, X, Never, Never, Never, Never, Never, Never> get u93 =>
      Union9.in3(this);
  Union9<Never, Never, Never, X, Never, Never, Never, Never, Never> get u94 =>
      Union9.in4(this);
  Union9<Never, Never, Never, Never, X, Never, Never, Never, Never> get u95 =>
      Union9.in5(this);
  Union9<Never, Never, Never, Never, Never, X, Never, Never, Never> get u96 =>
      Union9.in6(this);
  Union9<Never, Never, Never, Never, Never, Never, X, Never, Never> get u97 =>
      Union9.in7(this);
  Union9<Never, Never, Never, Never, Never, Never, Never, X, Never> get u98 =>
      Union9.in8(this);
  Union9<Never, Never, Never, Never, Never, Never, Never, Never, X> get u99 =>
      Union9.in9(this);
}
