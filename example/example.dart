import 'package:docker_engine/docker_engine.dart';

void main() async {
  var api = Docker();
  var images = await api.imageList();
  print(images);

  for (var image in images) {
    print(image.id);
    var inspect = await api.imageInspect(image.id.split(':').last);
    print(inspect.author);
    print(inspect.os);

    print('image ${image.id} ${image.labels}');
  }

  //api.container.containerCreate(body: ContainerConfig());
  var containers = await api.containerList(all: true);
  print('$containers');

  api.close();
}
