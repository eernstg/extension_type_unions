// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// This code generator will generate the contents of the library
// '../lib/inline_union_type.dart', with non-standard formatting. Use it to
// obtain a near-finished version of that library, and then run `dart format`
// on the output in order to obtain a version which is ready to publish.
//
// The reason why it makes sense to obtain that library from a code generator
// is that the code in that library is highly regular (you could say that it
// is "meta-redundant"), and manual writing (or even editing) of the library
// might easily give rise to accidental inconsistencies.

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
    source.write('  Union$arity.in$i(X$i this.value);\n');
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
    source.write('    if (v is X$i) return (on$i ?? onOther)?.call(v);\n');
  }
  source.write('    if (onInvalid != null) return onInvalid(v);');
  source.write('    throw InvalidUnionTypeException(\n');
  source.write('      "Union$arity<$typeArguments>",\n');
  source.write('      value,\n    );\n  }\n}\n');

  return source.toString();
}

String unionTypeWithX(int arity, int xIndex) {
  var typeArgumentsSource = StringBuffer('');
  for (int i = 1; i <= arity; ++i) {
    var typeVariable = i == xIndex ? 'X' : 'Never';
    typeArgumentsSource.write('$typeVariable${i < arity ? ', ' : ''}');
  }
  return 'Union$arity<$typeArgumentsSource>';
}

String extensionSource() {
  var source = StringBuffer('extension UnionInjectExtension<X> on X {\n');
  for (int arity = 2; arity <= maxArity; ++arity) {
    for (int xIndex = 1; xIndex <= arity; ++xIndex) {
      var typeSource = unionTypeWithX(arity, xIndex);
      source.write('  $typeSource get asUnion$arity$xIndex => '
          'Union$arity.in$xIndex(this);\n');
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
