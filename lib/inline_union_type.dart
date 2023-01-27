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
  final String message;

  InvalidUnionTypeException(this.message);

  @override
  String toString() => message;
}

inline class Union2<X1, X2> {
  final Object? value;
  Union2.from1(X1 this.value);
  Union2.from2(X2 this.value);

  bool get isValid => value is X1 || value is X2;

  R split<R>(R Function(X1) if1, R Function(X2) if2) {
    var v = value;
    if (v is X1) return if1(v);
    if (v is X2) return if2(v);
    throw InvalidUnionTypeException("Union2<$X1, $X2> has value of type "
        "${value.runtimeType}");
  }
}

inline class Union3<X1, X2, X3> {
  final Object? value;
  Union3.from1(X1 this.value);
  Union3.from2(X2 this.value);
  Union3.from3(X3 this.value);

  bool get isValid => value is X1 || value is X2 || value is X3;

  R split<R>(
    R Function(X1) if1,
    R Function(X2) if2,
    R Function(X3) if3,
  ) {
    var v = value;
    if (v is X1) return if1(v);
    if (v is X2) return if2(v);
    if (v is X3) return if3(v);
    throw InvalidUnionTypeException("Union3<$X1, $X2, $X3> has value of type "
        "${value.runtimeType}");
  }
}

inline class Union4<X1, X2, X3, X4> {
  final Object? value;
  Union4.from1(X1 this.value);
  Union4.from2(X2 this.value);
  Union4.from3(X3 this.value);
  Union4.from4(X4 this.value);

  bool get isValid => value is X1 || value is X2 || value is X3 || value is X4;

  R split<R>(
    R Function(X1) if1,
    R Function(X2) if2,
    R Function(X3) if3,
    R Function(X4) if4,
  ) {
    var v = value;
    if (v is X1) return if1(v);
    if (v is X2) return if2(v);
    if (v is X3) return if3(v);
    if (v is X4) return if4(v);
    throw InvalidUnionTypeException(
        "Union4<$X1, $X2, $X3, $X4> has value of type "
        "${value.runtimeType}");
  }
}

inline class Union5<X1, X2, X3, X4, X5> {
  final Object? value;
  Union5.from1(X1 this.value);
  Union5.from2(X2 this.value);
  Union5.from3(X3 this.value);
  Union5.from4(X4 this.value);
  Union5.from5(X5 this.value);

  bool get isValid =>
      value is X1 || value is X2 || value is X3 || value is X4 || value is X5;

  R split<R>(
    R Function(X1) if1,
    R Function(X2) if2,
    R Function(X3) if3,
    R Function(X4) if4,
    R Function(X5) if5,
  ) {
    var v = value;
    if (v is X1) return if1(v);
    if (v is X2) return if2(v);
    if (v is X3) return if3(v);
    if (v is X4) return if4(v);
    if (v is X5) return if5(v);
    throw InvalidUnionTypeException(
        "Union5<$X1, $X2, $X3, $X4, $X5> has value of type "
        "${value.runtimeType}");
  }
}

inline class Union6<X1, X2, X3, X4, X5, X6> {
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

  R split<R>(
    R Function(X1) if1,
    R Function(X2) if2,
    R Function(X3) if3,
    R Function(X4) if4,
    R Function(X5) if5,
    R Function(X6) if6,
  ) {
    var v = value;
    if (v is X1) return if1(v);
    if (v is X2) return if2(v);
    if (v is X3) return if3(v);
    if (v is X4) return if4(v);
    if (v is X5) return if5(v);
    if (v is X6) return if6(v);
    throw InvalidUnionTypeException(
        "Union6<$X1, $X2, $X3, $X4, $X5, $X6> has value of type "
        "${value.runtimeType}");
  }
}

inline class Union7<X1, X2, X3, X4, X5, X6, X7> {
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

  R split<R>(
    R Function(X1) if1,
    R Function(X2) if2,
    R Function(X3) if3,
    R Function(X4) if4,
    R Function(X5) if5,
    R Function(X6) if6,
    R Function(X7) if7,
  ) {
    var v = value;
    if (v is X1) return if1(v);
    if (v is X2) return if2(v);
    if (v is X3) return if3(v);
    if (v is X4) return if4(v);
    if (v is X5) return if5(v);
    if (v is X6) return if6(v);
    if (v is X7) return if7(v);
    throw InvalidUnionTypeException(
        "Union7<$X1, $X2, $X3, $X4, $X5, $X6, $X7> has value of type "
        "${value.runtimeType}");
  }
}

