// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
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

@inline
class Union2<X1, X2> {
  final Object? value;

  Union2.from1(X1 this.value);
  Union2.from2(X2 this.value);

  bool get isValid => value is X1 || value is X2;

  X1? get as1OrNull => value is X1 ? value as X1 : null;
  X2? get as2OrNull => value is X2 ? value as X2 : null;

  X1 get as1 => value as X1;
  X2 get as2 => value as X2;

  bool get is1 => value is X1;
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

@inline
class Union3<X1, X2, X3> {
  final Object? value;

  Union3.from1(X1 this.value);
  Union3.from2(X2 this.value);
  Union3.from3(X3 this.value);

  bool get isValid => value is X1 || value is X2 || value is X3;

  X1? get as1OrNull => value is X1 ? value as X1 : null;
  X2? get as2OrNull => value is X2 ? value as X2 : null;
  X3? get as3OrNull => value is X3 ? value as X3 : null;

  X1 get as1 => value as X1;
  X2 get as2 => value as X2;
  X3 get as3 => value as X3;

  bool get is1 => value is X1;
  bool get is2 => value is X2;
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

@inline
class Union4<X1, X2, X3, X4> {
  final Object? value;

  Union4.from1(X1 this.value);
  Union4.from2(X2 this.value);
  Union4.from3(X3 this.value);
  Union4.from4(X4 this.value);

  bool get isValid => value is X1 || value is X2 || value is X3 || value is X4;

  X1? get as1OrNull => value is X1 ? value as X1 : null;
  X2? get as2OrNull => value is X2 ? value as X2 : null;
  X3? get as3OrNull => value is X3 ? value as X3 : null;
  X4? get as4OrNull => value is X4 ? value as X4 : null;

  X1 get as1 => value as X1;
  X2 get as2 => value as X2;
  X3 get as3 => value as X3;
  X4 get as4 => value as X4;

  bool get is1 => value is X1;
  bool get is2 => value is X2;
  bool get is3 => value is X3;
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

@inline
class Union5<X1, X2, X3, X4, X5> {
  final Object? value;

  Union5.from1(X1 this.value);
  Union5.from2(X2 this.value);
  Union5.from3(X3 this.value);
  Union5.from4(X4 this.value);
  Union5.from5(X5 this.value);

  bool get isValid =>
      value is X1 || value is X2 || value is X3 || value is X4 || value is X5;

  X1? get as1OrNull => value is X1 ? value as X1 : null;
  X2? get as2OrNull => value is X2 ? value as X2 : null;
  X3? get as3OrNull => value is X3 ? value as X3 : null;
  X4? get as4OrNull => value is X4 ? value as X4 : null;
  X5? get as5OrNull => value is X5 ? value as X5 : null;

  X1 get as1 => value as X1;
  X2 get as2 => value as X2;
  X3 get as3 => value as X3;
  X4 get as4 => value as X4;
  X5 get as5 => value as X5;

  bool get is1 => value is X1;
  bool get is2 => value is X2;
  bool get is3 => value is X3;
  bool get is4 => value is X4;
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

@inline
class Union6<X1, X2, X3, X4, X5, X6> {
  final Object? value;

  Union6.from1(X1 this.value);
  Union6.from2(X2 this.value);
  Union6.from3(X3 this.value);
  Union6.from4(X4 this.value);
  Union6.from5(X5 this.value);
  Union6.from6(X6 this.value);

  bool get isValid =>
      value is X1 ||
      value is X2 ||
      value is X3 ||
      value is X4 ||
      value is X5 ||
      value is X6;

  X1? get as1OrNull => value is X1 ? value as X1 : null;
  X2? get as2OrNull => value is X2 ? value as X2 : null;
  X3? get as3OrNull => value is X3 ? value as X3 : null;
  X4? get as4OrNull => value is X4 ? value as X4 : null;
  X5? get as5OrNull => value is X5 ? value as X5 : null;
  X6? get as6OrNull => value is X6 ? value as X6 : null;

  X1 get as1 => value as X1;
  X2 get as2 => value as X2;
  X3 get as3 => value as X3;
  X4 get as4 => value as X4;
  X5 get as5 => value as X5;
  X6 get as6 => value as X6;

  bool get is1 => value is X1;
  bool get is2 => value is X2;
  bool get is3 => value is X3;
  bool get is4 => value is X4;
  bool get is5 => value is X5;
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

@inline
class Union7<X1, X2, X3, X4, X5, X6, X7> {
  final Object? value;

  Union7.from1(X1 this.value);
  Union7.from2(X2 this.value);
  Union7.from3(X3 this.value);
  Union7.from4(X4 this.value);
  Union7.from5(X5 this.value);
  Union7.from6(X6 this.value);
  Union7.from7(X7 this.value);

