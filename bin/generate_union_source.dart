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
  final String type;
  final Object? value;

  InvalidUnionTypeException(this.type, this.value);

  @override
  String toString() => '\$type: value has type \${value.runtimeType}';
}
""";

String unionSource(int arity) {
  var source = StringBuffer('');

  // Class header.
  source.write('inline class Union$arity<');
  for (int i = 1; i < arity; ++i) {
    source.write('X$i, ');
  }
  source.write('X$arity> {\n  final Object? value;\n\n');

  // Constructors.
  for (int i = 1; i <= arity; ++i) {
    source.write('  Union$arity.from$i(X$i this.value);\n');
  }

  // Getter `isValid`.
  source.write('\n  bool get isValid => ');
  for (int i = 1; i < arity; ++i) {
    source.write('value is X$i || ');
  }
  source.write('value is X$arity;\n\n');

  // Getters `as#OrNull`.
  for (int i = 1; i <= arity; ++i) {
    source.write(
        '  X$i? get as${i}OrNull => value is X$i ? value as X$i : null;\n');
  }
  source.write('\n');

  // Getters `as#`.
  for (int i = 1; i <= arity; ++i) {
    source.write('  X$i get as$i => value as X$i;\n');
  }
  source.write('\n');

  // Getters `is#`.
  for (int i = 1; i <= arity; ++i) {
    source.write('  bool get is$i => value is X$i;\n');
  }

  // Method `split`.
  source.write('\n  R split<R>(');
  for (int i = 1; i < arity; ++i) {
    source.write('R Function(X$i) on$i, ');
  }
  source.write('R Function(X$arity) on$arity');
  if (arity > 2) source.write(',');
  source.write(') {\n    var v = value;\n');
  for (int i = 1; i <= arity; ++i) {
    source.write('    if (v is X$i) return on$i(v);\n');
  }
  var typeArguments = StringBuffer('');
  for (int i = 1; i < arity; ++i) {
    typeArguments.write('\$X$i, ');
  }
  typeArguments.write('\$X$arity');
  source.write('    throw InvalidUnionTypeException(\n');
  source.write('      "Union$arity<$typeArguments>",\n');
  source.write('      value,\n    );\n  }\n');
  
  // Method `splitNamed`.
  source.write('\n  R? splitNamed<R>({\n');
  for (int i = 1; i < arity; ++i) {
    source.write('    R Function(X$i)? on$i,\n');
  }
  source.write('    R Function(X$arity)? on$arity,\n');
  source.write('    R Function(Object?)? onOther,\n');
  source.write('    R Function(Object?)? onInvalid,\n');
  source.write('  }) {\n    var v = value;\n');
  for (int i = 1; i <= arity; ++i) {
    source.write(
        '    if (v is X$i) return (on$i ?? onOther)?.call(v);\n');
  }
  source.write('    if (onInvalid != null) return onInvalid(v);');
  source.write('    throw InvalidUnionTypeException(\n');
  source.write('      "Union$arity<$typeArguments>",\n');
  source.write('      value,\n    );\n  }\n}\n');

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
          // Change `$typeSource` to `Union$arity` when inference works.
          '$typeSource.from$yIndex(this);\n');
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
