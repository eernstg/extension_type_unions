// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

/// Thrown when an invalid Json type value is detected.
///
/// An expression whose static type is a Json type and whose value does not
/// have any of the types [Null], [bool], [int], [double], [String],
/// `List<Json>`, `Map<String, Json>` is an _invalid_ Json type value. This
/// exception is used to report that such a value has been encountered.
///
/// Note that `Json` is an extension type whose underlying representation type
/// is `Object?`, and hence any `List<T>` where `T` is a top type will yield
/// true when tested with `is List<Json>`. Similarly for maps: any map whose
/// run-time type is `Map<String, T>` where `T` is a top type will yield
/// true when tested with `is Map<String, Json>`.
class InvalidJsonTypeException implements Exception {
  final Object? value;

  InvalidJsonTypeException(this.value);

  @override
  String toString() => 'Json: value $value has type ${value.runtimeType}';
}

/// Support handling of `jsonDecode` JSON representation.
///
/// This extension type supports handling of object graphs obtained
/// from `jsonDecode` (or from any other source using the same encoding).
/// In this encoding, JSON values are represented as as primitive values
/// (of type `Null`, `bool`, `int`, `double`, `String`) or composite
/// values (of type `List<dynamic>` or `Map<String, dynamic>`, whose
/// contents are themselves subject to the same constraints).
extension type Json._(Object? value) {
  /// Create the given [value] as a JSON value.
  ///
  /// This constructor will validate the given object
  /// structure when assertions are enabled.
  Json(this.value) : assert(isDeepValid(value as Json));

  /// Create a JSON value containing null.
  const Json.fromNull() : value = null;

  /// Create a JSON value containing the given [value].
  const Json.fromBool(bool this.value);

  /// Create a JSON value containing the given [value].
  const Json.fromInt(int this.value);

  /// Create a JSON value containing the given [value].
  const Json.fromDouble(double this.value);

  /// Create a JSON value containing the given [value].
  const Json.fromString(String this.value);

  /// Create a JSON value containing the given [value].
  const Json.fromList(List<Json> this.value);

  /// Create a JSON value containing the given [value].
  const Json.fromMap(Map<String, Json> this.value);

  /// Create a JSON value corresponding to the given [source].
  ///
  /// The [source] is transformed by `jsonDecode` to an object
  /// structure which is then the [value].
  Json.fromSource(String source) : value = jsonDecode(source);

  /// Deeply validate the given [json].
  ///
  /// [json] is considered valid iff it contains a primitive value (of
  /// type `Null`, `bool`, `int`, `double`, `String`) or a composite
  /// value (of type `List<dynamic>` or `Map<String, dynamic>`) whose
  /// elements (of the list) or values (of the map) satisfy the same
  /// constraints recursively.
  static bool isDeepValid(Json json) {
    var v = json.value;
    if (v == null || v is bool || v is num || v is String) {
      return true;
    }
    if (v is List<Json>) {
      for (Json json in v) {
        if (!isDeepValid(json)) return false;
      }
      return true;
    }
    if (v is Map<String, Json>) {
      for (Json json in v.values) {
        if (!isDeepValid(json)) return false;
      }
      return true;
    }
    // Some other type, can't be a Json.
    return false;
  }

  /// Validate this JSON value.
  ///
  /// This JSON value is considered valid if it is an atomic value
  /// (of type `Null`, `bool`, `int`, `double`, or `String`), or it
  /// is a composite value (of type `List<dynamic>` or
  /// `Map<String, dynamic>`. The elements and values of the latter
  /// are ignored.
  ///
  /// If a recursive validation is required then the static function
  /// [isDeepValid] can be used.
  bool get isValid =>
      value == null ||
      value is bool ||
      value is int ||
      value is double ||
      value is String ||
      value is List<Json> ||
      value is Map<String, Json>;

  bool? get asBoolOrNull => value is bool ? value as bool : null;
  int? get asIntOrNull => value is int ? value as int : null;
  double? get asDoubleOrNull => value is double ? value as double : null;
  String? get asStringOrNull => value is String ? value as String : null;
  List<Json>? get asListOrNull =>
      value is List<Json> ? value as List<Json> : null;
  Map<String, Json>? get asMapOrNull =>
      value is Map<String, Json> ? value as Map<String, Json> : null;

  bool get asBool => value as bool;
  int get asInt => value as int;
  double get asDouble => value as double;
  String get asString => value as String;
  List<Json> get asList => value as List<Json>;
  Map<String, Json> get asMap => value as Map<String, Json>;

  bool get isNull => value == null;
  bool get isBool => value is bool;
  bool get isInt => value is int;
  bool get isDouble => value is double;
  bool get isString => value is String;
  bool get isList => value is List<Json>;
  bool get isMap => value is Map<String, Json>;

  /// Handle each possible shape of this JSON value.
  ///
  /// This method is used to discriminate the possible shapes of
  /// this JSON value, similarly to a `switch` expression. It accepts
  /// one function per shape, unconditionally, and using positional
  /// parameters. This is the most concise approach. Use [splitNamed]
  /// if a more flexible (but less concise) approach is preferred.
  ///
  /// In the case where this JSON value is malformed (i.e., it is not of
  /// type `Null`, `bool`, `int`, `double`, `String`, `List<dynamic>`,
  /// or `Map<String, dynamic>`), an `InvalidJsonTypeException` is
  /// thrown, holding the given [value].
  R split<R>(
    R Function() onNull,
    R Function(bool) onBool,
    R Function(int) onInt,
    R Function(double) onDouble,
    R Function(String) onString,
    R Function(List<Json>) onList,
    R Function(Map<String, Json>) onMap,
  ) {
    var v = value;
    if (v == null) return onNull();
    if (v is bool) return onBool(v);
    if (v is int) return onInt(v);
    if (v is double) return onDouble(v);
    if (v is String) return onString(v);
    if (v is List<Json>) return onList(v);
    if (v is Map<String, Json>) return onMap(v);
    throw InvalidJsonTypeException(value);
  }

  /// Handle selected possible shapes of this JSON value.
  ///
  /// This method is used to discriminate some or all of the possible
  /// shapes of this JSON value, similarly to a `switch` expression. It
  /// accepts a function per shape, using an optional named parameter.
  /// If the actual case is not handled (say, it's a [String], and no
  /// actual argument named `onString` was provided, or it was null)
  /// then `onOther` is invoked. Finally, `onInvalid` is invoked in the
  /// case where this is not a valid JSON value.
  R? splitNamed<R>({
    R Function()? onNull,
    R Function(bool)? onBool,
    R Function(int)? onInt,
    R Function(double)? onDouble,
    R Function(String)? onString,
    R Function(List<Json>)? onList,
    R Function(Map<String, Json>)? onMap,
    R Function(Object?)? onOther,
    R Function(Object?)? onInvalid,
  }) {
    var v = value;
    if (v == null) return onNull != null ? onNull() : onOther?.call(null);
    if (v is bool) return (onBool ?? onOther)?.call(v);
    if (v is int) return (onInt ?? onOther)?.call(v);
    if (v is double) return (onDouble ?? onOther)?.call(v);
    if (v is String) return (onString ?? onOther)?.call(v);
    if (v is List<Json>) return (onList ?? onOther)?.call(v);
    if (v is Map<String, Json>) return (onMap ?? onOther)?.call(v);
    if (onInvalid != null) return onInvalid(v);
    throw InvalidJsonTypeException(value);
  }
}
