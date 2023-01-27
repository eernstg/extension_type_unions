// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

const maxArity = 9;

const frontMatter = """
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
""";

String unionSource(int arity) {
  var source = StringBuffer('');
  source.write('inline class Union$arity<');
  for (int i = 1; i < arity; ++i) {
    source.write('X$i, ');
  }
  source.write('X$arity> {\n  final Object? value;\n');
  for (int i = 1; i <= arity; ++i) {
    source.write('  Union$arity.from$i(X$i this.value);\n');
  }
  source.write('\n  bool get isValid => ');
  for (int i = 1; i < arity; ++i) {
    source.write('value is X$i || ');
  }
  source.write('value is X$arity;\n');
  source.write('\n  R split<R>(');
  for (int i = 1; i < arity; ++i) {
    source.write('R Function(X$i) if$i, ');
  }
  source.write('R Function(X$arity) if$arity');
  if (arity > 2) source.write(',');
  source.write(') {\n    var v = value;');
  for (int i = 1; i <= arity; ++i) {
    source.write('    if (v is X$i) return if$i(v);\n');
  }
  
  var typeArguments = StringBuffer('');
  for (int i = 1; i < arity; ++i) {
    typeArguments.write('\$X$i, ');
  }
  typeArguments.write('\$X$arity');

  var invalidityMessage =
      '"Union$arity<$typeArguments> has value of type "\n'
      '        "\${value.runtimeType}"';
  source.write('    throw InvalidUnionTypeException(\n');
  source.write('        $invalidityMessage);\n  }\n}\n');
  return source.toString();
}

String unionTypeWithY(int arity, int yIndex) {
  var typeArgumentsSource = StringBuffer('');
  for (int i = 1; i <= arity; ++i) {
    var typeVariable = i == yIndex ? 'Y' : 'X$i';
    typeArgumentsSource.write('$typeVariable${i < arity ? ', ' : ''}');
  }
  return 'Union$arity<$typeArgumentsSource>';
}

String typeParametersWithoutY(int arity, int yIndex) {
  var typeParametersSource = StringBuffer('');
  bool first = true;
  for (int i = 1; i <= arity; ++i) {
    if (i != yIndex) {
      var commaSource = first ? '' : ', ';
      first = false;
      typeParametersSource.write('${commaSource}X$i');
    }
  }
  return typeParametersSource.toString();
}

String extensionSource() {
  var source = StringBuffer('extension UnionInjectExtension<Y> on Y {\n');
  for (int arity = 2; arity <= maxArity; ++arity) {
    for (int yIndex = 1; yIndex <= arity; ++yIndex) {
      var typeSource = unionTypeWithY(arity, yIndex);
      var typeParametersSource = typeParametersWithoutY(arity, yIndex);
      source.write('  $typeSource asUnion$arity$yIndex'
          '<$typeParametersSource>() => '
          'Union$arity.from$yIndex(this);\n');
    }
  }
  source.write('}\n');
  return source.toString();
}

void main() {

  print(frontMatter);
  for (int i = 2; i < maxArity; ++i) {
    print(unionSource(i));
  }
  print(unionSource(maxArity));
  print(extensionSource());
}
