// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:inline_union_type/inline_json_type.dart';

abstract class JsonClassBase {
  String get typeAnnotation;
  toString() => typeAnnotation;
}

class JsonClassNull extends JsonClassBase {
  get typeAnnotation => 'Null';

  int get hashCode => (JsonClassNull).hashCode;
  bool operator ==(other) => other is JsonClassNull;
}

class JsonClassBool extends JsonClassBase {
  get typeAnnotation => 'bool';

  int get hashCode => (JsonClassBool).hashCode;
  bool operator ==(other) => other is JsonClassBool;
}

class JsonClassInt extends JsonClassBase {
  get typeAnnotation => 'int';

  int get hashCode => (JsonClassInt).hashCode;
  bool operator ==(other) => other is JsonClassInt;
}

class JsonClassDouble extends JsonClassBase {
  get typeAnnotation => 'double';

  int get hashCode => (JsonClassDouble).hashCode;
  bool operator ==(other) => other is JsonClassDouble;
}

class JsonClassString extends JsonClassBase {
  get typeAnnotation => 'String';

  int get hashCode => (JsonClassString).hashCode;
  bool operator ==(other) => other is JsonClassString;
}

class JsonClassList extends JsonClassBase {
  get typeAnnotation => 'List<$typeArgument>';
  final JsonClassBase typeArgument;

  JsonClassList(this.typeArgument);

  int get hashCode => Object.hash(JsonClassList, typeArgument);

  bool operator ==(other) {
    if (other is! JsonClassList) return false;
    return typeArgument != other.typeArgument;
  }
}

class JsonClassObject extends JsonClassBase {
  get typeAnnotation => className;
  final String className;
  final Map<String, (String, JsonClassBase)> fields = {};

  JsonClassObject(this.className);

  int get hashCode =>
      Object.hashAllUnordered([JsonClassObject, ...fields.keys]);

  toString() {
    var buffer = StringBuffer('class $className {\n');
    var keys = fields.keys.toList()..sort();
    for (var key in keys) {
      var typeAnnotation = fields[key]!.$1.typeAnnotation;
      buffer.write('  $typeAnnotation $key;\n');
    }
    buffer.write('}');
    return buffer.toString();
  }

  bool operator ==(other) {
    if (other is! JsonClassObject) return false;
    if (fields.length != other.fields.length) return false;
    for (var entry in fields.entries) {
      if (!other.fields.containsKey(entry.key)) return false;
      var otherValue = other.fields[entry.key];
      if (entry.value != otherValue) return false;
    }
    return true;
  }
}

String toCamelName(String jsonName) {
  if (!jsonName.contains('_')) return jsonName;
  var buffer = StringBuffer('');
  bool doUpCase = false;
  for (var rune in jsonName.runes) {
    var char = String.fromCharCode(rune);
    if (char == '_') {
      doUpCase = true;
    } else {
      if (doUpCase) char = char.toUpperCase();
      doUpCase = false;
      buffer.write(char);
    }
  }
  return buffer.toString();
}

class JsonClassCollector {
  var _nameIndex = 1;
  String freshName(String prefix) => '$prefix${_nameIndex++}';
  Set<JsonClassObject> result = {};

  JsonClassBase computeJsonClass(Json value) {
    return value.splitNamed<JsonClassBase>(
      onNull: () => JsonClassNull(),
      onBool: (_) => JsonClassBool(),
      onInt: (_) => JsonClassInt(),
      onDouble: (_) => JsonClassDouble(),
      onString: (_) => JsonClassString(),
      onList: (jsonValues) => JsonClassList(JsonClassNull()),
      onMap: (jsonMap) {
        var className = freshName('JsonClass');
        var jsonObject = JsonClassObject(className);
        for (var entry in jsonMap.entries) {
          var fieldType = computeJsonClass(entry.value);
          var fieldName = toCamelName(entry.key);
          jsonObject.fields[fieldName] = (entry.key, fieldType);
        }
        result.add(jsonObject);
        return jsonObject;
      },
    )!;
  }
}
