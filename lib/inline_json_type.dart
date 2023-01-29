// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
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
/// Note that `Json` is an inline type whose underlying representation type
/// is `Object?`, and hence any `List<T>` where `T` is a top type will yield
/// true when tested with `is List<Json>`. Similarly for maps: any map whose
/// run-time type is `Map<String, T>` where `T` is a top type will yield
/// true when tested with `is Map<String, Json>`.
class InvalidJsonTypeException implements Exception {
  final Object? value;

  InvalidJsonTypeException(this.value);

  @override
  String toString() => 'Json: value has type ${value.runtimeType}';
}

inline class Json {
  final Object? value;

  Json(this.value): assert(isDeepValid(value as Json));
  const Json.fromNull(): value = null;
  const Json.fromBool(bool this.value);
  const Json.fromInt(int this.value);
  const Json.fromDouble(double this.value);
  const Json.fromString(String this.value);
  const Json.fromList(List<Json> this.value);
  const Json.fromMap(Map<String, Json> this.value);
  Json.fromSource(String source): value = jsonDecode(source);

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
