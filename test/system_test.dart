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

  test('Ping', () async {
    var pong = await docker.systemPing();
    expect(pong, 'OK');
    await docker.systemPingHead();
  });
}