  bool get isValid =>
      value is X1 ||
      value is X2 ||
      value is X3 ||
      value is X4 ||
      value is X5 ||
      value is X6 ||
      value is X7;

  X1? get as1OrNull => value is X1 ? value as X1 : null;
  X2? get as2OrNull => value is X2 ? value as X2 : null;
  X3? get as3OrNull => value is X3 ? value as X3 : null;
  X4? get as4OrNull => value is X4 ? value as X4 : null;
  X5? get as5OrNull => value is X5 ? value as X5 : null;
  X6? get as6OrNull => value is X6 ? value as X6 : null;
  X7? get as7OrNull => value is X7 ? value as X7 : null;

  X1 get as1 => value as X1;
  X2 get as2 => value as X2;
  X3 get as3 => value as X3;
  X4 get as4 => value as X4;
  X5 get as5 => value as X5;
  X6 get as6 => value as X6;
  X7 get as7 => value as X7;

  bool get is1 => value is X1;
  bool get is2 => value is X2;
  bool get is3 => value is X3;
  bool get is4 => value is X4;
  bool get is5 => value is X5;
  bool get is6 => value is X6;
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

@inline
class Union8<X1, X2, X3, X4, X5, X6, X7, X8> {
  final Object? value;

  Union8.from1(X1 this.value);
  Union8.from2(X2 this.value);
  Union8.from3(X3 this.value);
  Union8.from4(X4 this.value);
  Union8.from5(X5 this.value);
  Union8.from6(X6 this.value);
  Union8.from7(X7 this.value);
  Union8.from8(X8 this.value);

  bool get isValid =>
      value is X1 ||
      value is X2 ||
      value is X3 ||
      value is X4 ||
      value is X5 ||
      value is X6 ||
      value is X7 ||
      value is X8;

  X1? get as1OrNull => value is X1 ? value as X1 : null;
  X2? get as2OrNull => value is X2 ? value as X2 : null;
  X3? get as3OrNull => value is X3 ? value as X3 : null;
  X4? get as4OrNull => value is X4 ? value as X4 : null;
  X5? get as5OrNull => value is X5 ? value as X5 : null;
  X6? get as6OrNull => value is X6 ? value as X6 : null;
  X7? get as7OrNull => value is X7 ? value as X7 : null;
  X8? get as8OrNull => value is X8 ? value as X8 : null;

  X1 get as1 => value as X1;
  X2 get as2 => value as X2;
  X3 get as3 => value as X3;
  X4 get as4 => value as X4;
  X5 get as5 => value as X5;
  X6 get as6 => value as X6;
  X7 get as7 => value as X7;
  X8 get as8 => value as X8;

  bool get is1 => value is X1;
  bool get is2 => value is X2;
  bool get is3 => value is X3;
  bool get is4 => value is X4;
  bool get is5 => value is X5;
  bool get is6 => value is X6;
  bool get is7 => value is X7;
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

@inline
class Union9<X1, X2, X3, X4, X5, X6, X7, X8, X9> {
  final Object? value;

  Union9.from1(X1 this.value);
  Union9.from2(X2 this.value);
  Union9.from3(X3 this.value);
  Union9.from4(X4 this.value);
  Union9.from5(X5 this.value);
  Union9.from6(X6 this.value);
  Union9.from7(X7 this.value);
  Union9.from8(X8 this.value);
  Union9.from9(X9 this.value);

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

  X1? get as1OrNull => value is X1 ? value as X1 : null;
  X2? get as2OrNull => value is X2 ? value as X2 : null;
  X3? get as3OrNull => value is X3 ? value as X3 : null;
  X4? get as4OrNull => value is X4 ? value as X4 : null;
  X5? get as5OrNull => value is X5 ? value as X5 : null;
  X6? get as6OrNull => value is X6 ? value as X6 : null;
  X7? get as7OrNull => value is X7 ? value as X7 : null;
  X8? get as8OrNull => value is X8 ? value as X8 : null;
  X9? get as9OrNull => value is X9 ? value as X9 : null;

  X1 get as1 => value as X1;
  X2 get as2 => value as X2;
  X3 get as3 => value as X3;
  X4 get as4 => value as X4;
  X5 get as5 => value as X5;
  X6 get as6 => value as X6;
  X7 get as7 => value as X7;
  X8 get as8 => value as X8;
  X9 get as9 => value as X9;

