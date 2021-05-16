import 'package:docker_engine/docker_engine.dart';
import 'package:test/test.dart';

void main() {
  late Docker docker;

  setUp(() {
    docker = Docker();
  });

  tearDown(() {
    docker.close();
  });

  test('Build image', () async {
    var info = await docker.imageBuild();
  });
}
