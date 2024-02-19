import 'dart:convert';
import 'package:inline_union_type/inline_json_type.dart';

// Standard example from documentation of `jsonDecode`.

const jsonString =
    '{"text": "foo", "value": 1, "status": false, "extra": null}';

const jsonArray = '''
  [{"text": "foo", "value": 1, "status": true},
   {"text": "bar", "value": 2, "status": false}]
''';

void main() {
  final data = jsonDecode(jsonString);
  print(data['text']); // foo
  print(data['value']); // 1
  print(data['status']); // false
  print(data['extra']); // null

  final List<dynamic> dataList = jsonDecode(jsonArray);
  print(dataList[0]); // {text: foo, value: 1, status: true}
  print(dataList[1]); // {text: bar, value: 2, status: false}

  final item = dataList[0];
  print(item['text']); // foo
  print(item['value']); // 1
  print(item['status']); // false

  // Trying out my stuff.
  print('\nInline stuff:');

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
