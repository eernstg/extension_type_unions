// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:inline_union_type/inline_json_type.dart';

abstract class JsonClassBase {
  String get typeAnnotation;
  void replace(
    JsonClassObject classToReplace,
    JsonClassObject replacementClass,
  );
  toString() => typeAnnotation;
}

abstract class JsonClassAtomic extends JsonClassBase {
  void replace(
    JsonClassObject classToReplace,
    JsonClassObject replacementClass,
  ) {}
}

class JsonClassNull extends JsonClassAtomic {
  get typeAnnotation => 'Null';

  int get hashCode => (JsonClassNull).hashCode;
  bool operator ==(other) => other is JsonClassNull;
}

class JsonClassBool extends JsonClassAtomic {
  get typeAnnotation => 'bool';

  int get hashCode => (JsonClassBool).hashCode;
  bool operator ==(other) => other is JsonClassBool;
}

class JsonClassInt extends JsonClassAtomic {
  get typeAnnotation => 'int';

  int get hashCode => (JsonClassInt).hashCode;
  bool operator ==(other) => other is JsonClassInt;
}

class JsonClassDouble extends JsonClassAtomic {
  get typeAnnotation => 'double';

  int get hashCode => (JsonClassDouble).hashCode;
  bool operator ==(other) => other is JsonClassDouble;
}

class JsonClassString extends JsonClassAtomic {
  get typeAnnotation => 'String';

  int get hashCode => (JsonClassString).hashCode;
  bool operator ==(other) => other is JsonClassString;
}

class JsonClassList extends JsonClassBase {
  get typeAnnotation => 'List<$typeArgument>';
  JsonClassBase typeArgument;
  final Set<JsonClassBase> elementTypes;

  JsonClassList(this.typeArgument, this.elementTypes);

  int get hashCode => Object.hash(JsonClassList, typeArgument);

  bool operator ==(other) {
    if (other is! JsonClassList) return false;
    return typeArgument != other.typeArgument;
  }

  void replace(
    JsonClassObject classToReplace,
    JsonClassObject replacementClass,
  ) {
    if (typeArgument == classToReplace) typeArgument = replacementClass;
    // Avoid concurrent modification.
    var elementTypeList = elementTypes.toList();
    for (var element in elementTypeList) {
      if (element == classToReplace) {
        elementTypes.remove(classToReplace);
        elementTypes.add(replacementClass);
      } else {
        element.replace(classToReplace, replacementClass);
      }
    }
  }

  String toString() {
    var buffer = StringBuffer('[');
    var first = true;
    for (var element in elementTypes) {
      if (first) {
        first = false;
      } else {
        buffer.write(', ');
      }
      buffer.write(element.toString());
    }
    buffer.write(']');
    return buffer.toString();
  }
}

class JsonClassObject extends JsonClassBase {
  String className;
  final Map<String, (String, JsonClassBase)> fields = {};

  JsonClassObject(this.className);

  int get hashCode => 
      Object.hashAllUnordered([JsonClassObject, ...fields.keys]);
  get typeAnnotation => className;

  bool canBeSameClass(JsonClassObject other) {
    if (identical(this, other)) return true;
    if (fields.length != other.fields.length) return false;
    for (var name in fields.keys) {
      var otherType = other.fields[name]?.$2;
      if (otherType == null) {
        // No such field in `other`.
        return false;
      } else if (otherType is JsonClassObject) {
        var otherTypeName = otherType.className;
        if (otherTypeName == null) return false;
        var type = fields[name]!.$2;
        if (type is! JsonClassObject) return false;
        var typeName = type.className;
        if (typeName != otherTypeName) return false;
      } else if (otherType is JsonClassList) {
        return false;
      } else if (otherType is JsonClassAtomic) {
        var type = fields[name]!.$2;
        if (type.runtimeType != otherType.runtimeType) return false;
      } else if (otherType is JsonClassDynamic) {
        return false;
      } else {
        throw 'Not yet handled in canBeSameClass: $otherType';
      }
    }
    return true;
  }

  void replace(
    JsonClassObject classToReplace,
    JsonClassObject replacementClass,
  ) {
    // Cannot iterate over entries, would be concurrent modification.
    var fieldNames = fields.keys.toList();
    for (var fieldName in fieldNames) {
      var fieldRecord = fields[fieldName]!;
      var fieldType = fieldRecord.$2;
      if (fieldType != classToReplace) continue;
      var jsonName = fieldRecord.$1;
      fields[fieldName] = (jsonName, replacementClass);
    }
  }

