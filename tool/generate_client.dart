import 'dart:convert';
import 'dart:io';
import 'package:dart_style/dart_style.dart';
import 'swagger/dart.dart' as dart;
import 'swagger/swagger_spec.dart';
import 'update_swagger_file.dart' show swaggerPath;
import 'package:yaml/yaml.dart';

void main() {
  var yamlSpec = loadYaml(File(swaggerPath).readAsStringSync());
  var jsonSpec = jsonDecode(jsonEncode(yamlSpec, toEncodable: (e) {
    if (e is YamlMap) {
      return e.map((key, value) => MapEntry(key.toString(), value));
    }
    return e;
  }));

  final spec = Spec.fromJson(jsonSpec);

  var apiGenerator = dart.Api('Docker', spec);
  var code = apiGenerator.toCode().replaceAll('dynamic?', 'dynamic');
  try {
    code = DartFormatter().format(code);
  } catch (e) {
    print('Code has syntax error');
  }

  File('lib/src/docker_api.dart').writeAsStringSync(code);
}
