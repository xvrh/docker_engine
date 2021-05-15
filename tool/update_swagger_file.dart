import 'dart:io';
import 'package:http/http.dart';

final String swaggerPath = 'tool/swagger.yaml';

void main() async {
  var content = await read(Uri.https(
      'raw.githubusercontent.com', 'docker/engine/master/api/swagger.yaml'));
  File(swaggerPath).writeAsStringSync(content);
}