  bool get is1 => value is X1;
  bool get is2 => value is X2;
  bool get is3 => value is X3;
  bool get is4 => value is X4;
  bool get is5 => value is X5;
  bool get is6 => value is X6;
  bool get is7 => value is X7;
  bool get is8 => value is X8;
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

extension UnionInjectExtension<Y> on Y {
  Union2<Y, X2> asUnion21<X2>() => Union2<Y, X2>.from1(this);
  Union2<X1, Y> asUnion22<X1>() => Union2<X1, Y>.from2(this);
  Union3<Y, X2, X3> asUnion31<X2, X3>() => Union3<Y, X2, X3>.from1(this);
  Union3<X1, Y, X3> asUnion32<X1, X3>() => Union3<X1, Y, X3>.from2(this);
  Union3<X1, X2, Y> asUnion33<X1, X2>() => Union3<X1, X2, Y>.from3(this);
  Union4<Y, X2, X3, X4> asUnion41<X2, X3, X4>() =>
      Union4<Y, X2, X3, X4>.from1(this);
  Union4<X1, Y, X3, X4> asUnion42<X1, X3, X4>() =>
      Union4<X1, Y, X3, X4>.from2(this);
  Union4<X1, X2, Y, X4> asUnion43<X1, X2, X4>() =>
      Union4<X1, X2, Y, X4>.from3(this);
  Union4<X1, X2, X3, Y> asUnion44<X1, X2, X3>() =>
      Union4<X1, X2, X3, Y>.from4(this);
  Union5<Y, X2, X3, X4, X5> asUnion51<X2, X3, X4, X5>() =>
      Union5<Y, X2, X3, X4, X5>.from1(this);
  Union5<X1, Y, X3, X4, X5> asUnion52<X1, X3, X4, X5>() =>
      Union5<X1, Y, X3, X4, X5>.from2(this);
  Union5<X1, X2, Y, X4, X5> asUnion53<X1, X2, X4, X5>() =>
      Union5<X1, X2, Y, X4, X5>.from3(this);
  Union5<X1, X2, X3, Y, X5> asUnion54<X1, X2, X3, X5>() =>
      Union5<X1, X2, X3, Y, X5>.from4(this);
  Union5<X1, X2, X3, X4, Y> asUnion55<X1, X2, X3, X4>() =>
      Union5<X1, X2, X3, X4, Y>.from5(this);
  Union6<Y, X2, X3, X4, X5, X6> asUnion61<X2, X3, X4, X5, X6>() =>
      Union6<Y, X2, X3, X4, X5, X6>.from1(this);
  Union6<X1, Y, X3, X4, X5, X6> asUnion62<X1, X3, X4, X5, X6>() =>
      Union6<X1, Y, X3, X4, X5, X6>.from2(this);
  Union6<X1, X2, Y, X4, X5, X6> asUnion63<X1, X2, X4, X5, X6>() =>
      Union6<X1, X2, Y, X4, X5, X6>.from3(this);
  Union6<X1, X2, X3, Y, X5, X6> asUnion64<X1, X2, X3, X5, X6>() =>
      Union6<X1, X2, X3, Y, X5, X6>.from4(this);
  Union6<X1, X2, X3, X4, Y, X6> asUnion65<X1, X2, X3, X4, X6>() =>
      Union6<X1, X2, X3, X4, Y, X6>.from5(this);
  Union6<X1, X2, X3, X4, X5, Y> asUnion66<X1, X2, X3, X4, X5>() =>
      Union6<X1, X2, X3, X4, X5, Y>.from6(this);
  Union7<Y, X2, X3, X4, X5, X6, X7> asUnion71<X2, X3, X4, X5, X6, X7>() =>
      Union7<Y, X2, X3, X4, X5, X6, X7>.from1(this);
  Union7<X1, Y, X3, X4, X5, X6, X7> asUnion72<X1, X3, X4, X5, X6, X7>() =>
      Union7<X1, Y, X3, X4, X5, X6, X7>.from2(this);
  Union7<X1, X2, Y, X4, X5, X6, X7> asUnion73<X1, X2, X4, X5, X6, X7>() =>
      Union7<X1, X2, Y, X4, X5, X6, X7>.from3(this);
  Union7<X1, X2, X3, Y, X5, X6, X7> asUnion74<X1, X2, X3, X5, X6, X7>() =>
      Union7<X1, X2, X3, Y, X5, X6, X7>.from4(this);
  Union7<X1, X2, X3, X4, Y, X6, X7> asUnion75<X1, X2, X3, X4, X6, X7>() =>
      Union7<X1, X2, X3, X4, Y, X6, X7>.from5(this);
  Union7<X1, X2, X3, X4, X5, Y, X7> asUnion76<X1, X2, X3, X4, X5, X7>() =>
      Union7<X1, X2, X3, X4, X5, Y, X7>.from6(this);
  Union7<X1, X2, X3, X4, X5, X6, Y> asUnion77<X1, X2, X3, X4, X5, X6>() =>
      Union7<X1, X2, X3, X4, X5, X6, Y>.from7(this);
  Union8<Y, X2, X3, X4, X5, X6, X7, X8>
      asUnion81<X2, X3, X4, X5, X6, X7, X8>() =>
          Union8<Y, X2, X3, X4, X5, X6, X7, X8>.from1(this);
  Union8<X1, Y, X3, X4, X5, X6, X7, X8>
      asUnion82<X1, X3, X4, X5, X6, X7, X8>() =>
          Union8<X1, Y, X3, X4, X5, X6, X7, X8>.from2(this);
  Union8<X1, X2, Y, X4, X5, X6, X7, X8>
      asUnion83<X1, X2, X4, X5, X6, X7, X8>() =>
          Union8<X1, X2, Y, X4, X5, X6, X7, X8>.from3(this);
  Union8<X1, X2, X3, Y, X5, X6, X7, X8>
      asUnion84<X1, X2, X3, X5, X6, X7, X8>() =>
          Union8<X1, X2, X3, Y, X5, X6, X7, X8>.from4(this);
  Union8<X1, X2, X3, X4, Y, X6, X7, X8>
      asUnion85<X1, X2, X3, X4, X6, X7, X8>() =>
          Union8<X1, X2, X3, X4, Y, X6, X7, X8>.from5(this);
  Union8<X1, X2, X3, X4, X5, Y, X7, X8>
      asUnion86<X1, X2, X3, X4, X5, X7, X8>() =>
          Union8<X1, X2, X3, X4, X5, Y, X7, X8>.from6(this);
  Union8<X1, X2, X3, X4, X5, X6, Y, X8>
      asUnion87<X1, X2, X3, X4, X5, X6, X8>() =>
          Union8<X1, X2, X3, X4, X5, X6, Y, X8>.from7(this);
  Union8<X1, X2, X3, X4, X5, X6, X7, Y>
      asUnion88<X1, X2, X3, X4, X5, X6, X7>() =>
          Union8<X1, X2, X3, X4, X5, X6, X7, Y>.from8(this);
  Union9<Y, X2, X3, X4, X5, X6, X7, X8, X9>
      asUnion91<X2, X3, X4, X5, X6, X7, X8, X9>() =>
          Union9<Y, X2, X3, X4, X5, X6, X7, X8, X9>.from1(this);
  Union9<X1, Y, X3, X4, X5, X6, X7, X8, X9>
      asUnion92<X1, X3, X4, X5, X6, X7, X8, X9>() =>
          Union9<X1, Y, X3, X4, X5, X6, X7, X8, X9>.from2(this);
  Union9<X1, X2, Y, X4, X5, X6, X7, X8, X9>
      asUnion93<X1, X2, X4, X5, X6, X7, X8, X9>() =>
          Union9<X1, X2, Y, X4, X5, X6, X7, X8, X9>.from3(this);
  Union9<X1, X2, X3, Y, X5, X6, X7, X8, X9>
      asUnion94<X1, X2, X3, X5, X6, X7, X8, X9>() =>
          Union9<X1, X2, X3, Y, X5, X6, X7, X8, X9>.from4(this);
  Union9<X1, X2, X3, X4, Y, X6, X7, X8, X9>
      asUnion95<X1, X2, X3, X4, X6, X7, X8, X9>() =>
          Union9<X1, X2, X3, X4, Y, X6, X7, X8, X9>.from5(this);
  Union9<X1, X2, X3, X4, X5, Y, X7, X8, X9>
      asUnion96<X1, X2, X3, X4, X5, X7, X8, X9>() =>
          Union9<X1, X2, X3, X4, X5, Y, X7, X8, X9>.from6(this);
  Union9<X1, X2, X3, X4, X5, X6, Y, X8, X9>
      asUnion97<X1, X2, X3, X4, X5, X6, X8, X9>() =>
          Union9<X1, X2, X3, X4, X5, X6, Y, X8, X9>.from7(this);
  Union9<X1, X2, X3, X4, X5, X6, X7, Y, X9>
      asUnion98<X1, X2, X3, X4, X5, X6, X7, X9>() =>
          Union9<X1, X2, X3, X4, X5, X6, X7, Y, X9>.from8(this);
  Union9<X1, X2, X3, X4, X5, X6, X7, X8, Y>
      asUnion99<X1, X2, X3, X4, X5, X6, X7, X8>() =>
          Union9<X1, X2, X3, X4, X5, X6, X7, X8, Y>.from9(this);
}
