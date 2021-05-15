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

  test('Get info', () async {
    var info = await docker.systemInfo();
    expect(info.architecture, isNotEmpty);
    expect(info.images, greaterThan(0));
  });
}
