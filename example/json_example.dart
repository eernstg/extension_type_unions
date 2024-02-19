// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:extension_type_union/extension_type_json.dart';

// Standard example from documentation of `jsonDecode`.

const jsonString =
    '{"text": "foo", "value": 1, "status": false, "extra": null}';

const jsonArray = '''
  [{"text": "foo", "value": 1, "status": true},
   {"text": "bar", "value": 2, "status": false}]
''';

void main() {
  final data = jsonDecode(jsonString);
  final List<dynamic> dataList = jsonDecode(jsonArray);

  var json = Json.fromSource(jsonString);
  json.splitNamed(
    onMap: (m) {
      print('{');
      for (var key in m.keys) {
        var jsonValue = Json(m[key]);
        var str = jsonValue.splitNamed(
          onString: (s) => '"$s" of type String',
          onInt: (i) => '$i of type int',
          onBool: (b) => '$b of type bool',
          onNull: () => 'null of type Null',
        );
        print('  "$key": $str');
      }
      print('}\n');
    },
    onOther: (_) => print('Error: Did not get a map!'),
  );
}
