// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:extension_type_unions/extension_type_json.dart';

// Standard example from documentation of `jsonDecode`.

const jsonString =
    '{"text": "foo", "value": 1, "status": false, "extra": null}';

const jsonArray = '''
  [{"text": "foo", "value": 1, "status": true},
   {"text": "bar", "value": 2, "status": false}]
''';

// Accepts a `Json` value which is a map whose values are atomic.
void handleSimpleJsonMap(Json json) {
  json.splitNamed(
    onMap: (m) {
      print('{');
      for (var key in m.keys) {
        // `m[key]` can be null because `key` may be mapped to the value null.
        // So if we encounter null then we insist that it is a `Json.fromNull`.
        // This ensures that `jsonValue` gets the type `Json`, as desired,
        // not `Json?`, as `operator []` would have it.
        var jsonValue = m[key] ?? Json.fromNull();
        var str = jsonValue.splitNamed(
          onString: (s) => '"$s" of type String',
          onInt: (i) => '$i of type int',
          onBool: (b) => '$b of type bool',
          onNull: () => 'null of type Null',
          onOther: (o) => throw "Composite values not expected here",
        );
        print('  "$key": $str');
      }
      print('}\n');
    },
    onOther: (_) => throw 'Error: Expected a map, got $json!',
  );
}

void main() {
  print('--- jsonString');
  handleSimpleJsonMap(Json.fromSource(jsonString));

  print('--- jsonArray');
  for (var json in Json.fromSource(jsonArray).asList) {
    handleSimpleJsonMap(json);
  }
}