inline class Union8<X1, X2, X3, X4, X5, X6, X7, X8> {
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

  R split<R>(
    R Function(X1) if1,
    R Function(X2) if2,
    R Function(X3) if3,
    R Function(X4) if4,
    R Function(X5) if5,
    R Function(X6) if6,
    R Function(X7) if7,
    R Function(X8) if8,
  ) {
    var v = value;
    if (v is X1) return if1(v);
    if (v is X2) return if2(v);
    if (v is X3) return if3(v);
    if (v is X4) return if4(v);
    if (v is X5) return if5(v);
    if (v is X6) return if6(v);
    if (v is X7) return if7(v);
    if (v is X8) return if8(v);
    throw InvalidUnionTypeException(
        "Union8<$X1, $X2, $X3, $X4, $X5, $X6, $X7, $X8> has value of type "
        "${value.runtimeType}");
  }
}

inline class Union9<X1, X2, X3, X4, X5, X6, X7, X8, X9> {
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

  R split<R>(
    R Function(X1) if1,
    R Function(X2) if2,
    R Function(X3) if3,
    R Function(X4) if4,
    R Function(X5) if5,
    R Function(X6) if6,
    R Function(X7) if7,
    R Function(X8) if8,
    R Function(X9) if9,
  ) {
    var v = value;
    if (v is X1) return if1(v);
    if (v is X2) return if2(v);
    if (v is X3) return if3(v);
    if (v is X4) return if4(v);
    if (v is X5) return if5(v);
    if (v is X6) return if6(v);
    if (v is X7) return if7(v);
    if (v is X8) return if8(v);
    if (v is X9) return if9(v);
    throw InvalidUnionTypeException(
        "Union9<$X1, $X2, $X3, $X4, $X5, $X6, $X7, $X8, $X9> has value of type "
        "${value.runtimeType}");
  }
}

