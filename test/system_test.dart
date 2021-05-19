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

  test('Events', () async {
    var events = await docker.systemEvents(
        since: ((DateTime.now().millisecondsSinceEpoch / 1000) - 60)
            .toStringAsFixed(0));
    expect(events, {});
  });

  test('Data usage', () async {
    var dataUsage = await docker.systemDataUsage();
    expect(dataUsage.images, hasLength(greaterThan(0)));
  });
}
