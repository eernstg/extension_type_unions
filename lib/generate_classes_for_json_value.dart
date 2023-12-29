// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides

import 'package:extension_type_unions/extension_type_json.dart';

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

class JsonClassNum extends JsonClassAtomic {
  get typeAnnotation => 'num';

  int get hashCode => (JsonClassNum).hashCode;
  bool operator ==(other) => other is JsonClassNum;
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
  get typeAnnotation => 'List<${typeArgument.typeAnnotation}>';
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
  final String className;
  final Map<String, (String, JsonClassBase)> fields = {};

  JsonClassObject(this.className);

  int get hashCode =>
      Object.hashAllUnordered([JsonClassObject, ...fields.keys]);
  String get typeAnnotation => className;

  bool canBeSameClass(JsonClassObject other) {
    if (identical(this, other)) return true;
    if (fields.length != other.fields.length) return false;
    for (var name in fields.keys) {
      var type = fields[name]!.$2;
      var otherType = other.fields[name]?.$2;
      if (otherType == null) {
        // No such field in `other`.
        return false;
      } else if (otherType is JsonClassObject) {
        var otherTypeName = otherType.className;
        if (type is! JsonClassObject) return false;
        var typeName = type.className;
        if (typeName != otherTypeName) return false;
      } else if (otherType is JsonClassList) {
        return type is JsonClassList &&
            type.typeArgument == otherType.typeArgument;
      } else if (otherType is JsonClassMap) {
        return type is JsonClassMap && type.valueType == otherType.valueType;
      } else if (otherType is JsonClassAtomic) {
        if (type != otherType) return false;
      } else if (otherType is JsonClassDynamic) {
        return type is JsonClassDynamic;
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

class JsonClassNullable extends JsonClassBase {
  get typeAnnotation => '${baseType.typeAnnotation}?';
  JsonClassBase baseType;
  JsonClassNullable(this.baseType);
  void replace(
    JsonClassObject classToReplace,
    JsonClassObject replacementClass,
  ) =>
      baseType.replace(classToReplace, replacementClass);
}

class JsonClassMap extends JsonClassBase {
  get typeAnnotation => 'Map<String, ${valueType.typeAnnotation}>';
  JsonClassBase valueType;
  JsonClassMap(this.valueType);
  void replace(
    JsonClassObject classToReplace,
    JsonClassObject replacementClass,
  ) =>
      valueType.replace(classToReplace, replacementClass);
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

  /// Compute a possible covering of [value] by Dart classes
  ///
  /// For the given [Json] [value], compute a proposal for how this value
  /// could be modeled using a set of Dart classes. In general, a map in
  /// [value] is modeled as an instance of a class with one getter for each
  /// key in the map. A list in [value] is modeled as a `List<T>` where `T`
  /// is the type of the model of the elements of the list, or `dynamic` if
  /// the list elements are modeled as several different types.
  ///
  /// In particular, `[1, 2]` is modeled as a `List<int>`, `[1, 2.5]` is
  /// modeled as a `List<num>`, `[1.5, 2.5]` is modeled as a `List<double>`,
  /// `[{"x": 1}, {"x": 2}]` is modeled as a `List<C>` if the two maps are
  /// both modeled by the class `C`, and `[{"x": 1}, null]` is modeled as a
  /// `List<C?>`.
  ///
  /// In the case where a list contains maps whose values are all the same
  /// atomic type `T`, but whose sets of keys are different, an approach where
  /// those maps are modeled as distinct classes (one class for each distinct
  /// key set) would yield a `List<dynamic>` with several (or even many)
  /// different types of objects. This is not likely to be a convenient model
  /// of the actual situation. Hence, this is modeled by keeping the maps as
  /// maps of type `Map<String, T>`, and hence the list will be modeled as a
  /// `List<Map<String, T>>`. Any occurrences of null as a value is accepted
  /// under this approach, yielding a `List<Map<String, T?>>`.
  ///
  /// If [useMapsAnywhere] is true then every map in [value] whose values are
  /// all of the same atomic type `T` (or all of type `T?`) is modeled as a
  /// `Map<String, T> (respectively `Map<String, T?>`).
  ///
  /// The returned value is the type that models the topmost construct in
  /// [value].
  JsonClassBase computeJsonClasses(
    Json value, {
    bool useMapsAnywhere = false,
  }) {
    var outermostType = _computeJsonClasses(
      value,
      useMapsAnywhere: useMapsAnywhere,
    );

    while (true) {
      Map<int, Set<JsonClassObject>> classesBySize = {};

      for (var jsonClass in classes) {
        var size = jsonClass.fields.length;
        Set<JsonClassObject>? currentSet = classesBySize[size];
        currentSet ??= classesBySize[size] = {};
        currentSet.add(jsonClass);
      }

      Map<JsonClassObject, JsonClassObject> willCollapse = {};
      for (var entry in classesBySize.entries) {
        // TODO(eernstg): Use `entry.key`.
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

  // Compute the raw set of classes
  //
  // The returned set is not normalized, that is, it may contain several
  // classes with identical declarations, reflecting the fact that several
  // parts of the given [Json] value had the same structure.
  JsonClassBase _computeJsonClasses(
    Json value, {
    bool useMapsAnywhere = false,
  }) {
    return value.splitNamed<JsonClassBase>(
      onNull: () => JsonClassNull(),
      onBool: (_) => JsonClassBool(),
      onInt: (_) => JsonClassInt(),
      onDouble: (_) => JsonClassDouble(),
      onString: (_) => JsonClassString(),
      onList: (jsonValues) {
        var elementTypes = <JsonClassBase>{};
        for (var jsonValue in jsonValues) {
          var elementType = _computeJsonClasses(
            jsonValue,
            useMapsAnywhere: useMapsAnywhere,
          );
          elementTypes.add(elementType);
        }
        JsonClassBase typeArgument;
        if (elementTypes.isEmpty) {
          typeArgument = JsonClassNull();
        } else if (elementTypes.length == 1) {
          typeArgument = elementTypes.single;
        } else if (elementTypes.length == 2 &&
            elementTypes.contains(JsonClassInt()) &&
            elementTypes.contains(JsonClassDouble())) {
          typeArgument = JsonClassNum();
        } else if (elementTypes.length == 2 &&
            elementTypes.contains(JsonClassNull())) {
          late JsonClassBase otherType;
          for (var elementType in elementTypes) {
            if (elementType is JsonClassNull) continue;
            otherType = elementType;
            break;
          }
          typeArgument = JsonClassNullable(otherType);
        } else if (elementTypes.length == 3 &&
            elementTypes.contains(JsonClassInt()) &&
            elementTypes.contains(JsonClassDouble()) &&
            elementTypes.contains(JsonClassNull())) {
          typeArgument = JsonClassNullable(JsonClassNum());
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

        // Detect special case: Model a Json map as a Dart map, in the case
        // where it has the same atomic type of value for every key.
        L:
        if (useMapsAnywhere) {
          Set<Type> types = {};
          for (var value in jsonMap.values) {
            if (value is Map || value is List) break L;
            types.add((value as dynamic).runtimeType);
          }
          bool isNullable = types.contains(Null);
          if (isNullable) types.remove(Null);
          if (types.length == 1) {
            var dartType = types.single;
            JsonClassBase jsonClassType = <Type, JsonClassBase>{
              bool: JsonClassBool(),
              num: JsonClassNum(),
              int: JsonClassInt(),
              double: JsonClassDouble(),
              String: JsonClassString(),
            }[dartType]!;
            var jsonTypeWithNullability =
                isNullable ? JsonClassNullable(jsonClassType) : jsonClassType;
            return JsonClassMap(jsonTypeWithNullability);
          } else if (types.length == 2) {
            if (types.contains(int) && types.contains(double)) {
              var jsonClassType = JsonClassNum();
              return jsonClassType;
            }
          }
        }

        // Normal case, treat the map as an encoding of a Dart class instance.
        for (var entry in jsonMap.entries) {
          var fieldType = _computeJsonClasses(
            entry.value,
            useMapsAnywhere: useMapsAnywhere,
          );
          var fieldName = toCamelName(entry.key);
          jsonObject.fields[fieldName] = (entry.key, fieldType);
        }
        classes.add(jsonObject);
        return jsonObject;
      },
    )!;
  }
}