extension UnionInjectExtension<Y> on Y {
  Union2<Y, X2> asUnion21<X2>() => Union2.from1(this);
  Union2<X1, Y> asUnion22<X1>() => Union2.from2(this);
  Union3<Y, X2, X3> asUnion31<X2, X3>() => Union3.from1(this);
  Union3<X1, Y, X3> asUnion32<X1, X3>() => Union3.from2(this);
  Union3<X1, X2, Y> asUnion33<X1, X2>() => Union3.from3(this);
  Union4<Y, X2, X3, X4> asUnion41<X2, X3, X4>() => Union4.from1(this);
  Union4<X1, Y, X3, X4> asUnion42<X1, X3, X4>() => Union4.from2(this);
  Union4<X1, X2, Y, X4> asUnion43<X1, X2, X4>() => Union4.from3(this);
  Union4<X1, X2, X3, Y> asUnion44<X1, X2, X3>() => Union4.from4(this);
  Union5<Y, X2, X3, X4, X5> asUnion51<X2, X3, X4, X5>() => Union5.from1(this);
  Union5<X1, Y, X3, X4, X5> asUnion52<X1, X3, X4, X5>() => Union5.from2(this);
  Union5<X1, X2, Y, X4, X5> asUnion53<X1, X2, X4, X5>() => Union5.from3(this);
  Union5<X1, X2, X3, Y, X5> asUnion54<X1, X2, X3, X5>() => Union5.from4(this);
  Union5<X1, X2, X3, X4, Y> asUnion55<X1, X2, X3, X4>() => Union5.from5(this);
  Union6<Y, X2, X3, X4, X5, X6> asUnion61<X2, X3, X4, X5, X6>() =>
      Union6.from1(this);
  Union6<X1, Y, X3, X4, X5, X6> asUnion62<X1, X3, X4, X5, X6>() =>
      Union6.from2(this);
  Union6<X1, X2, Y, X4, X5, X6> asUnion63<X1, X2, X4, X5, X6>() =>
      Union6.from3(this);
  Union6<X1, X2, X3, Y, X5, X6> asUnion64<X1, X2, X3, X5, X6>() =>
      Union6.from4(this);
  Union6<X1, X2, X3, X4, Y, X6> asUnion65<X1, X2, X3, X4, X6>() =>
      Union6.from5(this);
  Union6<X1, X2, X3, X4, X5, Y> asUnion66<X1, X2, X3, X4, X5>() =>
      Union6.from6(this);
  Union7<Y, X2, X3, X4, X5, X6, X7> asUnion71<X2, X3, X4, X5, X6, X7>() =>
      Union7.from1(this);
  Union7<X1, Y, X3, X4, X5, X6, X7> asUnion72<X1, X3, X4, X5, X6, X7>() =>
      Union7.from2(this);
  Union7<X1, X2, Y, X4, X5, X6, X7> asUnion73<X1, X2, X4, X5, X6, X7>() =>
      Union7.from3(this);
  Union7<X1, X2, X3, Y, X5, X6, X7> asUnion74<X1, X2, X3, X5, X6, X7>() =>
      Union7.from4(this);
  Union7<X1, X2, X3, X4, Y, X6, X7> asUnion75<X1, X2, X3, X4, X6, X7>() =>
      Union7.from5(this);
  Union7<X1, X2, X3, X4, X5, Y, X7> asUnion76<X1, X2, X3, X4, X5, X7>() =>
      Union7.from6(this);
  Union7<X1, X2, X3, X4, X5, X6, Y> asUnion77<X1, X2, X3, X4, X5, X6>() =>
      Union7.from7(this);
  Union8<Y, X2, X3, X4, X5, X6, X7, X8>
      asUnion81<X2, X3, X4, X5, X6, X7, X8>() => Union8.from1(this);
  Union8<X1, Y, X3, X4, X5, X6, X7, X8>
      asUnion82<X1, X3, X4, X5, X6, X7, X8>() => Union8.from2(this);
  Union8<X1, X2, Y, X4, X5, X6, X7, X8>
      asUnion83<X1, X2, X4, X5, X6, X7, X8>() => Union8.from3(this);
  Union8<X1, X2, X3, Y, X5, X6, X7, X8>
      asUnion84<X1, X2, X3, X5, X6, X7, X8>() => Union8.from4(this);
  Union8<X1, X2, X3, X4, Y, X6, X7, X8>
      asUnion85<X1, X2, X3, X4, X6, X7, X8>() => Union8.from5(this);
  Union8<X1, X2, X3, X4, X5, Y, X7, X8>
      asUnion86<X1, X2, X3, X4, X5, X7, X8>() => Union8.from6(this);
  Union8<X1, X2, X3, X4, X5, X6, Y, X8>
      asUnion87<X1, X2, X3, X4, X5, X6, X8>() => Union8.from7(this);
  Union8<X1, X2, X3, X4, X5, X6, X7, Y>
      asUnion88<X1, X2, X3, X4, X5, X6, X7>() => Union8.from8(this);
  Union9<Y, X2, X3, X4, X5, X6, X7, X8, X9>
      asUnion91<X2, X3, X4, X5, X6, X7, X8, X9>() => Union9.from1(this);
  Union9<X1, Y, X3, X4, X5, X6, X7, X8, X9>
      asUnion92<X1, X3, X4, X5, X6, X7, X8, X9>() => Union9.from2(this);
  Union9<X1, X2, Y, X4, X5, X6, X7, X8, X9>
      asUnion93<X1, X2, X4, X5, X6, X7, X8, X9>() => Union9.from3(this);
  Union9<X1, X2, X3, Y, X5, X6, X7, X8, X9>
      asUnion94<X1, X2, X3, X5, X6, X7, X8, X9>() => Union9.from4(this);
  Union9<X1, X2, X3, X4, Y, X6, X7, X8, X9>
      asUnion95<X1, X2, X3, X4, X6, X7, X8, X9>() => Union9.from5(this);
  Union9<X1, X2, X3, X4, X5, Y, X7, X8, X9>
      asUnion96<X1, X2, X3, X4, X5, X7, X8, X9>() => Union9.from6(this);
  Union9<X1, X2, X3, X4, X5, X6, Y, X8, X9>
      asUnion97<X1, X2, X3, X4, X5, X6, X8, X9>() => Union9.from7(this);
  Union9<X1, X2, X3, X4, X5, X6, X7, Y, X9>
      asUnion98<X1, X2, X3, X4, X5, X6, X7, X9>() => Union9.from8(this);
  Union9<X1, X2, X3, X4, X5, X6, X7, X8, Y>
      asUnion99<X1, X2, X3, X4, X5, X6, X7, X8>() => Union9.from9(this);
}