  String toString() {
    var buffer = StringBuffer('class $className {\n');
    var keys = fields.keys.toList()..sort();
    for (var key in keys) {
      var typeAnnotation = fields[key]!.$2.typeAnnotation;
      buffer.write('  $typeAnnotation $key;\n');
    }
    buffer.write('}');
    return buffer.toString();
  }
  
  bool operator ==(other) {
    if (other is! JsonClassObject) return false;
    if (className != other.className) return false;
    if (fields.length != other.fields.length) return false;
    for (var entry in fields.entries) {
      if (!other.fields.containsKey(entry.key)) return false;
      var otherValue = other.fields[entry.key];
      if (entry.value != otherValue) return false;
    }
    return true;
  }
}

class JsonClassDynamic extends JsonClassBase {
  get typeAnnotation => 'dynamic';
  void replace(
    JsonClassObject classToReplace,
    JsonClassObject replacementClass,
  ) {}
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
  Set<JsonClassObject> classes = {};
  Set<JsonClassList> lists = {};

  JsonClassBase computeJsonClasses(Json value) {
    var outermostType = _computeJsonClasses(value);

    while (true) {
      Map<int, Set<JsonClassObject>> classesBySize = {};

      for (var jsonClass in classes) {
        var size = jsonClass.fields.length;
        Set<JsonClassObject>? currentSet = classesBySize[size];
        if (currentSet == null) currentSet = classesBySize[size] = {};
        currentSet.add(jsonClass);
      }

      Map<JsonClassObject, JsonClassObject> willCollapse = {};
      for (var entry in classesBySize.entries) {
        var size = entry.key;
        var currentClasses = entry.value.toList();
        var currentClassesSize = currentClasses.length;
        for (var index = 0; index < currentClassesSize; ++index) {
          var currentClass = currentClasses[index];
          for (var index2 = index + 1; index2 < currentClassesSize; ++index2) {
            var currentClass2 = currentClasses[index2];
            if (currentClass2.canBeSameClass(currentClass)) {
              willCollapse[currentClass2] = currentClass;
            }
          }
        }
      }

      if (willCollapse.isEmpty) break;

      for (var entry in willCollapse.entries) {
        var classToReplace = entry.key;
        var replacementClass = entry.value;
        classes.remove(classToReplace);
        for (var currentClass in classes) {
          currentClass.replace(classToReplace, replacementClass);
        }
        for (var currentList in lists) {
          currentList.replace(classToReplace, replacementClass);
        }
      }
    }

    return outermostType;
  }

  /// Compute the raw set of classes
  ///
  /// The returned set is not normalized, that is, it may contain several
  /// classes with identical declarations, reflecting the fact that several
  /// parts of the given [Json] value had the same structure.
  JsonClassBase _computeJsonClasses(Json value) {
    return value.splitNamed<JsonClassBase>(
      onNull: () => JsonClassNull(),
      onBool: (_) => JsonClassBool(),
      onInt: (_) => JsonClassInt(),
      onDouble: (_) => JsonClassDouble(),
      onString: (_) => JsonClassString(),
      onList: (jsonValues) {
        var elementTypes = <JsonClassBase>{};
        for (var jsonValue in jsonValues) {
          var elementType = _computeJsonClasses(jsonValue);
          elementTypes.add(elementType);
        }
        JsonClassBase typeArgument;
        if (elementTypes.isEmpty) {
          typeArgument = JsonClassNull();
        } else if (elementTypes.length == 1) {
          typeArgument = elementTypes.single;
        } else {
          typeArgument = JsonClassDynamic();
        }
        var jsonList = JsonClassList(typeArgument, elementTypes);
        lists.add(jsonList);
        return jsonList;
      },
      onMap: (jsonMap) {
        var className = freshName('JsonClass');
        var jsonObject = JsonClassObject(className);
        for (var entry in jsonMap.entries) {
          var fieldType = _computeJsonClasses(entry.value);
          var fieldName = toCamelName(entry.key);
          jsonObject.fields[fieldName] = (entry.key, fieldType);
        }
        classes.add(jsonObject);
        return jsonObject;
      },
    )!;
  }
}
