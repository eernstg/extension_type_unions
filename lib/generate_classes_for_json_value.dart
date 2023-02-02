// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:inline_union_type/inline_json_type.dart';

abstract class JsonClassBase {
  String get typeAnnotation;
}


class JsonClassNull extends JsonClassBase {
  get typeAnnotation => 'Null';
}

class JsonClassBool extends JsonClassBase {
  get typeAnnotation => 'bool';
  
}

class JsonClassInt extends JsonClassBase {
  get typeAnnotation => 'int';

}

class JsonClassDouble extends JsonClassBase {
  get typeAnnotation => 'double';

}

class JsonClassString extends JsonClassBase {
  get typeAnnotation => 'String';

}

class JsonClassList extends JsonClassBase {
  get typeAnnotation => 'List<$typeArgument>';
  String typeArgument;
  
}

class JsonClassMap extends JsonClassBase {
  String typeAnnotation = '';
  
}


List<JsonClassBase> computeJsonClasses(Json value) {
  return []; // TODO
}
