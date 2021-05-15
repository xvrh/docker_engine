// Generated code - Do not edit manually

import 'api_utils.dart';

// ignore_for_file: deprecated_member_use_from_same_package

/// The Engine API is an HTTP API served by Docker Engine. It is the API the
/// Docker client uses to communicate with the Engine, so everything the Docker
/// client can do can be done with the API.
///
/// Most of the client's commands map directly to API endpoints (e.g. `docker
/// ps`
/// is `GET /containers/json`). The notable exception is running containers,
/// which consists of several API calls.
///
/// # Errors
///
/// The API uses standard HTTP status codes to indicate the success or failure
/// of the API call. The body of the response will be JSON in the following
/// format:
///
/// ```
/// {
///   "message": "page not found"
/// }
/// ```
///
/// # Versioning
///
/// The API is usually changed in each release, so API calls are versioned to
/// ensure that clients don't break. To lock to a specific version of the API,
/// you prefix the URL with its version, for example, call `/v1.30/info` to use
/// the v1.30 version of the `/info` endpoint. If the API version specified in
/// the URL is not supported by the daemon, a HTTP `400 Bad Request` error
/// message
/// is returned.
///
/// If you omit the version-prefix, the current version of the API (v1.41) is
/// used.
/// For example, calling `/info` is the same as calling `/v1.41/info`. Using the
/// API without a version-prefix is deprecated and will be removed in a future
/// release.
///
/// Engine releases in the near future should support this version of the API,
/// so your client will continue to work even if it is talking to a newer
/// Engine.
///
/// The API uses an open schema model, which means server may add extra
/// properties
/// to responses. Likewise, the server will ignore any extra query parameters
/// and
/// request body properties. When you write clients, you need to ignore
/// additional
/// properties in responses to ensure they do not break when talking to newer
/// daemons.
///
///
/// # Authentication
///
/// Authentication for registries is handled client side. The client has to send
/// authentication details to various endpoints that need to communicate with
/// registries, such as `POST /images/(name)/push`. These are sent as
/// `X-Registry-Auth` header as a
/// [base64url encoded](https://tools.ietf.org/html/rfc4648#section-5)
/// (JSON) string with the following structure:
///
/// ```
/// {
///   "username": "string",
///   "password": "string",
///   "email": "string",
///   "serveraddress": "string"
/// }
/// ```
///
/// The `serveraddress` is a domain/IP without a protocol. Throughout this
/// structure, double quotes are required.
///
/// If you have already got an identity token from the
/// [`/auth` endpoint](#operation/SystemAuth),
/// you can just pass this instead of credentials:
///
/// ```
/// {
///   "identitytoken": "9cbaf023786cd7..."
/// }
/// ```

class Docker {
  final ApiClient _client;

  Docker({String? socketPath})
      : _client = ApiClient(socketPath: socketPath, basePath: '/v1.41');

  void close() => _client.close();

  /// Returns a list of containers. For details on the format, see the
  /// [inspect endpoint](#operation/ContainerInspect).
  ///
  /// Note that it uses a different, smaller representation of a container
  /// than inspecting a single container. For example, the list of linked
  /// containers is not propagated .
  Future<List<ContainerSummary>> containerList(
      {bool? all, int? limit, bool? size, String? filters}) async {
    return (await _client.send(
      'get',
      'containers/json',
      queryParameters: {
        if (all != null) 'all': '$all',
        if (limit != null) 'limit': '$limit',
        if (size != null) 'size': '$size',
        if (filters != null) 'filters': filters,
      },
    ) as List<Object?>)
        .map((i) =>
            ContainerSummary.fromJson(i as Map<String, Object?>? ?? const {}))
        .toList();
  }

  Future<Map<String, dynamic>> containerCreate(
      {String? name, required ContainerConfig body}) async {
    return await _client.send(
      'post',
      'containers/create',
      queryParameters: {
        if (name != null) 'name': name,
      },
    ) as Map<String, Object?>;
  }

  /// Return low-level information about a container.
  Future<Map<String, dynamic>> containerInspect(
      {required String id, bool? size}) async {
    return await _client.send(
      'get',
      'containers/{id}/json',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (size != null) 'size': '$size',
      },
    ) as Map<String, Object?>;
  }

  /// On Unix systems, this is done by running the `ps` command. This endpoint
  /// is not supported on Windows.
  Future<Map<String, dynamic>> containerTop(
      {required String id, String? psArgs}) async {
    return await _client.send(
      'get',
      'containers/{id}/top',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (psArgs != null) 'ps_args': psArgs,
      },
    ) as Map<String, Object?>;
  }

  /// Get `stdout` and `stderr` logs from a container.
  ///
  /// Note: This endpoint works only for containers with the `json-file` or
  /// `journald` logging driver.
  Future<String> containerLogs(
      {required String id,
      bool? follow,
      bool? stdout,
      bool? stderr,
      int? since,
      int? until,
      bool? timestamps,
      String? tail}) async {
    return await _client.send(
      'get',
      'containers/{id}/logs',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (follow != null) 'follow': '$follow',
        if (stdout != null) 'stdout': '$stdout',
        if (stderr != null) 'stderr': '$stderr',
        if (since != null) 'since': '$since',
        if (until != null) 'until': '$until',
        if (timestamps != null) 'timestamps': '$timestamps',
        if (tail != null) 'tail': tail,
      },
    ) as String;
  }

  /// Returns which files in a container's filesystem have been added, deleted,
  /// or modified. The `Kind` of modification can be one of:
  ///
  /// - `0`: Modified
  /// - `1`: Added
  /// - `2`: Deleted
  Future<List<Map<String, dynamic>>> containerChanges(String id) async {
    return (await _client.send(
      'get',
      'containers/{id}/changes',
      pathParameters: {
        'id': id,
      },
    ) as List<Object?>)
        .map((i) => i as Map<String, Object?>? ?? {})
        .toList();
  }

  /// Export the contents of a container as a tarball.
  Future<void> containerExport(String id) async {
    await _client.send(
      'get',
      'containers/{id}/export',
      pathParameters: {
        'id': id,
      },
    );
  }

  /// This endpoint returns a live stream of a container’s resource usage
  /// statistics.
  ///
  /// The `precpu_stats` is the CPU statistic of the *previous* read, and is
  /// used to calculate the CPU usage percentage. It is not an exact copy
  /// of the `cpu_stats` field.
  ///
  /// If either `precpu_stats.online_cpus` or `cpu_stats.online_cpus` is
  /// nil then for compatibility with older daemons the length of the
  /// corresponding `cpu_usage.percpu_usage` array should be used.
  ///
  /// On a cgroup v2 host, the following fields are not set
  /// * `blkio_stats`: all fields other than `io_service_bytes_recursive`
  /// * `cpu_stats`: `cpu_usage.percpu_usage`
  /// * `memory_stats`: `max_usage` and `failcnt`
  /// Also, `memory_stats.stats` fields are incompatible with cgroup v1.
  ///
  /// To calculate the values shown by the `stats` command of the docker cli
  /// tool
  /// the following formulas can be used:
  /// * used_memory = `memory_stats.usage - memory_stats.stats.cache`
  /// * available_memory = `memory_stats.limit`
  /// * Memory usage % = `(used_memory / available_memory) * 100.0`
  /// * cpu_delta = `cpu_stats.cpu_usage.total_usage -
  /// precpu_stats.cpu_usage.total_usage`
  /// * system_cpu_delta = `cpu_stats.system_cpu_usage -
  /// precpu_stats.system_cpu_usage`
  /// * number_cpus = `lenght(cpu_stats.cpu_usage.percpu_usage)` or
  /// `cpu_stats.online_cpus`
  /// * CPU usage % = `(cpu_delta / system_cpu_delta) * number_cpus * 100.0`
  Future<Map<String, dynamic>> containerStats(
      {required String id, bool? stream, bool? oneShot}) async {
    return await _client.send(
      'get',
      'containers/{id}/stats',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (stream != null) 'stream': '$stream',
        if (oneShot != null) 'one-shot': '$oneShot',
      },
    ) as Map<String, Object?>;
  }

  /// Resize the TTY for a container.
  Future<void> containerResize({required String id, int? h, int? w}) async {
    await _client.send(
      'post',
      'containers/{id}/resize',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (h != null) 'h': '$h',
        if (w != null) 'w': '$w',
      },
    );
  }

  Future<void> containerStart({required String id, String? detachKeys}) async {
    await _client.send(
      'post',
      'containers/{id}/start',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (detachKeys != null) 'detachKeys': detachKeys,
      },
    );
  }

  Future<void> containerStop({required String id, int? t}) async {
    await _client.send(
      'post',
      'containers/{id}/stop',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (t != null) 't': '$t',
      },
    );
  }

  Future<void> containerRestart({required String id, int? t}) async {
    await _client.send(
      'post',
      'containers/{id}/restart',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (t != null) 't': '$t',
      },
    );
  }

  /// Send a POSIX signal to a container, defaulting to killing to the
  /// container.
  Future<void> containerKill({required String id, String? signal}) async {
    await _client.send(
      'post',
      'containers/{id}/kill',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (signal != null) 'signal': signal,
      },
    );
  }

  /// Change various configuration options of a container without having to
  /// recreate it.
  Future<Map<String, dynamic>> containerUpdate(
      {required String id, required Resources update}) async {
    return await _client.send(
      'post',
      'containers/{id}/update',
      pathParameters: {
        'id': id,
      },
    ) as Map<String, Object?>;
  }

  Future<void> containerRename(
      {required String id, required String name}) async {
    await _client.send(
      'post',
      'containers/{id}/rename',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        'name': name,
      },
    );
  }

  /// Use the freezer cgroup to suspend all processes in a container.
  ///
  /// Traditionally, when suspending a process the `SIGSTOP` signal is used,
  /// which is observable by the process being suspended. With the freezer
  /// cgroup the process is unaware, and unable to capture, that it is being
  /// suspended, and subsequently resumed.
  Future<void> containerPause(String id) async {
    await _client.send(
      'post',
      'containers/{id}/pause',
      pathParameters: {
        'id': id,
      },
    );
  }

  /// Resume a container which has been paused.
  Future<void> containerUnpause(String id) async {
    await _client.send(
      'post',
      'containers/{id}/unpause',
      pathParameters: {
        'id': id,
      },
    );
  }

  /// Attach to a container to read its output or send it input. You can attach
  /// to the same container multiple times and you can reattach to containers
  /// that have been detached.
  ///
  /// Either the `stream` or `logs` parameter must be `true` for this endpoint
  /// to do anything.
  ///
  /// See the
  /// [documentation for the `docker attach` command](https://docs.docker.com/engine/reference/commandline/attach/)
  /// for more details.
  ///
  /// ### Hijacking
  ///
  /// This endpoint hijacks the HTTP connection to transport `stdin`, `stdout`,
  /// and `stderr` on the same socket.
  ///
  /// This is the response from the daemon for an attach request:
  ///
  /// ```
  /// HTTP/1.1 200 OK
  /// Content-Type: application/vnd.docker.raw-stream
  ///
  /// [STREAM]
  /// ```
  ///
  /// After the headers and two new lines, the TCP connection can now be used
  /// for raw, bidirectional communication between the client and server.
  ///
  /// To hint potential proxies about connection hijacking, the Docker client
  /// can also optionally send connection upgrade headers.
  ///
  /// For example, the client sends this request to upgrade the connection:
  ///
  /// ```
  /// POST /containers/16253994b7c4/attach?stream=1&stdout=1 HTTP/1.1
  /// Upgrade: tcp
  /// Connection: Upgrade
  /// ```
  ///
  /// The Docker daemon will respond with a `101 UPGRADED` response, and will
  /// similarly follow with the raw stream:
  ///
  /// ```
  /// HTTP/1.1 101 UPGRADED
  /// Content-Type: application/vnd.docker.raw-stream
  /// Connection: Upgrade
  /// Upgrade: tcp
  ///
  /// [STREAM]
  /// ```
  ///
  /// ### Stream format
  ///
  /// When the TTY setting is disabled in
  /// [`POST /containers/create`](#operation/ContainerCreate),
  /// the stream over the hijacked connected is multiplexed to separate out
  /// `stdout` and `stderr`. The stream consists of a series of frames, each
  /// containing a header and a payload.
  ///
  /// The header contains the information which the stream writes (`stdout` or
  /// `stderr`). It also contains the size of the associated frame encoded in
  /// the last four bytes (`uint32`).
  ///
  /// It is encoded on the first eight bytes like this:
  ///
  /// ```go
  /// header := [8]byte{STREAM_TYPE, 0, 0, 0, SIZE1, SIZE2, SIZE3, SIZE4}
  /// ```
  ///
  /// `STREAM_TYPE` can be:
  ///
  /// - 0: `stdin` (is written on `stdout`)
  /// - 1: `stdout`
  /// - 2: `stderr`
  ///
  /// `SIZE1, SIZE2, SIZE3, SIZE4` are the four bytes of the `uint32` size
  /// encoded as big endian.
  ///
  /// Following the header is the payload, which is the specified number of
  /// bytes of `STREAM_TYPE`.
  ///
  /// The simplest way to implement this protocol is the following:
  ///
  /// 1. Read 8 bytes.
  /// 2. Choose `stdout` or `stderr` depending on the first byte.
  /// 3. Extract the frame size from the last four bytes.
  /// 4. Read the extracted size and output it on the correct output.
  /// 5. Goto 1.
  ///
  /// ### Stream format when using a TTY
  ///
  /// When the TTY setting is enabled in
  /// [`POST /containers/create`](#operation/ContainerCreate),
  /// the stream is not multiplexed. The data exchanged over the hijacked
  /// connection is simply the raw data from the process PTY and client's
  /// `stdin`.
  Future<void> containerAttach(
      {required String id,
      String? detachKeys,
      bool? logs,
      bool? stream,
      bool? stdin,
      bool? stdout,
      bool? stderr}) async {
    await _client.send(
      'post',
      'containers/{id}/attach',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (detachKeys != null) 'detachKeys': detachKeys,
        if (logs != null) 'logs': '$logs',
        if (stream != null) 'stream': '$stream',
        if (stdin != null) 'stdin': '$stdin',
        if (stdout != null) 'stdout': '$stdout',
        if (stderr != null) 'stderr': '$stderr',
      },
    );
  }

  Future<void> containerAttachWebsocket(
      {required String id,
      String? detachKeys,
      bool? logs,
      bool? stream,
      bool? stdin,
      bool? stdout,
      bool? stderr}) async {
    await _client.send(
      'get',
      'containers/{id}/attach/ws',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (detachKeys != null) 'detachKeys': detachKeys,
        if (logs != null) 'logs': '$logs',
        if (stream != null) 'stream': '$stream',
        if (stdin != null) 'stdin': '$stdin',
        if (stdout != null) 'stdout': '$stdout',
        if (stderr != null) 'stderr': '$stderr',
      },
    );
  }

  /// Block until a container stops, then returns the exit code.
  Future<Map<String, dynamic>> containerWait(
      {required String id, String? condition}) async {
    return await _client.send(
      'post',
      'containers/{id}/wait',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (condition != null) 'condition': condition,
      },
    ) as Map<String, Object?>;
  }

  Future<void> containerDelete(
      {required String id, bool? v, bool? force, bool? link}) async {
    await _client.send(
      'delete',
      'containers/{id}',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (v != null) 'v': '$v',
        if (force != null) 'force': '$force',
        if (link != null) 'link': '$link',
      },
    );
  }

  /// A response header `X-Docker-Container-Path-Stat` is returned, containing
  /// a base64 - encoded JSON object with some filesystem header information
  /// about the path.
  Future<void> containerArchiveInfo(
      {required String id, required String path}) async {
    await _client.send(
      'head',
      'containers/{id}/archive',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        'path': path,
      },
    );
  }

  /// Get a tar archive of a resource in the filesystem of container id.
  Future<void> containerArchive(
      {required String id, required String path}) async {
    await _client.send(
      'get',
      'containers/{id}/archive',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        'path': path,
      },
    );
  }

  /// Upload a tar archive to be extracted to a path in the filesystem of
  /// container id.
  Future<void> putContainerArchive(
      {required String id,
      required String path,
      String? noOverwriteDirNonDir,
      String? copyUidgid,
      required String inputStream}) async {
    await _client.send(
      'put',
      'containers/{id}/archive',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        'path': path,
        if (noOverwriteDirNonDir != null)
          'noOverwriteDirNonDir': noOverwriteDirNonDir,
        if (copyUidgid != null) 'copyUIDGID': copyUidgid,
      },
    );
  }

  Future<Map<String, dynamic>> containerPrune({String? filters}) async {
    return await _client.send(
      'post',
      'containers/prune',
      queryParameters: {
        if (filters != null) 'filters': filters,
      },
    ) as Map<String, Object?>;
  }

  /// Returns a list of images on the server. Note that it uses a different,
  /// smaller representation of an image than inspecting a single image.
  Future<List<ImageSummary>> imageList(
      {bool? all, String? filters, bool? digests}) async {
    return (await _client.send(
      'get',
      'images/json',
      queryParameters: {
        if (all != null) 'all': '$all',
        if (filters != null) 'filters': filters,
        if (digests != null) 'digests': '$digests',
      },
    ) as List<Object?>)
        .map((i) =>
            ImageSummary.fromJson(i as Map<String, Object?>? ?? const {}))
        .toList();
  }

  /// Build an image from a tar archive with a `Dockerfile` in it.
  ///
  /// The `Dockerfile` specifies how the image is built from the tar archive. It
  /// is typically in the archive's root, but can be at a different path or have
  /// a different name by specifying the `dockerfile` parameter.
  /// [See the `Dockerfile` reference for more information](https://docs.docker.com/engine/reference/builder/).
  ///
  /// The Docker daemon performs a preliminary validation of the `Dockerfile`
  /// before starting the build, and returns an error if the syntax is
  /// incorrect. After that, each instruction is run one-by-one until the ID of
  /// the new image is output.
  ///
  /// The build is canceled if the client drops the connection by quitting or
  /// being killed.
  Future<void> imageBuild(
      {String? inputStream,
      String? dockerfile,
      String? t,
      String? extrahosts,
      String? remote,
      bool? q,
      bool? nocache,
      String? cachefrom,
      String? pull,
      bool? rm,
      bool? forcerm,
      int? memory,
      int? memswap,
      int? cpushares,
      String? cpusetcpus,
      int? cpuperiod,
      int? cpuquota,
      String? buildargs,
      int? shmsize,
      bool? squash,
      String? labels,
      String? networkmode,
      String? contentType,
      String? xRegistryConfig,
      String? platform,
      String? target,
      String? outputs}) async {
    await _client.send(
      'post',
      'build',
      queryParameters: {
        if (dockerfile != null) 'dockerfile': dockerfile,
        if (t != null) 't': t,
        if (extrahosts != null) 'extrahosts': extrahosts,
        if (remote != null) 'remote': remote,
        if (q != null) 'q': '$q',
        if (nocache != null) 'nocache': '$nocache',
        if (cachefrom != null) 'cachefrom': cachefrom,
        if (pull != null) 'pull': pull,
        if (rm != null) 'rm': '$rm',
        if (forcerm != null) 'forcerm': '$forcerm',
        if (memory != null) 'memory': '$memory',
        if (memswap != null) 'memswap': '$memswap',
        if (cpushares != null) 'cpushares': '$cpushares',
        if (cpusetcpus != null) 'cpusetcpus': cpusetcpus,
        if (cpuperiod != null) 'cpuperiod': '$cpuperiod',
        if (cpuquota != null) 'cpuquota': '$cpuquota',
        if (buildargs != null) 'buildargs': buildargs,
        if (shmsize != null) 'shmsize': '$shmsize',
        if (squash != null) 'squash': '$squash',
        if (labels != null) 'labels': labels,
        if (networkmode != null) 'networkmode': networkmode,
        if (platform != null) 'platform': platform,
        if (target != null) 'target': target,
        if (outputs != null) 'outputs': outputs,
      },
      headers: {
        'Content-type': 'null',
        'X-Registry-Config': 'null',
      },
    );
  }

  Future<Map<String, dynamic>> buildPrune(
      {int? keepStorage, bool? all, String? filters}) async {
    return await _client.send(
      'post',
      'build/prune',
      queryParameters: {
        if (keepStorage != null) 'keep-storage': '$keepStorage',
        if (all != null) 'all': '$all',
        if (filters != null) 'filters': filters,
      },
    ) as Map<String, Object?>;
  }

  /// Create an image by either pulling it from a registry or importing it.
  Future<void> imageCreate(
      {String? fromImage,
      String? fromSrc,
      String? repo,
      String? tag,
      String? message,
      String? inputImage,
      String? xRegistryAuth,
      String? platform}) async {
    await _client.send(
      'post',
      'images/create',
      queryParameters: {
        if (fromImage != null) 'fromImage': fromImage,
        if (fromSrc != null) 'fromSrc': fromSrc,
        if (repo != null) 'repo': repo,
        if (tag != null) 'tag': tag,
        if (message != null) 'message': message,
        if (platform != null) 'platform': platform,
      },
      headers: {
        'X-Registry-Auth': 'null',
      },
    );
  }

  /// Return low-level information about an image.
  Future<Image> imageInspect(String name) async {
    return Image.fromJson(await _client.send(
      'get',
      'images/{name}/json',
      pathParameters: {
        'name': name,
      },
    ));
  }

  /// Return parent layers of an image.
  Future<List<Map<String, dynamic>>> imageHistory(String name) async {
    return (await _client.send(
      'get',
      'images/{name}/history',
      pathParameters: {
        'name': name,
      },
    ) as List<Object?>)
        .map((i) => i as Map<String, Object?>? ?? {})
        .toList();
  }

  /// Push an image to a registry.
  ///
  /// If you wish to push an image on to a private registry, that image must
  /// already have a tag which references the registry. For example,
  /// `registry.example.com/myimage:latest`.
  ///
  /// The push is cancelled if the HTTP connection is closed.
  Future<void> imagePush(
      {required String name,
      String? tag,
      required String xRegistryAuth}) async {
    await _client.send(
      'post',
      'images/{name}/push',
      pathParameters: {
        'name': name,
      },
      queryParameters: {
        if (tag != null) 'tag': tag,
      },
      headers: {
        'X-Registry-Auth': 'null',
      },
    );
  }

  /// Tag an image so that it becomes part of a repository.
  Future<void> imageTag(
      {required String name, String? repo, String? tag}) async {
    await _client.send(
      'post',
      'images/{name}/tag',
      pathParameters: {
        'name': name,
      },
      queryParameters: {
        if (repo != null) 'repo': repo,
        if (tag != null) 'tag': tag,
      },
    );
  }

  /// Remove an image, along with any untagged parent images that were
  /// referenced by that image.
  ///
  /// Images can't be removed if they have descendant images, are being
  /// used by a running container or are being used by a build.
  Future<List<ImageDeleteResponseItem>> imageDelete(
      {required String name, bool? force, bool? noprune}) async {
    return (await _client.send(
      'delete',
      'images/{name}',
      pathParameters: {
        'name': name,
      },
      queryParameters: {
        if (force != null) 'force': '$force',
        if (noprune != null) 'noprune': '$noprune',
      },
    ) as List<Object?>)
        .map((i) => ImageDeleteResponseItem.fromJson(
            i as Map<String, Object?>? ?? const {}))
        .toList();
  }

  /// Search for an image on Docker Hub.
  Future<List<Map<String, dynamic>>> imageSearch(
      {required String term, int? limit, String? filters}) async {
    return (await _client.send(
      'get',
      'images/search',
      queryParameters: {
        'term': term,
        if (limit != null) 'limit': '$limit',
        if (filters != null) 'filters': filters,
      },
    ) as List<Object?>)
        .map((i) => i as Map<String, Object?>? ?? {})
        .toList();
  }

  Future<Map<String, dynamic>> imagePrune({String? filters}) async {
    return await _client.send(
      'post',
      'images/prune',
      queryParameters: {
        if (filters != null) 'filters': filters,
      },
    ) as Map<String, Object?>;
  }

  /// Validate credentials for a registry and, if available, get an identity
  /// token for accessing the registry without password.
  Future<Map<String, dynamic>> systemAuth({AuthConfig? authConfig}) async {
    return await _client.send(
      'post',
      'auth',
    ) as Map<String, Object?>;
  }

  Future<SystemInfo> systemInfo() async {
    return SystemInfo.fromJson(await _client.send(
      'get',
      'info',
    ));
  }

  /// Returns the version of Docker that is running and various information
  /// about the system that Docker is running on.
  Future<SystemVersion> systemVersion() async {
    return SystemVersion.fromJson(await _client.send(
      'get',
      'version',
    ));
  }

  /// This is a dummy endpoint you can use to test if the server is accessible.
  Future<String> systemPing() async {
    return await _client.send(
      'get',
      '_ping',
    ) as String;
  }

  /// This is a dummy endpoint you can use to test if the server is accessible.
  Future<String> systemPingHead() async {
    return await _client.send(
      'head',
      '_ping',
    ) as String;
  }

  Future<IdResponse> imageCommit(
      {ContainerConfig? containerConfig,
      String? container,
      String? repo,
      String? tag,
      String? comment,
      String? author,
      bool? pause,
      String? changes}) async {
    return IdResponse.fromJson(await _client.send(
      'post',
      'commit',
      queryParameters: {
        if (container != null) 'container': container,
        if (repo != null) 'repo': repo,
        if (tag != null) 'tag': tag,
        if (comment != null) 'comment': comment,
        if (author != null) 'author': author,
        if (pause != null) 'pause': '$pause',
        if (changes != null) 'changes': changes,
      },
    ));
  }

  /// Stream real-time events from the server.
  ///
  /// Various objects within Docker report events when something happens to
  /// them.
  ///
  /// Containers report these events: `attach`, `commit`, `copy`, `create`,
  /// `destroy`, `detach`, `die`, `exec_create`, `exec_detach`, `exec_start`,
  /// `exec_die`, `export`, `health_status`, `kill`, `oom`, `pause`, `rename`,
  /// `resize`, `restart`, `start`, `stop`, `top`, `unpause`, `update`, and
  /// `prune`
  ///
  /// Images report these events: `delete`, `import`, `load`, `pull`, `push`,
  /// `save`, `tag`, `untag`, and `prune`
  ///
  /// Volumes report these events: `create`, `mount`, `unmount`, `destroy`, and
  /// `prune`
  ///
  /// Networks report these events: `create`, `connect`, `disconnect`,
  /// `destroy`, `update`, `remove`, and `prune`
  ///
  /// The Docker daemon reports these events: `reload`
  ///
  /// Services report these events: `create`, `update`, and `remove`
  ///
  /// Nodes report these events: `create`, `update`, and `remove`
  ///
  /// Secrets report these events: `create`, `update`, and `remove`
  ///
  /// Configs report these events: `create`, `update`, and `remove`
  ///
  /// The Builder reports `prune` events
  Future<Map<String, dynamic>> systemEvents(
      {String? since, String? until, String? filters}) async {
    return await _client.send(
      'get',
      'events',
      queryParameters: {
        if (since != null) 'since': since,
        if (until != null) 'until': until,
        if (filters != null) 'filters': filters,
      },
    ) as Map<String, Object?>;
  }

  Future<Map<String, dynamic>> systemDataUsage() async {
    return await _client.send(
      'get',
      'system/df',
    ) as Map<String, Object?>;
  }

  /// Get a tarball containing all images and metadata for a repository.
  ///
  /// If `name` is a specific name and tag (e.g. `ubuntu:latest`), then only
  /// that image (and its parents) are returned. If `name` is an image ID,
  /// similarly only that image (and its parents) are returned, but with the
  /// exclusion of the `repositories` file in the tarball, as there were no
  /// image names referenced.
  ///
  /// ### Image tarball format
  ///
  /// An image tarball contains one directory per image layer (named using its
  /// long ID), each containing these files:
  ///
  /// - `VERSION`: currently `1.0` - the file format version
  /// - `json`: detailed layer information, similar to `docker inspect layer_id`
  /// - `layer.tar`: A tarfile containing the filesystem changes in this layer
  ///
  /// The `layer.tar` file contains `aufs` style `.wh..wh.aufs` files and
  /// directories for storing attribute changes and deletions.
  ///
  /// If the tarball defines a repository, the tarball should also include a
  /// `repositories` file at the root that contains a list of repository and tag
  /// names mapped to layer IDs.
  ///
  /// ```json
  /// {
  ///   "hello-world": {
  ///     "latest":
  /// "565a9d68a73f6706862bfe8409a7f659776d4d60a8d096eb4a3cbce6999cc2a1"
  ///   }
  /// }
  /// ```
  Future<String> imageGet(String name) async {
    return await _client.send(
      'get',
      'images/{name}/get',
      pathParameters: {
        'name': name,
      },
    ) as String;
  }

  /// Get a tarball containing all images and metadata for several image
  /// repositories.
  ///
  /// For each value of the `names` parameter: if it is a specific name and
  /// tag (e.g. `ubuntu:latest`), then only that image (and its parents) are
  /// returned; if it is an image ID, similarly only that image (and its
  /// parents)
  /// are returned and there would be no names referenced in the 'repositories'
  /// file for this image ID.
  ///
  /// For details on the format, see the
  /// [export image endpoint](#operation/ImageGet).
  Future<String> imageGetAll({List<String>? names}) async {
    return await _client.send(
      'get',
      'images/get',
      queryParameters: {
        if (names != null) 'names': '$names',
      },
    ) as String;
  }

  /// Load a set of images and tags into a repository.
  ///
  /// For details on the format, see the
  /// [export image endpoint](#operation/ImageGet).
  Future<void> imageLoad({String? imagesTarball, bool? quiet}) async {
    await _client.send(
      'post',
      'images/load',
      queryParameters: {
        if (quiet != null) 'quiet': '$quiet',
      },
    );
  }

  /// Run a command inside a running container.
  Future<IdResponse> containerExec(
      {required Map<String, dynamic> execConfig, required String id}) async {
    return IdResponse.fromJson(await _client.send(
      'post',
      'containers/{id}/exec',
      pathParameters: {
        'id': id,
      },
    ));
  }

  /// Starts a previously set up exec instance. If detach is true, this endpoint
  /// returns immediately after starting the command. Otherwise, it sets up an
  /// interactive session with the command.
  Future<void> execStart(
      {Map<String, dynamic>? execStartConfig, required String id}) async {
    await _client.send(
      'post',
      'exec/{id}/start',
      pathParameters: {
        'id': id,
      },
    );
  }

  /// Resize the TTY session used by an exec instance. This endpoint only works
  /// if `tty` was specified as part of creating and starting the exec instance.
  Future<void> execResize({required String id, int? h, int? w}) async {
    await _client.send(
      'post',
      'exec/{id}/resize',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (h != null) 'h': '$h',
        if (w != null) 'w': '$w',
      },
    );
  }

  /// Return low-level information about an exec instance.
  Future<Map<String, dynamic>> execInspect(String id) async {
    return await _client.send(
      'get',
      'exec/{id}/json',
      pathParameters: {
        'id': id,
      },
    ) as Map<String, Object?>;
  }

  Future<Map<String, dynamic>> volumeList({String? filters}) async {
    return await _client.send(
      'get',
      'volumes',
      queryParameters: {
        if (filters != null) 'filters': filters,
      },
    ) as Map<String, Object?>;
  }

  Future<Volume> volumeCreate(Map<String, dynamic> volumeConfig) async {
    return Volume.fromJson(await _client.send(
      'post',
      'volumes/create',
    ));
  }

  Future<Volume> volumeInspect(String name) async {
    return Volume.fromJson(await _client.send(
      'get',
      'volumes/{name}',
      pathParameters: {
        'name': name,
      },
    ));
  }

  /// Instruct the driver to remove the volume.
  Future<void> volumeDelete({required String name, bool? force}) async {
    await _client.send(
      'delete',
      'volumes/{name}',
      pathParameters: {
        'name': name,
      },
      queryParameters: {
        if (force != null) 'force': '$force',
      },
    );
  }

  Future<Map<String, dynamic>> volumePrune({String? filters}) async {
    return await _client.send(
      'post',
      'volumes/prune',
      queryParameters: {
        if (filters != null) 'filters': filters,
      },
    ) as Map<String, Object?>;
  }

  /// Returns a list of networks. For details on the format, see the
  /// [network inspect endpoint](#operation/NetworkInspect).
  ///
  /// Note that it uses a different, smaller representation of a network than
  /// inspecting a single network. For example, the list of containers attached
  /// to the network is not propagated in API versions 1.28 and up.
  Future<List<Network>> networkList({String? filters}) async {
    return (await _client.send(
      'get',
      'networks',
      queryParameters: {
        if (filters != null) 'filters': filters,
      },
    ) as List<Object?>)
        .map((i) => Network.fromJson(i as Map<String, Object?>? ?? const {}))
        .toList();
  }

  Future<Network> networkInspect(
      {required String id, bool? verbose, String? scope}) async {
    return Network.fromJson(await _client.send(
      'get',
      'networks/{id}',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (verbose != null) 'verbose': '$verbose',
        if (scope != null) 'scope': scope,
      },
    ));
  }

  Future<void> networkDelete(String id) async {
    await _client.send(
      'delete',
      'networks/{id}',
      pathParameters: {
        'id': id,
      },
    );
  }

  Future<Map<String, dynamic>> networkCreate(
      Map<String, dynamic> networkConfig) async {
    return await _client.send(
      'post',
      'networks/create',
    ) as Map<String, Object?>;
  }

  Future<void> networkConnect(
      {required String id, required Map<String, dynamic> container}) async {
    await _client.send(
      'post',
      'networks/{id}/connect',
      pathParameters: {
        'id': id,
      },
    );
  }

  Future<void> networkDisconnect(
      {required String id, required Map<String, dynamic> container}) async {
    await _client.send(
      'post',
      'networks/{id}/disconnect',
      pathParameters: {
        'id': id,
      },
    );
  }

  Future<Map<String, dynamic>> networkPrune({String? filters}) async {
    return await _client.send(
      'post',
      'networks/prune',
      queryParameters: {
        if (filters != null) 'filters': filters,
      },
    ) as Map<String, Object?>;
  }

  /// Returns information about installed plugins.
  Future<List<Plugin>> pluginList({String? filters}) async {
    return (await _client.send(
      'get',
      'plugins',
      queryParameters: {
        if (filters != null) 'filters': filters,
      },
    ) as List<Object?>)
        .map((i) => Plugin.fromJson(i as Map<String, Object?>? ?? const {}))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getPluginPrivileges(String remote) async {
    return (await _client.send(
      'get',
      'plugins/privileges',
      queryParameters: {
        'remote': remote,
      },
    ) as List<Object?>)
        .map((i) => i as Map<String, Object?>? ?? {})
        .toList();
  }

  /// Pulls and installs a plugin. After the plugin is installed, it can be
  /// enabled using the
  /// [`POST /plugins/{name}/enable` endpoint](#operation/PostPluginsEnable).
  Future<void> pluginPull(
      {required String remote,
      String? name,
      String? xRegistryAuth,
      List<Map<String, dynamic>>? body}) async {
    await _client.send(
      'post',
      'plugins/pull',
      queryParameters: {
        'remote': remote,
        if (name != null) 'name': name,
      },
      headers: {
        'X-Registry-Auth': 'null',
      },
    );
  }

  Future<Plugin> pluginInspect(String name) async {
    return Plugin.fromJson(await _client.send(
      'get',
      'plugins/{name}/json',
      pathParameters: {
        'name': name,
      },
    ));
  }

  Future<Plugin> pluginDelete({required String name, bool? force}) async {
    return Plugin.fromJson(await _client.send(
      'delete',
      'plugins/{name}',
      pathParameters: {
        'name': name,
      },
      queryParameters: {
        if (force != null) 'force': '$force',
      },
    ));
  }

  Future<void> pluginEnable({required String name, int? timeout}) async {
    await _client.send(
      'post',
      'plugins/{name}/enable',
      pathParameters: {
        'name': name,
      },
      queryParameters: {
        if (timeout != null) 'timeout': '$timeout',
      },
    );
  }

  Future<void> pluginDisable(String name) async {
    await _client.send(
      'post',
      'plugins/{name}/disable',
      pathParameters: {
        'name': name,
      },
    );
  }

  Future<void> pluginUpgrade(
      {required String name,
      required String remote,
      String? xRegistryAuth,
      List<Map<String, dynamic>>? body}) async {
    await _client.send(
      'post',
      'plugins/{name}/upgrade',
      pathParameters: {
        'name': name,
      },
      queryParameters: {
        'remote': remote,
      },
      headers: {
        'X-Registry-Auth': 'null',
      },
    );
  }

  Future<void> pluginCreate({required String name, String? tarContext}) async {
    await _client.send(
      'post',
      'plugins/create',
      queryParameters: {
        'name': name,
      },
    );
  }

  /// Push a plugin to the registry.
  Future<void> pluginPush(String name) async {
    await _client.send(
      'post',
      'plugins/{name}/push',
      pathParameters: {
        'name': name,
      },
    );
  }

  Future<void> pluginSet({required String name, List<String>? body}) async {
    await _client.send(
      'post',
      'plugins/{name}/set',
      pathParameters: {
        'name': name,
      },
    );
  }

  Future<List<Node>> nodeList({String? filters}) async {
    return (await _client.send(
      'get',
      'nodes',
      queryParameters: {
        if (filters != null) 'filters': filters,
      },
    ) as List<Object?>)
        .map((i) => Node.fromJson(i as Map<String, Object?>? ?? const {}))
        .toList();
  }

  Future<Node> nodeInspect(String id) async {
    return Node.fromJson(await _client.send(
      'get',
      'nodes/{id}',
      pathParameters: {
        'id': id,
      },
    ));
  }

  Future<void> nodeDelete({required String id, bool? force}) async {
    await _client.send(
      'delete',
      'nodes/{id}',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (force != null) 'force': '$force',
      },
    );
  }

  Future<void> nodeUpdate(
      {required String id, NodeSpec? body, required int version}) async {
    await _client.send(
      'post',
      'nodes/{id}/update',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        'version': '$version',
      },
    );
  }

  Future<Swarm> swarmInspect() async {
    return Swarm.fromJson(await _client.send(
      'get',
      'swarm',
    ));
  }

  Future<String> swarmInit(Map<String, dynamic> body) async {
    return await _client.send(
      'post',
      'swarm/init',
    ) as String;
  }

  Future<void> swarmJoin(Map<String, dynamic> body) async {
    await _client.send(
      'post',
      'swarm/join',
    );
  }

  Future<void> swarmLeave({bool? force}) async {
    await _client.send(
      'post',
      'swarm/leave',
      queryParameters: {
        if (force != null) 'force': '$force',
      },
    );
  }

  Future<void> swarmUpdate(
      {required SwarmSpec body,
      required int version,
      bool? rotateWorkerToken,
      bool? rotateManagerToken,
      bool? rotateManagerUnlockKey}) async {
    await _client.send(
      'post',
      'swarm/update',
      queryParameters: {
        'version': '$version',
        if (rotateWorkerToken != null)
          'rotateWorkerToken': '$rotateWorkerToken',
        if (rotateManagerToken != null)
          'rotateManagerToken': '$rotateManagerToken',
        if (rotateManagerUnlockKey != null)
          'rotateManagerUnlockKey': '$rotateManagerUnlockKey',
      },
    );
  }

  Future<Map<String, dynamic>> swarmUnlockkey() async {
    return await _client.send(
      'get',
      'swarm/unlockkey',
    ) as Map<String, Object?>;
  }

  Future<void> swarmUnlock(Map<String, dynamic> body) async {
    await _client.send(
      'post',
      'swarm/unlock',
    );
  }

  Future<List<Service>> serviceList({String? filters, bool? status}) async {
    return (await _client.send(
      'get',
      'services',
      queryParameters: {
        if (filters != null) 'filters': filters,
        if (status != null) 'status': '$status',
      },
    ) as List<Object?>)
        .map((i) => Service.fromJson(i as Map<String, Object?>? ?? const {}))
        .toList();
  }

  Future<Map<String, dynamic>> serviceCreate(
      {required ServiceSpec body, String? xRegistryAuth}) async {
    return await _client.send(
      'post',
      'services/create',
      headers: {
        'X-Registry-Auth': 'null',
      },
    ) as Map<String, Object?>;
  }

  Future<Service> serviceInspect(
      {required String id, bool? insertDefaults}) async {
    return Service.fromJson(await _client.send(
      'get',
      'services/{id}',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (insertDefaults != null) 'insertDefaults': '$insertDefaults',
      },
    ));
  }

  Future<void> serviceDelete(String id) async {
    await _client.send(
      'delete',
      'services/{id}',
      pathParameters: {
        'id': id,
      },
    );
  }

  Future<ServiceUpdateResponse> serviceUpdate(
      {required String id,
      required ServiceSpec body,
      required int version,
      String? registryAuthFrom,
      String? rollback,
      String? xRegistryAuth}) async {
    return ServiceUpdateResponse.fromJson(await _client.send(
      'post',
      'services/{id}/update',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        'version': '$version',
        if (registryAuthFrom != null) 'registryAuthFrom': registryAuthFrom,
        if (rollback != null) 'rollback': rollback,
      },
      headers: {
        'X-Registry-Auth': 'null',
      },
    ));
  }

  /// Get `stdout` and `stderr` logs from a service. See also
  /// [`/containers/{id}/logs`](#operation/ContainerLogs).
  ///
  /// **Note**: This endpoint works only for services with the `local`,
  /// `json-file` or `journald` logging drivers.
  Future<String> serviceLogs(
      {required String id,
      bool? details,
      bool? follow,
      bool? stdout,
      bool? stderr,
      int? since,
      bool? timestamps,
      String? tail}) async {
    return await _client.send(
      'get',
      'services/{id}/logs',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (details != null) 'details': '$details',
        if (follow != null) 'follow': '$follow',
        if (stdout != null) 'stdout': '$stdout',
        if (stderr != null) 'stderr': '$stderr',
        if (since != null) 'since': '$since',
        if (timestamps != null) 'timestamps': '$timestamps',
        if (tail != null) 'tail': tail,
      },
    ) as String;
  }

  Future<List<Task>> taskList({String? filters}) async {
    return (await _client.send(
      'get',
      'tasks',
      queryParameters: {
        if (filters != null) 'filters': filters,
      },
    ) as List<Object?>)
        .map((i) => Task.fromJson(i as Map<String, Object?>? ?? const {}))
        .toList();
  }

  Future<Task> taskInspect(String id) async {
    return Task.fromJson(await _client.send(
      'get',
      'tasks/{id}',
      pathParameters: {
        'id': id,
      },
    ));
  }

  /// Get `stdout` and `stderr` logs from a task.
  /// See also [`/containers/{id}/logs`](#operation/ContainerLogs).
  ///
  /// **Note**: This endpoint works only for services with the `local`,
  /// `json-file` or `journald` logging drivers.
  Future<String> taskLogs(
      {required String id,
      bool? details,
      bool? follow,
      bool? stdout,
      bool? stderr,
      int? since,
      bool? timestamps,
      String? tail}) async {
    return await _client.send(
      'get',
      'tasks/{id}/logs',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        if (details != null) 'details': '$details',
        if (follow != null) 'follow': '$follow',
        if (stdout != null) 'stdout': '$stdout',
        if (stderr != null) 'stderr': '$stderr',
        if (since != null) 'since': '$since',
        if (timestamps != null) 'timestamps': '$timestamps',
        if (tail != null) 'tail': tail,
      },
    ) as String;
  }

  Future<List<Secret>> secretList({String? filters}) async {
    return (await _client.send(
      'get',
      'secrets',
      queryParameters: {
        if (filters != null) 'filters': filters,
      },
    ) as List<Object?>)
        .map((i) => Secret.fromJson(i as Map<String, Object?>? ?? const {}))
        .toList();
  }

  Future<IdResponse> secretCreate({SecretSpec? body}) async {
    return IdResponse.fromJson(await _client.send(
      'post',
      'secrets/create',
    ));
  }

  Future<Secret> secretInspect(String id) async {
    return Secret.fromJson(await _client.send(
      'get',
      'secrets/{id}',
      pathParameters: {
        'id': id,
      },
    ));
  }

  Future<void> secretDelete(String id) async {
    await _client.send(
      'delete',
      'secrets/{id}',
      pathParameters: {
        'id': id,
      },
    );
  }

  Future<void> secretUpdate(
      {required String id, SecretSpec? body, required int version}) async {
    await _client.send(
      'post',
      'secrets/{id}/update',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        'version': '$version',
      },
    );
  }

  Future<List<Config>> configList({String? filters}) async {
    return (await _client.send(
      'get',
      'configs',
      queryParameters: {
        if (filters != null) 'filters': filters,
      },
    ) as List<Object?>)
        .map((i) => Config.fromJson(i as Map<String, Object?>? ?? const {}))
        .toList();
  }

  Future<IdResponse> configCreate({ConfigSpec? body}) async {
    return IdResponse.fromJson(await _client.send(
      'post',
      'configs/create',
    ));
  }

  Future<Config> configInspect(String id) async {
    return Config.fromJson(await _client.send(
      'get',
      'configs/{id}',
      pathParameters: {
        'id': id,
      },
    ));
  }

  Future<void> configDelete(String id) async {
    await _client.send(
      'delete',
      'configs/{id}',
      pathParameters: {
        'id': id,
      },
    );
  }

  Future<void> configUpdate(
      {required String id, ConfigSpec? body, required int version}) async {
    await _client.send(
      'post',
      'configs/{id}/update',
      pathParameters: {
        'id': id,
      },
      queryParameters: {
        'version': '$version',
      },
    );
  }

  /// Return image digest and platform information by contacting the registry.
  Future<Map<String, dynamic>> distributionInspect(String name) async {
    return await _client.send(
      'get',
      'distribution/{name}/json',
      pathParameters: {
        'name': name,
      },
    ) as Map<String, Object?>;
  }

  /// Start a new interactive session with a server. Session allows server to
  /// call back to the client for advanced capabilities.
  ///
  /// ### Hijacking
  ///
  /// This endpoint hijacks the HTTP connection to HTTP2 transport that allows
  /// the client to expose gPRC services on that connection.
  ///
  /// For example, the client sends this request to upgrade the connection:
  ///
  /// ```
  /// POST /session HTTP/1.1
  /// Upgrade: h2c
  /// Connection: Upgrade
  /// ```
  ///
  /// The Docker daemon responds with a `101 UPGRADED` response follow with
  /// the raw stream:
  ///
  /// ```
  /// HTTP/1.1 101 UPGRADED
  /// Connection: Upgrade
  /// Upgrade: h2c
  /// ```
  Future<void> session() async {
    await _client.send(
      'post',
      'session',
    );
  }
}

/// Address represents an IPv4 or IPv6 IP address.
class Address {
  /// IP address.
  final String? addr;

  /// Mask length of the IP address.
  final int? prefixLen;

  Address({this.addr, this.prefixLen});

  factory Address.fromJson(Map<String, Object?> json) {
    return Address(
      addr: json[r'Addr'] as String?,
      prefixLen: (json[r'PrefixLen'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var addr = this.addr;
    var prefixLen = this.prefixLen;

    final json = <String, Object?>{};
    if (addr != null) {
      json[r'Addr'] = addr;
    }
    if (prefixLen != null) {
      json[r'PrefixLen'] = prefixLen;
    }
    return json;
  }

  Address copyWith({String? addr, int? prefixLen}) {
    return Address(
      addr: addr ?? this.addr,
      prefixLen: prefixLen ?? this.prefixLen,
    );
  }
}

class AuthConfig {
  final String? username;
  final String? password;
  final String? email;
  final String? serveraddress;

  AuthConfig({this.username, this.password, this.email, this.serveraddress});

  factory AuthConfig.fromJson(Map<String, Object?> json) {
    return AuthConfig(
      username: json[r'username'] as String?,
      password: json[r'password'] as String?,
      email: json[r'email'] as String?,
      serveraddress: json[r'serveraddress'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var username = this.username;
    var password = this.password;
    var email = this.email;
    var serveraddress = this.serveraddress;

    final json = <String, Object?>{};
    if (username != null) {
      json[r'username'] = username;
    }
    if (password != null) {
      json[r'password'] = password;
    }
    if (email != null) {
      json[r'email'] = email;
    }
    if (serveraddress != null) {
      json[r'serveraddress'] = serveraddress;
    }
    return json;
  }

  AuthConfig copyWith(
      {String? username,
      String? password,
      String? email,
      String? serveraddress}) {
    return AuthConfig(
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      serveraddress: serveraddress ?? this.serveraddress,
    );
  }
}

class BuildCache {
  final String? id;
  final String? parent;
  final String? type;
  final String? description;
  final bool inUse;
  final bool shared;

  /// Amount of disk space used by the build cache (in bytes).
  final int? size;

  /// Date and time at which the build cache was created in
  /// [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.
  final DateTime? createdAt;

  /// Date and time at which the build cache was last used in
  /// [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.
  final DateTime? lastUsedAt;
  final int? usageCount;

  BuildCache(
      {this.id,
      this.parent,
      this.type,
      this.description,
      bool? inUse,
      bool? shared,
      this.size,
      this.createdAt,
      this.lastUsedAt,
      this.usageCount})
      : inUse = inUse ?? false,
        shared = shared ?? false;

  factory BuildCache.fromJson(Map<String, Object?> json) {
    return BuildCache(
      id: json[r'ID'] as String?,
      parent: json[r'Parent'] as String?,
      type: json[r'Type'] as String?,
      description: json[r'Description'] as String?,
      inUse: json[r'InUse'] as bool? ?? false,
      shared: json[r'Shared'] as bool? ?? false,
      size: (json[r'Size'] as num?)?.toInt(),
      createdAt: DateTime.tryParse(json[r'CreatedAt'] as String? ?? ''),
      lastUsedAt: DateTime.tryParse(json[r'LastUsedAt'] as String? ?? ''),
      usageCount: (json[r'UsageCount'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var parent = this.parent;
    var type = this.type;
    var description = this.description;
    var inUse = this.inUse;
    var shared = this.shared;
    var size = this.size;
    var createdAt = this.createdAt;
    var lastUsedAt = this.lastUsedAt;
    var usageCount = this.usageCount;

    final json = <String, Object?>{};
    if (id != null) {
      json[r'ID'] = id;
    }
    if (parent != null) {
      json[r'Parent'] = parent;
    }
    if (type != null) {
      json[r'Type'] = type;
    }
    if (description != null) {
      json[r'Description'] = description;
    }
    json[r'InUse'] = inUse;
    json[r'Shared'] = shared;
    if (size != null) {
      json[r'Size'] = size;
    }
    if (createdAt != null) {
      json[r'CreatedAt'] = createdAt.toIso8601String();
    }
    if (lastUsedAt != null) {
      json[r'LastUsedAt'] = lastUsedAt.toIso8601String();
    }
    if (usageCount != null) {
      json[r'UsageCount'] = usageCount;
    }
    return json;
  }

  BuildCache copyWith(
      {String? id,
      String? parent,
      String? type,
      String? description,
      bool? inUse,
      bool? shared,
      int? size,
      DateTime? createdAt,
      DateTime? lastUsedAt,
      int? usageCount}) {
    return BuildCache(
      id: id ?? this.id,
      parent: parent ?? this.parent,
      type: type ?? this.type,
      description: description ?? this.description,
      inUse: inUse ?? this.inUse,
      shared: shared ?? this.shared,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      usageCount: usageCount ?? this.usageCount,
    );
  }
}

class BuildInfo {
  final String? id;
  final String? stream;
  final String? error;
  final ErrorDetail? errorDetail;
  final String? status;
  final String? progress;
  final ProgressDetail? progressDetail;
  final ImageID? aux;

  BuildInfo(
      {this.id,
      this.stream,
      this.error,
      this.errorDetail,
      this.status,
      this.progress,
      this.progressDetail,
      this.aux});

  factory BuildInfo.fromJson(Map<String, Object?> json) {
    return BuildInfo(
      id: json[r'id'] as String?,
      stream: json[r'stream'] as String?,
      error: json[r'error'] as String?,
      errorDetail: json[r'errorDetail'] != null
          ? ErrorDetail.fromJson(json[r'errorDetail']! as Map<String, Object?>)
          : null,
      status: json[r'status'] as String?,
      progress: json[r'progress'] as String?,
      progressDetail: json[r'progressDetail'] != null
          ? ProgressDetail.fromJson(
              json[r'progressDetail']! as Map<String, Object?>)
          : null,
      aux: json[r'aux'] != null
          ? ImageID.fromJson(json[r'aux']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var stream = this.stream;
    var error = this.error;
    var errorDetail = this.errorDetail;
    var status = this.status;
    var progress = this.progress;
    var progressDetail = this.progressDetail;
    var aux = this.aux;

    final json = <String, Object?>{};
    if (id != null) {
      json[r'id'] = id;
    }
    if (stream != null) {
      json[r'stream'] = stream;
    }
    if (error != null) {
      json[r'error'] = error;
    }
    if (errorDetail != null) {
      json[r'errorDetail'] = errorDetail.toJson();
    }
    if (status != null) {
      json[r'status'] = status;
    }
    if (progress != null) {
      json[r'progress'] = progress;
    }
    if (progressDetail != null) {
      json[r'progressDetail'] = progressDetail.toJson();
    }
    if (aux != null) {
      json[r'aux'] = aux.toJson();
    }
    return json;
  }

  BuildInfo copyWith(
      {String? id,
      String? stream,
      String? error,
      ErrorDetail? errorDetail,
      String? status,
      String? progress,
      ProgressDetail? progressDetail,
      ImageID? aux}) {
    return BuildInfo(
      id: id ?? this.id,
      stream: stream ?? this.stream,
      error: error ?? this.error,
      errorDetail: errorDetail ?? this.errorDetail,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      progressDetail: progressDetail ?? this.progressDetail,
      aux: aux ?? this.aux,
    );
  }
}

/// ClusterInfo represents information about the swarm as is returned by the
/// "/info" endpoint. Join-tokens are not included.
class ClusterInfo {
  /// The ID of the swarm.
  final String? id;
  final ObjectVersion? version;

  /// Date and time at which the swarm was initialised in
  /// [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.
  final DateTime? createdAt;

  /// Date and time at which the swarm was last updated in
  /// [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.
  final DateTime? updatedAt;
  final SwarmSpec? spec;
  final TLSInfo? tlsInfo;

  /// Whether there is currently a root CA rotation in progress for the swarm
  final bool rootRotationInProgress;

  /// DataPathPort specifies the data path port number for data traffic.
  /// Acceptable port range is 1024 to 49151.
  /// If no port is set or is set to 0, the default port (4789) is used.
  final int? dataPathPort;

  /// Default Address Pool specifies default subnet pools for global scope
  /// networks.
  final List<String> defaultAddrPool;

  /// SubnetSize specifies the subnet size of the networks created from the
  /// default subnet pool.
  final int? subnetSize;

  ClusterInfo(
      {this.id,
      this.version,
      this.createdAt,
      this.updatedAt,
      this.spec,
      this.tlsInfo,
      bool? rootRotationInProgress,
      this.dataPathPort,
      List<String>? defaultAddrPool,
      this.subnetSize})
      : rootRotationInProgress = rootRotationInProgress ?? false,
        defaultAddrPool = defaultAddrPool ?? [];

  factory ClusterInfo.fromJson(Map<String, Object?> json) {
    return ClusterInfo(
      id: json[r'ID'] as String?,
      version: json[r'Version'] != null
          ? ObjectVersion.fromJson(json[r'Version']! as Map<String, Object?>)
          : null,
      createdAt: DateTime.tryParse(json[r'CreatedAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json[r'UpdatedAt'] as String? ?? ''),
      spec: json[r'Spec'] != null
          ? SwarmSpec.fromJson(json[r'Spec']! as Map<String, Object?>)
          : null,
      tlsInfo: json[r'TLSInfo'] != null
          ? TLSInfo.fromJson(json[r'TLSInfo']! as Map<String, Object?>)
          : null,
      rootRotationInProgress: json[r'RootRotationInProgress'] as bool? ?? false,
      dataPathPort: (json[r'DataPathPort'] as num?)?.toInt(),
      defaultAddrPool: (json[r'DefaultAddrPool'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      subnetSize: (json[r'SubnetSize'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var version = this.version;
    var createdAt = this.createdAt;
    var updatedAt = this.updatedAt;
    var spec = this.spec;
    var tlsInfo = this.tlsInfo;
    var rootRotationInProgress = this.rootRotationInProgress;
    var dataPathPort = this.dataPathPort;
    var defaultAddrPool = this.defaultAddrPool;
    var subnetSize = this.subnetSize;

    final json = <String, Object?>{};
    if (id != null) {
      json[r'ID'] = id;
    }
    if (version != null) {
      json[r'Version'] = version.toJson();
    }
    if (createdAt != null) {
      json[r'CreatedAt'] = createdAt.toIso8601String();
    }
    if (updatedAt != null) {
      json[r'UpdatedAt'] = updatedAt.toIso8601String();
    }
    if (spec != null) {
      json[r'Spec'] = spec.toJson();
    }
    if (tlsInfo != null) {
      json[r'TLSInfo'] = tlsInfo.toJson();
    }
    json[r'RootRotationInProgress'] = rootRotationInProgress;
    if (dataPathPort != null) {
      json[r'DataPathPort'] = dataPathPort;
    }
    json[r'DefaultAddrPool'] = defaultAddrPool;
    if (subnetSize != null) {
      json[r'SubnetSize'] = subnetSize;
    }
    return json;
  }

  ClusterInfo copyWith(
      {String? id,
      ObjectVersion? version,
      DateTime? createdAt,
      DateTime? updatedAt,
      SwarmSpec? spec,
      TLSInfo? tlsInfo,
      bool? rootRotationInProgress,
      int? dataPathPort,
      List<String>? defaultAddrPool,
      int? subnetSize}) {
    return ClusterInfo(
      id: id ?? this.id,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      spec: spec ?? this.spec,
      tlsInfo: tlsInfo ?? this.tlsInfo,
      rootRotationInProgress:
          rootRotationInProgress ?? this.rootRotationInProgress,
      dataPathPort: dataPathPort ?? this.dataPathPort,
      defaultAddrPool: defaultAddrPool ?? this.defaultAddrPool,
      subnetSize: subnetSize ?? this.subnetSize,
    );
  }
}

/// Commit holds the Git-commit (SHA1) that a binary was built from, as
/// reported in the version-string of external tools, such as `containerd`,
/// or `runC`.
class Commit {
  /// Actual commit ID of external tool.
  final String? id;

  /// Commit ID of external tool expected by dockerd as set at build time.
  final String? expected;

  Commit({this.id, this.expected});

  factory Commit.fromJson(Map<String, Object?> json) {
    return Commit(
      id: json[r'ID'] as String?,
      expected: json[r'Expected'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var expected = this.expected;

    final json = <String, Object?>{};
    if (id != null) {
      json[r'ID'] = id;
    }
    if (expected != null) {
      json[r'Expected'] = expected;
    }
    return json;
  }

  Commit copyWith({String? id, String? expected}) {
    return Commit(
      id: id ?? this.id,
      expected: expected ?? this.expected,
    );
  }
}

class Config {
  final String? id;
  final ObjectVersion? version;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ConfigSpec? spec;

  Config({this.id, this.version, this.createdAt, this.updatedAt, this.spec});

  factory Config.fromJson(Map<String, Object?> json) {
    return Config(
      id: json[r'ID'] as String?,
      version: json[r'Version'] != null
          ? ObjectVersion.fromJson(json[r'Version']! as Map<String, Object?>)
          : null,
      createdAt: DateTime.tryParse(json[r'CreatedAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json[r'UpdatedAt'] as String? ?? ''),
      spec: json[r'Spec'] != null
          ? ConfigSpec.fromJson(json[r'Spec']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var version = this.version;
    var createdAt = this.createdAt;
    var updatedAt = this.updatedAt;
    var spec = this.spec;

    final json = <String, Object?>{};
    if (id != null) {
      json[r'ID'] = id;
    }
    if (version != null) {
      json[r'Version'] = version.toJson();
    }
    if (createdAt != null) {
      json[r'CreatedAt'] = createdAt.toIso8601String();
    }
    if (updatedAt != null) {
      json[r'UpdatedAt'] = updatedAt.toIso8601String();
    }
    if (spec != null) {
      json[r'Spec'] = spec.toJson();
    }
    return json;
  }

  Config copyWith(
      {String? id,
      ObjectVersion? version,
      DateTime? createdAt,
      DateTime? updatedAt,
      ConfigSpec? spec}) {
    return Config(
      id: id ?? this.id,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      spec: spec ?? this.spec,
    );
  }
}

class ConfigSpec {
  /// User-defined name of the config.
  final String? name;

  /// User-defined key/value metadata.
  final Map<String, dynamic>? labels;

  /// Base64-url-safe-encoded
  /// ([RFC 4648](https://tools.ietf.org/html/rfc4648#section-5))
  /// config data.
  final String? data;

  /// Templating driver, if applicable
  ///
  /// Templating controls whether and how to evaluate the config payload as
  /// a template. If no driver is set, no templating is used.
  final Driver? templating;

  ConfigSpec({this.name, this.labels, this.data, this.templating});

  factory ConfigSpec.fromJson(Map<String, Object?> json) {
    return ConfigSpec(
      name: json[r'Name'] as String?,
      labels: json[r'Labels'] as Map<String, Object?>?,
      data: json[r'Data'] as String?,
      templating: json[r'Templating'] != null
          ? Driver.fromJson(json[r'Templating']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var labels = this.labels;
    var data = this.data;
    var templating = this.templating;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (labels != null) {
      json[r'Labels'] = labels;
    }
    if (data != null) {
      json[r'Data'] = data;
    }
    if (templating != null) {
      json[r'Templating'] = templating.toJson();
    }
    return json;
  }

  ConfigSpec copyWith(
      {String? name,
      Map<String, dynamic>? labels,
      String? data,
      Driver? templating}) {
    return ConfigSpec(
      name: name ?? this.name,
      labels: labels ?? this.labels,
      data: data ?? this.data,
      templating: templating ?? this.templating,
    );
  }
}

/// Configuration for a container that is portable between hosts
class ContainerConfig {
  /// The hostname to use for the container, as a valid RFC 1123 hostname.
  final String? hostname;

  /// The domain name to use for the container.
  final String? domainname;

  /// The user that commands are run as inside the container.
  final String? user;

  /// Whether to attach to `stdin`.
  final bool attachStdin;

  /// Whether to attach to `stdout`.
  final bool attachStdout;

  /// Whether to attach to `stderr`.
  final bool attachStderr;

  /// An object mapping ports to an empty object in the form:
  ///
  /// `{"<port>/<tcp|udp|sctp>": {}}`
  final Map<String, dynamic>? exposedPorts;

  /// Attach standard streams to a TTY, including `stdin` if it is not closed.
  final bool tty;

  /// Open `stdin`
  final bool openStdin;

  /// Close `stdin` after one attached client disconnects
  final bool stdinOnce;

  /// A list of environment variables to set inside the container in the
  /// form `["VAR=value", ...]`. A variable without `=` is removed from the
  /// environment, rather than to have an empty value.
  final List<String> env;

  /// Command to run specified as a string or an array of strings.
  final List<String> cmd;
  final HealthConfig? healthcheck;

  /// Command is already escaped (Windows only)
  final bool argsEscaped;

  /// The name of the image to use when creating the container/
  final String? image;

  /// An object mapping mount point paths inside the container to empty
  /// objects.
  final Map<String, dynamic>? volumes;

  /// The working directory for commands to run in.
  final String? workingDir;

  /// The entry point for the container as a string or an array of strings.
  ///
  /// If the array consists of exactly one empty string (`[""]`) then the
  /// entry point is reset to system default (i.e., the entry point used by
  /// docker when there is no `ENTRYPOINT` instruction in the `Dockerfile`).
  final List<String> entrypoint;

  /// Disable networking for the container.
  final bool networkDisabled;

  /// MAC address of the container.
  final String? macAddress;

  /// `ONBUILD` metadata that were defined in the image's `Dockerfile`.
  final List<String> onBuild;

  /// User-defined key/value metadata.
  final Map<String, dynamic>? labels;

  /// Signal to stop a container as a string or unsigned integer.
  final String? stopSignal;

  /// Timeout to stop a container in seconds.
  final int? stopTimeout;

  /// Shell for when `RUN`, `CMD`, and `ENTRYPOINT` uses a shell.
  final List<String> shell;

  ContainerConfig(
      {this.hostname,
      this.domainname,
      this.user,
      bool? attachStdin,
      bool? attachStdout,
      bool? attachStderr,
      this.exposedPorts,
      bool? tty,
      bool? openStdin,
      bool? stdinOnce,
      List<String>? env,
      List<String>? cmd,
      this.healthcheck,
      bool? argsEscaped,
      this.image,
      this.volumes,
      this.workingDir,
      List<String>? entrypoint,
      bool? networkDisabled,
      this.macAddress,
      List<String>? onBuild,
      this.labels,
      this.stopSignal,
      this.stopTimeout,
      List<String>? shell})
      : attachStdin = attachStdin ?? false,
        attachStdout = attachStdout ?? false,
        attachStderr = attachStderr ?? false,
        tty = tty ?? false,
        openStdin = openStdin ?? false,
        stdinOnce = stdinOnce ?? false,
        env = env ?? [],
        cmd = cmd ?? [],
        argsEscaped = argsEscaped ?? false,
        entrypoint = entrypoint ?? [],
        networkDisabled = networkDisabled ?? false,
        onBuild = onBuild ?? [],
        shell = shell ?? [];

  factory ContainerConfig.fromJson(Map<String, Object?> json) {
    return ContainerConfig(
      hostname: json[r'Hostname'] as String?,
      domainname: json[r'Domainname'] as String?,
      user: json[r'User'] as String?,
      attachStdin: json[r'AttachStdin'] as bool? ?? false,
      attachStdout: json[r'AttachStdout'] as bool? ?? false,
      attachStderr: json[r'AttachStderr'] as bool? ?? false,
      exposedPorts: json[r'ExposedPorts'] as Map<String, Object?>?,
      tty: json[r'Tty'] as bool? ?? false,
      openStdin: json[r'OpenStdin'] as bool? ?? false,
      stdinOnce: json[r'StdinOnce'] as bool? ?? false,
      env: (json[r'Env'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      cmd: (json[r'Cmd'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      healthcheck: json[r'Healthcheck'] != null
          ? HealthConfig.fromJson(json[r'Healthcheck']! as Map<String, Object?>)
          : null,
      argsEscaped: json[r'ArgsEscaped'] as bool? ?? false,
      image: json[r'Image'] as String?,
      volumes: json[r'Volumes'] as Map<String, Object?>?,
      workingDir: json[r'WorkingDir'] as String?,
      entrypoint: (json[r'Entrypoint'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      networkDisabled: json[r'NetworkDisabled'] as bool? ?? false,
      macAddress: json[r'MacAddress'] as String?,
      onBuild: (json[r'OnBuild'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      labels: json[r'Labels'] as Map<String, Object?>?,
      stopSignal: json[r'StopSignal'] as String?,
      stopTimeout: (json[r'StopTimeout'] as num?)?.toInt(),
      shell: (json[r'Shell'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var hostname = this.hostname;
    var domainname = this.domainname;
    var user = this.user;
    var attachStdin = this.attachStdin;
    var attachStdout = this.attachStdout;
    var attachStderr = this.attachStderr;
    var exposedPorts = this.exposedPorts;
    var tty = this.tty;
    var openStdin = this.openStdin;
    var stdinOnce = this.stdinOnce;
    var env = this.env;
    var cmd = this.cmd;
    var healthcheck = this.healthcheck;
    var argsEscaped = this.argsEscaped;
    var image = this.image;
    var volumes = this.volumes;
    var workingDir = this.workingDir;
    var entrypoint = this.entrypoint;
    var networkDisabled = this.networkDisabled;
    var macAddress = this.macAddress;
    var onBuild = this.onBuild;
    var labels = this.labels;
    var stopSignal = this.stopSignal;
    var stopTimeout = this.stopTimeout;
    var shell = this.shell;

    final json = <String, Object?>{};
    if (hostname != null) {
      json[r'Hostname'] = hostname;
    }
    if (domainname != null) {
      json[r'Domainname'] = domainname;
    }
    if (user != null) {
      json[r'User'] = user;
    }
    json[r'AttachStdin'] = attachStdin;
    json[r'AttachStdout'] = attachStdout;
    json[r'AttachStderr'] = attachStderr;
    if (exposedPorts != null) {
      json[r'ExposedPorts'] = exposedPorts;
    }
    json[r'Tty'] = tty;
    json[r'OpenStdin'] = openStdin;
    json[r'StdinOnce'] = stdinOnce;
    json[r'Env'] = env;
    json[r'Cmd'] = cmd;
    if (healthcheck != null) {
      json[r'Healthcheck'] = healthcheck.toJson();
    }
    json[r'ArgsEscaped'] = argsEscaped;
    if (image != null) {
      json[r'Image'] = image;
    }
    if (volumes != null) {
      json[r'Volumes'] = volumes;
    }
    if (workingDir != null) {
      json[r'WorkingDir'] = workingDir;
    }
    json[r'Entrypoint'] = entrypoint;
    json[r'NetworkDisabled'] = networkDisabled;
    if (macAddress != null) {
      json[r'MacAddress'] = macAddress;
    }
    json[r'OnBuild'] = onBuild;
    if (labels != null) {
      json[r'Labels'] = labels;
    }
    if (stopSignal != null) {
      json[r'StopSignal'] = stopSignal;
    }
    if (stopTimeout != null) {
      json[r'StopTimeout'] = stopTimeout;
    }
    json[r'Shell'] = shell;
    return json;
  }

  ContainerConfig copyWith(
      {String? hostname,
      String? domainname,
      String? user,
      bool? attachStdin,
      bool? attachStdout,
      bool? attachStderr,
      Map<String, dynamic>? exposedPorts,
      bool? tty,
      bool? openStdin,
      bool? stdinOnce,
      List<String>? env,
      List<String>? cmd,
      HealthConfig? healthcheck,
      bool? argsEscaped,
      String? image,
      Map<String, dynamic>? volumes,
      String? workingDir,
      List<String>? entrypoint,
      bool? networkDisabled,
      String? macAddress,
      List<String>? onBuild,
      Map<String, dynamic>? labels,
      String? stopSignal,
      int? stopTimeout,
      List<String>? shell}) {
    return ContainerConfig(
      hostname: hostname ?? this.hostname,
      domainname: domainname ?? this.domainname,
      user: user ?? this.user,
      attachStdin: attachStdin ?? this.attachStdin,
      attachStdout: attachStdout ?? this.attachStdout,
      attachStderr: attachStderr ?? this.attachStderr,
      exposedPorts: exposedPorts ?? this.exposedPorts,
      tty: tty ?? this.tty,
      openStdin: openStdin ?? this.openStdin,
      stdinOnce: stdinOnce ?? this.stdinOnce,
      env: env ?? this.env,
      cmd: cmd ?? this.cmd,
      healthcheck: healthcheck ?? this.healthcheck,
      argsEscaped: argsEscaped ?? this.argsEscaped,
      image: image ?? this.image,
      volumes: volumes ?? this.volumes,
      workingDir: workingDir ?? this.workingDir,
      entrypoint: entrypoint ?? this.entrypoint,
      networkDisabled: networkDisabled ?? this.networkDisabled,
      macAddress: macAddress ?? this.macAddress,
      onBuild: onBuild ?? this.onBuild,
      labels: labels ?? this.labels,
      stopSignal: stopSignal ?? this.stopSignal,
      stopTimeout: stopTimeout ?? this.stopTimeout,
      shell: shell ?? this.shell,
    );
  }
}

/// ContainerState stores container's running state. It's part of
/// ContainerJSONBase
/// and will be returned by the "inspect" command.
class ContainerState {
  /// String representation of the container state. Can be one of "created",
  /// "running", "paused", "restarting", "removing", "exited", or "dead".
  final ContainerStateStatus? status;

  /// Whether this container is running.
  ///
  /// Note that a running container can be _paused_. The `Running` and `Paused`
  /// booleans are not mutually exclusive:
  ///
  /// When pausing a container (on Linux), the freezer cgroup is used to suspend
  /// all processes in the container. Freezing the process requires the process
  /// to
  /// be running. As a result, paused containers are both `Running` _and_
  /// `Paused`.
  ///
  /// Use the `Status` field instead to determine if a container's state is
  /// "running".
  final bool running;

  /// Whether this container is paused.
  final bool paused;

  /// Whether this container is restarting.
  final bool restarting;

  /// Whether this container has been killed because it ran out of memory.
  final bool oomKilled;
  final bool dead;

  /// The process ID of this container
  final int? pid;

  /// The last exit code of this container
  final int? exitCode;
  final String? error;

  /// The time when this container was last started.
  final String? startedAt;

  /// The time when this container last exited.
  final String? finishedAt;
  final Health? health;

  ContainerState(
      {this.status,
      bool? running,
      bool? paused,
      bool? restarting,
      bool? oomKilled,
      bool? dead,
      this.pid,
      this.exitCode,
      this.error,
      this.startedAt,
      this.finishedAt,
      this.health})
      : running = running ?? false,
        paused = paused ?? false,
        restarting = restarting ?? false,
        oomKilled = oomKilled ?? false,
        dead = dead ?? false;

  factory ContainerState.fromJson(Map<String, Object?> json) {
    return ContainerState(
      status: json[r'Status'] != null
          ? ContainerStateStatus.fromValue(json[r'Status']! as String)
          : null,
      running: json[r'Running'] as bool? ?? false,
      paused: json[r'Paused'] as bool? ?? false,
      restarting: json[r'Restarting'] as bool? ?? false,
      oomKilled: json[r'OOMKilled'] as bool? ?? false,
      dead: json[r'Dead'] as bool? ?? false,
      pid: (json[r'Pid'] as num?)?.toInt(),
      exitCode: (json[r'ExitCode'] as num?)?.toInt(),
      error: json[r'Error'] as String?,
      startedAt: json[r'StartedAt'] as String?,
      finishedAt: json[r'FinishedAt'] as String?,
      health: json[r'Health'] != null
          ? Health.fromJson(json[r'Health']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var status = this.status;
    var running = this.running;
    var paused = this.paused;
    var restarting = this.restarting;
    var oomKilled = this.oomKilled;
    var dead = this.dead;
    var pid = this.pid;
    var exitCode = this.exitCode;
    var error = this.error;
    var startedAt = this.startedAt;
    var finishedAt = this.finishedAt;
    var health = this.health;

    final json = <String, Object?>{};
    if (status != null) {
      json[r'Status'] = status.value;
    }
    json[r'Running'] = running;
    json[r'Paused'] = paused;
    json[r'Restarting'] = restarting;
    json[r'OOMKilled'] = oomKilled;
    json[r'Dead'] = dead;
    if (pid != null) {
      json[r'Pid'] = pid;
    }
    if (exitCode != null) {
      json[r'ExitCode'] = exitCode;
    }
    if (error != null) {
      json[r'Error'] = error;
    }
    if (startedAt != null) {
      json[r'StartedAt'] = startedAt;
    }
    if (finishedAt != null) {
      json[r'FinishedAt'] = finishedAt;
    }
    if (health != null) {
      json[r'Health'] = health.toJson();
    }
    return json;
  }

  ContainerState copyWith(
      {ContainerStateStatus? status,
      bool? running,
      bool? paused,
      bool? restarting,
      bool? oomKilled,
      bool? dead,
      int? pid,
      int? exitCode,
      String? error,
      String? startedAt,
      String? finishedAt,
      Health? health}) {
    return ContainerState(
      status: status ?? this.status,
      running: running ?? this.running,
      paused: paused ?? this.paused,
      restarting: restarting ?? this.restarting,
      oomKilled: oomKilled ?? this.oomKilled,
      dead: dead ?? this.dead,
      pid: pid ?? this.pid,
      exitCode: exitCode ?? this.exitCode,
      error: error ?? this.error,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      health: health ?? this.health,
    );
  }
}

class ContainerStateStatus {
  static const created = ContainerStateStatus._('created');
  static const running = ContainerStateStatus._('running');
  static const paused = ContainerStateStatus._('paused');
  static const restarting = ContainerStateStatus._('restarting');
  static const removing = ContainerStateStatus._('removing');
  static const exited = ContainerStateStatus._('exited');
  static const dead = ContainerStateStatus._('dead');

  static const values = [
    created,
    running,
    paused,
    restarting,
    removing,
    exited,
    dead,
  ];
  final String value;

  const ContainerStateStatus._(this.value);

  static ContainerStateStatus fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => ContainerStateStatus._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

class ContainerSummary {
  /// The ID of this container
  final String? id;

  /// The names that this container has been given
  final List<String> names;

  /// The name of the image used when creating this container
  final String? image;

  /// The ID of the image that this container was created from
  final String? imageId;

  /// Command to run when starting the container
  final String? command;

  /// When the container was created
  final int? created;

  /// The ports exposed by this container
  final List<Port> ports;

  /// The size of files that have been created or changed by this container
  final int? sizeRw;

  /// The total size of all the files in this container
  final int? sizeRootFs;

  /// User-defined key/value metadata.
  final Map<String, dynamic>? labels;

  /// The state of this container (e.g. `Exited`)
  final String? state;

  /// Additional human-readable status of this container (e.g. `Exit 0`)
  final String? status;
  final ContainerSummaryHostConfig? hostConfig;

  /// A summary of the container's network settings
  final ContainerSummaryNetworkSettings? networkSettings;
  final List<Mount> mounts;

  ContainerSummary(
      {this.id,
      List<String>? names,
      this.image,
      this.imageId,
      this.command,
      this.created,
      List<Port>? ports,
      this.sizeRw,
      this.sizeRootFs,
      this.labels,
      this.state,
      this.status,
      this.hostConfig,
      this.networkSettings,
      List<Mount>? mounts})
      : names = names ?? [],
        ports = ports ?? [],
        mounts = mounts ?? [];

  factory ContainerSummary.fromJson(Map<String, Object?> json) {
    return ContainerSummary(
      id: json[r'Id'] as String?,
      names: (json[r'Names'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      image: json[r'Image'] as String?,
      imageId: json[r'ImageID'] as String?,
      command: json[r'Command'] as String?,
      created: (json[r'Created'] as num?)?.toInt(),
      ports: (json[r'Ports'] as List<Object?>?)
              ?.map(
                  (i) => Port.fromJson(i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      sizeRw: (json[r'SizeRw'] as num?)?.toInt(),
      sizeRootFs: (json[r'SizeRootFs'] as num?)?.toInt(),
      labels: json[r'Labels'] as Map<String, Object?>?,
      state: json[r'State'] as String?,
      status: json[r'Status'] as String?,
      hostConfig: json[r'HostConfig'] != null
          ? ContainerSummaryHostConfig.fromJson(
              json[r'HostConfig']! as Map<String, Object?>)
          : null,
      networkSettings: json[r'NetworkSettings'] != null
          ? ContainerSummaryNetworkSettings.fromJson(
              json[r'NetworkSettings']! as Map<String, Object?>)
          : null,
      mounts: (json[r'Mounts'] as List<Object?>?)
              ?.map(
                  (i) => Mount.fromJson(i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var names = this.names;
    var image = this.image;
    var imageId = this.imageId;
    var command = this.command;
    var created = this.created;
    var ports = this.ports;
    var sizeRw = this.sizeRw;
    var sizeRootFs = this.sizeRootFs;
    var labels = this.labels;
    var state = this.state;
    var status = this.status;
    var hostConfig = this.hostConfig;
    var networkSettings = this.networkSettings;
    var mounts = this.mounts;

    final json = <String, Object?>{};
    if (id != null) {
      json[r'Id'] = id;
    }
    json[r'Names'] = names;
    if (image != null) {
      json[r'Image'] = image;
    }
    if (imageId != null) {
      json[r'ImageID'] = imageId;
    }
    if (command != null) {
      json[r'Command'] = command;
    }
    if (created != null) {
      json[r'Created'] = created;
    }
    json[r'Ports'] = ports.map((i) => i.toJson()).toList();
    if (sizeRw != null) {
      json[r'SizeRw'] = sizeRw;
    }
    if (sizeRootFs != null) {
      json[r'SizeRootFs'] = sizeRootFs;
    }
    if (labels != null) {
      json[r'Labels'] = labels;
    }
    if (state != null) {
      json[r'State'] = state;
    }
    if (status != null) {
      json[r'Status'] = status;
    }
    if (hostConfig != null) {
      json[r'HostConfig'] = hostConfig.toJson();
    }
    if (networkSettings != null) {
      json[r'NetworkSettings'] = networkSettings.toJson();
    }
    json[r'Mounts'] = mounts.map((i) => i.toJson()).toList();
    return json;
  }

  ContainerSummary copyWith(
      {String? id,
      List<String>? names,
      String? image,
      String? imageId,
      String? command,
      int? created,
      List<Port>? ports,
      int? sizeRw,
      int? sizeRootFs,
      Map<String, dynamic>? labels,
      String? state,
      String? status,
      ContainerSummaryHostConfig? hostConfig,
      ContainerSummaryNetworkSettings? networkSettings,
      List<Mount>? mounts}) {
    return ContainerSummary(
      id: id ?? this.id,
      names: names ?? this.names,
      image: image ?? this.image,
      imageId: imageId ?? this.imageId,
      command: command ?? this.command,
      created: created ?? this.created,
      ports: ports ?? this.ports,
      sizeRw: sizeRw ?? this.sizeRw,
      sizeRootFs: sizeRootFs ?? this.sizeRootFs,
      labels: labels ?? this.labels,
      state: state ?? this.state,
      status: status ?? this.status,
      hostConfig: hostConfig ?? this.hostConfig,
      networkSettings: networkSettings ?? this.networkSettings,
      mounts: mounts ?? this.mounts,
    );
  }
}

class ContainerSummaryHostConfig {
  final String? networkMode;

  ContainerSummaryHostConfig({this.networkMode});

  factory ContainerSummaryHostConfig.fromJson(Map<String, Object?> json) {
    return ContainerSummaryHostConfig(
      networkMode: json[r'NetworkMode'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var networkMode = this.networkMode;

    final json = <String, Object?>{};
    if (networkMode != null) {
      json[r'NetworkMode'] = networkMode;
    }
    return json;
  }

  ContainerSummaryHostConfig copyWith({String? networkMode}) {
    return ContainerSummaryHostConfig(
      networkMode: networkMode ?? this.networkMode,
    );
  }
}

/// A summary of the container's network settings
class ContainerSummaryNetworkSettings {
  final Map<String, dynamic>? networks;

  ContainerSummaryNetworkSettings({this.networks});

  factory ContainerSummaryNetworkSettings.fromJson(Map<String, Object?> json) {
    return ContainerSummaryNetworkSettings(
      networks: json[r'Networks'] as Map<String, Object?>?,
    );
  }

  Map<String, Object?> toJson() {
    var networks = this.networks;

    final json = <String, Object?>{};
    if (networks != null) {
      json[r'Networks'] = networks;
    }
    return json;
  }

  ContainerSummaryNetworkSettings copyWith({Map<String, dynamic>? networks}) {
    return ContainerSummaryNetworkSettings(
      networks: networks ?? this.networks,
    );
  }
}

class CreateImageInfo {
  final String? id;
  final String? error;
  final String? status;
  final String? progress;
  final ProgressDetail? progressDetail;

  CreateImageInfo(
      {this.id, this.error, this.status, this.progress, this.progressDetail});

  factory CreateImageInfo.fromJson(Map<String, Object?> json) {
    return CreateImageInfo(
      id: json[r'id'] as String?,
      error: json[r'error'] as String?,
      status: json[r'status'] as String?,
      progress: json[r'progress'] as String?,
      progressDetail: json[r'progressDetail'] != null
          ? ProgressDetail.fromJson(
              json[r'progressDetail']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var error = this.error;
    var status = this.status;
    var progress = this.progress;
    var progressDetail = this.progressDetail;

    final json = <String, Object?>{};
    if (id != null) {
      json[r'id'] = id;
    }
    if (error != null) {
      json[r'error'] = error;
    }
    if (status != null) {
      json[r'status'] = status;
    }
    if (progress != null) {
      json[r'progress'] = progress;
    }
    if (progressDetail != null) {
      json[r'progressDetail'] = progressDetail.toJson();
    }
    return json;
  }

  CreateImageInfo copyWith(
      {String? id,
      String? error,
      String? status,
      String? progress,
      ProgressDetail? progressDetail}) {
    return CreateImageInfo(
      id: id ?? this.id,
      error: error ?? this.error,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      progressDetail: progressDetail ?? this.progressDetail,
    );
  }
}

/// A device mapping between the host and container
class DeviceMapping {
  final String? pathOnHost;
  final String? pathInContainer;
  final String? cgroupPermissions;

  DeviceMapping(
      {this.pathOnHost, this.pathInContainer, this.cgroupPermissions});

  factory DeviceMapping.fromJson(Map<String, Object?> json) {
    return DeviceMapping(
      pathOnHost: json[r'PathOnHost'] as String?,
      pathInContainer: json[r'PathInContainer'] as String?,
      cgroupPermissions: json[r'CgroupPermissions'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var pathOnHost = this.pathOnHost;
    var pathInContainer = this.pathInContainer;
    var cgroupPermissions = this.cgroupPermissions;

    final json = <String, Object?>{};
    if (pathOnHost != null) {
      json[r'PathOnHost'] = pathOnHost;
    }
    if (pathInContainer != null) {
      json[r'PathInContainer'] = pathInContainer;
    }
    if (cgroupPermissions != null) {
      json[r'CgroupPermissions'] = cgroupPermissions;
    }
    return json;
  }

  DeviceMapping copyWith(
      {String? pathOnHost,
      String? pathInContainer,
      String? cgroupPermissions}) {
    return DeviceMapping(
      pathOnHost: pathOnHost ?? this.pathOnHost,
      pathInContainer: pathInContainer ?? this.pathInContainer,
      cgroupPermissions: cgroupPermissions ?? this.cgroupPermissions,
    );
  }
}

/// A request for devices to be sent to device drivers
class DeviceRequest {
  final String? driver;
  final int? count;
  final List<String> deviceiDs;

  /// A list of capabilities; an OR list of AND lists of capabilities.
  final List<List<String>> capabilities;

  /// Driver-specific options, specified as a key/value pairs. These options
  /// are passed directly to the driver.
  final Map<String, dynamic>? options;

  DeviceRequest(
      {this.driver,
      this.count,
      List<String>? deviceiDs,
      List<List<String>>? capabilities,
      this.options})
      : deviceiDs = deviceiDs ?? [],
        capabilities = capabilities ?? [];

  factory DeviceRequest.fromJson(Map<String, Object?> json) {
    return DeviceRequest(
      driver: json[r'Driver'] as String?,
      count: (json[r'Count'] as num?)?.toInt(),
      deviceiDs: (json[r'DeviceIDs'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      capabilities: (json[r'Capabilities'] as List<Object?>?)
              ?.map((i) =>
                  (i as List<Object?>?)
                      ?.map((i) => i as String? ?? '')
                      .toList() ??
                  [])
              .toList() ??
          [],
      options: json[r'Options'] as Map<String, Object?>?,
    );
  }

  Map<String, Object?> toJson() {
    var driver = this.driver;
    var count = this.count;
    var deviceiDs = this.deviceiDs;
    var capabilities = this.capabilities;
    var options = this.options;

    final json = <String, Object?>{};
    if (driver != null) {
      json[r'Driver'] = driver;
    }
    if (count != null) {
      json[r'Count'] = count;
    }
    json[r'DeviceIDs'] = deviceiDs;
    json[r'Capabilities'] = capabilities;
    if (options != null) {
      json[r'Options'] = options;
    }
    return json;
  }

  DeviceRequest copyWith(
      {String? driver,
      int? count,
      List<String>? deviceiDs,
      List<List<String>>? capabilities,
      Map<String, dynamic>? options}) {
    return DeviceRequest(
      driver: driver ?? this.driver,
      count: count ?? this.count,
      deviceiDs: deviceiDs ?? this.deviceiDs,
      capabilities: capabilities ?? this.capabilities,
      options: options ?? this.options,
    );
  }
}

/// Driver represents a driver (network, logging, secrets).
class Driver {
  /// Name of the driver.
  final String name;

  /// Key/value map of driver-specific options.
  final Map<String, dynamic>? options;

  Driver({required this.name, this.options});

  factory Driver.fromJson(Map<String, Object?> json) {
    return Driver(
      name: json[r'Name'] as String? ?? '',
      options: json[r'Options'] as Map<String, Object?>?,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var options = this.options;

    final json = <String, Object?>{};
    json[r'Name'] = name;
    if (options != null) {
      json[r'Options'] = options;
    }
    return json;
  }

  Driver copyWith({String? name, Map<String, dynamic>? options}) {
    return Driver(
      name: name ?? this.name,
      options: options ?? this.options,
    );
  }
}

/// EndpointIPAMConfig represents an endpoint's IPAM configuration.
class EndpointIPAMConfig {
  final String? iPv4Address;
  final String? iPv6Address;
  final List<String> linkLocaliPs;

  EndpointIPAMConfig(
      {this.iPv4Address, this.iPv6Address, List<String>? linkLocaliPs})
      : linkLocaliPs = linkLocaliPs ?? [];

  factory EndpointIPAMConfig.fromJson(Map<String, Object?> json) {
    return EndpointIPAMConfig(
      iPv4Address: json[r'IPv4Address'] as String?,
      iPv6Address: json[r'IPv6Address'] as String?,
      linkLocaliPs: (json[r'LinkLocalIPs'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var iPv4Address = this.iPv4Address;
    var iPv6Address = this.iPv6Address;
    var linkLocaliPs = this.linkLocaliPs;

    final json = <String, Object?>{};
    if (iPv4Address != null) {
      json[r'IPv4Address'] = iPv4Address;
    }
    if (iPv6Address != null) {
      json[r'IPv6Address'] = iPv6Address;
    }
    json[r'LinkLocalIPs'] = linkLocaliPs;
    return json;
  }

  EndpointIPAMConfig copyWith(
      {String? iPv4Address, String? iPv6Address, List<String>? linkLocaliPs}) {
    return EndpointIPAMConfig(
      iPv4Address: iPv4Address ?? this.iPv4Address,
      iPv6Address: iPv6Address ?? this.iPv6Address,
      linkLocaliPs: linkLocaliPs ?? this.linkLocaliPs,
    );
  }
}

class EndpointPortConfig {
  final String? name;
  final EndpointPortConfigProtocol? protocol;

  /// The port inside the container.
  final int? targetPort;

  /// The port on the swarm hosts.
  final int? publishedPort;

  /// The mode in which port is published.
  ///
  /// <p>
  /// </p>
  ///
  /// - "ingress" makes the target port accessible on every node,
  ///   regardless of whether there is a task for the service running on
  ///   that node or not.
  /// - "host" bypasses the routing mesh and publish the port directly on
  ///   the swarm node where that service is running.
  final EndpointPortConfigPublishMode? publishMode;

  EndpointPortConfig(
      {this.name,
      this.protocol,
      this.targetPort,
      this.publishedPort,
      this.publishMode});

  factory EndpointPortConfig.fromJson(Map<String, Object?> json) {
    return EndpointPortConfig(
      name: json[r'Name'] as String?,
      protocol: json[r'Protocol'] != null
          ? EndpointPortConfigProtocol.fromValue(json[r'Protocol']! as String)
          : null,
      targetPort: (json[r'TargetPort'] as num?)?.toInt(),
      publishedPort: (json[r'PublishedPort'] as num?)?.toInt(),
      publishMode: json[r'PublishMode'] != null
          ? EndpointPortConfigPublishMode.fromValue(
              json[r'PublishMode']! as String)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var protocol = this.protocol;
    var targetPort = this.targetPort;
    var publishedPort = this.publishedPort;
    var publishMode = this.publishMode;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (protocol != null) {
      json[r'Protocol'] = protocol.value;
    }
    if (targetPort != null) {
      json[r'TargetPort'] = targetPort;
    }
    if (publishedPort != null) {
      json[r'PublishedPort'] = publishedPort;
    }
    if (publishMode != null) {
      json[r'PublishMode'] = publishMode.value;
    }
    return json;
  }

  EndpointPortConfig copyWith(
      {String? name,
      EndpointPortConfigProtocol? protocol,
      int? targetPort,
      int? publishedPort,
      EndpointPortConfigPublishMode? publishMode}) {
    return EndpointPortConfig(
      name: name ?? this.name,
      protocol: protocol ?? this.protocol,
      targetPort: targetPort ?? this.targetPort,
      publishedPort: publishedPort ?? this.publishedPort,
      publishMode: publishMode ?? this.publishMode,
    );
  }
}

class EndpointPortConfigProtocol {
  static const tcp = EndpointPortConfigProtocol._('tcp');
  static const udp = EndpointPortConfigProtocol._('udp');
  static const sctp = EndpointPortConfigProtocol._('sctp');

  static const values = [
    tcp,
    udp,
    sctp,
  ];
  final String value;

  const EndpointPortConfigProtocol._(this.value);

  static EndpointPortConfigProtocol fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => EndpointPortConfigProtocol._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

class EndpointPortConfigPublishMode {
  static const ingress = EndpointPortConfigPublishMode._('ingress');
  static const host = EndpointPortConfigPublishMode._('host');

  static const values = [
    ingress,
    host,
  ];
  final String value;

  const EndpointPortConfigPublishMode._(this.value);

  static EndpointPortConfigPublishMode fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => EndpointPortConfigPublishMode._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

/// Configuration for a network endpoint.
class EndpointSettings {
  final EndpointIPAMConfig? ipamConfig;
  final List<String> links;
  final List<String> aliases;

  /// Unique ID of the network.
  final String? networkId;

  /// Unique ID for the service endpoint in a Sandbox.
  final String? endpointId;

  /// Gateway address for this network.
  final String? gateway;

  /// IPv4 address.
  final String? ipAddress;

  /// Mask length of the IPv4 address.
  final int? ipPrefixLen;

  /// IPv6 gateway address.
  final String? iPv6Gateway;

  /// Global IPv6 address.
  final String? globaliPv6Address;

  /// Mask length of the global IPv6 address.
  final int? globaliPv6PrefixLen;

  /// MAC address for the endpoint on this network.
  final String? macAddress;

  /// DriverOpts is a mapping of driver options and values. These options
  /// are passed directly to the driver and are driver specific.
  final Map<String, dynamic>? driverOpts;

  EndpointSettings(
      {this.ipamConfig,
      List<String>? links,
      List<String>? aliases,
      this.networkId,
      this.endpointId,
      this.gateway,
      this.ipAddress,
      this.ipPrefixLen,
      this.iPv6Gateway,
      this.globaliPv6Address,
      this.globaliPv6PrefixLen,
      this.macAddress,
      this.driverOpts})
      : links = links ?? [],
        aliases = aliases ?? [];

  factory EndpointSettings.fromJson(Map<String, Object?> json) {
    return EndpointSettings(
      ipamConfig: json[r'IPAMConfig'] != null
          ? EndpointIPAMConfig.fromJson(
              json[r'IPAMConfig']! as Map<String, Object?>)
          : null,
      links: (json[r'Links'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      aliases: (json[r'Aliases'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      networkId: json[r'NetworkID'] as String?,
      endpointId: json[r'EndpointID'] as String?,
      gateway: json[r'Gateway'] as String?,
      ipAddress: json[r'IPAddress'] as String?,
      ipPrefixLen: (json[r'IPPrefixLen'] as num?)?.toInt(),
      iPv6Gateway: json[r'IPv6Gateway'] as String?,
      globaliPv6Address: json[r'GlobalIPv6Address'] as String?,
      globaliPv6PrefixLen: (json[r'GlobalIPv6PrefixLen'] as num?)?.toInt(),
      macAddress: json[r'MacAddress'] as String?,
      driverOpts: json[r'DriverOpts'] as Map<String, Object?>?,
    );
  }

  Map<String, Object?> toJson() {
    var ipamConfig = this.ipamConfig;
    var links = this.links;
    var aliases = this.aliases;
    var networkId = this.networkId;
    var endpointId = this.endpointId;
    var gateway = this.gateway;
    var ipAddress = this.ipAddress;
    var ipPrefixLen = this.ipPrefixLen;
    var iPv6Gateway = this.iPv6Gateway;
    var globaliPv6Address = this.globaliPv6Address;
    var globaliPv6PrefixLen = this.globaliPv6PrefixLen;
    var macAddress = this.macAddress;
    var driverOpts = this.driverOpts;

    final json = <String, Object?>{};
    if (ipamConfig != null) {
      json[r'IPAMConfig'] = ipamConfig.toJson();
    }
    json[r'Links'] = links;
    json[r'Aliases'] = aliases;
    if (networkId != null) {
      json[r'NetworkID'] = networkId;
    }
    if (endpointId != null) {
      json[r'EndpointID'] = endpointId;
    }
    if (gateway != null) {
      json[r'Gateway'] = gateway;
    }
    if (ipAddress != null) {
      json[r'IPAddress'] = ipAddress;
    }
    if (ipPrefixLen != null) {
      json[r'IPPrefixLen'] = ipPrefixLen;
    }
    if (iPv6Gateway != null) {
      json[r'IPv6Gateway'] = iPv6Gateway;
    }
    if (globaliPv6Address != null) {
      json[r'GlobalIPv6Address'] = globaliPv6Address;
    }
    if (globaliPv6PrefixLen != null) {
      json[r'GlobalIPv6PrefixLen'] = globaliPv6PrefixLen;
    }
    if (macAddress != null) {
      json[r'MacAddress'] = macAddress;
    }
    if (driverOpts != null) {
      json[r'DriverOpts'] = driverOpts;
    }
    return json;
  }

  EndpointSettings copyWith(
      {EndpointIPAMConfig? ipamConfig,
      List<String>? links,
      List<String>? aliases,
      String? networkId,
      String? endpointId,
      String? gateway,
      String? ipAddress,
      int? ipPrefixLen,
      String? iPv6Gateway,
      String? globaliPv6Address,
      int? globaliPv6PrefixLen,
      String? macAddress,
      Map<String, dynamic>? driverOpts}) {
    return EndpointSettings(
      ipamConfig: ipamConfig ?? this.ipamConfig,
      links: links ?? this.links,
      aliases: aliases ?? this.aliases,
      networkId: networkId ?? this.networkId,
      endpointId: endpointId ?? this.endpointId,
      gateway: gateway ?? this.gateway,
      ipAddress: ipAddress ?? this.ipAddress,
      ipPrefixLen: ipPrefixLen ?? this.ipPrefixLen,
      iPv6Gateway: iPv6Gateway ?? this.iPv6Gateway,
      globaliPv6Address: globaliPv6Address ?? this.globaliPv6Address,
      globaliPv6PrefixLen: globaliPv6PrefixLen ?? this.globaliPv6PrefixLen,
      macAddress: macAddress ?? this.macAddress,
      driverOpts: driverOpts ?? this.driverOpts,
    );
  }
}

/// Properties that can be configured to access and load balance a service.
class EndpointSpec {
  /// The mode of resolution to use for internal load balancing between tasks.
  final EndpointSpecMode? mode;

  /// List of exposed ports that this service is accessible on from the
  /// outside. Ports can only be provided if `vip` resolution mode is used.
  final List<EndpointPortConfig> ports;

  EndpointSpec({this.mode, List<EndpointPortConfig>? ports})
      : ports = ports ?? [];

  factory EndpointSpec.fromJson(Map<String, Object?> json) {
    return EndpointSpec(
      mode: json[r'Mode'] != null
          ? EndpointSpecMode.fromValue(json[r'Mode']! as String)
          : null,
      ports: (json[r'Ports'] as List<Object?>?)
              ?.map((i) => EndpointPortConfig.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var mode = this.mode;
    var ports = this.ports;

    final json = <String, Object?>{};
    if (mode != null) {
      json[r'Mode'] = mode.value;
    }
    json[r'Ports'] = ports.map((i) => i.toJson()).toList();
    return json;
  }

  EndpointSpec copyWith(
      {EndpointSpecMode? mode, List<EndpointPortConfig>? ports}) {
    return EndpointSpec(
      mode: mode ?? this.mode,
      ports: ports ?? this.ports,
    );
  }
}

class EndpointSpecMode {
  static const vip = EndpointSpecMode._('vip');
  static const dnsrr = EndpointSpecMode._('dnsrr');

  static const values = [
    vip,
    dnsrr,
  ];
  final String value;

  const EndpointSpecMode._(this.value);

  static EndpointSpecMode fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => EndpointSpecMode._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

/// EngineDescription provides information about an engine.
class EngineDescription {
  final String? engineVersion;
  final Map<String, dynamic>? labels;
  final List<EngineDescriptionPluginsItem> plugins;

  EngineDescription(
      {this.engineVersion,
      this.labels,
      List<EngineDescriptionPluginsItem>? plugins})
      : plugins = plugins ?? [];

  factory EngineDescription.fromJson(Map<String, Object?> json) {
    return EngineDescription(
      engineVersion: json[r'EngineVersion'] as String?,
      labels: json[r'Labels'] as Map<String, Object?>?,
      plugins: (json[r'Plugins'] as List<Object?>?)
              ?.map((i) => EngineDescriptionPluginsItem.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var engineVersion = this.engineVersion;
    var labels = this.labels;
    var plugins = this.plugins;

    final json = <String, Object?>{};
    if (engineVersion != null) {
      json[r'EngineVersion'] = engineVersion;
    }
    if (labels != null) {
      json[r'Labels'] = labels;
    }
    json[r'Plugins'] = plugins.map((i) => i.toJson()).toList();
    return json;
  }

  EngineDescription copyWith(
      {String? engineVersion,
      Map<String, dynamic>? labels,
      List<EngineDescriptionPluginsItem>? plugins}) {
    return EngineDescription(
      engineVersion: engineVersion ?? this.engineVersion,
      labels: labels ?? this.labels,
      plugins: plugins ?? this.plugins,
    );
  }
}

class EngineDescriptionPluginsItem {
  final String? type;
  final String? name;

  EngineDescriptionPluginsItem({this.type, this.name});

  factory EngineDescriptionPluginsItem.fromJson(Map<String, Object?> json) {
    return EngineDescriptionPluginsItem(
      type: json[r'Type'] as String?,
      name: json[r'Name'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var type = this.type;
    var name = this.name;

    final json = <String, Object?>{};
    if (type != null) {
      json[r'Type'] = type;
    }
    if (name != null) {
      json[r'Name'] = name;
    }
    return json;
  }

  EngineDescriptionPluginsItem copyWith({String? type, String? name}) {
    return EngineDescriptionPluginsItem(
      type: type ?? this.type,
      name: name ?? this.name,
    );
  }
}

class ErrorDetail {
  final int? code;
  final String? message;

  ErrorDetail({this.code, this.message});

  factory ErrorDetail.fromJson(Map<String, Object?> json) {
    return ErrorDetail(
      code: (json[r'code'] as num?)?.toInt(),
      message: json[r'message'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var code = this.code;
    var message = this.message;

    final json = <String, Object?>{};
    if (code != null) {
      json[r'code'] = code;
    }
    if (message != null) {
      json[r'message'] = message;
    }
    return json;
  }

  ErrorDetail copyWith({int? code, String? message}) {
    return ErrorDetail(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }
}

/// Represents an error.
class ErrorResponse {
  /// The error message.
  final String message;

  ErrorResponse({required this.message});

  factory ErrorResponse.fromJson(Map<String, Object?> json) {
    return ErrorResponse(
      message: json[r'message'] as String? ?? '',
    );
  }

  Map<String, Object?> toJson() {
    var message = this.message;

    final json = <String, Object?>{};
    json[r'message'] = message;
    return json;
  }

  ErrorResponse copyWith({String? message}) {
    return ErrorResponse(
      message: message ?? this.message,
    );
  }
}

class GenericResources {
  final GenericResourcesNamedResourceSpec? namedResourceSpec;
  final GenericResourcesDiscreteResourceSpec? discreteResourceSpec;

  GenericResources({this.namedResourceSpec, this.discreteResourceSpec});

  factory GenericResources.fromJson(Map<String, Object?> json) {
    return GenericResources(
      namedResourceSpec: json[r'NamedResourceSpec'] != null
          ? GenericResourcesNamedResourceSpec.fromJson(
              json[r'NamedResourceSpec']! as Map<String, Object?>)
          : null,
      discreteResourceSpec: json[r'DiscreteResourceSpec'] != null
          ? GenericResourcesDiscreteResourceSpec.fromJson(
              json[r'DiscreteResourceSpec']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var namedResourceSpec = this.namedResourceSpec;
    var discreteResourceSpec = this.discreteResourceSpec;

    final json = <String, Object?>{};
    if (namedResourceSpec != null) {
      json[r'NamedResourceSpec'] = namedResourceSpec.toJson();
    }
    if (discreteResourceSpec != null) {
      json[r'DiscreteResourceSpec'] = discreteResourceSpec.toJson();
    }
    return json;
  }

  GenericResources copyWith(
      {GenericResourcesNamedResourceSpec? namedResourceSpec,
      GenericResourcesDiscreteResourceSpec? discreteResourceSpec}) {
    return GenericResources(
      namedResourceSpec: namedResourceSpec ?? this.namedResourceSpec,
      discreteResourceSpec: discreteResourceSpec ?? this.discreteResourceSpec,
    );
  }
}

class GenericResourcesDiscreteResourceSpec {
  final String? kind;
  final int? value;

  GenericResourcesDiscreteResourceSpec({this.kind, this.value});

  factory GenericResourcesDiscreteResourceSpec.fromJson(
      Map<String, Object?> json) {
    return GenericResourcesDiscreteResourceSpec(
      kind: json[r'Kind'] as String?,
      value: (json[r'Value'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var kind = this.kind;
    var value = this.value;

    final json = <String, Object?>{};
    if (kind != null) {
      json[r'Kind'] = kind;
    }
    if (value != null) {
      json[r'Value'] = value;
    }
    return json;
  }

  GenericResourcesDiscreteResourceSpec copyWith({String? kind, int? value}) {
    return GenericResourcesDiscreteResourceSpec(
      kind: kind ?? this.kind,
      value: value ?? this.value,
    );
  }
}

class GenericResourcesNamedResourceSpec {
  final String? kind;
  final String? value;

  GenericResourcesNamedResourceSpec({this.kind, this.value});

  factory GenericResourcesNamedResourceSpec.fromJson(
      Map<String, Object?> json) {
    return GenericResourcesNamedResourceSpec(
      kind: json[r'Kind'] as String?,
      value: json[r'Value'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var kind = this.kind;
    var value = this.value;

    final json = <String, Object?>{};
    if (kind != null) {
      json[r'Kind'] = kind;
    }
    if (value != null) {
      json[r'Value'] = value;
    }
    return json;
  }

  GenericResourcesNamedResourceSpec copyWith({String? kind, String? value}) {
    return GenericResourcesNamedResourceSpec(
      kind: kind ?? this.kind,
      value: value ?? this.value,
    );
  }
}

/// Information about a container's graph driver.
class GraphDriverData {
  final String name;
  final Map<String, dynamic> data;

  GraphDriverData({required this.name, required this.data});

  factory GraphDriverData.fromJson(Map<String, Object?> json) {
    return GraphDriverData(
      name: json[r'Name'] as String? ?? '',
      data: json[r'Data'] as Map<String, Object?>? ?? {},
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var data = this.data;

    final json = <String, Object?>{};
    json[r'Name'] = name;
    json[r'Data'] = data;
    return json;
  }

  GraphDriverData copyWith({String? name, Map<String, dynamic>? data}) {
    return GraphDriverData(
      name: name ?? this.name,
      data: data ?? this.data,
    );
  }
}

/// Health stores information about the container's healthcheck results.
class Health {
  /// Status is one of `none`, `starting`, `healthy` or `unhealthy`
  ///
  /// - "none"      Indicates there is no healthcheck
  /// - "starting"  Starting indicates that the container is not yet ready
  /// - "healthy"   Healthy indicates that the container is running correctly
  /// - "unhealthy" Unhealthy indicates that the container has a problem
  final HealthStatus? status;

  /// FailingStreak is the number of consecutive failures
  final int? failingStreak;

  /// Log contains the last few results (oldest first)
  final List<HealthcheckResult> log;

  Health({this.status, this.failingStreak, List<HealthcheckResult>? log})
      : log = log ?? [];

  factory Health.fromJson(Map<String, Object?> json) {
    return Health(
      status: json[r'Status'] != null
          ? HealthStatus.fromValue(json[r'Status']! as String)
          : null,
      failingStreak: (json[r'FailingStreak'] as num?)?.toInt(),
      log: (json[r'Log'] as List<Object?>?)
              ?.map((i) => HealthcheckResult.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var status = this.status;
    var failingStreak = this.failingStreak;
    var log = this.log;

    final json = <String, Object?>{};
    if (status != null) {
      json[r'Status'] = status.value;
    }
    if (failingStreak != null) {
      json[r'FailingStreak'] = failingStreak;
    }
    json[r'Log'] = log.map((i) => i.toJson()).toList();
    return json;
  }

  Health copyWith(
      {HealthStatus? status,
      int? failingStreak,
      List<HealthcheckResult>? log}) {
    return Health(
      status: status ?? this.status,
      failingStreak: failingStreak ?? this.failingStreak,
      log: log ?? this.log,
    );
  }
}

class HealthStatus {
  static const none = HealthStatus._('none');
  static const starting = HealthStatus._('starting');
  static const healthy = HealthStatus._('healthy');
  static const unhealthy = HealthStatus._('unhealthy');

  static const values = [
    none,
    starting,
    healthy,
    unhealthy,
  ];
  final String value;

  const HealthStatus._(this.value);

  static HealthStatus fromValue(String value) => values
      .firstWhere((e) => e.value == value, orElse: () => HealthStatus._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

/// A test to perform to check that the container is healthy.
class HealthConfig {
  /// The test to perform. Possible values are:
  ///
  /// - `[]` inherit healthcheck from image or parent image
  /// - `["NONE"]` disable healthcheck
  /// - `["CMD", args...]` exec arguments directly
  /// - `["CMD-SHELL", command]` run command with system's default shell
  final List<String> test;

  /// The time to wait between checks in nanoseconds. It should be 0 or at
  /// least 1000000 (1 ms). 0 means inherit.
  final int? interval;

  /// The time to wait before considering the check to have hung. It should
  /// be 0 or at least 1000000 (1 ms). 0 means inherit.
  final int? timeout;

  /// The number of consecutive failures needed to consider a container as
  /// unhealthy. 0 means inherit.
  final int? retries;

  /// Start period for the container to initialize before starting
  /// health-retries countdown in nanoseconds. It should be 0 or at least
  /// 1000000 (1 ms). 0 means inherit.
  final int? startPeriod;

  HealthConfig(
      {List<String>? test,
      this.interval,
      this.timeout,
      this.retries,
      this.startPeriod})
      : test = test ?? [];

  factory HealthConfig.fromJson(Map<String, Object?> json) {
    return HealthConfig(
      test: (json[r'Test'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      interval: (json[r'Interval'] as num?)?.toInt(),
      timeout: (json[r'Timeout'] as num?)?.toInt(),
      retries: (json[r'Retries'] as num?)?.toInt(),
      startPeriod: (json[r'StartPeriod'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var test = this.test;
    var interval = this.interval;
    var timeout = this.timeout;
    var retries = this.retries;
    var startPeriod = this.startPeriod;

    final json = <String, Object?>{};
    json[r'Test'] = test;
    if (interval != null) {
      json[r'Interval'] = interval;
    }
    if (timeout != null) {
      json[r'Timeout'] = timeout;
    }
    if (retries != null) {
      json[r'Retries'] = retries;
    }
    if (startPeriod != null) {
      json[r'StartPeriod'] = startPeriod;
    }
    return json;
  }

  HealthConfig copyWith(
      {List<String>? test,
      int? interval,
      int? timeout,
      int? retries,
      int? startPeriod}) {
    return HealthConfig(
      test: test ?? this.test,
      interval: interval ?? this.interval,
      timeout: timeout ?? this.timeout,
      retries: retries ?? this.retries,
      startPeriod: startPeriod ?? this.startPeriod,
    );
  }
}

/// HealthcheckResult stores information about a single run of a healthcheck
/// probe
class HealthcheckResult {
  /// Date and time at which this check started in
  /// [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.
  final DateTime? start;

  /// Date and time at which this check ended in
  /// [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.
  final DateTime? end;

  /// ExitCode meanings:
  ///
  /// - `0` healthy
  /// - `1` unhealthy
  /// - `2` reserved (considered unhealthy)
  /// - other values: error running probe
  final int? exitCode;

  /// Output from last check
  final String? output;

  HealthcheckResult({this.start, this.end, this.exitCode, this.output});

  factory HealthcheckResult.fromJson(Map<String, Object?> json) {
    return HealthcheckResult(
      start: DateTime.tryParse(json[r'Start'] as String? ?? ''),
      end: DateTime.tryParse(json[r'End'] as String? ?? ''),
      exitCode: (json[r'ExitCode'] as num?)?.toInt(),
      output: json[r'Output'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var start = this.start;
    var end = this.end;
    var exitCode = this.exitCode;
    var output = this.output;

    final json = <String, Object?>{};
    if (start != null) {
      json[r'Start'] = start.toIso8601String();
    }
    if (end != null) {
      json[r'End'] = end.toIso8601String();
    }
    if (exitCode != null) {
      json[r'ExitCode'] = exitCode;
    }
    if (output != null) {
      json[r'Output'] = output;
    }
    return json;
  }

  HealthcheckResult copyWith(
      {DateTime? start, DateTime? end, int? exitCode, String? output}) {
    return HealthcheckResult(
      start: start ?? this.start,
      end: end ?? this.end,
      exitCode: exitCode ?? this.exitCode,
      output: output ?? this.output,
    );
  }
}

/// Container configuration that depends on the host we are running on
class HostConfig {
  HostConfig();

  factory HostConfig.fromJson(Map<String, Object?> json) {
    return HostConfig();
  }

  Map<String, Object?> toJson() {
    final json = <String, Object?>{};
    return json;
  }
}

class IPAM {
  /// Name of the IPAM driver to use.
  final String? driver;

  /// List of IPAM configuration options, specified as a map:
  ///
  /// ```
  /// {"Subnet": <CIDR>, "IPRange": <CIDR>, "Gateway": <IP address>,
  /// "AuxAddress": <device_name:IP address>}
  /// ```
  final List<Map<String, dynamic>> config;

  /// Driver-specific options, specified as a map.
  final Map<String, dynamic>? options;

  IPAM({this.driver, List<Map<String, dynamic>>? config, this.options})
      : config = config ?? [];

  factory IPAM.fromJson(Map<String, Object?> json) {
    return IPAM(
      driver: json[r'Driver'] as String?,
      config: (json[r'Config'] as List<Object?>?)
              ?.map((i) => i as Map<String, Object?>? ?? {})
              .toList() ??
          [],
      options: json[r'Options'] as Map<String, Object?>?,
    );
  }

  Map<String, Object?> toJson() {
    var driver = this.driver;
    var config = this.config;
    var options = this.options;

    final json = <String, Object?>{};
    if (driver != null) {
      json[r'Driver'] = driver;
    }
    json[r'Config'] = config;
    if (options != null) {
      json[r'Options'] = options;
    }
    return json;
  }

  IPAM copyWith(
      {String? driver,
      List<Map<String, dynamic>>? config,
      Map<String, dynamic>? options}) {
    return IPAM(
      driver: driver ?? this.driver,
      config: config ?? this.config,
      options: options ?? this.options,
    );
  }
}

/// Response to an API call that returns just an Id
class IdResponse {
  /// The id of the newly created object.
  final String id;

  IdResponse({required this.id});

  factory IdResponse.fromJson(Map<String, Object?> json) {
    return IdResponse(
      id: json[r'Id'] as String? ?? '',
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;

    final json = <String, Object?>{};
    json[r'Id'] = id;
    return json;
  }

  IdResponse copyWith({String? id}) {
    return IdResponse(
      id: id ?? this.id,
    );
  }
}

class Image {
  final String id;
  final List<String> repoTags;
  final List<String> repoDigests;
  final String parent;
  final String comment;
  final String created;
  final String container;
  final ContainerConfig? containerConfig;
  final String dockerVersion;
  final String author;
  final ContainerConfig? config;
  final String architecture;
  final String os;
  final String? osVersion;
  final int size;
  final int virtualSize;
  final GraphDriverData graphDriver;
  final ImageRootFS rootFs;
  final ImageMetadata? metadata;

  Image(
      {required this.id,
      List<String>? repoTags,
      List<String>? repoDigests,
      required this.parent,
      required this.comment,
      required this.created,
      required this.container,
      this.containerConfig,
      required this.dockerVersion,
      required this.author,
      this.config,
      required this.architecture,
      required this.os,
      this.osVersion,
      required this.size,
      required this.virtualSize,
      required this.graphDriver,
      required this.rootFs,
      this.metadata})
      : repoTags = repoTags ?? [],
        repoDigests = repoDigests ?? [];

  factory Image.fromJson(Map<String, Object?> json) {
    return Image(
      id: json[r'Id'] as String? ?? '',
      repoTags: (json[r'RepoTags'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      repoDigests: (json[r'RepoDigests'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      parent: json[r'Parent'] as String? ?? '',
      comment: json[r'Comment'] as String? ?? '',
      created: json[r'Created'] as String? ?? '',
      container: json[r'Container'] as String? ?? '',
      containerConfig: json[r'ContainerConfig'] != null
          ? ContainerConfig.fromJson(
              json[r'ContainerConfig']! as Map<String, Object?>)
          : null,
      dockerVersion: json[r'DockerVersion'] as String? ?? '',
      author: json[r'Author'] as String? ?? '',
      config: json[r'Config'] != null
          ? ContainerConfig.fromJson(json[r'Config']! as Map<String, Object?>)
          : null,
      architecture: json[r'Architecture'] as String? ?? '',
      os: json[r'Os'] as String? ?? '',
      osVersion: json[r'OsVersion'] as String?,
      size: (json[r'Size'] as num?)?.toInt() ?? 0,
      virtualSize: (json[r'VirtualSize'] as num?)?.toInt() ?? 0,
      graphDriver: GraphDriverData.fromJson(
          json[r'GraphDriver'] as Map<String, Object?>? ?? const {}),
      rootFs: ImageRootFS.fromJson(
          json[r'RootFS'] as Map<String, Object?>? ?? const {}),
      metadata: json[r'Metadata'] != null
          ? ImageMetadata.fromJson(json[r'Metadata']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var repoTags = this.repoTags;
    var repoDigests = this.repoDigests;
    var parent = this.parent;
    var comment = this.comment;
    var created = this.created;
    var container = this.container;
    var containerConfig = this.containerConfig;
    var dockerVersion = this.dockerVersion;
    var author = this.author;
    var config = this.config;
    var architecture = this.architecture;
    var os = this.os;
    var osVersion = this.osVersion;
    var size = this.size;
    var virtualSize = this.virtualSize;
    var graphDriver = this.graphDriver;
    var rootFs = this.rootFs;
    var metadata = this.metadata;

    final json = <String, Object?>{};
    json[r'Id'] = id;
    json[r'RepoTags'] = repoTags;
    json[r'RepoDigests'] = repoDigests;
    json[r'Parent'] = parent;
    json[r'Comment'] = comment;
    json[r'Created'] = created;
    json[r'Container'] = container;
    if (containerConfig != null) {
      json[r'ContainerConfig'] = containerConfig.toJson();
    }
    json[r'DockerVersion'] = dockerVersion;
    json[r'Author'] = author;
    if (config != null) {
      json[r'Config'] = config.toJson();
    }
    json[r'Architecture'] = architecture;
    json[r'Os'] = os;
    if (osVersion != null) {
      json[r'OsVersion'] = osVersion;
    }
    json[r'Size'] = size;
    json[r'VirtualSize'] = virtualSize;
    json[r'GraphDriver'] = graphDriver.toJson();
    json[r'RootFS'] = rootFs.toJson();
    if (metadata != null) {
      json[r'Metadata'] = metadata.toJson();
    }
    return json;
  }

  Image copyWith(
      {String? id,
      List<String>? repoTags,
      List<String>? repoDigests,
      String? parent,
      String? comment,
      String? created,
      String? container,
      ContainerConfig? containerConfig,
      String? dockerVersion,
      String? author,
      ContainerConfig? config,
      String? architecture,
      String? os,
      String? osVersion,
      int? size,
      int? virtualSize,
      GraphDriverData? graphDriver,
      ImageRootFS? rootFs,
      ImageMetadata? metadata}) {
    return Image(
      id: id ?? this.id,
      repoTags: repoTags ?? this.repoTags,
      repoDigests: repoDigests ?? this.repoDigests,
      parent: parent ?? this.parent,
      comment: comment ?? this.comment,
      created: created ?? this.created,
      container: container ?? this.container,
      containerConfig: containerConfig ?? this.containerConfig,
      dockerVersion: dockerVersion ?? this.dockerVersion,
      author: author ?? this.author,
      config: config ?? this.config,
      architecture: architecture ?? this.architecture,
      os: os ?? this.os,
      osVersion: osVersion ?? this.osVersion,
      size: size ?? this.size,
      virtualSize: virtualSize ?? this.virtualSize,
      graphDriver: graphDriver ?? this.graphDriver,
      rootFs: rootFs ?? this.rootFs,
      metadata: metadata ?? this.metadata,
    );
  }
}

class ImageDeleteResponseItem {
  /// The image ID of an image that was untagged
  final String? untagged;

  /// The image ID of an image that was deleted
  final String? deleted;

  ImageDeleteResponseItem({this.untagged, this.deleted});

  factory ImageDeleteResponseItem.fromJson(Map<String, Object?> json) {
    return ImageDeleteResponseItem(
      untagged: json[r'Untagged'] as String?,
      deleted: json[r'Deleted'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var untagged = this.untagged;
    var deleted = this.deleted;

    final json = <String, Object?>{};
    if (untagged != null) {
      json[r'Untagged'] = untagged;
    }
    if (deleted != null) {
      json[r'Deleted'] = deleted;
    }
    return json;
  }

  ImageDeleteResponseItem copyWith({String? untagged, String? deleted}) {
    return ImageDeleteResponseItem(
      untagged: untagged ?? this.untagged,
      deleted: deleted ?? this.deleted,
    );
  }
}

/// Image ID or Digest
class ImageID {
  final String? id;

  ImageID({this.id});

  factory ImageID.fromJson(Map<String, Object?> json) {
    return ImageID(
      id: json[r'ID'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;

    final json = <String, Object?>{};
    if (id != null) {
      json[r'ID'] = id;
    }
    return json;
  }

  ImageID copyWith({String? id}) {
    return ImageID(
      id: id ?? this.id,
    );
  }
}

class ImageMetadata {
  final DateTime? lastTagTime;

  ImageMetadata({this.lastTagTime});

  factory ImageMetadata.fromJson(Map<String, Object?> json) {
    return ImageMetadata(
      lastTagTime: DateTime.tryParse(json[r'LastTagTime'] as String? ?? ''),
    );
  }

  Map<String, Object?> toJson() {
    var lastTagTime = this.lastTagTime;

    final json = <String, Object?>{};
    if (lastTagTime != null) {
      json[r'LastTagTime'] = lastTagTime.toIso8601String();
    }
    return json;
  }

  ImageMetadata copyWith({DateTime? lastTagTime}) {
    return ImageMetadata(
      lastTagTime: lastTagTime ?? this.lastTagTime,
    );
  }
}

class ImageRootFS {
  final String type;
  final List<String> layers;
  final String? baseLayer;

  ImageRootFS({required this.type, List<String>? layers, this.baseLayer})
      : layers = layers ?? [];

  factory ImageRootFS.fromJson(Map<String, Object?> json) {
    return ImageRootFS(
      type: json[r'Type'] as String? ?? '',
      layers: (json[r'Layers'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      baseLayer: json[r'BaseLayer'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var type = this.type;
    var layers = this.layers;
    var baseLayer = this.baseLayer;

    final json = <String, Object?>{};
    json[r'Type'] = type;
    json[r'Layers'] = layers;
    if (baseLayer != null) {
      json[r'BaseLayer'] = baseLayer;
    }
    return json;
  }

  ImageRootFS copyWith(
      {String? type, List<String>? layers, String? baseLayer}) {
    return ImageRootFS(
      type: type ?? this.type,
      layers: layers ?? this.layers,
      baseLayer: baseLayer ?? this.baseLayer,
    );
  }
}

class ImageSummary {
  final String id;
  final String parentId;
  final List<String> repoTags;
  final List<String> repoDigests;
  final int created;
  final int size;
  final int sharedSize;
  final int virtualSize;
  final Map<String, dynamic> labels;
  final int containers;

  ImageSummary(
      {required this.id,
      required this.parentId,
      required this.repoTags,
      required this.repoDigests,
      required this.created,
      required this.size,
      required this.sharedSize,
      required this.virtualSize,
      required this.labels,
      required this.containers});

  factory ImageSummary.fromJson(Map<String, Object?> json) {
    return ImageSummary(
      id: json[r'Id'] as String? ?? '',
      parentId: json[r'ParentId'] as String? ?? '',
      repoTags: (json[r'RepoTags'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      repoDigests: (json[r'RepoDigests'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      created: (json[r'Created'] as num?)?.toInt() ?? 0,
      size: (json[r'Size'] as num?)?.toInt() ?? 0,
      sharedSize: (json[r'SharedSize'] as num?)?.toInt() ?? 0,
      virtualSize: (json[r'VirtualSize'] as num?)?.toInt() ?? 0,
      labels: json[r'Labels'] as Map<String, Object?>? ?? {},
      containers: (json[r'Containers'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var parentId = this.parentId;
    var repoTags = this.repoTags;
    var repoDigests = this.repoDigests;
    var created = this.created;
    var size = this.size;
    var sharedSize = this.sharedSize;
    var virtualSize = this.virtualSize;
    var labels = this.labels;
    var containers = this.containers;

    final json = <String, Object?>{};
    json[r'Id'] = id;
    json[r'ParentId'] = parentId;
    json[r'RepoTags'] = repoTags;
    json[r'RepoDigests'] = repoDigests;
    json[r'Created'] = created;
    json[r'Size'] = size;
    json[r'SharedSize'] = sharedSize;
    json[r'VirtualSize'] = virtualSize;
    json[r'Labels'] = labels;
    json[r'Containers'] = containers;
    return json;
  }

  ImageSummary copyWith(
      {String? id,
      String? parentId,
      List<String>? repoTags,
      List<String>? repoDigests,
      int? created,
      int? size,
      int? sharedSize,
      int? virtualSize,
      Map<String, dynamic>? labels,
      int? containers}) {
    return ImageSummary(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      repoTags: repoTags ?? this.repoTags,
      repoDigests: repoDigests ?? this.repoDigests,
      created: created ?? this.created,
      size: size ?? this.size,
      sharedSize: sharedSize ?? this.sharedSize,
      virtualSize: virtualSize ?? this.virtualSize,
      labels: labels ?? this.labels,
      containers: containers ?? this.containers,
    );
  }
}

/// IndexInfo contains information about a registry.
class IndexInfo {
  /// Name of the registry, such as "docker.io".
  final String? name;

  /// List of mirrors, expressed as URIs.
  final List<String> mirrors;

  /// Indicates if the registry is part of the list of insecure
  /// registries.
  ///
  /// If `false`, the registry is insecure. Insecure registries accept
  /// un-encrypted (HTTP) and/or untrusted (HTTPS with certificates from
  /// unknown CAs) communication.
  ///
  /// > **Warning**: Insecure registries can be useful when running a local
  /// > registry. However, because its use creates security vulnerabilities
  /// > it should ONLY be enabled for testing purposes. For increased
  /// > security, users should add their CA to their system's list of
  /// > trusted CAs instead of enabling this option.
  final bool secure;

  /// Indicates whether this is an official registry (i.e., Docker Hub /
  /// docker.io)
  final bool official;

  IndexInfo({this.name, List<String>? mirrors, bool? secure, bool? official})
      : mirrors = mirrors ?? [],
        secure = secure ?? false,
        official = official ?? false;

  factory IndexInfo.fromJson(Map<String, Object?> json) {
    return IndexInfo(
      name: json[r'Name'] as String?,
      mirrors: (json[r'Mirrors'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      secure: json[r'Secure'] as bool? ?? false,
      official: json[r'Official'] as bool? ?? false,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var mirrors = this.mirrors;
    var secure = this.secure;
    var official = this.official;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    json[r'Mirrors'] = mirrors;
    json[r'Secure'] = secure;
    json[r'Official'] = official;
    return json;
  }

  IndexInfo copyWith(
      {String? name, List<String>? mirrors, bool? secure, bool? official}) {
    return IndexInfo(
      name: name ?? this.name,
      mirrors: mirrors ?? this.mirrors,
      secure: secure ?? this.secure,
      official: official ?? this.official,
    );
  }
}

/// JoinTokens contains the tokens workers and managers need to join the swarm.
class JoinTokens {
  /// The token workers can use to join the swarm.
  final String? worker;

  /// The token managers can use to join the swarm.
  final String? manager;

  JoinTokens({this.worker, this.manager});

  factory JoinTokens.fromJson(Map<String, Object?> json) {
    return JoinTokens(
      worker: json[r'Worker'] as String?,
      manager: json[r'Manager'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var worker = this.worker;
    var manager = this.manager;

    final json = <String, Object?>{};
    if (worker != null) {
      json[r'Worker'] = worker;
    }
    if (manager != null) {
      json[r'Manager'] = manager;
    }
    return json;
  }

  JoinTokens copyWith({String? worker, String? manager}) {
    return JoinTokens(
      worker: worker ?? this.worker,
      manager: manager ?? this.manager,
    );
  }
}

/// An object describing a limit on resources which can be requested by a task.
class Limit {
  final int? nanoCpUs;
  final int? memoryBytes;

  /// Limits the maximum number of PIDs in the container. Set `0` for unlimited.
  final int? pids;

  Limit({this.nanoCpUs, this.memoryBytes, this.pids});

  factory Limit.fromJson(Map<String, Object?> json) {
    return Limit(
      nanoCpUs: (json[r'NanoCPUs'] as num?)?.toInt(),
      memoryBytes: (json[r'MemoryBytes'] as num?)?.toInt(),
      pids: (json[r'Pids'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var nanoCpUs = this.nanoCpUs;
    var memoryBytes = this.memoryBytes;
    var pids = this.pids;

    final json = <String, Object?>{};
    if (nanoCpUs != null) {
      json[r'NanoCPUs'] = nanoCpUs;
    }
    if (memoryBytes != null) {
      json[r'MemoryBytes'] = memoryBytes;
    }
    if (pids != null) {
      json[r'Pids'] = pids;
    }
    return json;
  }

  Limit copyWith({int? nanoCpUs, int? memoryBytes, int? pids}) {
    return Limit(
      nanoCpUs: nanoCpUs ?? this.nanoCpUs,
      memoryBytes: memoryBytes ?? this.memoryBytes,
      pids: pids ?? this.pids,
    );
  }
}

/// Current local status of this node.
class LocalNodeState {
  LocalNodeState();

  factory LocalNodeState.fromJson(Map<String, Object?> json) {
    return LocalNodeState();
  }

  Map<String, Object?> toJson() {
    final json = <String, Object?>{};
    return json;
  }
}

/// ManagerStatus represents the status of a manager.
///
/// It provides the current status of a node's manager component, if the node
/// is a manager.
class ManagerStatus {
  final bool leader;
  final Reachability? reachability;

  /// The IP address and port at which the manager is reachable.
  final String? addr;

  ManagerStatus({bool? leader, this.reachability, this.addr})
      : leader = leader ?? false;

  factory ManagerStatus.fromJson(Map<String, Object?> json) {
    return ManagerStatus(
      leader: json[r'Leader'] as bool? ?? false,
      reachability: json[r'Reachability'] != null
          ? Reachability.fromJson(
              json[r'Reachability']! as Map<String, Object?>)
          : null,
      addr: json[r'Addr'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var leader = this.leader;
    var reachability = this.reachability;
    var addr = this.addr;

    final json = <String, Object?>{};
    json[r'Leader'] = leader;
    if (reachability != null) {
      json[r'Reachability'] = reachability.toJson();
    }
    if (addr != null) {
      json[r'Addr'] = addr;
    }
    return json;
  }

  ManagerStatus copyWith(
      {bool? leader, Reachability? reachability, String? addr}) {
    return ManagerStatus(
      leader: leader ?? this.leader,
      reachability: reachability ?? this.reachability,
      addr: addr ?? this.addr,
    );
  }
}

class Mount {
  /// Container path.
  final String? target;

  /// Mount source (e.g. a volume name, a host path).
  final String? source;

  /// The mount type. Available types:
  ///
  /// - `bind` Mounts a file or directory from the host into the container. Must
  /// exist prior to creating the container.
  /// - `volume` Creates a volume with the given name and options (or uses a
  /// pre-existing volume with the same name and options). These are **not**
  /// removed when the container is removed.
  /// - `tmpfs` Create a tmpfs with the given options. The mount source cannot
  /// be specified for tmpfs.
  /// - `npipe` Mounts a named pipe from the host into the container. Must exist
  /// prior to creating the container.
  final MountType? type;

  /// Whether the mount should be read-only.
  final bool readOnly;

  /// The consistency requirement for the mount: `default`, `consistent`,
  /// `cached`, or `delegated`.
  final String? consistency;

  /// Optional configuration for the `bind` type.
  final MountBindOptions? bindOptions;

  /// Optional configuration for the `volume` type.
  final MountVolumeOptions? volumeOptions;

  /// Optional configuration for the `tmpfs` type.
  final MountTmpfsOptions? tmpfsOptions;

  Mount(
      {this.target,
      this.source,
      this.type,
      bool? readOnly,
      this.consistency,
      this.bindOptions,
      this.volumeOptions,
      this.tmpfsOptions})
      : readOnly = readOnly ?? false;

  factory Mount.fromJson(Map<String, Object?> json) {
    return Mount(
      target: json[r'Target'] as String?,
      source: json[r'Source'] as String?,
      type: json[r'Type'] != null
          ? MountType.fromValue(json[r'Type']! as String)
          : null,
      readOnly: json[r'ReadOnly'] as bool? ?? false,
      consistency: json[r'Consistency'] as String?,
      bindOptions: json[r'BindOptions'] != null
          ? MountBindOptions.fromJson(
              json[r'BindOptions']! as Map<String, Object?>)
          : null,
      volumeOptions: json[r'VolumeOptions'] != null
          ? MountVolumeOptions.fromJson(
              json[r'VolumeOptions']! as Map<String, Object?>)
          : null,
      tmpfsOptions: json[r'TmpfsOptions'] != null
          ? MountTmpfsOptions.fromJson(
              json[r'TmpfsOptions']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var target = this.target;
    var source = this.source;
    var type = this.type;
    var readOnly = this.readOnly;
    var consistency = this.consistency;
    var bindOptions = this.bindOptions;
    var volumeOptions = this.volumeOptions;
    var tmpfsOptions = this.tmpfsOptions;

    final json = <String, Object?>{};
    if (target != null) {
      json[r'Target'] = target;
    }
    if (source != null) {
      json[r'Source'] = source;
    }
    if (type != null) {
      json[r'Type'] = type.value;
    }
    json[r'ReadOnly'] = readOnly;
    if (consistency != null) {
      json[r'Consistency'] = consistency;
    }
    if (bindOptions != null) {
      json[r'BindOptions'] = bindOptions.toJson();
    }
    if (volumeOptions != null) {
      json[r'VolumeOptions'] = volumeOptions.toJson();
    }
    if (tmpfsOptions != null) {
      json[r'TmpfsOptions'] = tmpfsOptions.toJson();
    }
    return json;
  }

  Mount copyWith(
      {String? target,
      String? source,
      MountType? type,
      bool? readOnly,
      String? consistency,
      MountBindOptions? bindOptions,
      MountVolumeOptions? volumeOptions,
      MountTmpfsOptions? tmpfsOptions}) {
    return Mount(
      target: target ?? this.target,
      source: source ?? this.source,
      type: type ?? this.type,
      readOnly: readOnly ?? this.readOnly,
      consistency: consistency ?? this.consistency,
      bindOptions: bindOptions ?? this.bindOptions,
      volumeOptions: volumeOptions ?? this.volumeOptions,
      tmpfsOptions: tmpfsOptions ?? this.tmpfsOptions,
    );
  }
}

class MountType {
  static const bind = MountType._('bind');
  static const volume = MountType._('volume');
  static const tmpfs = MountType._('tmpfs');
  static const npipe = MountType._('npipe');

  static const values = [
    bind,
    volume,
    tmpfs,
    npipe,
  ];
  final String value;

  const MountType._(this.value);

  static MountType fromValue(String value) => values
      .firstWhere((e) => e.value == value, orElse: () => MountType._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

/// Optional configuration for the `bind` type.
class MountBindOptions {
  /// A propagation mode with the value `[r]private`, `[r]shared`, or
  /// `[r]slave`.
  final MountBindOptionsPropagation? propagation;

  /// Disable recursive bind mount.
  final bool nonRecursive;

  MountBindOptions({this.propagation, bool? nonRecursive})
      : nonRecursive = nonRecursive ?? false;

  factory MountBindOptions.fromJson(Map<String, Object?> json) {
    return MountBindOptions(
      propagation: json[r'Propagation'] != null
          ? MountBindOptionsPropagation.fromValue(
              json[r'Propagation']! as String)
          : null,
      nonRecursive: json[r'NonRecursive'] as bool? ?? false,
    );
  }

  Map<String, Object?> toJson() {
    var propagation = this.propagation;
    var nonRecursive = this.nonRecursive;

    final json = <String, Object?>{};
    if (propagation != null) {
      json[r'Propagation'] = propagation.value;
    }
    json[r'NonRecursive'] = nonRecursive;
    return json;
  }

  MountBindOptions copyWith(
      {MountBindOptionsPropagation? propagation, bool? nonRecursive}) {
    return MountBindOptions(
      propagation: propagation ?? this.propagation,
      nonRecursive: nonRecursive ?? this.nonRecursive,
    );
  }
}

class MountBindOptionsPropagation {
  static const private = MountBindOptionsPropagation._('private');
  static const rprivate = MountBindOptionsPropagation._('rprivate');
  static const shared = MountBindOptionsPropagation._('shared');
  static const rshared = MountBindOptionsPropagation._('rshared');
  static const slave = MountBindOptionsPropagation._('slave');
  static const rslave = MountBindOptionsPropagation._('rslave');

  static const values = [
    private,
    rprivate,
    shared,
    rshared,
    slave,
    rslave,
  ];
  final String value;

  const MountBindOptionsPropagation._(this.value);

  static MountBindOptionsPropagation fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => MountBindOptionsPropagation._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

/// A mount point inside a container
class MountPoint {
  final String? type;
  final String? name;
  final String? source;
  final String? destination;
  final String? driver;
  final String? mode;
  final bool rw;
  final String? propagation;

  MountPoint(
      {this.type,
      this.name,
      this.source,
      this.destination,
      this.driver,
      this.mode,
      bool? rw,
      this.propagation})
      : rw = rw ?? false;

  factory MountPoint.fromJson(Map<String, Object?> json) {
    return MountPoint(
      type: json[r'Type'] as String?,
      name: json[r'Name'] as String?,
      source: json[r'Source'] as String?,
      destination: json[r'Destination'] as String?,
      driver: json[r'Driver'] as String?,
      mode: json[r'Mode'] as String?,
      rw: json[r'RW'] as bool? ?? false,
      propagation: json[r'Propagation'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var type = this.type;
    var name = this.name;
    var source = this.source;
    var destination = this.destination;
    var driver = this.driver;
    var mode = this.mode;
    var rw = this.rw;
    var propagation = this.propagation;

    final json = <String, Object?>{};
    if (type != null) {
      json[r'Type'] = type;
    }
    if (name != null) {
      json[r'Name'] = name;
    }
    if (source != null) {
      json[r'Source'] = source;
    }
    if (destination != null) {
      json[r'Destination'] = destination;
    }
    if (driver != null) {
      json[r'Driver'] = driver;
    }
    if (mode != null) {
      json[r'Mode'] = mode;
    }
    json[r'RW'] = rw;
    if (propagation != null) {
      json[r'Propagation'] = propagation;
    }
    return json;
  }

  MountPoint copyWith(
      {String? type,
      String? name,
      String? source,
      String? destination,
      String? driver,
      String? mode,
      bool? rw,
      String? propagation}) {
    return MountPoint(
      type: type ?? this.type,
      name: name ?? this.name,
      source: source ?? this.source,
      destination: destination ?? this.destination,
      driver: driver ?? this.driver,
      mode: mode ?? this.mode,
      rw: rw ?? this.rw,
      propagation: propagation ?? this.propagation,
    );
  }
}

/// Optional configuration for the `tmpfs` type.
class MountTmpfsOptions {
  /// The size for the tmpfs mount in bytes.
  final int? sizeBytes;

  /// The permission mode for the tmpfs mount in an integer.
  final int? mode;

  MountTmpfsOptions({this.sizeBytes, this.mode});

  factory MountTmpfsOptions.fromJson(Map<String, Object?> json) {
    return MountTmpfsOptions(
      sizeBytes: (json[r'SizeBytes'] as num?)?.toInt(),
      mode: (json[r'Mode'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var sizeBytes = this.sizeBytes;
    var mode = this.mode;

    final json = <String, Object?>{};
    if (sizeBytes != null) {
      json[r'SizeBytes'] = sizeBytes;
    }
    if (mode != null) {
      json[r'Mode'] = mode;
    }
    return json;
  }

  MountTmpfsOptions copyWith({int? sizeBytes, int? mode}) {
    return MountTmpfsOptions(
      sizeBytes: sizeBytes ?? this.sizeBytes,
      mode: mode ?? this.mode,
    );
  }
}

/// Optional configuration for the `volume` type.
class MountVolumeOptions {
  /// Populate volume with data from the target.
  final bool noCopy;

  /// User-defined key/value metadata.
  final Map<String, dynamic>? labels;

  /// Map of driver specific options
  final MountVolumeOptionsDriverConfig? driverConfig;

  MountVolumeOptions({bool? noCopy, this.labels, this.driverConfig})
      : noCopy = noCopy ?? false;

  factory MountVolumeOptions.fromJson(Map<String, Object?> json) {
    return MountVolumeOptions(
      noCopy: json[r'NoCopy'] as bool? ?? false,
      labels: json[r'Labels'] as Map<String, Object?>?,
      driverConfig: json[r'DriverConfig'] != null
          ? MountVolumeOptionsDriverConfig.fromJson(
              json[r'DriverConfig']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var noCopy = this.noCopy;
    var labels = this.labels;
    var driverConfig = this.driverConfig;

    final json = <String, Object?>{};
    json[r'NoCopy'] = noCopy;
    if (labels != null) {
      json[r'Labels'] = labels;
    }
    if (driverConfig != null) {
      json[r'DriverConfig'] = driverConfig.toJson();
    }
    return json;
  }

  MountVolumeOptions copyWith(
      {bool? noCopy,
      Map<String, dynamic>? labels,
      MountVolumeOptionsDriverConfig? driverConfig}) {
    return MountVolumeOptions(
      noCopy: noCopy ?? this.noCopy,
      labels: labels ?? this.labels,
      driverConfig: driverConfig ?? this.driverConfig,
    );
  }
}

/// Map of driver specific options
class MountVolumeOptionsDriverConfig {
  /// Name of the driver to use to create the volume.
  final String? name;

  /// key/value map of driver specific options.
  final Map<String, dynamic>? options;

  MountVolumeOptionsDriverConfig({this.name, this.options});

  factory MountVolumeOptionsDriverConfig.fromJson(Map<String, Object?> json) {
    return MountVolumeOptionsDriverConfig(
      name: json[r'Name'] as String?,
      options: json[r'Options'] as Map<String, Object?>?,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var options = this.options;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (options != null) {
      json[r'Options'] = options;
    }
    return json;
  }

  MountVolumeOptionsDriverConfig copyWith(
      {String? name, Map<String, dynamic>? options}) {
    return MountVolumeOptionsDriverConfig(
      name: name ?? this.name,
      options: options ?? this.options,
    );
  }
}

class Network {
  final String? name;
  final String? id;
  final DateTime? created;
  final String? scope;
  final String? driver;
  final bool enableiPv6;
  final IPAM? ipam;
  final bool internal;
  final bool attachable;
  final bool ingress;
  final Map<String, dynamic>? containers;
  final Map<String, dynamic>? options;
  final Map<String, dynamic>? labels;

  Network(
      {this.name,
      this.id,
      this.created,
      this.scope,
      this.driver,
      bool? enableiPv6,
      this.ipam,
      bool? internal,
      bool? attachable,
      bool? ingress,
      this.containers,
      this.options,
      this.labels})
      : enableiPv6 = enableiPv6 ?? false,
        internal = internal ?? false,
        attachable = attachable ?? false,
        ingress = ingress ?? false;

  factory Network.fromJson(Map<String, Object?> json) {
    return Network(
      name: json[r'Name'] as String?,
      id: json[r'Id'] as String?,
      created: DateTime.tryParse(json[r'Created'] as String? ?? ''),
      scope: json[r'Scope'] as String?,
      driver: json[r'Driver'] as String?,
      enableiPv6: json[r'EnableIPv6'] as bool? ?? false,
      ipam: json[r'IPAM'] != null
          ? IPAM.fromJson(json[r'IPAM']! as Map<String, Object?>)
          : null,
      internal: json[r'Internal'] as bool? ?? false,
      attachable: json[r'Attachable'] as bool? ?? false,
      ingress: json[r'Ingress'] as bool? ?? false,
      containers: json[r'Containers'] as Map<String, Object?>?,
      options: json[r'Options'] as Map<String, Object?>?,
      labels: json[r'Labels'] as Map<String, Object?>?,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var id = this.id;
    var created = this.created;
    var scope = this.scope;
    var driver = this.driver;
    var enableiPv6 = this.enableiPv6;
    var ipam = this.ipam;
    var internal = this.internal;
    var attachable = this.attachable;
    var ingress = this.ingress;
    var containers = this.containers;
    var options = this.options;
    var labels = this.labels;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (id != null) {
      json[r'Id'] = id;
    }
    if (created != null) {
      json[r'Created'] = created.toIso8601String();
    }
    if (scope != null) {
      json[r'Scope'] = scope;
    }
    if (driver != null) {
      json[r'Driver'] = driver;
    }
    json[r'EnableIPv6'] = enableiPv6;
    if (ipam != null) {
      json[r'IPAM'] = ipam.toJson();
    }
    json[r'Internal'] = internal;
    json[r'Attachable'] = attachable;
    json[r'Ingress'] = ingress;
    if (containers != null) {
      json[r'Containers'] = containers;
    }
    if (options != null) {
      json[r'Options'] = options;
    }
    if (labels != null) {
      json[r'Labels'] = labels;
    }
    return json;
  }

  Network copyWith(
      {String? name,
      String? id,
      DateTime? created,
      String? scope,
      String? driver,
      bool? enableiPv6,
      IPAM? ipam,
      bool? internal,
      bool? attachable,
      bool? ingress,
      Map<String, dynamic>? containers,
      Map<String, dynamic>? options,
      Map<String, dynamic>? labels}) {
    return Network(
      name: name ?? this.name,
      id: id ?? this.id,
      created: created ?? this.created,
      scope: scope ?? this.scope,
      driver: driver ?? this.driver,
      enableiPv6: enableiPv6 ?? this.enableiPv6,
      ipam: ipam ?? this.ipam,
      internal: internal ?? this.internal,
      attachable: attachable ?? this.attachable,
      ingress: ingress ?? this.ingress,
      containers: containers ?? this.containers,
      options: options ?? this.options,
      labels: labels ?? this.labels,
    );
  }
}

/// Specifies how a service should be attached to a particular network.
class NetworkAttachmentConfig {
  /// The target network for attachment. Must be a network name or ID.
  final String? target;

  /// Discoverable alternate names for the service on this network.
  final List<String> aliases;

  /// Driver attachment options for the network target.
  final Map<String, dynamic>? driverOpts;

  NetworkAttachmentConfig({this.target, List<String>? aliases, this.driverOpts})
      : aliases = aliases ?? [];

  factory NetworkAttachmentConfig.fromJson(Map<String, Object?> json) {
    return NetworkAttachmentConfig(
      target: json[r'Target'] as String?,
      aliases: (json[r'Aliases'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      driverOpts: json[r'DriverOpts'] as Map<String, Object?>?,
    );
  }

  Map<String, Object?> toJson() {
    var target = this.target;
    var aliases = this.aliases;
    var driverOpts = this.driverOpts;

    final json = <String, Object?>{};
    if (target != null) {
      json[r'Target'] = target;
    }
    json[r'Aliases'] = aliases;
    if (driverOpts != null) {
      json[r'DriverOpts'] = driverOpts;
    }
    return json;
  }

  NetworkAttachmentConfig copyWith(
      {String? target,
      List<String>? aliases,
      Map<String, dynamic>? driverOpts}) {
    return NetworkAttachmentConfig(
      target: target ?? this.target,
      aliases: aliases ?? this.aliases,
      driverOpts: driverOpts ?? this.driverOpts,
    );
  }
}

class NetworkContainer {
  final String? name;
  final String? endpointId;
  final String? macAddress;
  final String? iPv4Address;
  final String? iPv6Address;

  NetworkContainer(
      {this.name,
      this.endpointId,
      this.macAddress,
      this.iPv4Address,
      this.iPv6Address});

  factory NetworkContainer.fromJson(Map<String, Object?> json) {
    return NetworkContainer(
      name: json[r'Name'] as String?,
      endpointId: json[r'EndpointID'] as String?,
      macAddress: json[r'MacAddress'] as String?,
      iPv4Address: json[r'IPv4Address'] as String?,
      iPv6Address: json[r'IPv6Address'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var endpointId = this.endpointId;
    var macAddress = this.macAddress;
    var iPv4Address = this.iPv4Address;
    var iPv6Address = this.iPv6Address;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (endpointId != null) {
      json[r'EndpointID'] = endpointId;
    }
    if (macAddress != null) {
      json[r'MacAddress'] = macAddress;
    }
    if (iPv4Address != null) {
      json[r'IPv4Address'] = iPv4Address;
    }
    if (iPv6Address != null) {
      json[r'IPv6Address'] = iPv6Address;
    }
    return json;
  }

  NetworkContainer copyWith(
      {String? name,
      String? endpointId,
      String? macAddress,
      String? iPv4Address,
      String? iPv6Address}) {
    return NetworkContainer(
      name: name ?? this.name,
      endpointId: endpointId ?? this.endpointId,
      macAddress: macAddress ?? this.macAddress,
      iPv4Address: iPv4Address ?? this.iPv4Address,
      iPv6Address: iPv6Address ?? this.iPv6Address,
    );
  }
}

/// NetworkSettings exposes the network settings in the API
class NetworkSettings {
  /// Name of the network's bridge (for example, `docker0`).
  final String? bridge;

  /// SandboxID uniquely represents a container's network stack.
  final String? sandboxId;

  /// Indicates if hairpin NAT should be enabled on the virtual interface.
  final bool hairpinMode;

  /// IPv6 unicast address using the link-local prefix.
  final String? linkLocaliPv6Address;

  /// Prefix length of the IPv6 unicast address.
  final int? linkLocaliPv6PrefixLen;
  final PortMap? ports;

  /// SandboxKey identifies the sandbox
  final String? sandboxKey;
  final List<Address> secondaryIpAddresses;
  final List<Address> secondaryiPv6Addresses;

  /// EndpointID uniquely represents a service endpoint in a Sandbox.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Deprecated**: This field is only propagated when attached to the
  /// > default "bridge" network. Use the information from the "bridge"
  /// > network inside the `Networks` map instead, which contains the same
  /// > information. This field was deprecated in Docker 1.9 and is scheduled
  /// > to be removed in Docker 17.12.0
  final String? endpointId;

  /// Gateway address for the default "bridge" network.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Deprecated**: This field is only propagated when attached to the
  /// > default "bridge" network. Use the information from the "bridge"
  /// > network inside the `Networks` map instead, which contains the same
  /// > information. This field was deprecated in Docker 1.9 and is scheduled
  /// > to be removed in Docker 17.12.0
  final String? gateway;

  /// Global IPv6 address for the default "bridge" network.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Deprecated**: This field is only propagated when attached to the
  /// > default "bridge" network. Use the information from the "bridge"
  /// > network inside the `Networks` map instead, which contains the same
  /// > information. This field was deprecated in Docker 1.9 and is scheduled
  /// > to be removed in Docker 17.12.0
  final String? globaliPv6Address;

  /// Mask length of the global IPv6 address.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Deprecated**: This field is only propagated when attached to the
  /// > default "bridge" network. Use the information from the "bridge"
  /// > network inside the `Networks` map instead, which contains the same
  /// > information. This field was deprecated in Docker 1.9 and is scheduled
  /// > to be removed in Docker 17.12.0
  final int? globaliPv6PrefixLen;

  /// IPv4 address for the default "bridge" network.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Deprecated**: This field is only propagated when attached to the
  /// > default "bridge" network. Use the information from the "bridge"
  /// > network inside the `Networks` map instead, which contains the same
  /// > information. This field was deprecated in Docker 1.9 and is scheduled
  /// > to be removed in Docker 17.12.0
  final String? ipAddress;

  /// Mask length of the IPv4 address.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Deprecated**: This field is only propagated when attached to the
  /// > default "bridge" network. Use the information from the "bridge"
  /// > network inside the `Networks` map instead, which contains the same
  /// > information. This field was deprecated in Docker 1.9 and is scheduled
  /// > to be removed in Docker 17.12.0
  final int? ipPrefixLen;

  /// IPv6 gateway address for this network.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Deprecated**: This field is only propagated when attached to the
  /// > default "bridge" network. Use the information from the "bridge"
  /// > network inside the `Networks` map instead, which contains the same
  /// > information. This field was deprecated in Docker 1.9 and is scheduled
  /// > to be removed in Docker 17.12.0
  final String? iPv6Gateway;

  /// MAC address for the container on the default "bridge" network.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Deprecated**: This field is only propagated when attached to the
  /// > default "bridge" network. Use the information from the "bridge"
  /// > network inside the `Networks` map instead, which contains the same
  /// > information. This field was deprecated in Docker 1.9 and is scheduled
  /// > to be removed in Docker 17.12.0
  final String? macAddress;

  /// Information about all networks that the container is connected to.
  final Map<String, dynamic>? networks;

  NetworkSettings(
      {this.bridge,
      this.sandboxId,
      bool? hairpinMode,
      this.linkLocaliPv6Address,
      this.linkLocaliPv6PrefixLen,
      this.ports,
      this.sandboxKey,
      List<Address>? secondaryIpAddresses,
      List<Address>? secondaryiPv6Addresses,
      this.endpointId,
      this.gateway,
      this.globaliPv6Address,
      this.globaliPv6PrefixLen,
      this.ipAddress,
      this.ipPrefixLen,
      this.iPv6Gateway,
      this.macAddress,
      this.networks})
      : hairpinMode = hairpinMode ?? false,
        secondaryIpAddresses = secondaryIpAddresses ?? [],
        secondaryiPv6Addresses = secondaryiPv6Addresses ?? [];

  factory NetworkSettings.fromJson(Map<String, Object?> json) {
    return NetworkSettings(
      bridge: json[r'Bridge'] as String?,
      sandboxId: json[r'SandboxID'] as String?,
      hairpinMode: json[r'HairpinMode'] as bool? ?? false,
      linkLocaliPv6Address: json[r'LinkLocalIPv6Address'] as String?,
      linkLocaliPv6PrefixLen:
          (json[r'LinkLocalIPv6PrefixLen'] as num?)?.toInt(),
      ports: json[r'Ports'] != null
          ? PortMap.fromJson(json[r'Ports']! as Map<String, Object?>)
          : null,
      sandboxKey: json[r'SandboxKey'] as String?,
      secondaryIpAddresses: (json[r'SecondaryIPAddresses'] as List<Object?>?)
              ?.map((i) =>
                  Address.fromJson(i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      secondaryiPv6Addresses:
          (json[r'SecondaryIPv6Addresses'] as List<Object?>?)
                  ?.map((i) =>
                      Address.fromJson(i as Map<String, Object?>? ?? const {}))
                  .toList() ??
              [],
      endpointId: json[r'EndpointID'] as String?,
      gateway: json[r'Gateway'] as String?,
      globaliPv6Address: json[r'GlobalIPv6Address'] as String?,
      globaliPv6PrefixLen: (json[r'GlobalIPv6PrefixLen'] as num?)?.toInt(),
      ipAddress: json[r'IPAddress'] as String?,
      ipPrefixLen: (json[r'IPPrefixLen'] as num?)?.toInt(),
      iPv6Gateway: json[r'IPv6Gateway'] as String?,
      macAddress: json[r'MacAddress'] as String?,
      networks: json[r'Networks'] as Map<String, Object?>?,
    );
  }

  Map<String, Object?> toJson() {
    var bridge = this.bridge;
    var sandboxId = this.sandboxId;
    var hairpinMode = this.hairpinMode;
    var linkLocaliPv6Address = this.linkLocaliPv6Address;
    var linkLocaliPv6PrefixLen = this.linkLocaliPv6PrefixLen;
    var ports = this.ports;
    var sandboxKey = this.sandboxKey;
    var secondaryIpAddresses = this.secondaryIpAddresses;
    var secondaryiPv6Addresses = this.secondaryiPv6Addresses;
    var endpointId = this.endpointId;
    var gateway = this.gateway;
    var globaliPv6Address = this.globaliPv6Address;
    var globaliPv6PrefixLen = this.globaliPv6PrefixLen;
    var ipAddress = this.ipAddress;
    var ipPrefixLen = this.ipPrefixLen;
    var iPv6Gateway = this.iPv6Gateway;
    var macAddress = this.macAddress;
    var networks = this.networks;

    final json = <String, Object?>{};
    if (bridge != null) {
      json[r'Bridge'] = bridge;
    }
    if (sandboxId != null) {
      json[r'SandboxID'] = sandboxId;
    }
    json[r'HairpinMode'] = hairpinMode;
    if (linkLocaliPv6Address != null) {
      json[r'LinkLocalIPv6Address'] = linkLocaliPv6Address;
    }
    if (linkLocaliPv6PrefixLen != null) {
      json[r'LinkLocalIPv6PrefixLen'] = linkLocaliPv6PrefixLen;
    }
    if (ports != null) {
      json[r'Ports'] = ports.toJson();
    }
    if (sandboxKey != null) {
      json[r'SandboxKey'] = sandboxKey;
    }
    json[r'SecondaryIPAddresses'] =
        secondaryIpAddresses.map((i) => i.toJson()).toList();
    json[r'SecondaryIPv6Addresses'] =
        secondaryiPv6Addresses.map((i) => i.toJson()).toList();
    if (endpointId != null) {
      json[r'EndpointID'] = endpointId;
    }
    if (gateway != null) {
      json[r'Gateway'] = gateway;
    }
    if (globaliPv6Address != null) {
      json[r'GlobalIPv6Address'] = globaliPv6Address;
    }
    if (globaliPv6PrefixLen != null) {
      json[r'GlobalIPv6PrefixLen'] = globaliPv6PrefixLen;
    }
    if (ipAddress != null) {
      json[r'IPAddress'] = ipAddress;
    }
    if (ipPrefixLen != null) {
      json[r'IPPrefixLen'] = ipPrefixLen;
    }
    if (iPv6Gateway != null) {
      json[r'IPv6Gateway'] = iPv6Gateway;
    }
    if (macAddress != null) {
      json[r'MacAddress'] = macAddress;
    }
    if (networks != null) {
      json[r'Networks'] = networks;
    }
    return json;
  }

  NetworkSettings copyWith(
      {String? bridge,
      String? sandboxId,
      bool? hairpinMode,
      String? linkLocaliPv6Address,
      int? linkLocaliPv6PrefixLen,
      PortMap? ports,
      String? sandboxKey,
      List<Address>? secondaryIpAddresses,
      List<Address>? secondaryiPv6Addresses,
      String? endpointId,
      String? gateway,
      String? globaliPv6Address,
      int? globaliPv6PrefixLen,
      String? ipAddress,
      int? ipPrefixLen,
      String? iPv6Gateway,
      String? macAddress,
      Map<String, dynamic>? networks}) {
    return NetworkSettings(
      bridge: bridge ?? this.bridge,
      sandboxId: sandboxId ?? this.sandboxId,
      hairpinMode: hairpinMode ?? this.hairpinMode,
      linkLocaliPv6Address: linkLocaliPv6Address ?? this.linkLocaliPv6Address,
      linkLocaliPv6PrefixLen:
          linkLocaliPv6PrefixLen ?? this.linkLocaliPv6PrefixLen,
      ports: ports ?? this.ports,
      sandboxKey: sandboxKey ?? this.sandboxKey,
      secondaryIpAddresses: secondaryIpAddresses ?? this.secondaryIpAddresses,
      secondaryiPv6Addresses:
          secondaryiPv6Addresses ?? this.secondaryiPv6Addresses,
      endpointId: endpointId ?? this.endpointId,
      gateway: gateway ?? this.gateway,
      globaliPv6Address: globaliPv6Address ?? this.globaliPv6Address,
      globaliPv6PrefixLen: globaliPv6PrefixLen ?? this.globaliPv6PrefixLen,
      ipAddress: ipAddress ?? this.ipAddress,
      ipPrefixLen: ipPrefixLen ?? this.ipPrefixLen,
      iPv6Gateway: iPv6Gateway ?? this.iPv6Gateway,
      macAddress: macAddress ?? this.macAddress,
      networks: networks ?? this.networks,
    );
  }
}

/// NetworkingConfig represents the container's networking configuration for
/// each of its interfaces.
/// It is used for the networking configs specified in the `docker create`
/// and `docker network connect` commands.
class NetworkingConfig {
  /// A mapping of network name to endpoint configuration for that network.
  final Map<String, dynamic>? endpointsConfig;

  NetworkingConfig({this.endpointsConfig});

  factory NetworkingConfig.fromJson(Map<String, Object?> json) {
    return NetworkingConfig(
      endpointsConfig: json[r'EndpointsConfig'] as Map<String, Object?>?,
    );
  }

  Map<String, Object?> toJson() {
    var endpointsConfig = this.endpointsConfig;

    final json = <String, Object?>{};
    if (endpointsConfig != null) {
      json[r'EndpointsConfig'] = endpointsConfig;
    }
    return json;
  }

  NetworkingConfig copyWith({Map<String, dynamic>? endpointsConfig}) {
    return NetworkingConfig(
      endpointsConfig: endpointsConfig ?? this.endpointsConfig,
    );
  }
}

class Node {
  final String? id;
  final ObjectVersion? version;

  /// Date and time at which the node was added to the swarm in
  /// [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.
  final DateTime? createdAt;

  /// Date and time at which the node was last updated in
  /// [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format with nano-seconds.
  final DateTime? updatedAt;
  final NodeSpec? spec;
  final NodeDescription? description;
  final NodeStatus? status;
  final ManagerStatus? managerStatus;

  Node(
      {this.id,
      this.version,
      this.createdAt,
      this.updatedAt,
      this.spec,
      this.description,
      this.status,
      this.managerStatus});

  factory Node.fromJson(Map<String, Object?> json) {
    return Node(
      id: json[r'ID'] as String?,
      version: json[r'Version'] != null
          ? ObjectVersion.fromJson(json[r'Version']! as Map<String, Object?>)
          : null,
      createdAt: DateTime.tryParse(json[r'CreatedAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json[r'UpdatedAt'] as String? ?? ''),
      spec: json[r'Spec'] != null
          ? NodeSpec.fromJson(json[r'Spec']! as Map<String, Object?>)
          : null,
      description: json[r'Description'] != null
          ? NodeDescription.fromJson(
              json[r'Description']! as Map<String, Object?>)
          : null,
      status: json[r'Status'] != null
          ? NodeStatus.fromJson(json[r'Status']! as Map<String, Object?>)
          : null,
      managerStatus: json[r'ManagerStatus'] != null
          ? ManagerStatus.fromJson(
              json[r'ManagerStatus']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var version = this.version;
    var createdAt = this.createdAt;
    var updatedAt = this.updatedAt;
    var spec = this.spec;
    var description = this.description;
    var status = this.status;
    var managerStatus = this.managerStatus;

    final json = <String, Object?>{};
    if (id != null) {
      json[r'ID'] = id;
    }
    if (version != null) {
      json[r'Version'] = version.toJson();
    }
    if (createdAt != null) {
      json[r'CreatedAt'] = createdAt.toIso8601String();
    }
    if (updatedAt != null) {
      json[r'UpdatedAt'] = updatedAt.toIso8601String();
    }
    if (spec != null) {
      json[r'Spec'] = spec.toJson();
    }
    if (description != null) {
      json[r'Description'] = description.toJson();
    }
    if (status != null) {
      json[r'Status'] = status.toJson();
    }
    if (managerStatus != null) {
      json[r'ManagerStatus'] = managerStatus.toJson();
    }
    return json;
  }

  Node copyWith(
      {String? id,
      ObjectVersion? version,
      DateTime? createdAt,
      DateTime? updatedAt,
      NodeSpec? spec,
      NodeDescription? description,
      NodeStatus? status,
      ManagerStatus? managerStatus}) {
    return Node(
      id: id ?? this.id,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      spec: spec ?? this.spec,
      description: description ?? this.description,
      status: status ?? this.status,
      managerStatus: managerStatus ?? this.managerStatus,
    );
  }
}

/// NodeDescription encapsulates the properties of the Node as reported by the
/// agent.
class NodeDescription {
  final String? hostname;
  final Platform? platform;
  final ResourceObject? resources;
  final EngineDescription? engine;
  final TLSInfo? tlsInfo;

  NodeDescription(
      {this.hostname,
      this.platform,
      this.resources,
      this.engine,
      this.tlsInfo});

  factory NodeDescription.fromJson(Map<String, Object?> json) {
    return NodeDescription(
      hostname: json[r'Hostname'] as String?,
      platform: json[r'Platform'] != null
          ? Platform.fromJson(json[r'Platform']! as Map<String, Object?>)
          : null,
      resources: json[r'Resources'] != null
          ? ResourceObject.fromJson(json[r'Resources']! as Map<String, Object?>)
          : null,
      engine: json[r'Engine'] != null
          ? EngineDescription.fromJson(json[r'Engine']! as Map<String, Object?>)
          : null,
      tlsInfo: json[r'TLSInfo'] != null
          ? TLSInfo.fromJson(json[r'TLSInfo']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var hostname = this.hostname;
    var platform = this.platform;
    var resources = this.resources;
    var engine = this.engine;
    var tlsInfo = this.tlsInfo;

    final json = <String, Object?>{};
    if (hostname != null) {
      json[r'Hostname'] = hostname;
    }
    if (platform != null) {
      json[r'Platform'] = platform.toJson();
    }
    if (resources != null) {
      json[r'Resources'] = resources.toJson();
    }
    if (engine != null) {
      json[r'Engine'] = engine.toJson();
    }
    if (tlsInfo != null) {
      json[r'TLSInfo'] = tlsInfo.toJson();
    }
    return json;
  }

  NodeDescription copyWith(
      {String? hostname,
      Platform? platform,
      ResourceObject? resources,
      EngineDescription? engine,
      TLSInfo? tlsInfo}) {
    return NodeDescription(
      hostname: hostname ?? this.hostname,
      platform: platform ?? this.platform,
      resources: resources ?? this.resources,
      engine: engine ?? this.engine,
      tlsInfo: tlsInfo ?? this.tlsInfo,
    );
  }
}

class NodeSpec {
  /// Name for the node.
  final String? name;

  /// User-defined key/value metadata.
  final Map<String, dynamic>? labels;

  /// Role of the node.
  final NodeSpecRole? role;

  /// Availability of the node.
  final NodeSpecAvailability? availability;

  NodeSpec({this.name, this.labels, this.role, this.availability});

  factory NodeSpec.fromJson(Map<String, Object?> json) {
    return NodeSpec(
      name: json[r'Name'] as String?,
      labels: json[r'Labels'] as Map<String, Object?>?,
      role: json[r'Role'] != null
          ? NodeSpecRole.fromValue(json[r'Role']! as String)
          : null,
      availability: json[r'Availability'] != null
          ? NodeSpecAvailability.fromValue(json[r'Availability']! as String)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var labels = this.labels;
    var role = this.role;
    var availability = this.availability;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (labels != null) {
      json[r'Labels'] = labels;
    }
    if (role != null) {
      json[r'Role'] = role.value;
    }
    if (availability != null) {
      json[r'Availability'] = availability.value;
    }
    return json;
  }

  NodeSpec copyWith(
      {String? name,
      Map<String, dynamic>? labels,
      NodeSpecRole? role,
      NodeSpecAvailability? availability}) {
    return NodeSpec(
      name: name ?? this.name,
      labels: labels ?? this.labels,
      role: role ?? this.role,
      availability: availability ?? this.availability,
    );
  }
}

class NodeSpecRole {
  static const worker = NodeSpecRole._('worker');
  static const manager = NodeSpecRole._('manager');

  static const values = [
    worker,
    manager,
  ];
  final String value;

  const NodeSpecRole._(this.value);

  static NodeSpecRole fromValue(String value) => values
      .firstWhere((e) => e.value == value, orElse: () => NodeSpecRole._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

class NodeSpecAvailability {
  static const active = NodeSpecAvailability._('active');
  static const pause = NodeSpecAvailability._('pause');
  static const drain = NodeSpecAvailability._('drain');

  static const values = [
    active,
    pause,
    drain,
  ];
  final String value;

  const NodeSpecAvailability._(this.value);

  static NodeSpecAvailability fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => NodeSpecAvailability._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

/// NodeState represents the state of a node.
class NodeState {
  NodeState();

  factory NodeState.fromJson(Map<String, Object?> json) {
    return NodeState();
  }

  Map<String, Object?> toJson() {
    final json = <String, Object?>{};
    return json;
  }
}

/// NodeStatus represents the status of a node.
///
/// It provides the current status of the node, as seen by the manager.
class NodeStatus {
  final NodeState? state;
  final String? message;

  /// IP address of the node.
  final String? addr;

  NodeStatus({this.state, this.message, this.addr});

  factory NodeStatus.fromJson(Map<String, Object?> json) {
    return NodeStatus(
      state: json[r'State'] != null
          ? NodeState.fromJson(json[r'State']! as Map<String, Object?>)
          : null,
      message: json[r'Message'] as String?,
      addr: json[r'Addr'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var state = this.state;
    var message = this.message;
    var addr = this.addr;

    final json = <String, Object?>{};
    if (state != null) {
      json[r'State'] = state.toJson();
    }
    if (message != null) {
      json[r'Message'] = message;
    }
    if (addr != null) {
      json[r'Addr'] = addr;
    }
    return json;
  }

  NodeStatus copyWith({NodeState? state, String? message, String? addr}) {
    return NodeStatus(
      state: state ?? this.state,
      message: message ?? this.message,
      addr: addr ?? this.addr,
    );
  }
}

/// The version number of the object such as node, service, etc. This is needed
/// to avoid conflicting writes. The client must send the version number along
/// with the modified specification when updating these objects.
///
/// This approach ensures safe concurrency and determinism in that the change
/// on the object may not be applied if the version number has changed from the
/// last read. In other words, if two update requests specify the same base
/// version, only one of the requests can succeed. As a result, two separate
/// update requests that happen at the same time will not unintentionally
/// overwrite each other.
class ObjectVersion {
  final int? index;

  ObjectVersion({this.index});

  factory ObjectVersion.fromJson(Map<String, Object?> json) {
    return ObjectVersion(
      index: (json[r'Index'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var index = this.index;

    final json = <String, Object?>{};
    if (index != null) {
      json[r'Index'] = index;
    }
    return json;
  }

  ObjectVersion copyWith({int? index}) {
    return ObjectVersion(
      index: index ?? this.index,
    );
  }
}

/// Represents a peer-node in the swarm
class PeerNode {
  /// Unique identifier of for this node in the swarm.
  final String? nodeId;

  /// IP address and ports at which this node can be reached.
  final String? addr;

  PeerNode({this.nodeId, this.addr});

  factory PeerNode.fromJson(Map<String, Object?> json) {
    return PeerNode(
      nodeId: json[r'NodeID'] as String?,
      addr: json[r'Addr'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var nodeId = this.nodeId;
    var addr = this.addr;

    final json = <String, Object?>{};
    if (nodeId != null) {
      json[r'NodeID'] = nodeId;
    }
    if (addr != null) {
      json[r'Addr'] = addr;
    }
    return json;
  }

  PeerNode copyWith({String? nodeId, String? addr}) {
    return PeerNode(
      nodeId: nodeId ?? this.nodeId,
      addr: addr ?? this.addr,
    );
  }
}

/// Platform represents the platform (Arch/OS).
class Platform {
  /// Architecture represents the hardware architecture (for example,
  /// `x86_64`).
  final String? architecture;

  /// OS represents the Operating System (for example, `linux` or `windows`).
  final String? os;

  Platform({this.architecture, this.os});

  factory Platform.fromJson(Map<String, Object?> json) {
    return Platform(
      architecture: json[r'Architecture'] as String?,
      os: json[r'OS'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var architecture = this.architecture;
    var os = this.os;

    final json = <String, Object?>{};
    if (architecture != null) {
      json[r'Architecture'] = architecture;
    }
    if (os != null) {
      json[r'OS'] = os;
    }
    return json;
  }

  Platform copyWith({String? architecture, String? os}) {
    return Platform(
      architecture: architecture ?? this.architecture,
      os: os ?? this.os,
    );
  }
}

/// A plugin for the Engine API
class Plugin {
  final String? id;
  final String name;

  /// True if the plugin is running. False if the plugin is not running, only
  /// installed.
  final bool enabled;

  /// Settings that can be modified by users.
  final PluginSettings settings;

  /// plugin remote reference used to push/pull the plugin
  final String? pluginReference;

  /// The config of a plugin.
  final PluginConfig config;

  Plugin(
      {this.id,
      required this.name,
      required this.enabled,
      required this.settings,
      this.pluginReference,
      required this.config});

  factory Plugin.fromJson(Map<String, Object?> json) {
    return Plugin(
      id: json[r'Id'] as String?,
      name: json[r'Name'] as String? ?? '',
      enabled: json[r'Enabled'] as bool? ?? false,
      settings: PluginSettings.fromJson(
          json[r'Settings'] as Map<String, Object?>? ?? const {}),
      pluginReference: json[r'PluginReference'] as String?,
      config: PluginConfig.fromJson(
          json[r'Config'] as Map<String, Object?>? ?? const {}),
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var name = this.name;
    var enabled = this.enabled;
    var settings = this.settings;
    var pluginReference = this.pluginReference;
    var config = this.config;

    final json = <String, Object?>{};
    if (id != null) {
      json[r'Id'] = id;
    }
    json[r'Name'] = name;
    json[r'Enabled'] = enabled;
    json[r'Settings'] = settings.toJson();
    if (pluginReference != null) {
      json[r'PluginReference'] = pluginReference;
    }
    json[r'Config'] = config.toJson();
    return json;
  }

  Plugin copyWith(
      {String? id,
      String? name,
      bool? enabled,
      PluginSettings? settings,
      String? pluginReference,
      PluginConfig? config}) {
    return Plugin(
      id: id ?? this.id,
      name: name ?? this.name,
      enabled: enabled ?? this.enabled,
      settings: settings ?? this.settings,
      pluginReference: pluginReference ?? this.pluginReference,
      config: config ?? this.config,
    );
  }
}

/// The config of a plugin.
class PluginConfig {
  /// Docker Version used to create the plugin
  final String? dockerVersion;
  final String description;
  final String documentation;

  /// The interface between Docker and the plugin
  final PluginConfigInterface interface;
  final List<String> entrypoint;
  final String workDir;
  final PluginConfigUser? user;
  final PluginConfigNetwork network;
  final PluginConfigLinux linux;
  final String propagatedMount;
  final bool ipcHost;
  final bool pidHost;
  final List<PluginMount> mounts;
  final List<PluginEnv> env;
  final PluginConfigArgs args;
  final PluginConfigRootfs? rootfs;

  PluginConfig(
      {this.dockerVersion,
      required this.description,
      required this.documentation,
      required this.interface,
      required this.entrypoint,
      required this.workDir,
      this.user,
      required this.network,
      required this.linux,
      required this.propagatedMount,
      required this.ipcHost,
      required this.pidHost,
      required this.mounts,
      required this.env,
      required this.args,
      this.rootfs});

  factory PluginConfig.fromJson(Map<String, Object?> json) {
    return PluginConfig(
      dockerVersion: json[r'DockerVersion'] as String?,
      description: json[r'Description'] as String? ?? '',
      documentation: json[r'Documentation'] as String? ?? '',
      interface: PluginConfigInterface.fromJson(
          json[r'Interface'] as Map<String, Object?>? ?? const {}),
      entrypoint: (json[r'Entrypoint'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      workDir: json[r'WorkDir'] as String? ?? '',
      user: json[r'User'] != null
          ? PluginConfigUser.fromJson(json[r'User']! as Map<String, Object?>)
          : null,
      network: PluginConfigNetwork.fromJson(
          json[r'Network'] as Map<String, Object?>? ?? const {}),
      linux: PluginConfigLinux.fromJson(
          json[r'Linux'] as Map<String, Object?>? ?? const {}),
      propagatedMount: json[r'PropagatedMount'] as String? ?? '',
      ipcHost: json[r'IpcHost'] as bool? ?? false,
      pidHost: json[r'PidHost'] as bool? ?? false,
      mounts: (json[r'Mounts'] as List<Object?>?)
              ?.map((i) =>
                  PluginMount.fromJson(i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      env: (json[r'Env'] as List<Object?>?)
              ?.map((i) =>
                  PluginEnv.fromJson(i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      args: PluginConfigArgs.fromJson(
          json[r'Args'] as Map<String, Object?>? ?? const {}),
      rootfs: json[r'rootfs'] != null
          ? PluginConfigRootfs.fromJson(
              json[r'rootfs']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var dockerVersion = this.dockerVersion;
    var description = this.description;
    var documentation = this.documentation;
    var interface = this.interface;
    var entrypoint = this.entrypoint;
    var workDir = this.workDir;
    var user = this.user;
    var network = this.network;
    var linux = this.linux;
    var propagatedMount = this.propagatedMount;
    var ipcHost = this.ipcHost;
    var pidHost = this.pidHost;
    var mounts = this.mounts;
    var env = this.env;
    var args = this.args;
    var rootfs = this.rootfs;

    final json = <String, Object?>{};
    if (dockerVersion != null) {
      json[r'DockerVersion'] = dockerVersion;
    }
    json[r'Description'] = description;
    json[r'Documentation'] = documentation;
    json[r'Interface'] = interface.toJson();
    json[r'Entrypoint'] = entrypoint;
    json[r'WorkDir'] = workDir;
    if (user != null) {
      json[r'User'] = user.toJson();
    }
    json[r'Network'] = network.toJson();
    json[r'Linux'] = linux.toJson();
    json[r'PropagatedMount'] = propagatedMount;
    json[r'IpcHost'] = ipcHost;
    json[r'PidHost'] = pidHost;
    json[r'Mounts'] = mounts.map((i) => i.toJson()).toList();
    json[r'Env'] = env.map((i) => i.toJson()).toList();
    json[r'Args'] = args.toJson();
    if (rootfs != null) {
      json[r'rootfs'] = rootfs.toJson();
    }
    return json;
  }

  PluginConfig copyWith(
      {String? dockerVersion,
      String? description,
      String? documentation,
      PluginConfigInterface? interface,
      List<String>? entrypoint,
      String? workDir,
      PluginConfigUser? user,
      PluginConfigNetwork? network,
      PluginConfigLinux? linux,
      String? propagatedMount,
      bool? ipcHost,
      bool? pidHost,
      List<PluginMount>? mounts,
      List<PluginEnv>? env,
      PluginConfigArgs? args,
      PluginConfigRootfs? rootfs}) {
    return PluginConfig(
      dockerVersion: dockerVersion ?? this.dockerVersion,
      description: description ?? this.description,
      documentation: documentation ?? this.documentation,
      interface: interface ?? this.interface,
      entrypoint: entrypoint ?? this.entrypoint,
      workDir: workDir ?? this.workDir,
      user: user ?? this.user,
      network: network ?? this.network,
      linux: linux ?? this.linux,
      propagatedMount: propagatedMount ?? this.propagatedMount,
      ipcHost: ipcHost ?? this.ipcHost,
      pidHost: pidHost ?? this.pidHost,
      mounts: mounts ?? this.mounts,
      env: env ?? this.env,
      args: args ?? this.args,
      rootfs: rootfs ?? this.rootfs,
    );
  }
}

class PluginConfigArgs {
  final String name;
  final String description;
  final List<String> settable;
  final List<String> value;

  PluginConfigArgs(
      {required this.name,
      required this.description,
      required this.settable,
      required this.value});

  factory PluginConfigArgs.fromJson(Map<String, Object?> json) {
    return PluginConfigArgs(
      name: json[r'Name'] as String? ?? '',
      description: json[r'Description'] as String? ?? '',
      settable: (json[r'Settable'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      value: (json[r'Value'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var description = this.description;
    var settable = this.settable;
    var value = this.value;

    final json = <String, Object?>{};
    json[r'Name'] = name;
    json[r'Description'] = description;
    json[r'Settable'] = settable;
    json[r'Value'] = value;
    return json;
  }

  PluginConfigArgs copyWith(
      {String? name,
      String? description,
      List<String>? settable,
      List<String>? value}) {
    return PluginConfigArgs(
      name: name ?? this.name,
      description: description ?? this.description,
      settable: settable ?? this.settable,
      value: value ?? this.value,
    );
  }
}

/// The interface between Docker and the plugin
class PluginConfigInterface {
  final List<PluginInterfaceType> types;
  final String socket;

  /// Protocol to use for clients connecting to the plugin.
  final PluginConfigInterfaceProtocolScheme? protocolScheme;

  PluginConfigInterface(
      {required this.types, required this.socket, this.protocolScheme});

  factory PluginConfigInterface.fromJson(Map<String, Object?> json) {
    return PluginConfigInterface(
      types: (json[r'Types'] as List<Object?>?)
              ?.map((i) => PluginInterfaceType.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      socket: json[r'Socket'] as String? ?? '',
      protocolScheme: json[r'ProtocolScheme'] != null
          ? PluginConfigInterfaceProtocolScheme.fromValue(
              json[r'ProtocolScheme']! as String)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var types = this.types;
    var socket = this.socket;
    var protocolScheme = this.protocolScheme;

    final json = <String, Object?>{};
    json[r'Types'] = types.map((i) => i.toJson()).toList();
    json[r'Socket'] = socket;
    if (protocolScheme != null) {
      json[r'ProtocolScheme'] = protocolScheme.value;
    }
    return json;
  }

  PluginConfigInterface copyWith(
      {List<PluginInterfaceType>? types,
      String? socket,
      PluginConfigInterfaceProtocolScheme? protocolScheme}) {
    return PluginConfigInterface(
      types: types ?? this.types,
      socket: socket ?? this.socket,
      protocolScheme: protocolScheme ?? this.protocolScheme,
    );
  }
}

class PluginConfigInterfaceProtocolScheme {
  static const $empty = PluginConfigInterfaceProtocolScheme._('');
  static const mobyPluginsHttpV1 =
      PluginConfigInterfaceProtocolScheme._('moby.plugins.http/v1');

  static const values = [
    $empty,
    mobyPluginsHttpV1,
  ];
  final String value;

  const PluginConfigInterfaceProtocolScheme._(this.value);

  static PluginConfigInterfaceProtocolScheme fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => PluginConfigInterfaceProtocolScheme._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

class PluginConfigLinux {
  final List<String> capabilities;
  final bool allowAllDevices;
  final List<PluginDevice> devices;

  PluginConfigLinux(
      {required this.capabilities,
      required this.allowAllDevices,
      required this.devices});

  factory PluginConfigLinux.fromJson(Map<String, Object?> json) {
    return PluginConfigLinux(
      capabilities: (json[r'Capabilities'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      allowAllDevices: json[r'AllowAllDevices'] as bool? ?? false,
      devices: (json[r'Devices'] as List<Object?>?)
              ?.map((i) =>
                  PluginDevice.fromJson(i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var capabilities = this.capabilities;
    var allowAllDevices = this.allowAllDevices;
    var devices = this.devices;

    final json = <String, Object?>{};
    json[r'Capabilities'] = capabilities;
    json[r'AllowAllDevices'] = allowAllDevices;
    json[r'Devices'] = devices.map((i) => i.toJson()).toList();
    return json;
  }

  PluginConfigLinux copyWith(
      {List<String>? capabilities,
      bool? allowAllDevices,
      List<PluginDevice>? devices}) {
    return PluginConfigLinux(
      capabilities: capabilities ?? this.capabilities,
      allowAllDevices: allowAllDevices ?? this.allowAllDevices,
      devices: devices ?? this.devices,
    );
  }
}

class PluginConfigNetwork {
  final String type;

  PluginConfigNetwork({required this.type});

  factory PluginConfigNetwork.fromJson(Map<String, Object?> json) {
    return PluginConfigNetwork(
      type: json[r'Type'] as String? ?? '',
    );
  }

  Map<String, Object?> toJson() {
    var type = this.type;

    final json = <String, Object?>{};
    json[r'Type'] = type;
    return json;
  }

  PluginConfigNetwork copyWith({String? type}) {
    return PluginConfigNetwork(
      type: type ?? this.type,
    );
  }
}

class PluginConfigRootfs {
  final String? type;
  final List<String> diffIds;

  PluginConfigRootfs({this.type, List<String>? diffIds})
      : diffIds = diffIds ?? [];

  factory PluginConfigRootfs.fromJson(Map<String, Object?> json) {
    return PluginConfigRootfs(
      type: json[r'type'] as String?,
      diffIds: (json[r'diff_ids'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var type = this.type;
    var diffIds = this.diffIds;

    final json = <String, Object?>{};
    if (type != null) {
      json[r'type'] = type;
    }
    json[r'diff_ids'] = diffIds;
    return json;
  }

  PluginConfigRootfs copyWith({String? type, List<String>? diffIds}) {
    return PluginConfigRootfs(
      type: type ?? this.type,
      diffIds: diffIds ?? this.diffIds,
    );
  }
}

class PluginConfigUser {
  final int? uid;
  final int? gid;

  PluginConfigUser({this.uid, this.gid});

  factory PluginConfigUser.fromJson(Map<String, Object?> json) {
    return PluginConfigUser(
      uid: (json[r'UID'] as num?)?.toInt(),
      gid: (json[r'GID'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var uid = this.uid;
    var gid = this.gid;

    final json = <String, Object?>{};
    if (uid != null) {
      json[r'UID'] = uid;
    }
    if (gid != null) {
      json[r'GID'] = gid;
    }
    return json;
  }

  PluginConfigUser copyWith({int? uid, int? gid}) {
    return PluginConfigUser(
      uid: uid ?? this.uid,
      gid: gid ?? this.gid,
    );
  }
}

class PluginDevice {
  final String name;
  final String description;
  final List<String> settable;
  final String path;

  PluginDevice(
      {required this.name,
      required this.description,
      required this.settable,
      required this.path});

  factory PluginDevice.fromJson(Map<String, Object?> json) {
    return PluginDevice(
      name: json[r'Name'] as String? ?? '',
      description: json[r'Description'] as String? ?? '',
      settable: (json[r'Settable'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      path: json[r'Path'] as String? ?? '',
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var description = this.description;
    var settable = this.settable;
    var path = this.path;

    final json = <String, Object?>{};
    json[r'Name'] = name;
    json[r'Description'] = description;
    json[r'Settable'] = settable;
    json[r'Path'] = path;
    return json;
  }

  PluginDevice copyWith(
      {String? name,
      String? description,
      List<String>? settable,
      String? path}) {
    return PluginDevice(
      name: name ?? this.name,
      description: description ?? this.description,
      settable: settable ?? this.settable,
      path: path ?? this.path,
    );
  }
}

class PluginEnv {
  final String name;
  final String description;
  final List<String> settable;
  final String value;

  PluginEnv(
      {required this.name,
      required this.description,
      required this.settable,
      required this.value});

  factory PluginEnv.fromJson(Map<String, Object?> json) {
    return PluginEnv(
      name: json[r'Name'] as String? ?? '',
      description: json[r'Description'] as String? ?? '',
      settable: (json[r'Settable'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      value: json[r'Value'] as String? ?? '',
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var description = this.description;
    var settable = this.settable;
    var value = this.value;

    final json = <String, Object?>{};
    json[r'Name'] = name;
    json[r'Description'] = description;
    json[r'Settable'] = settable;
    json[r'Value'] = value;
    return json;
  }

  PluginEnv copyWith(
      {String? name,
      String? description,
      List<String>? settable,
      String? value}) {
    return PluginEnv(
      name: name ?? this.name,
      description: description ?? this.description,
      settable: settable ?? this.settable,
      value: value ?? this.value,
    );
  }
}

class PluginInterfaceType {
  final String prefix;
  final String capability;
  final String version;

  PluginInterfaceType(
      {required this.prefix, required this.capability, required this.version});

  factory PluginInterfaceType.fromJson(Map<String, Object?> json) {
    return PluginInterfaceType(
      prefix: json[r'Prefix'] as String? ?? '',
      capability: json[r'Capability'] as String? ?? '',
      version: json[r'Version'] as String? ?? '',
    );
  }

  Map<String, Object?> toJson() {
    var prefix = this.prefix;
    var capability = this.capability;
    var version = this.version;

    final json = <String, Object?>{};
    json[r'Prefix'] = prefix;
    json[r'Capability'] = capability;
    json[r'Version'] = version;
    return json;
  }

  PluginInterfaceType copyWith(
      {String? prefix, String? capability, String? version}) {
    return PluginInterfaceType(
      prefix: prefix ?? this.prefix,
      capability: capability ?? this.capability,
      version: version ?? this.version,
    );
  }
}

class PluginMount {
  final String name;
  final String description;
  final List<String> settable;
  final String source;
  final String destination;
  final String type;
  final List<String> options;

  PluginMount(
      {required this.name,
      required this.description,
      required this.settable,
      required this.source,
      required this.destination,
      required this.type,
      required this.options});

  factory PluginMount.fromJson(Map<String, Object?> json) {
    return PluginMount(
      name: json[r'Name'] as String? ?? '',
      description: json[r'Description'] as String? ?? '',
      settable: (json[r'Settable'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      source: json[r'Source'] as String? ?? '',
      destination: json[r'Destination'] as String? ?? '',
      type: json[r'Type'] as String? ?? '',
      options: (json[r'Options'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var description = this.description;
    var settable = this.settable;
    var source = this.source;
    var destination = this.destination;
    var type = this.type;
    var options = this.options;

    final json = <String, Object?>{};
    json[r'Name'] = name;
    json[r'Description'] = description;
    json[r'Settable'] = settable;
    json[r'Source'] = source;
    json[r'Destination'] = destination;
    json[r'Type'] = type;
    json[r'Options'] = options;
    return json;
  }

  PluginMount copyWith(
      {String? name,
      String? description,
      List<String>? settable,
      String? source,
      String? destination,
      String? type,
      List<String>? options}) {
    return PluginMount(
      name: name ?? this.name,
      description: description ?? this.description,
      settable: settable ?? this.settable,
      source: source ?? this.source,
      destination: destination ?? this.destination,
      type: type ?? this.type,
      options: options ?? this.options,
    );
  }
}

/// Settings that can be modified by users.
class PluginSettings {
  final List<PluginMount> mounts;
  final List<String> env;
  final List<String> args;
  final List<PluginDevice> devices;

  PluginSettings(
      {required this.mounts,
      required this.env,
      required this.args,
      required this.devices});

  factory PluginSettings.fromJson(Map<String, Object?> json) {
    return PluginSettings(
      mounts: (json[r'Mounts'] as List<Object?>?)
              ?.map((i) =>
                  PluginMount.fromJson(i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      env: (json[r'Env'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      args: (json[r'Args'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      devices: (json[r'Devices'] as List<Object?>?)
              ?.map((i) =>
                  PluginDevice.fromJson(i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var mounts = this.mounts;
    var env = this.env;
    var args = this.args;
    var devices = this.devices;

    final json = <String, Object?>{};
    json[r'Mounts'] = mounts.map((i) => i.toJson()).toList();
    json[r'Env'] = env;
    json[r'Args'] = args;
    json[r'Devices'] = devices.map((i) => i.toJson()).toList();
    return json;
  }

  PluginSettings copyWith(
      {List<PluginMount>? mounts,
      List<String>? env,
      List<String>? args,
      List<PluginDevice>? devices}) {
    return PluginSettings(
      mounts: mounts ?? this.mounts,
      env: env ?? this.env,
      args: args ?? this.args,
      devices: devices ?? this.devices,
    );
  }
}

/// Available plugins per type.
///
/// <p>
/// </p>
///
/// > **Note**: Only unmanaged (V1) plugins are included in this list.
/// > V1 plugins are "lazily" loaded, and are not returned in this list
/// > if there is no resource using the plugin.
class PluginsInfo {
  /// Names of available volume-drivers, and network-driver plugins.
  final List<String> volume;

  /// Names of available network-drivers, and network-driver plugins.
  final List<String> network;

  /// Names of available authorization plugins.
  final List<String> authorization;

  /// Names of available logging-drivers, and logging-driver plugins.
  final List<String> log;

  PluginsInfo(
      {List<String>? volume,
      List<String>? network,
      List<String>? authorization,
      List<String>? log})
      : volume = volume ?? [],
        network = network ?? [],
        authorization = authorization ?? [],
        log = log ?? [];

  factory PluginsInfo.fromJson(Map<String, Object?> json) {
    return PluginsInfo(
      volume: (json[r'Volume'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      network: (json[r'Network'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      authorization: (json[r'Authorization'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      log: (json[r'Log'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var volume = this.volume;
    var network = this.network;
    var authorization = this.authorization;
    var log = this.log;

    final json = <String, Object?>{};
    json[r'Volume'] = volume;
    json[r'Network'] = network;
    json[r'Authorization'] = authorization;
    json[r'Log'] = log;
    return json;
  }

  PluginsInfo copyWith(
      {List<String>? volume,
      List<String>? network,
      List<String>? authorization,
      List<String>? log}) {
    return PluginsInfo(
      volume: volume ?? this.volume,
      network: network ?? this.network,
      authorization: authorization ?? this.authorization,
      log: log ?? this.log,
    );
  }
}

/// An open port on a container
class Port {
  /// Host IP address that the container's port is mapped to
  final String? ip;

  /// Port on the container
  final int privatePort;

  /// Port exposed on the host
  final int? publicPort;
  final PortType type;

  Port(
      {this.ip,
      required this.privatePort,
      this.publicPort,
      required this.type});

  factory Port.fromJson(Map<String, Object?> json) {
    return Port(
      ip: json[r'IP'] as String?,
      privatePort: (json[r'PrivatePort'] as num?)?.toInt() ?? 0,
      publicPort: (json[r'PublicPort'] as num?)?.toInt(),
      type: PortType.fromValue(json[r'Type'] as String? ?? ''),
    );
  }

  Map<String, Object?> toJson() {
    var ip = this.ip;
    var privatePort = this.privatePort;
    var publicPort = this.publicPort;
    var type = this.type;

    final json = <String, Object?>{};
    if (ip != null) {
      json[r'IP'] = ip;
    }
    json[r'PrivatePort'] = privatePort;
    if (publicPort != null) {
      json[r'PublicPort'] = publicPort;
    }
    json[r'Type'] = type.value;
    return json;
  }

  Port copyWith(
      {String? ip, int? privatePort, int? publicPort, PortType? type}) {
    return Port(
      ip: ip ?? this.ip,
      privatePort: privatePort ?? this.privatePort,
      publicPort: publicPort ?? this.publicPort,
      type: type ?? this.type,
    );
  }
}

class PortType {
  static const tcp = PortType._('tcp');
  static const udp = PortType._('udp');
  static const sctp = PortType._('sctp');

  static const values = [
    tcp,
    udp,
    sctp,
  ];
  final String value;

  const PortType._(this.value);

  static PortType fromValue(String value) => values
      .firstWhere((e) => e.value == value, orElse: () => PortType._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

/// PortBinding represents a binding between a host IP address and a host
/// port.
class PortBinding {
  /// Host IP address that the container's port is mapped to.
  final String? hostIp;

  /// Host port number that the container's port is mapped to.
  final String? hostPort;

  PortBinding({this.hostIp, this.hostPort});

  factory PortBinding.fromJson(Map<String, Object?> json) {
    return PortBinding(
      hostIp: json[r'HostIp'] as String?,
      hostPort: json[r'HostPort'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var hostIp = this.hostIp;
    var hostPort = this.hostPort;

    final json = <String, Object?>{};
    if (hostIp != null) {
      json[r'HostIp'] = hostIp;
    }
    if (hostPort != null) {
      json[r'HostPort'] = hostPort;
    }
    return json;
  }

  PortBinding copyWith({String? hostIp, String? hostPort}) {
    return PortBinding(
      hostIp: hostIp ?? this.hostIp,
      hostPort: hostPort ?? this.hostPort,
    );
  }
}

/// PortMap describes the mapping of container ports to host ports, using the
/// container's port-number and protocol as key in the format
/// `<port>/<protocol>`,
/// for example, `80/udp`.
///
/// If a container's port is mapped for multiple protocols, separate entries
/// are added to the mapping table.
class PortMap {
  PortMap();

  factory PortMap.fromJson(Map<String, Object?> json) {
    return PortMap();
  }

  Map<String, Object?> toJson() {
    final json = <String, Object?>{};
    return json;
  }
}

class ProcessConfig {
  final bool privileged;
  final String? user;
  final bool tty;
  final String? entrypoint;
  final List<String> arguments;

  ProcessConfig(
      {bool? privileged,
      this.user,
      bool? tty,
      this.entrypoint,
      List<String>? arguments})
      : privileged = privileged ?? false,
        tty = tty ?? false,
        arguments = arguments ?? [];

  factory ProcessConfig.fromJson(Map<String, Object?> json) {
    return ProcessConfig(
      privileged: json[r'privileged'] as bool? ?? false,
      user: json[r'user'] as String?,
      tty: json[r'tty'] as bool? ?? false,
      entrypoint: json[r'entrypoint'] as String?,
      arguments: (json[r'arguments'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var privileged = this.privileged;
    var user = this.user;
    var tty = this.tty;
    var entrypoint = this.entrypoint;
    var arguments = this.arguments;

    final json = <String, Object?>{};
    json[r'privileged'] = privileged;
    if (user != null) {
      json[r'user'] = user;
    }
    json[r'tty'] = tty;
    if (entrypoint != null) {
      json[r'entrypoint'] = entrypoint;
    }
    json[r'arguments'] = arguments;
    return json;
  }

  ProcessConfig copyWith(
      {bool? privileged,
      String? user,
      bool? tty,
      String? entrypoint,
      List<String>? arguments}) {
    return ProcessConfig(
      privileged: privileged ?? this.privileged,
      user: user ?? this.user,
      tty: tty ?? this.tty,
      entrypoint: entrypoint ?? this.entrypoint,
      arguments: arguments ?? this.arguments,
    );
  }
}

class ProgressDetail {
  final int? current;
  final int? total;

  ProgressDetail({this.current, this.total});

  factory ProgressDetail.fromJson(Map<String, Object?> json) {
    return ProgressDetail(
      current: (json[r'current'] as num?)?.toInt(),
      total: (json[r'total'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var current = this.current;
    var total = this.total;

    final json = <String, Object?>{};
    if (current != null) {
      json[r'current'] = current;
    }
    if (total != null) {
      json[r'total'] = total;
    }
    return json;
  }

  ProgressDetail copyWith({int? current, int? total}) {
    return ProgressDetail(
      current: current ?? this.current,
      total: total ?? this.total,
    );
  }
}

class PushImageInfo {
  final String? error;
  final String? status;
  final String? progress;
  final ProgressDetail? progressDetail;

  PushImageInfo({this.error, this.status, this.progress, this.progressDetail});

  factory PushImageInfo.fromJson(Map<String, Object?> json) {
    return PushImageInfo(
      error: json[r'error'] as String?,
      status: json[r'status'] as String?,
      progress: json[r'progress'] as String?,
      progressDetail: json[r'progressDetail'] != null
          ? ProgressDetail.fromJson(
              json[r'progressDetail']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var error = this.error;
    var status = this.status;
    var progress = this.progress;
    var progressDetail = this.progressDetail;

    final json = <String, Object?>{};
    if (error != null) {
      json[r'error'] = error;
    }
    if (status != null) {
      json[r'status'] = status;
    }
    if (progress != null) {
      json[r'progress'] = progress;
    }
    if (progressDetail != null) {
      json[r'progressDetail'] = progressDetail.toJson();
    }
    return json;
  }

  PushImageInfo copyWith(
      {String? error,
      String? status,
      String? progress,
      ProgressDetail? progressDetail}) {
    return PushImageInfo(
      error: error ?? this.error,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      progressDetail: progressDetail ?? this.progressDetail,
    );
  }
}

/// Reachability represents the reachability of a node.
class Reachability {
  Reachability();

  factory Reachability.fromJson(Map<String, Object?> json) {
    return Reachability();
  }

  Map<String, Object?> toJson() {
    final json = <String, Object?>{};
    return json;
  }
}

/// RegistryServiceConfig stores daemon registry services configuration.
class RegistryServiceConfig {
  /// List of IP ranges to which nondistributable artifacts can be pushed,
  /// using the CIDR syntax [RFC 4632](https://tools.ietf.org/html/4632).
  ///
  /// Some images (for example, Windows base images) contain artifacts
  /// whose distribution is restricted by license. When these images are
  /// pushed to a registry, restricted artifacts are not included.
  ///
  /// This configuration override this behavior, and enables the daemon to
  /// push nondistributable artifacts to all registries whose resolved IP
  /// address is within the subnet described by the CIDR syntax.
  ///
  /// This option is useful when pushing images containing
  /// nondistributable artifacts to a registry on an air-gapped network so
  /// hosts on that network can pull the images without connecting to
  /// another server.
  ///
  /// > **Warning**: Nondistributable artifacts typically have restrictions
  /// > on how and where they can be distributed and shared. Only use this
  /// > feature to push artifacts to private registries and ensure that you
  /// > are in compliance with any terms that cover redistributing
  /// > nondistributable artifacts.
  final List<String> allowNondistributableArtifactsCidRs;

  /// List of registry hostnames to which nondistributable artifacts can be
  /// pushed, using the format `<hostname>[:<port>]` or `<IP address>[:<port>]`.
  ///
  /// Some images (for example, Windows base images) contain artifacts
  /// whose distribution is restricted by license. When these images are
  /// pushed to a registry, restricted artifacts are not included.
  ///
  /// This configuration override this behavior for the specified
  /// registries.
  ///
  /// This option is useful when pushing images containing
  /// nondistributable artifacts to a registry on an air-gapped network so
  /// hosts on that network can pull the images without connecting to
  /// another server.
  ///
  /// > **Warning**: Nondistributable artifacts typically have restrictions
  /// > on how and where they can be distributed and shared. Only use this
  /// > feature to push artifacts to private registries and ensure that you
  /// > are in compliance with any terms that cover redistributing
  /// > nondistributable artifacts.
  final List<String> allowNondistributableArtifactsHostnames;

  /// List of IP ranges of insecure registries, using the CIDR syntax
  /// ([RFC 4632](https://tools.ietf.org/html/4632)). Insecure registries
  /// accept un-encrypted (HTTP) and/or untrusted (HTTPS with certificates
  /// from unknown CAs) communication.
  ///
  /// By default, local registries (`127.0.0.0/8`) are configured as
  /// insecure. All other registries are secure. Communicating with an
  /// insecure registry is not possible if the daemon assumes that registry
  /// is secure.
  ///
  /// This configuration override this behavior, insecure communication with
  /// registries whose resolved IP address is within the subnet described by
  /// the CIDR syntax.
  ///
  /// Registries can also be marked insecure by hostname. Those registries
  /// are listed under `IndexConfigs` and have their `Secure` field set to
  /// `false`.
  ///
  /// > **Warning**: Using this option can be useful when running a local
  /// > registry, but introduces security vulnerabilities. This option
  /// > should therefore ONLY be used for testing purposes. For increased
  /// > security, users should add their CA to their system's list of trusted
  /// > CAs instead of enabling this option.
  final List<String> insecureRegistryCidRs;
  final Map<String, dynamic>? indexConfigs;

  /// List of registry URLs that act as a mirror for the official
  /// (`docker.io`) registry.
  final List<String> mirrors;

  RegistryServiceConfig(
      {List<String>? allowNondistributableArtifactsCidRs,
      List<String>? allowNondistributableArtifactsHostnames,
      List<String>? insecureRegistryCidRs,
      this.indexConfigs,
      List<String>? mirrors})
      : allowNondistributableArtifactsCidRs =
            allowNondistributableArtifactsCidRs ?? [],
        allowNondistributableArtifactsHostnames =
            allowNondistributableArtifactsHostnames ?? [],
        insecureRegistryCidRs = insecureRegistryCidRs ?? [],
        mirrors = mirrors ?? [];

  factory RegistryServiceConfig.fromJson(Map<String, Object?> json) {
    return RegistryServiceConfig(
      allowNondistributableArtifactsCidRs:
          (json[r'AllowNondistributableArtifactsCIDRs'] as List<Object?>?)
                  ?.map((i) => i as String? ?? '')
                  .toList() ??
              [],
      allowNondistributableArtifactsHostnames:
          (json[r'AllowNondistributableArtifactsHostnames'] as List<Object?>?)
                  ?.map((i) => i as String? ?? '')
                  .toList() ??
              [],
      insecureRegistryCidRs: (json[r'InsecureRegistryCIDRs'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      indexConfigs: json[r'IndexConfigs'] as Map<String, Object?>?,
      mirrors: (json[r'Mirrors'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var allowNondistributableArtifactsCidRs =
        this.allowNondistributableArtifactsCidRs;
    var allowNondistributableArtifactsHostnames =
        this.allowNondistributableArtifactsHostnames;
    var insecureRegistryCidRs = this.insecureRegistryCidRs;
    var indexConfigs = this.indexConfigs;
    var mirrors = this.mirrors;

    final json = <String, Object?>{};
    json[r'AllowNondistributableArtifactsCIDRs'] =
        allowNondistributableArtifactsCidRs;
    json[r'AllowNondistributableArtifactsHostnames'] =
        allowNondistributableArtifactsHostnames;
    json[r'InsecureRegistryCIDRs'] = insecureRegistryCidRs;
    if (indexConfigs != null) {
      json[r'IndexConfigs'] = indexConfigs;
    }
    json[r'Mirrors'] = mirrors;
    return json;
  }

  RegistryServiceConfig copyWith(
      {List<String>? allowNondistributableArtifactsCidRs,
      List<String>? allowNondistributableArtifactsHostnames,
      List<String>? insecureRegistryCidRs,
      Map<String, dynamic>? indexConfigs,
      List<String>? mirrors}) {
    return RegistryServiceConfig(
      allowNondistributableArtifactsCidRs:
          allowNondistributableArtifactsCidRs ??
              this.allowNondistributableArtifactsCidRs,
      allowNondistributableArtifactsHostnames:
          allowNondistributableArtifactsHostnames ??
              this.allowNondistributableArtifactsHostnames,
      insecureRegistryCidRs:
          insecureRegistryCidRs ?? this.insecureRegistryCidRs,
      indexConfigs: indexConfigs ?? this.indexConfigs,
      mirrors: mirrors ?? this.mirrors,
    );
  }
}

/// An object describing the resources which can be advertised by a node and
/// requested by a task.
class ResourceObject {
  final int? nanoCpUs;
  final int? memoryBytes;
  final List<GenericResources> genericResources;

  ResourceObject(
      {this.nanoCpUs,
      this.memoryBytes,
      List<GenericResources>? genericResources})
      : genericResources = genericResources ?? [];

  factory ResourceObject.fromJson(Map<String, Object?> json) {
    return ResourceObject(
      nanoCpUs: (json[r'NanoCPUs'] as num?)?.toInt(),
      memoryBytes: (json[r'MemoryBytes'] as num?)?.toInt(),
      genericResources: (json[r'GenericResources'] as List<Object?>?)
              ?.map((i) => GenericResources.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var nanoCpUs = this.nanoCpUs;
    var memoryBytes = this.memoryBytes;
    var genericResources = this.genericResources;

    final json = <String, Object?>{};
    if (nanoCpUs != null) {
      json[r'NanoCPUs'] = nanoCpUs;
    }
    if (memoryBytes != null) {
      json[r'MemoryBytes'] = memoryBytes;
    }
    json[r'GenericResources'] =
        genericResources.map((i) => i.toJson()).toList();
    return json;
  }

  ResourceObject copyWith(
      {int? nanoCpUs,
      int? memoryBytes,
      List<GenericResources>? genericResources}) {
    return ResourceObject(
      nanoCpUs: nanoCpUs ?? this.nanoCpUs,
      memoryBytes: memoryBytes ?? this.memoryBytes,
      genericResources: genericResources ?? this.genericResources,
    );
  }
}

/// A container's resources (cgroups config, ulimits, etc)
class Resources {
  /// An integer value representing this container's relative CPU weight
  /// versus other containers.
  final int? cpuShares;

  /// Memory limit in bytes.
  final int? memory;

  /// Path to `cgroups` under which the container's `cgroup` is created. If
  /// the path is not absolute, the path is considered to be relative to the
  /// `cgroups` path of the init process. Cgroups are created if they do not
  /// already exist.
  final String? cgroupParent;

  /// Block IO weight (relative weight).
  final int? blkioWeight;

  /// Block IO weight (relative device weight) in the form:
  ///
  /// ```
  /// [{"Path": "device_path", "Weight": weight}]
  /// ```
  final List<ResourcesBlkioWeightDeviceItem> blkioWeightDevice;

  /// Limit read rate (bytes per second) from a device, in the form:
  ///
  /// ```
  /// [{"Path": "device_path", "Rate": rate}]
  /// ```
  final List<ThrottleDevice> blkioDeviceReadBps;

  /// Limit write rate (bytes per second) to a device, in the form:
  ///
  /// ```
  /// [{"Path": "device_path", "Rate": rate}]
  /// ```
  final List<ThrottleDevice> blkioDeviceWriteBps;

  /// Limit read rate (IO per second) from a device, in the form:
  ///
  /// ```
  /// [{"Path": "device_path", "Rate": rate}]
  /// ```
  final List<ThrottleDevice> blkioDeviceReadiOps;

  /// Limit write rate (IO per second) to a device, in the form:
  ///
  /// ```
  /// [{"Path": "device_path", "Rate": rate}]
  /// ```
  final List<ThrottleDevice> blkioDeviceWriteiOps;

  /// The length of a CPU period in microseconds.
  final int? cpuPeriod;

  /// Microseconds of CPU time that the container can get in a CPU period.
  final int? cpuQuota;

  /// The length of a CPU real-time period in microseconds. Set to 0 to
  /// allocate no time allocated to real-time tasks.
  final int? cpuRealtimePeriod;

  /// The length of a CPU real-time runtime in microseconds. Set to 0 to
  /// allocate no time allocated to real-time tasks.
  final int? cpuRealtimeRuntime;

  /// CPUs in which to allow execution (e.g., `0-3`, `0,1`).
  final String? cpusetCpus;

  /// Memory nodes (MEMs) in which to allow execution (0-3, 0,1). Only
  /// effective on NUMA systems.
  final String? cpusetMems;

  /// A list of devices to add to the container.
  final List<DeviceMapping> devices;

  /// a list of cgroup rules to apply to the container
  final List<String> deviceCgroupRules;

  /// A list of requests for devices to be sent to device drivers.
  final List<DeviceRequest> deviceRequests;

  /// Kernel memory limit in bytes.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Deprecated**: This field is deprecated as the kernel 5.4 deprecated
  /// > `kmem.limit_in_bytes`.
  final int? kernelMemory;

  /// Hard limit for kernel TCP buffer memory (in bytes).
  final int? kernelMemoryTcp;

  /// Memory soft limit in bytes.
  final int? memoryReservation;

  /// Total memory limit (memory + swap). Set as `-1` to enable unlimited
  /// swap.
  final int? memorySwap;

  /// Tune a container's memory swappiness behavior. Accepts an integer
  /// between 0 and 100.
  final int? memorySwappiness;

  /// CPU quota in units of 10<sup>-9</sup> CPUs.
  final int? nanoCpus;

  /// Disable OOM Killer for the container.
  final bool oomKillDisable;

  /// Run an init inside the container that forwards signals and reaps
  /// processes. This field is omitted if empty, and the default (as
  /// configured on the daemon) is used.
  final bool init;

  /// Tune a container's PIDs limit. Set `0` or `-1` for unlimited, or `null`
  /// to not change.
  final int? pidsLimit;

  /// A list of resource limits to set in the container. For example:
  ///
  /// ```
  /// {"Name": "nofile", "Soft": 1024, "Hard": 2048}
  /// ```
  final List<ResourcesUlimitsItem> ulimits;

  /// The number of usable CPUs (Windows only).
  ///
  /// On Windows Server containers, the processor resource controls are
  /// mutually exclusive. The order of precedence is `CPUCount` first, then
  /// `CPUShares`, and `CPUPercent` last.
  final int? cpuCount;

  /// The usable percentage of the available CPUs (Windows only).
  ///
  /// On Windows Server containers, the processor resource controls are
  /// mutually exclusive. The order of precedence is `CPUCount` first, then
  /// `CPUShares`, and `CPUPercent` last.
  final int? cpuPercent;

  /// Maximum IOps for the container system drive (Windows only)
  final int? ioMaximumiOps;

  /// Maximum IO in bytes per second for the container system drive
  /// (Windows only).
  final int? ioMaximumBandwidth;

  Resources(
      {this.cpuShares,
      this.memory,
      this.cgroupParent,
      this.blkioWeight,
      List<ResourcesBlkioWeightDeviceItem>? blkioWeightDevice,
      List<ThrottleDevice>? blkioDeviceReadBps,
      List<ThrottleDevice>? blkioDeviceWriteBps,
      List<ThrottleDevice>? blkioDeviceReadiOps,
      List<ThrottleDevice>? blkioDeviceWriteiOps,
      this.cpuPeriod,
      this.cpuQuota,
      this.cpuRealtimePeriod,
      this.cpuRealtimeRuntime,
      this.cpusetCpus,
      this.cpusetMems,
      List<DeviceMapping>? devices,
      List<String>? deviceCgroupRules,
      List<DeviceRequest>? deviceRequests,
      this.kernelMemory,
      this.kernelMemoryTcp,
      this.memoryReservation,
      this.memorySwap,
      this.memorySwappiness,
      this.nanoCpus,
      bool? oomKillDisable,
      bool? init,
      this.pidsLimit,
      List<ResourcesUlimitsItem>? ulimits,
      this.cpuCount,
      this.cpuPercent,
      this.ioMaximumiOps,
      this.ioMaximumBandwidth})
      : blkioWeightDevice = blkioWeightDevice ?? [],
        blkioDeviceReadBps = blkioDeviceReadBps ?? [],
        blkioDeviceWriteBps = blkioDeviceWriteBps ?? [],
        blkioDeviceReadiOps = blkioDeviceReadiOps ?? [],
        blkioDeviceWriteiOps = blkioDeviceWriteiOps ?? [],
        devices = devices ?? [],
        deviceCgroupRules = deviceCgroupRules ?? [],
        deviceRequests = deviceRequests ?? [],
        oomKillDisable = oomKillDisable ?? false,
        init = init ?? false,
        ulimits = ulimits ?? [];

  factory Resources.fromJson(Map<String, Object?> json) {
    return Resources(
      cpuShares: (json[r'CpuShares'] as num?)?.toInt(),
      memory: (json[r'Memory'] as num?)?.toInt(),
      cgroupParent: json[r'CgroupParent'] as String?,
      blkioWeight: (json[r'BlkioWeight'] as num?)?.toInt(),
      blkioWeightDevice: (json[r'BlkioWeightDevice'] as List<Object?>?)
              ?.map((i) => ResourcesBlkioWeightDeviceItem.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      blkioDeviceReadBps: (json[r'BlkioDeviceReadBps'] as List<Object?>?)
              ?.map((i) => ThrottleDevice.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      blkioDeviceWriteBps: (json[r'BlkioDeviceWriteBps'] as List<Object?>?)
              ?.map((i) => ThrottleDevice.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      blkioDeviceReadiOps: (json[r'BlkioDeviceReadIOps'] as List<Object?>?)
              ?.map((i) => ThrottleDevice.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      blkioDeviceWriteiOps: (json[r'BlkioDeviceWriteIOps'] as List<Object?>?)
              ?.map((i) => ThrottleDevice.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      cpuPeriod: (json[r'CpuPeriod'] as num?)?.toInt(),
      cpuQuota: (json[r'CpuQuota'] as num?)?.toInt(),
      cpuRealtimePeriod: (json[r'CpuRealtimePeriod'] as num?)?.toInt(),
      cpuRealtimeRuntime: (json[r'CpuRealtimeRuntime'] as num?)?.toInt(),
      cpusetCpus: json[r'CpusetCpus'] as String?,
      cpusetMems: json[r'CpusetMems'] as String?,
      devices: (json[r'Devices'] as List<Object?>?)
              ?.map((i) => DeviceMapping.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      deviceCgroupRules: (json[r'DeviceCgroupRules'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      deviceRequests: (json[r'DeviceRequests'] as List<Object?>?)
              ?.map((i) => DeviceRequest.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      kernelMemory: (json[r'KernelMemory'] as num?)?.toInt(),
      kernelMemoryTcp: (json[r'KernelMemoryTCP'] as num?)?.toInt(),
      memoryReservation: (json[r'MemoryReservation'] as num?)?.toInt(),
      memorySwap: (json[r'MemorySwap'] as num?)?.toInt(),
      memorySwappiness: (json[r'MemorySwappiness'] as num?)?.toInt(),
      nanoCpus: (json[r'NanoCpus'] as num?)?.toInt(),
      oomKillDisable: json[r'OomKillDisable'] as bool? ?? false,
      init: json[r'Init'] as bool? ?? false,
      pidsLimit: (json[r'PidsLimit'] as num?)?.toInt(),
      ulimits: (json[r'Ulimits'] as List<Object?>?)
              ?.map((i) => ResourcesUlimitsItem.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      cpuCount: (json[r'CpuCount'] as num?)?.toInt(),
      cpuPercent: (json[r'CpuPercent'] as num?)?.toInt(),
      ioMaximumiOps: (json[r'IOMaximumIOps'] as num?)?.toInt(),
      ioMaximumBandwidth: (json[r'IOMaximumBandwidth'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var cpuShares = this.cpuShares;
    var memory = this.memory;
    var cgroupParent = this.cgroupParent;
    var blkioWeight = this.blkioWeight;
    var blkioWeightDevice = this.blkioWeightDevice;
    var blkioDeviceReadBps = this.blkioDeviceReadBps;
    var blkioDeviceWriteBps = this.blkioDeviceWriteBps;
    var blkioDeviceReadiOps = this.blkioDeviceReadiOps;
    var blkioDeviceWriteiOps = this.blkioDeviceWriteiOps;
    var cpuPeriod = this.cpuPeriod;
    var cpuQuota = this.cpuQuota;
    var cpuRealtimePeriod = this.cpuRealtimePeriod;
    var cpuRealtimeRuntime = this.cpuRealtimeRuntime;
    var cpusetCpus = this.cpusetCpus;
    var cpusetMems = this.cpusetMems;
    var devices = this.devices;
    var deviceCgroupRules = this.deviceCgroupRules;
    var deviceRequests = this.deviceRequests;
    var kernelMemory = this.kernelMemory;
    var kernelMemoryTcp = this.kernelMemoryTcp;
    var memoryReservation = this.memoryReservation;
    var memorySwap = this.memorySwap;
    var memorySwappiness = this.memorySwappiness;
    var nanoCpus = this.nanoCpus;
    var oomKillDisable = this.oomKillDisable;
    var init = this.init;
    var pidsLimit = this.pidsLimit;
    var ulimits = this.ulimits;
    var cpuCount = this.cpuCount;
    var cpuPercent = this.cpuPercent;
    var ioMaximumiOps = this.ioMaximumiOps;
    var ioMaximumBandwidth = this.ioMaximumBandwidth;

    final json = <String, Object?>{};
    if (cpuShares != null) {
      json[r'CpuShares'] = cpuShares;
    }
    if (memory != null) {
      json[r'Memory'] = memory;
    }
    if (cgroupParent != null) {
      json[r'CgroupParent'] = cgroupParent;
    }
    if (blkioWeight != null) {
      json[r'BlkioWeight'] = blkioWeight;
    }
    json[r'BlkioWeightDevice'] =
        blkioWeightDevice.map((i) => i.toJson()).toList();
    json[r'BlkioDeviceReadBps'] =
        blkioDeviceReadBps.map((i) => i.toJson()).toList();
    json[r'BlkioDeviceWriteBps'] =
        blkioDeviceWriteBps.map((i) => i.toJson()).toList();
    json[r'BlkioDeviceReadIOps'] =
        blkioDeviceReadiOps.map((i) => i.toJson()).toList();
    json[r'BlkioDeviceWriteIOps'] =
        blkioDeviceWriteiOps.map((i) => i.toJson()).toList();
    if (cpuPeriod != null) {
      json[r'CpuPeriod'] = cpuPeriod;
    }
    if (cpuQuota != null) {
      json[r'CpuQuota'] = cpuQuota;
    }
    if (cpuRealtimePeriod != null) {
      json[r'CpuRealtimePeriod'] = cpuRealtimePeriod;
    }
    if (cpuRealtimeRuntime != null) {
      json[r'CpuRealtimeRuntime'] = cpuRealtimeRuntime;
    }
    if (cpusetCpus != null) {
      json[r'CpusetCpus'] = cpusetCpus;
    }
    if (cpusetMems != null) {
      json[r'CpusetMems'] = cpusetMems;
    }
    json[r'Devices'] = devices.map((i) => i.toJson()).toList();
    json[r'DeviceCgroupRules'] = deviceCgroupRules;
    json[r'DeviceRequests'] = deviceRequests.map((i) => i.toJson()).toList();
    if (kernelMemory != null) {
      json[r'KernelMemory'] = kernelMemory;
    }
    if (kernelMemoryTcp != null) {
      json[r'KernelMemoryTCP'] = kernelMemoryTcp;
    }
    if (memoryReservation != null) {
      json[r'MemoryReservation'] = memoryReservation;
    }
    if (memorySwap != null) {
      json[r'MemorySwap'] = memorySwap;
    }
    if (memorySwappiness != null) {
      json[r'MemorySwappiness'] = memorySwappiness;
    }
    if (nanoCpus != null) {
      json[r'NanoCpus'] = nanoCpus;
    }
    json[r'OomKillDisable'] = oomKillDisable;
    json[r'Init'] = init;
    if (pidsLimit != null) {
      json[r'PidsLimit'] = pidsLimit;
    }
    json[r'Ulimits'] = ulimits.map((i) => i.toJson()).toList();
    if (cpuCount != null) {
      json[r'CpuCount'] = cpuCount;
    }
    if (cpuPercent != null) {
      json[r'CpuPercent'] = cpuPercent;
    }
    if (ioMaximumiOps != null) {
      json[r'IOMaximumIOps'] = ioMaximumiOps;
    }
    if (ioMaximumBandwidth != null) {
      json[r'IOMaximumBandwidth'] = ioMaximumBandwidth;
    }
    return json;
  }

  Resources copyWith(
      {int? cpuShares,
      int? memory,
      String? cgroupParent,
      int? blkioWeight,
      List<ResourcesBlkioWeightDeviceItem>? blkioWeightDevice,
      List<ThrottleDevice>? blkioDeviceReadBps,
      List<ThrottleDevice>? blkioDeviceWriteBps,
      List<ThrottleDevice>? blkioDeviceReadiOps,
      List<ThrottleDevice>? blkioDeviceWriteiOps,
      int? cpuPeriod,
      int? cpuQuota,
      int? cpuRealtimePeriod,
      int? cpuRealtimeRuntime,
      String? cpusetCpus,
      String? cpusetMems,
      List<DeviceMapping>? devices,
      List<String>? deviceCgroupRules,
      List<DeviceRequest>? deviceRequests,
      int? kernelMemory,
      int? kernelMemoryTcp,
      int? memoryReservation,
      int? memorySwap,
      int? memorySwappiness,
      int? nanoCpus,
      bool? oomKillDisable,
      bool? init,
      int? pidsLimit,
      List<ResourcesUlimitsItem>? ulimits,
      int? cpuCount,
      int? cpuPercent,
      int? ioMaximumiOps,
      int? ioMaximumBandwidth}) {
    return Resources(
      cpuShares: cpuShares ?? this.cpuShares,
      memory: memory ?? this.memory,
      cgroupParent: cgroupParent ?? this.cgroupParent,
      blkioWeight: blkioWeight ?? this.blkioWeight,
      blkioWeightDevice: blkioWeightDevice ?? this.blkioWeightDevice,
      blkioDeviceReadBps: blkioDeviceReadBps ?? this.blkioDeviceReadBps,
      blkioDeviceWriteBps: blkioDeviceWriteBps ?? this.blkioDeviceWriteBps,
      blkioDeviceReadiOps: blkioDeviceReadiOps ?? this.blkioDeviceReadiOps,
      blkioDeviceWriteiOps: blkioDeviceWriteiOps ?? this.blkioDeviceWriteiOps,
      cpuPeriod: cpuPeriod ?? this.cpuPeriod,
      cpuQuota: cpuQuota ?? this.cpuQuota,
      cpuRealtimePeriod: cpuRealtimePeriod ?? this.cpuRealtimePeriod,
      cpuRealtimeRuntime: cpuRealtimeRuntime ?? this.cpuRealtimeRuntime,
      cpusetCpus: cpusetCpus ?? this.cpusetCpus,
      cpusetMems: cpusetMems ?? this.cpusetMems,
      devices: devices ?? this.devices,
      deviceCgroupRules: deviceCgroupRules ?? this.deviceCgroupRules,
      deviceRequests: deviceRequests ?? this.deviceRequests,
      kernelMemory: kernelMemory ?? this.kernelMemory,
      kernelMemoryTcp: kernelMemoryTcp ?? this.kernelMemoryTcp,
      memoryReservation: memoryReservation ?? this.memoryReservation,
      memorySwap: memorySwap ?? this.memorySwap,
      memorySwappiness: memorySwappiness ?? this.memorySwappiness,
      nanoCpus: nanoCpus ?? this.nanoCpus,
      oomKillDisable: oomKillDisable ?? this.oomKillDisable,
      init: init ?? this.init,
      pidsLimit: pidsLimit ?? this.pidsLimit,
      ulimits: ulimits ?? this.ulimits,
      cpuCount: cpuCount ?? this.cpuCount,
      cpuPercent: cpuPercent ?? this.cpuPercent,
      ioMaximumiOps: ioMaximumiOps ?? this.ioMaximumiOps,
      ioMaximumBandwidth: ioMaximumBandwidth ?? this.ioMaximumBandwidth,
    );
  }
}

class ResourcesBlkioWeightDeviceItem {
  final String? path;
  final int? weight;

  ResourcesBlkioWeightDeviceItem({this.path, this.weight});

  factory ResourcesBlkioWeightDeviceItem.fromJson(Map<String, Object?> json) {
    return ResourcesBlkioWeightDeviceItem(
      path: json[r'Path'] as String?,
      weight: (json[r'Weight'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var path = this.path;
    var weight = this.weight;

    final json = <String, Object?>{};
    if (path != null) {
      json[r'Path'] = path;
    }
    if (weight != null) {
      json[r'Weight'] = weight;
    }
    return json;
  }

  ResourcesBlkioWeightDeviceItem copyWith({String? path, int? weight}) {
    return ResourcesBlkioWeightDeviceItem(
      path: path ?? this.path,
      weight: weight ?? this.weight,
    );
  }
}

class ResourcesUlimitsItem {
  /// Name of ulimit
  final String? name;

  /// Soft limit
  final int? soft;

  /// Hard limit
  final int? hard;

  ResourcesUlimitsItem({this.name, this.soft, this.hard});

  factory ResourcesUlimitsItem.fromJson(Map<String, Object?> json) {
    return ResourcesUlimitsItem(
      name: json[r'Name'] as String?,
      soft: (json[r'Soft'] as num?)?.toInt(),
      hard: (json[r'Hard'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var soft = this.soft;
    var hard = this.hard;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (soft != null) {
      json[r'Soft'] = soft;
    }
    if (hard != null) {
      json[r'Hard'] = hard;
    }
    return json;
  }

  ResourcesUlimitsItem copyWith({String? name, int? soft, int? hard}) {
    return ResourcesUlimitsItem(
      name: name ?? this.name,
      soft: soft ?? this.soft,
      hard: hard ?? this.hard,
    );
  }
}

/// The behavior to apply when the container exits. The default is not to
/// restart.
///
/// An ever increasing delay (double the previous delay, starting at 100ms) is
/// added before each restart to prevent flooding the server.
class RestartPolicy {
  /// - Empty string means not to restart
  /// - `always` Always restart
  /// - `unless-stopped` Restart always except when the user has manually
  /// stopped the container
  /// - `on-failure` Restart only when the container exit code is non-zero
  final RestartPolicyName? name;

  /// If `on-failure` is used, the number of times to retry before giving up.
  final int? maximumRetryCount;

  RestartPolicy({this.name, this.maximumRetryCount});

  factory RestartPolicy.fromJson(Map<String, Object?> json) {
    return RestartPolicy(
      name: json[r'Name'] != null
          ? RestartPolicyName.fromValue(json[r'Name']! as String)
          : null,
      maximumRetryCount: (json[r'MaximumRetryCount'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var maximumRetryCount = this.maximumRetryCount;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name.value;
    }
    if (maximumRetryCount != null) {
      json[r'MaximumRetryCount'] = maximumRetryCount;
    }
    return json;
  }

  RestartPolicy copyWith({RestartPolicyName? name, int? maximumRetryCount}) {
    return RestartPolicy(
      name: name ?? this.name,
      maximumRetryCount: maximumRetryCount ?? this.maximumRetryCount,
    );
  }
}

class RestartPolicyName {
  static const $empty = RestartPolicyName._('');
  static const always = RestartPolicyName._('always');
  static const unlessStopped = RestartPolicyName._('unless-stopped');
  static const onFailure = RestartPolicyName._('on-failure');

  static const values = [
    $empty,
    always,
    unlessStopped,
    onFailure,
  ];
  final String value;

  const RestartPolicyName._(this.value);

  static RestartPolicyName fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => RestartPolicyName._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

/// Runtime describes an
/// [OCI compliant](https://github.com/opencontainers/runtime-spec)
/// runtime.
///
/// The runtime is invoked by the daemon via the `containerd` daemon. OCI
/// runtimes act as an interface to the Linux kernel namespaces, cgroups,
/// and SELinux.
class Runtime {
  /// Name and, optional, path, of the OCI executable binary.
  ///
  /// If the path is omitted, the daemon searches the host's `$PATH` for the
  /// binary and uses the first result.
  final String? path;

  /// List of command-line arguments to pass to the runtime when invoked.
  final List<String> runtimeArgs;

  Runtime({this.path, List<String>? runtimeArgs})
      : runtimeArgs = runtimeArgs ?? [];

  factory Runtime.fromJson(Map<String, Object?> json) {
    return Runtime(
      path: json[r'path'] as String?,
      runtimeArgs: (json[r'runtimeArgs'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var path = this.path;
    var runtimeArgs = this.runtimeArgs;

    final json = <String, Object?>{};
    if (path != null) {
      json[r'path'] = path;
    }
    json[r'runtimeArgs'] = runtimeArgs;
    return json;
  }

  Runtime copyWith({String? path, List<String>? runtimeArgs}) {
    return Runtime(
      path: path ?? this.path,
      runtimeArgs: runtimeArgs ?? this.runtimeArgs,
    );
  }
}

class Secret {
  final String? id;
  final ObjectVersion? version;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SecretSpec? spec;

  Secret({this.id, this.version, this.createdAt, this.updatedAt, this.spec});

  factory Secret.fromJson(Map<String, Object?> json) {
    return Secret(
      id: json[r'ID'] as String?,
      version: json[r'Version'] != null
          ? ObjectVersion.fromJson(json[r'Version']! as Map<String, Object?>)
          : null,
      createdAt: DateTime.tryParse(json[r'CreatedAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json[r'UpdatedAt'] as String? ?? ''),
      spec: json[r'Spec'] != null
          ? SecretSpec.fromJson(json[r'Spec']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var version = this.version;
    var createdAt = this.createdAt;
    var updatedAt = this.updatedAt;
    var spec = this.spec;

    final json = <String, Object?>{};
    if (id != null) {
      json[r'ID'] = id;
    }
    if (version != null) {
      json[r'Version'] = version.toJson();
    }
    if (createdAt != null) {
      json[r'CreatedAt'] = createdAt.toIso8601String();
    }
    if (updatedAt != null) {
      json[r'UpdatedAt'] = updatedAt.toIso8601String();
    }
    if (spec != null) {
      json[r'Spec'] = spec.toJson();
    }
    return json;
  }

  Secret copyWith(
      {String? id,
      ObjectVersion? version,
      DateTime? createdAt,
      DateTime? updatedAt,
      SecretSpec? spec}) {
    return Secret(
      id: id ?? this.id,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      spec: spec ?? this.spec,
    );
  }
}

class SecretSpec {
  /// User-defined name of the secret.
  final String? name;

  /// User-defined key/value metadata.
  final Map<String, dynamic>? labels;

  /// Base64-url-safe-encoded
  /// ([RFC 4648](https://tools.ietf.org/html/rfc4648#section-5))
  /// data to store as secret.
  ///
  /// This field is only used to _create_ a secret, and is not returned by
  /// other endpoints.
  final String? data;

  /// Name of the secrets driver used to fetch the secret's value from an
  /// external secret store.
  final Driver? driver;

  /// Templating driver, if applicable
  ///
  /// Templating controls whether and how to evaluate the config payload as
  /// a template. If no driver is set, no templating is used.
  final Driver? templating;

  SecretSpec({this.name, this.labels, this.data, this.driver, this.templating});

  factory SecretSpec.fromJson(Map<String, Object?> json) {
    return SecretSpec(
      name: json[r'Name'] as String?,
      labels: json[r'Labels'] as Map<String, Object?>?,
      data: json[r'Data'] as String?,
      driver: json[r'Driver'] != null
          ? Driver.fromJson(json[r'Driver']! as Map<String, Object?>)
          : null,
      templating: json[r'Templating'] != null
          ? Driver.fromJson(json[r'Templating']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var labels = this.labels;
    var data = this.data;
    var driver = this.driver;
    var templating = this.templating;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (labels != null) {
      json[r'Labels'] = labels;
    }
    if (data != null) {
      json[r'Data'] = data;
    }
    if (driver != null) {
      json[r'Driver'] = driver.toJson();
    }
    if (templating != null) {
      json[r'Templating'] = templating.toJson();
    }
    return json;
  }

  SecretSpec copyWith(
      {String? name,
      Map<String, dynamic>? labels,
      String? data,
      Driver? driver,
      Driver? templating}) {
    return SecretSpec(
      name: name ?? this.name,
      labels: labels ?? this.labels,
      data: data ?? this.data,
      driver: driver ?? this.driver,
      templating: templating ?? this.templating,
    );
  }
}

class Service {
  final String? id;
  final ObjectVersion? version;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ServiceSpec? spec;
  final ServiceEndpoint? endpoint;

  /// The status of a service update.
  final ServiceUpdateStatus? updateStatus;

  /// The status of the service's tasks. Provided only when requested as
  /// part of a ServiceList operation.
  final ServiceServiceStatus? serviceStatus;

  /// The status of the service when it is in one of ReplicatedJob or
  /// GlobalJob modes. Absent on Replicated and Global mode services. The
  /// JobIteration is an ObjectVersion, but unlike the Service's version,
  /// does not need to be sent with an update request.
  final ServiceJobStatus? jobStatus;

  Service(
      {this.id,
      this.version,
      this.createdAt,
      this.updatedAt,
      this.spec,
      this.endpoint,
      this.updateStatus,
      this.serviceStatus,
      this.jobStatus});

  factory Service.fromJson(Map<String, Object?> json) {
    return Service(
      id: json[r'ID'] as String?,
      version: json[r'Version'] != null
          ? ObjectVersion.fromJson(json[r'Version']! as Map<String, Object?>)
          : null,
      createdAt: DateTime.tryParse(json[r'CreatedAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json[r'UpdatedAt'] as String? ?? ''),
      spec: json[r'Spec'] != null
          ? ServiceSpec.fromJson(json[r'Spec']! as Map<String, Object?>)
          : null,
      endpoint: json[r'Endpoint'] != null
          ? ServiceEndpoint.fromJson(json[r'Endpoint']! as Map<String, Object?>)
          : null,
      updateStatus: json[r'UpdateStatus'] != null
          ? ServiceUpdateStatus.fromJson(
              json[r'UpdateStatus']! as Map<String, Object?>)
          : null,
      serviceStatus: json[r'ServiceStatus'] != null
          ? ServiceServiceStatus.fromJson(
              json[r'ServiceStatus']! as Map<String, Object?>)
          : null,
      jobStatus: json[r'JobStatus'] != null
          ? ServiceJobStatus.fromJson(
              json[r'JobStatus']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var version = this.version;
    var createdAt = this.createdAt;
    var updatedAt = this.updatedAt;
    var spec = this.spec;
    var endpoint = this.endpoint;
    var updateStatus = this.updateStatus;
    var serviceStatus = this.serviceStatus;
    var jobStatus = this.jobStatus;

    final json = <String, Object?>{};
    if (id != null) {
      json[r'ID'] = id;
    }
    if (version != null) {
      json[r'Version'] = version.toJson();
    }
    if (createdAt != null) {
      json[r'CreatedAt'] = createdAt.toIso8601String();
    }
    if (updatedAt != null) {
      json[r'UpdatedAt'] = updatedAt.toIso8601String();
    }
    if (spec != null) {
      json[r'Spec'] = spec.toJson();
    }
    if (endpoint != null) {
      json[r'Endpoint'] = endpoint.toJson();
    }
    if (updateStatus != null) {
      json[r'UpdateStatus'] = updateStatus.toJson();
    }
    if (serviceStatus != null) {
      json[r'ServiceStatus'] = serviceStatus.toJson();
    }
    if (jobStatus != null) {
      json[r'JobStatus'] = jobStatus.toJson();
    }
    return json;
  }

  Service copyWith(
      {String? id,
      ObjectVersion? version,
      DateTime? createdAt,
      DateTime? updatedAt,
      ServiceSpec? spec,
      ServiceEndpoint? endpoint,
      ServiceUpdateStatus? updateStatus,
      ServiceServiceStatus? serviceStatus,
      ServiceJobStatus? jobStatus}) {
    return Service(
      id: id ?? this.id,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      spec: spec ?? this.spec,
      endpoint: endpoint ?? this.endpoint,
      updateStatus: updateStatus ?? this.updateStatus,
      serviceStatus: serviceStatus ?? this.serviceStatus,
      jobStatus: jobStatus ?? this.jobStatus,
    );
  }
}

class ServiceEndpoint {
  final EndpointSpec? spec;
  final List<EndpointPortConfig> ports;
  final List<ServiceEndpointVirtualIPsItem> virtualiPs;

  ServiceEndpoint(
      {this.spec,
      List<EndpointPortConfig>? ports,
      List<ServiceEndpointVirtualIPsItem>? virtualiPs})
      : ports = ports ?? [],
        virtualiPs = virtualiPs ?? [];

  factory ServiceEndpoint.fromJson(Map<String, Object?> json) {
    return ServiceEndpoint(
      spec: json[r'Spec'] != null
          ? EndpointSpec.fromJson(json[r'Spec']! as Map<String, Object?>)
          : null,
      ports: (json[r'Ports'] as List<Object?>?)
              ?.map((i) => EndpointPortConfig.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      virtualiPs: (json[r'VirtualIPs'] as List<Object?>?)
              ?.map((i) => ServiceEndpointVirtualIPsItem.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var spec = this.spec;
    var ports = this.ports;
    var virtualiPs = this.virtualiPs;

    final json = <String, Object?>{};
    if (spec != null) {
      json[r'Spec'] = spec.toJson();
    }
    json[r'Ports'] = ports.map((i) => i.toJson()).toList();
    json[r'VirtualIPs'] = virtualiPs.map((i) => i.toJson()).toList();
    return json;
  }

  ServiceEndpoint copyWith(
      {EndpointSpec? spec,
      List<EndpointPortConfig>? ports,
      List<ServiceEndpointVirtualIPsItem>? virtualiPs}) {
    return ServiceEndpoint(
      spec: spec ?? this.spec,
      ports: ports ?? this.ports,
      virtualiPs: virtualiPs ?? this.virtualiPs,
    );
  }
}

class ServiceEndpointVirtualIPsItem {
  final String? networkId;
  final String? addr;

  ServiceEndpointVirtualIPsItem({this.networkId, this.addr});

  factory ServiceEndpointVirtualIPsItem.fromJson(Map<String, Object?> json) {
    return ServiceEndpointVirtualIPsItem(
      networkId: json[r'NetworkID'] as String?,
      addr: json[r'Addr'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var networkId = this.networkId;
    var addr = this.addr;

    final json = <String, Object?>{};
    if (networkId != null) {
      json[r'NetworkID'] = networkId;
    }
    if (addr != null) {
      json[r'Addr'] = addr;
    }
    return json;
  }

  ServiceEndpointVirtualIPsItem copyWith({String? networkId, String? addr}) {
    return ServiceEndpointVirtualIPsItem(
      networkId: networkId ?? this.networkId,
      addr: addr ?? this.addr,
    );
  }
}

/// The status of the service when it is in one of ReplicatedJob or
/// GlobalJob modes. Absent on Replicated and Global mode services. The
/// JobIteration is an ObjectVersion, but unlike the Service's version,
/// does not need to be sent with an update request.
class ServiceJobStatus {
  /// JobIteration is a value increased each time a Job is executed,
  /// successfully or otherwise. "Executed", in this case, means the
  /// job as a whole has been started, not that an individual Task has
  /// been launched. A job is "Executed" when its ServiceSpec is
  /// updated. JobIteration can be used to disambiguate Tasks belonging
  /// to different executions of a job.  Though JobIteration will
  /// increase with each subsequent execution, it may not necessarily
  /// increase by 1, and so JobIteration should not be used to
  final ObjectVersion? jobIteration;

  /// The last time, as observed by the server, that this job was
  /// started.
  final DateTime? lastExecution;

  ServiceJobStatus({this.jobIteration, this.lastExecution});

  factory ServiceJobStatus.fromJson(Map<String, Object?> json) {
    return ServiceJobStatus(
      jobIteration: json[r'JobIteration'] != null
          ? ObjectVersion.fromJson(
              json[r'JobIteration']! as Map<String, Object?>)
          : null,
      lastExecution: DateTime.tryParse(json[r'LastExecution'] as String? ?? ''),
    );
  }

  Map<String, Object?> toJson() {
    var jobIteration = this.jobIteration;
    var lastExecution = this.lastExecution;

    final json = <String, Object?>{};
    if (jobIteration != null) {
      json[r'JobIteration'] = jobIteration.toJson();
    }
    if (lastExecution != null) {
      json[r'LastExecution'] = lastExecution.toIso8601String();
    }
    return json;
  }

  ServiceJobStatus copyWith(
      {ObjectVersion? jobIteration, DateTime? lastExecution}) {
    return ServiceJobStatus(
      jobIteration: jobIteration ?? this.jobIteration,
      lastExecution: lastExecution ?? this.lastExecution,
    );
  }
}

/// The status of the service's tasks. Provided only when requested as
/// part of a ServiceList operation.
class ServiceServiceStatus {
  /// The number of tasks for the service currently in the Running state.
  final int? runningTasks;

  /// The number of tasks for the service desired to be running.
  /// For replicated services, this is the replica count from the
  /// service spec. For global services, this is computed by taking
  /// count of all tasks for the service with a Desired State other
  /// than Shutdown.
  final int? desiredTasks;

  /// The number of tasks for a job that are in the Completed state.
  /// This field must be cross-referenced with the service type, as the
  /// value of 0 may mean the service is not in a job mode, or it may
  /// mean the job-mode service has no tasks yet Completed.
  final int? completedTasks;

  ServiceServiceStatus(
      {this.runningTasks, this.desiredTasks, this.completedTasks});

  factory ServiceServiceStatus.fromJson(Map<String, Object?> json) {
    return ServiceServiceStatus(
      runningTasks: (json[r'RunningTasks'] as num?)?.toInt(),
      desiredTasks: (json[r'DesiredTasks'] as num?)?.toInt(),
      completedTasks: (json[r'CompletedTasks'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var runningTasks = this.runningTasks;
    var desiredTasks = this.desiredTasks;
    var completedTasks = this.completedTasks;

    final json = <String, Object?>{};
    if (runningTasks != null) {
      json[r'RunningTasks'] = runningTasks;
    }
    if (desiredTasks != null) {
      json[r'DesiredTasks'] = desiredTasks;
    }
    if (completedTasks != null) {
      json[r'CompletedTasks'] = completedTasks;
    }
    return json;
  }

  ServiceServiceStatus copyWith(
      {int? runningTasks, int? desiredTasks, int? completedTasks}) {
    return ServiceServiceStatus(
      runningTasks: runningTasks ?? this.runningTasks,
      desiredTasks: desiredTasks ?? this.desiredTasks,
      completedTasks: completedTasks ?? this.completedTasks,
    );
  }
}

/// User modifiable configuration for a service.
class ServiceSpec {
  /// Name of the service.
  final String? name;

  /// User-defined key/value metadata.
  final Map<String, dynamic>? labels;
  final TaskSpec? taskTemplate;

  /// Scheduling mode for the service.
  final ServiceSpecMode? mode;

  /// Specification for the update strategy of the service.
  final ServiceSpecUpdateConfig? updateConfig;

  /// Specification for the rollback strategy of the service.
  final ServiceSpecRollbackConfig? rollbackConfig;

  /// Specifies which networks the service should attach to.
  final List<NetworkAttachmentConfig> networks;
  final EndpointSpec? endpointSpec;

  ServiceSpec(
      {this.name,
      this.labels,
      this.taskTemplate,
      this.mode,
      this.updateConfig,
      this.rollbackConfig,
      List<NetworkAttachmentConfig>? networks,
      this.endpointSpec})
      : networks = networks ?? [];

  factory ServiceSpec.fromJson(Map<String, Object?> json) {
    return ServiceSpec(
      name: json[r'Name'] as String?,
      labels: json[r'Labels'] as Map<String, Object?>?,
      taskTemplate: json[r'TaskTemplate'] != null
          ? TaskSpec.fromJson(json[r'TaskTemplate']! as Map<String, Object?>)
          : null,
      mode: json[r'Mode'] != null
          ? ServiceSpecMode.fromJson(json[r'Mode']! as Map<String, Object?>)
          : null,
      updateConfig: json[r'UpdateConfig'] != null
          ? ServiceSpecUpdateConfig.fromJson(
              json[r'UpdateConfig']! as Map<String, Object?>)
          : null,
      rollbackConfig: json[r'RollbackConfig'] != null
          ? ServiceSpecRollbackConfig.fromJson(
              json[r'RollbackConfig']! as Map<String, Object?>)
          : null,
      networks: (json[r'Networks'] as List<Object?>?)
              ?.map((i) => NetworkAttachmentConfig.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      endpointSpec: json[r'EndpointSpec'] != null
          ? EndpointSpec.fromJson(
              json[r'EndpointSpec']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var labels = this.labels;
    var taskTemplate = this.taskTemplate;
    var mode = this.mode;
    var updateConfig = this.updateConfig;
    var rollbackConfig = this.rollbackConfig;
    var networks = this.networks;
    var endpointSpec = this.endpointSpec;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (labels != null) {
      json[r'Labels'] = labels;
    }
    if (taskTemplate != null) {
      json[r'TaskTemplate'] = taskTemplate.toJson();
    }
    if (mode != null) {
      json[r'Mode'] = mode.toJson();
    }
    if (updateConfig != null) {
      json[r'UpdateConfig'] = updateConfig.toJson();
    }
    if (rollbackConfig != null) {
      json[r'RollbackConfig'] = rollbackConfig.toJson();
    }
    json[r'Networks'] = networks.map((i) => i.toJson()).toList();
    if (endpointSpec != null) {
      json[r'EndpointSpec'] = endpointSpec.toJson();
    }
    return json;
  }

  ServiceSpec copyWith(
      {String? name,
      Map<String, dynamic>? labels,
      TaskSpec? taskTemplate,
      ServiceSpecMode? mode,
      ServiceSpecUpdateConfig? updateConfig,
      ServiceSpecRollbackConfig? rollbackConfig,
      List<NetworkAttachmentConfig>? networks,
      EndpointSpec? endpointSpec}) {
    return ServiceSpec(
      name: name ?? this.name,
      labels: labels ?? this.labels,
      taskTemplate: taskTemplate ?? this.taskTemplate,
      mode: mode ?? this.mode,
      updateConfig: updateConfig ?? this.updateConfig,
      rollbackConfig: rollbackConfig ?? this.rollbackConfig,
      networks: networks ?? this.networks,
      endpointSpec: endpointSpec ?? this.endpointSpec,
    );
  }
}

/// Scheduling mode for the service.
class ServiceSpecMode {
  final ServiceSpecModeReplicated? replicated;
  final Map<String, dynamic>? global;

  /// The mode used for services with a finite number of tasks that run
  /// to a completed state.
  final ServiceSpecModeReplicatedJob? replicatedJob;

  /// The mode used for services which run a task to the completed state
  /// on each valid node.
  final Map<String, dynamic>? globalJob;

  ServiceSpecMode(
      {this.replicated, this.global, this.replicatedJob, this.globalJob});

  factory ServiceSpecMode.fromJson(Map<String, Object?> json) {
    return ServiceSpecMode(
      replicated: json[r'Replicated'] != null
          ? ServiceSpecModeReplicated.fromJson(
              json[r'Replicated']! as Map<String, Object?>)
          : null,
      global: json[r'Global'] as Map<String, Object?>?,
      replicatedJob: json[r'ReplicatedJob'] != null
          ? ServiceSpecModeReplicatedJob.fromJson(
              json[r'ReplicatedJob']! as Map<String, Object?>)
          : null,
      globalJob: json[r'GlobalJob'] as Map<String, Object?>?,
    );
  }

  Map<String, Object?> toJson() {
    var replicated = this.replicated;
    var global = this.global;
    var replicatedJob = this.replicatedJob;
    var globalJob = this.globalJob;

    final json = <String, Object?>{};
    if (replicated != null) {
      json[r'Replicated'] = replicated.toJson();
    }
    if (global != null) {
      json[r'Global'] = global;
    }
    if (replicatedJob != null) {
      json[r'ReplicatedJob'] = replicatedJob.toJson();
    }
    if (globalJob != null) {
      json[r'GlobalJob'] = globalJob;
    }
    return json;
  }

  ServiceSpecMode copyWith(
      {ServiceSpecModeReplicated? replicated,
      Map<String, dynamic>? global,
      ServiceSpecModeReplicatedJob? replicatedJob,
      Map<String, dynamic>? globalJob}) {
    return ServiceSpecMode(
      replicated: replicated ?? this.replicated,
      global: global ?? this.global,
      replicatedJob: replicatedJob ?? this.replicatedJob,
      globalJob: globalJob ?? this.globalJob,
    );
  }
}

class ServiceSpecModeReplicated {
  final int? replicas;

  ServiceSpecModeReplicated({this.replicas});

  factory ServiceSpecModeReplicated.fromJson(Map<String, Object?> json) {
    return ServiceSpecModeReplicated(
      replicas: (json[r'Replicas'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var replicas = this.replicas;

    final json = <String, Object?>{};
    if (replicas != null) {
      json[r'Replicas'] = replicas;
    }
    return json;
  }

  ServiceSpecModeReplicated copyWith({int? replicas}) {
    return ServiceSpecModeReplicated(
      replicas: replicas ?? this.replicas,
    );
  }
}

/// The mode used for services with a finite number of tasks that run
/// to a completed state.
class ServiceSpecModeReplicatedJob {
  /// The maximum number of replicas to run simultaneously.
  final int? maxConcurrent;

  /// The total number of replicas desired to reach the Completed
  /// state. If unset, will default to the value of `MaxConcurrent`
  final int? totalCompletions;

  ServiceSpecModeReplicatedJob({this.maxConcurrent, this.totalCompletions});

  factory ServiceSpecModeReplicatedJob.fromJson(Map<String, Object?> json) {
    return ServiceSpecModeReplicatedJob(
      maxConcurrent: (json[r'MaxConcurrent'] as num?)?.toInt(),
      totalCompletions: (json[r'TotalCompletions'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var maxConcurrent = this.maxConcurrent;
    var totalCompletions = this.totalCompletions;

    final json = <String, Object?>{};
    if (maxConcurrent != null) {
      json[r'MaxConcurrent'] = maxConcurrent;
    }
    if (totalCompletions != null) {
      json[r'TotalCompletions'] = totalCompletions;
    }
    return json;
  }

  ServiceSpecModeReplicatedJob copyWith(
      {int? maxConcurrent, int? totalCompletions}) {
    return ServiceSpecModeReplicatedJob(
      maxConcurrent: maxConcurrent ?? this.maxConcurrent,
      totalCompletions: totalCompletions ?? this.totalCompletions,
    );
  }
}

/// Specification for the rollback strategy of the service.
class ServiceSpecRollbackConfig {
  /// Maximum number of tasks to be rolled back in one iteration (0 means
  /// unlimited parallelism).
  final int? parallelism;

  /// Amount of time between rollback iterations, in nanoseconds.
  final int? delay;

  /// Action to take if an rolled back task fails to run, or stops
  /// running during the rollback.
  final ServiceSpecRollbackConfigFailureAction? failureAction;

  /// Amount of time to monitor each rolled back task for failures, in
  /// nanoseconds.
  final int? monitor;

  /// The fraction of tasks that may fail during a rollback before the
  /// failure action is invoked, specified as a floating point number
  /// between 0 and 1.
  final num? maxFailureRatio;

  /// The order of operations when rolling back a task. Either the old
  /// task is shut down before the new task is started, or the new task
  /// is started before the old task is shut down.
  final ServiceSpecRollbackConfigOrder? order;

  ServiceSpecRollbackConfig(
      {this.parallelism,
      this.delay,
      this.failureAction,
      this.monitor,
      this.maxFailureRatio,
      this.order});

  factory ServiceSpecRollbackConfig.fromJson(Map<String, Object?> json) {
    return ServiceSpecRollbackConfig(
      parallelism: (json[r'Parallelism'] as num?)?.toInt(),
      delay: (json[r'Delay'] as num?)?.toInt(),
      failureAction: json[r'FailureAction'] != null
          ? ServiceSpecRollbackConfigFailureAction.fromValue(
              json[r'FailureAction']! as String)
          : null,
      monitor: (json[r'Monitor'] as num?)?.toInt(),
      maxFailureRatio: json[r'MaxFailureRatio'] as num?,
      order: json[r'Order'] != null
          ? ServiceSpecRollbackConfigOrder.fromValue(json[r'Order']! as String)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var parallelism = this.parallelism;
    var delay = this.delay;
    var failureAction = this.failureAction;
    var monitor = this.monitor;
    var maxFailureRatio = this.maxFailureRatio;
    var order = this.order;

    final json = <String, Object?>{};
    if (parallelism != null) {
      json[r'Parallelism'] = parallelism;
    }
    if (delay != null) {
      json[r'Delay'] = delay;
    }
    if (failureAction != null) {
      json[r'FailureAction'] = failureAction.value;
    }
    if (monitor != null) {
      json[r'Monitor'] = monitor;
    }
    if (maxFailureRatio != null) {
      json[r'MaxFailureRatio'] = maxFailureRatio;
    }
    if (order != null) {
      json[r'Order'] = order.value;
    }
    return json;
  }

  ServiceSpecRollbackConfig copyWith(
      {int? parallelism,
      int? delay,
      ServiceSpecRollbackConfigFailureAction? failureAction,
      int? monitor,
      num? maxFailureRatio,
      ServiceSpecRollbackConfigOrder? order}) {
    return ServiceSpecRollbackConfig(
      parallelism: parallelism ?? this.parallelism,
      delay: delay ?? this.delay,
      failureAction: failureAction ?? this.failureAction,
      monitor: monitor ?? this.monitor,
      maxFailureRatio: maxFailureRatio ?? this.maxFailureRatio,
      order: order ?? this.order,
    );
  }
}

class ServiceSpecRollbackConfigFailureAction {
  static const continue$ = ServiceSpecRollbackConfigFailureAction._('continue');
  static const pause = ServiceSpecRollbackConfigFailureAction._('pause');

  static const values = [
    continue$,
    pause,
  ];
  final String value;

  const ServiceSpecRollbackConfigFailureAction._(this.value);

  static ServiceSpecRollbackConfigFailureAction fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => ServiceSpecRollbackConfigFailureAction._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

class ServiceSpecRollbackConfigOrder {
  static const stopFirst = ServiceSpecRollbackConfigOrder._('stop-first');
  static const startFirst = ServiceSpecRollbackConfigOrder._('start-first');

  static const values = [
    stopFirst,
    startFirst,
  ];
  final String value;

  const ServiceSpecRollbackConfigOrder._(this.value);

  static ServiceSpecRollbackConfigOrder fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => ServiceSpecRollbackConfigOrder._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

/// Specification for the update strategy of the service.
class ServiceSpecUpdateConfig {
  /// Maximum number of tasks to be updated in one iteration (0 means
  /// unlimited parallelism).
  final int? parallelism;

  /// Amount of time between updates, in nanoseconds.
  final int? delay;

  /// Action to take if an updated task fails to run, or stops running
  /// during the update.
  final ServiceSpecUpdateConfigFailureAction? failureAction;

  /// Amount of time to monitor each updated task for failures, in
  /// nanoseconds.
  final int? monitor;

  /// The fraction of tasks that may fail during an update before the
  /// failure action is invoked, specified as a floating point number
  /// between 0 and 1.
  final num? maxFailureRatio;

  /// The order of operations when rolling out an updated task. Either
  /// the old task is shut down before the new task is started, or the
  /// new task is started before the old task is shut down.
  final ServiceSpecUpdateConfigOrder? order;

  ServiceSpecUpdateConfig(
      {this.parallelism,
      this.delay,
      this.failureAction,
      this.monitor,
      this.maxFailureRatio,
      this.order});

  factory ServiceSpecUpdateConfig.fromJson(Map<String, Object?> json) {
    return ServiceSpecUpdateConfig(
      parallelism: (json[r'Parallelism'] as num?)?.toInt(),
      delay: (json[r'Delay'] as num?)?.toInt(),
      failureAction: json[r'FailureAction'] != null
          ? ServiceSpecUpdateConfigFailureAction.fromValue(
              json[r'FailureAction']! as String)
          : null,
      monitor: (json[r'Monitor'] as num?)?.toInt(),
      maxFailureRatio: json[r'MaxFailureRatio'] as num?,
      order: json[r'Order'] != null
          ? ServiceSpecUpdateConfigOrder.fromValue(json[r'Order']! as String)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var parallelism = this.parallelism;
    var delay = this.delay;
    var failureAction = this.failureAction;
    var monitor = this.monitor;
    var maxFailureRatio = this.maxFailureRatio;
    var order = this.order;

    final json = <String, Object?>{};
    if (parallelism != null) {
      json[r'Parallelism'] = parallelism;
    }
    if (delay != null) {
      json[r'Delay'] = delay;
    }
    if (failureAction != null) {
      json[r'FailureAction'] = failureAction.value;
    }
    if (monitor != null) {
      json[r'Monitor'] = monitor;
    }
    if (maxFailureRatio != null) {
      json[r'MaxFailureRatio'] = maxFailureRatio;
    }
    if (order != null) {
      json[r'Order'] = order.value;
    }
    return json;
  }

  ServiceSpecUpdateConfig copyWith(
      {int? parallelism,
      int? delay,
      ServiceSpecUpdateConfigFailureAction? failureAction,
      int? monitor,
      num? maxFailureRatio,
      ServiceSpecUpdateConfigOrder? order}) {
    return ServiceSpecUpdateConfig(
      parallelism: parallelism ?? this.parallelism,
      delay: delay ?? this.delay,
      failureAction: failureAction ?? this.failureAction,
      monitor: monitor ?? this.monitor,
      maxFailureRatio: maxFailureRatio ?? this.maxFailureRatio,
      order: order ?? this.order,
    );
  }
}

class ServiceSpecUpdateConfigFailureAction {
  static const continue$ = ServiceSpecUpdateConfigFailureAction._('continue');
  static const pause = ServiceSpecUpdateConfigFailureAction._('pause');
  static const rollback = ServiceSpecUpdateConfigFailureAction._('rollback');

  static const values = [
    continue$,
    pause,
    rollback,
  ];
  final String value;

  const ServiceSpecUpdateConfigFailureAction._(this.value);

  static ServiceSpecUpdateConfigFailureAction fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => ServiceSpecUpdateConfigFailureAction._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

class ServiceSpecUpdateConfigOrder {
  static const stopFirst = ServiceSpecUpdateConfigOrder._('stop-first');
  static const startFirst = ServiceSpecUpdateConfigOrder._('start-first');

  static const values = [
    stopFirst,
    startFirst,
  ];
  final String value;

  const ServiceSpecUpdateConfigOrder._(this.value);

  static ServiceSpecUpdateConfigOrder fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => ServiceSpecUpdateConfigOrder._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

class ServiceUpdateResponse {
  /// Optional warning messages
  final List<String> warnings;

  ServiceUpdateResponse({List<String>? warnings}) : warnings = warnings ?? [];

  factory ServiceUpdateResponse.fromJson(Map<String, Object?> json) {
    return ServiceUpdateResponse(
      warnings: (json[r'Warnings'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var warnings = this.warnings;

    final json = <String, Object?>{};
    json[r'Warnings'] = warnings;
    return json;
  }

  ServiceUpdateResponse copyWith({List<String>? warnings}) {
    return ServiceUpdateResponse(
      warnings: warnings ?? this.warnings,
    );
  }
}

/// The status of a service update.
class ServiceUpdateStatus {
  final ServiceUpdateStatusState? state;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String? message;

  ServiceUpdateStatus(
      {this.state, this.startedAt, this.completedAt, this.message});

  factory ServiceUpdateStatus.fromJson(Map<String, Object?> json) {
    return ServiceUpdateStatus(
      state: json[r'State'] != null
          ? ServiceUpdateStatusState.fromValue(json[r'State']! as String)
          : null,
      startedAt: DateTime.tryParse(json[r'StartedAt'] as String? ?? ''),
      completedAt: DateTime.tryParse(json[r'CompletedAt'] as String? ?? ''),
      message: json[r'Message'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var state = this.state;
    var startedAt = this.startedAt;
    var completedAt = this.completedAt;
    var message = this.message;

    final json = <String, Object?>{};
    if (state != null) {
      json[r'State'] = state.value;
    }
    if (startedAt != null) {
      json[r'StartedAt'] = startedAt.toIso8601String();
    }
    if (completedAt != null) {
      json[r'CompletedAt'] = completedAt.toIso8601String();
    }
    if (message != null) {
      json[r'Message'] = message;
    }
    return json;
  }

  ServiceUpdateStatus copyWith(
      {ServiceUpdateStatusState? state,
      DateTime? startedAt,
      DateTime? completedAt,
      String? message}) {
    return ServiceUpdateStatus(
      state: state ?? this.state,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      message: message ?? this.message,
    );
  }
}

class ServiceUpdateStatusState {
  static const updating = ServiceUpdateStatusState._('updating');
  static const paused = ServiceUpdateStatusState._('paused');
  static const completed = ServiceUpdateStatusState._('completed');

  static const values = [
    updating,
    paused,
    completed,
  ];
  final String value;

  const ServiceUpdateStatusState._(this.value);

  static ServiceUpdateStatusState fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => ServiceUpdateStatusState._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

class Swarm {
  Swarm();

  factory Swarm.fromJson(Map<String, Object?> json) {
    return Swarm();
  }

  Map<String, Object?> toJson() {
    final json = <String, Object?>{};
    return json;
  }
}

/// Represents generic information about swarm.
class SwarmInfo {
  /// Unique identifier of for this node in the swarm.
  final String? nodeId;

  /// IP address at which this node can be reached by other nodes in the
  /// swarm.
  final String? nodeAddr;
  final LocalNodeState? localNodeState;
  final bool controlAvailable;
  final String? error;

  /// List of ID's and addresses of other managers in the swarm.
  final List<PeerNode> remoteManagers;

  /// Total number of nodes in the swarm.
  final int? nodes;

  /// Total number of managers in the swarm.
  final int? managers;
  final ClusterInfo? cluster;

  SwarmInfo(
      {this.nodeId,
      this.nodeAddr,
      this.localNodeState,
      bool? controlAvailable,
      this.error,
      List<PeerNode>? remoteManagers,
      this.nodes,
      this.managers,
      this.cluster})
      : controlAvailable = controlAvailable ?? false,
        remoteManagers = remoteManagers ?? [];

  factory SwarmInfo.fromJson(Map<String, Object?> json) {
    return SwarmInfo(
      nodeId: json[r'NodeID'] as String?,
      nodeAddr: json[r'NodeAddr'] as String?,
      localNodeState: json[r'LocalNodeState'] != null
          ? LocalNodeState.fromJson(
              json[r'LocalNodeState']! as Map<String, Object?>)
          : null,
      controlAvailable: json[r'ControlAvailable'] as bool? ?? false,
      error: json[r'Error'] as String?,
      remoteManagers: (json[r'RemoteManagers'] as List<Object?>?)
              ?.map((i) =>
                  PeerNode.fromJson(i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      nodes: (json[r'Nodes'] as num?)?.toInt(),
      managers: (json[r'Managers'] as num?)?.toInt(),
      cluster: json[r'Cluster'] != null
          ? ClusterInfo.fromJson(json[r'Cluster']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var nodeId = this.nodeId;
    var nodeAddr = this.nodeAddr;
    var localNodeState = this.localNodeState;
    var controlAvailable = this.controlAvailable;
    var error = this.error;
    var remoteManagers = this.remoteManagers;
    var nodes = this.nodes;
    var managers = this.managers;
    var cluster = this.cluster;

    final json = <String, Object?>{};
    if (nodeId != null) {
      json[r'NodeID'] = nodeId;
    }
    if (nodeAddr != null) {
      json[r'NodeAddr'] = nodeAddr;
    }
    if (localNodeState != null) {
      json[r'LocalNodeState'] = localNodeState.toJson();
    }
    json[r'ControlAvailable'] = controlAvailable;
    if (error != null) {
      json[r'Error'] = error;
    }
    json[r'RemoteManagers'] = remoteManagers.map((i) => i.toJson()).toList();
    if (nodes != null) {
      json[r'Nodes'] = nodes;
    }
    if (managers != null) {
      json[r'Managers'] = managers;
    }
    if (cluster != null) {
      json[r'Cluster'] = cluster.toJson();
    }
    return json;
  }

  SwarmInfo copyWith(
      {String? nodeId,
      String? nodeAddr,
      LocalNodeState? localNodeState,
      bool? controlAvailable,
      String? error,
      List<PeerNode>? remoteManagers,
      int? nodes,
      int? managers,
      ClusterInfo? cluster}) {
    return SwarmInfo(
      nodeId: nodeId ?? this.nodeId,
      nodeAddr: nodeAddr ?? this.nodeAddr,
      localNodeState: localNodeState ?? this.localNodeState,
      controlAvailable: controlAvailable ?? this.controlAvailable,
      error: error ?? this.error,
      remoteManagers: remoteManagers ?? this.remoteManagers,
      nodes: nodes ?? this.nodes,
      managers: managers ?? this.managers,
      cluster: cluster ?? this.cluster,
    );
  }
}

/// User modifiable swarm configuration.
class SwarmSpec {
  /// Name of the swarm.
  final String? name;

  /// User-defined key/value metadata.
  final Map<String, dynamic>? labels;

  /// Orchestration configuration.
  final SwarmSpecOrchestration? orchestration;

  /// Raft configuration.
  final SwarmSpecRaft? raft;

  /// Dispatcher configuration.
  final SwarmSpecDispatcher? dispatcher;

  /// CA configuration.
  final SwarmSpecCAConfig? caConfig;

  /// Parameters related to encryption-at-rest.
  final SwarmSpecEncryptionConfig? encryptionConfig;

  /// Defaults for creating tasks in this cluster.
  final SwarmSpecTaskDefaults? taskDefaults;

  SwarmSpec(
      {this.name,
      this.labels,
      this.orchestration,
      this.raft,
      this.dispatcher,
      this.caConfig,
      this.encryptionConfig,
      this.taskDefaults});

  factory SwarmSpec.fromJson(Map<String, Object?> json) {
    return SwarmSpec(
      name: json[r'Name'] as String?,
      labels: json[r'Labels'] as Map<String, Object?>?,
      orchestration: json[r'Orchestration'] != null
          ? SwarmSpecOrchestration.fromJson(
              json[r'Orchestration']! as Map<String, Object?>)
          : null,
      raft: json[r'Raft'] != null
          ? SwarmSpecRaft.fromJson(json[r'Raft']! as Map<String, Object?>)
          : null,
      dispatcher: json[r'Dispatcher'] != null
          ? SwarmSpecDispatcher.fromJson(
              json[r'Dispatcher']! as Map<String, Object?>)
          : null,
      caConfig: json[r'CAConfig'] != null
          ? SwarmSpecCAConfig.fromJson(
              json[r'CAConfig']! as Map<String, Object?>)
          : null,
      encryptionConfig: json[r'EncryptionConfig'] != null
          ? SwarmSpecEncryptionConfig.fromJson(
              json[r'EncryptionConfig']! as Map<String, Object?>)
          : null,
      taskDefaults: json[r'TaskDefaults'] != null
          ? SwarmSpecTaskDefaults.fromJson(
              json[r'TaskDefaults']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var labels = this.labels;
    var orchestration = this.orchestration;
    var raft = this.raft;
    var dispatcher = this.dispatcher;
    var caConfig = this.caConfig;
    var encryptionConfig = this.encryptionConfig;
    var taskDefaults = this.taskDefaults;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (labels != null) {
      json[r'Labels'] = labels;
    }
    if (orchestration != null) {
      json[r'Orchestration'] = orchestration.toJson();
    }
    if (raft != null) {
      json[r'Raft'] = raft.toJson();
    }
    if (dispatcher != null) {
      json[r'Dispatcher'] = dispatcher.toJson();
    }
    if (caConfig != null) {
      json[r'CAConfig'] = caConfig.toJson();
    }
    if (encryptionConfig != null) {
      json[r'EncryptionConfig'] = encryptionConfig.toJson();
    }
    if (taskDefaults != null) {
      json[r'TaskDefaults'] = taskDefaults.toJson();
    }
    return json;
  }

  SwarmSpec copyWith(
      {String? name,
      Map<String, dynamic>? labels,
      SwarmSpecOrchestration? orchestration,
      SwarmSpecRaft? raft,
      SwarmSpecDispatcher? dispatcher,
      SwarmSpecCAConfig? caConfig,
      SwarmSpecEncryptionConfig? encryptionConfig,
      SwarmSpecTaskDefaults? taskDefaults}) {
    return SwarmSpec(
      name: name ?? this.name,
      labels: labels ?? this.labels,
      orchestration: orchestration ?? this.orchestration,
      raft: raft ?? this.raft,
      dispatcher: dispatcher ?? this.dispatcher,
      caConfig: caConfig ?? this.caConfig,
      encryptionConfig: encryptionConfig ?? this.encryptionConfig,
      taskDefaults: taskDefaults ?? this.taskDefaults,
    );
  }
}

/// CA configuration.
class SwarmSpecCAConfig {
  /// The duration node certificates are issued for.
  final int? nodeCertExpiry;

  /// Configuration for forwarding signing requests to an external
  /// certificate authority.
  final List<SwarmSpecCAConfigExternalCAsItem> externalcAs;

  /// The desired signing CA certificate for all swarm node TLS leaf
  /// certificates, in PEM format.
  final String? signingCaCert;

  /// The desired signing CA key for all swarm node TLS leaf certificates,
  /// in PEM format.
  final String? signingCaKey;

  /// An integer whose purpose is to force swarm to generate a new
  /// signing CA certificate and key, if none have been specified in
  /// `SigningCACert` and `SigningCAKey`
  final int? forceRotate;

  SwarmSpecCAConfig(
      {this.nodeCertExpiry,
      List<SwarmSpecCAConfigExternalCAsItem>? externalcAs,
      this.signingCaCert,
      this.signingCaKey,
      this.forceRotate})
      : externalcAs = externalcAs ?? [];

  factory SwarmSpecCAConfig.fromJson(Map<String, Object?> json) {
    return SwarmSpecCAConfig(
      nodeCertExpiry: (json[r'NodeCertExpiry'] as num?)?.toInt(),
      externalcAs: (json[r'ExternalCAs'] as List<Object?>?)
              ?.map((i) => SwarmSpecCAConfigExternalCAsItem.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      signingCaCert: json[r'SigningCACert'] as String?,
      signingCaKey: json[r'SigningCAKey'] as String?,
      forceRotate: (json[r'ForceRotate'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var nodeCertExpiry = this.nodeCertExpiry;
    var externalcAs = this.externalcAs;
    var signingCaCert = this.signingCaCert;
    var signingCaKey = this.signingCaKey;
    var forceRotate = this.forceRotate;

    final json = <String, Object?>{};
    if (nodeCertExpiry != null) {
      json[r'NodeCertExpiry'] = nodeCertExpiry;
    }
    json[r'ExternalCAs'] = externalcAs.map((i) => i.toJson()).toList();
    if (signingCaCert != null) {
      json[r'SigningCACert'] = signingCaCert;
    }
    if (signingCaKey != null) {
      json[r'SigningCAKey'] = signingCaKey;
    }
    if (forceRotate != null) {
      json[r'ForceRotate'] = forceRotate;
    }
    return json;
  }

  SwarmSpecCAConfig copyWith(
      {int? nodeCertExpiry,
      List<SwarmSpecCAConfigExternalCAsItem>? externalcAs,
      String? signingCaCert,
      String? signingCaKey,
      int? forceRotate}) {
    return SwarmSpecCAConfig(
      nodeCertExpiry: nodeCertExpiry ?? this.nodeCertExpiry,
      externalcAs: externalcAs ?? this.externalcAs,
      signingCaCert: signingCaCert ?? this.signingCaCert,
      signingCaKey: signingCaKey ?? this.signingCaKey,
      forceRotate: forceRotate ?? this.forceRotate,
    );
  }
}

class SwarmSpecCAConfigExternalCAsItem {
  /// Protocol for communication with the external CA (currently
  /// only `cfssl` is supported).
  final SwarmSpecCAConfigExternalCAsItemProtocol? protocol;

  /// URL where certificate signing requests should be sent.
  final String? url;

  /// An object with key/value pairs that are interpreted as
  /// protocol-specific options for the external CA driver.
  final Map<String, dynamic>? options;

  /// The root CA certificate (in PEM format) this external CA uses
  /// to issue TLS certificates (assumed to be to the current swarm
  /// root CA certificate if not provided).
  final String? caCert;

  SwarmSpecCAConfigExternalCAsItem(
      {this.protocol, this.url, this.options, this.caCert});

  factory SwarmSpecCAConfigExternalCAsItem.fromJson(Map<String, Object?> json) {
    return SwarmSpecCAConfigExternalCAsItem(
      protocol: json[r'Protocol'] != null
          ? SwarmSpecCAConfigExternalCAsItemProtocol.fromValue(
              json[r'Protocol']! as String)
          : null,
      url: json[r'URL'] as String?,
      options: json[r'Options'] as Map<String, Object?>?,
      caCert: json[r'CACert'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var protocol = this.protocol;
    var url = this.url;
    var options = this.options;
    var caCert = this.caCert;

    final json = <String, Object?>{};
    if (protocol != null) {
      json[r'Protocol'] = protocol.value;
    }
    if (url != null) {
      json[r'URL'] = url;
    }
    if (options != null) {
      json[r'Options'] = options;
    }
    if (caCert != null) {
      json[r'CACert'] = caCert;
    }
    return json;
  }

  SwarmSpecCAConfigExternalCAsItem copyWith(
      {SwarmSpecCAConfigExternalCAsItemProtocol? protocol,
      String? url,
      Map<String, dynamic>? options,
      String? caCert}) {
    return SwarmSpecCAConfigExternalCAsItem(
      protocol: protocol ?? this.protocol,
      url: url ?? this.url,
      options: options ?? this.options,
      caCert: caCert ?? this.caCert,
    );
  }
}

class SwarmSpecCAConfigExternalCAsItemProtocol {
  static const cfssl = SwarmSpecCAConfigExternalCAsItemProtocol._('cfssl');

  static const values = [
    cfssl,
  ];
  final String value;

  const SwarmSpecCAConfigExternalCAsItemProtocol._(this.value);

  static SwarmSpecCAConfigExternalCAsItemProtocol fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => SwarmSpecCAConfigExternalCAsItemProtocol._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

/// Dispatcher configuration.
class SwarmSpecDispatcher {
  /// The delay for an agent to send a heartbeat to the dispatcher.
  final int? heartbeatPeriod;

  SwarmSpecDispatcher({this.heartbeatPeriod});

  factory SwarmSpecDispatcher.fromJson(Map<String, Object?> json) {
    return SwarmSpecDispatcher(
      heartbeatPeriod: (json[r'HeartbeatPeriod'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var heartbeatPeriod = this.heartbeatPeriod;

    final json = <String, Object?>{};
    if (heartbeatPeriod != null) {
      json[r'HeartbeatPeriod'] = heartbeatPeriod;
    }
    return json;
  }

  SwarmSpecDispatcher copyWith({int? heartbeatPeriod}) {
    return SwarmSpecDispatcher(
      heartbeatPeriod: heartbeatPeriod ?? this.heartbeatPeriod,
    );
  }
}

/// Parameters related to encryption-at-rest.
class SwarmSpecEncryptionConfig {
  /// If set, generate a key and use it to lock data stored on the
  /// managers.
  final bool autoLockManagers;

  SwarmSpecEncryptionConfig({bool? autoLockManagers})
      : autoLockManagers = autoLockManagers ?? false;

  factory SwarmSpecEncryptionConfig.fromJson(Map<String, Object?> json) {
    return SwarmSpecEncryptionConfig(
      autoLockManagers: json[r'AutoLockManagers'] as bool? ?? false,
    );
  }

  Map<String, Object?> toJson() {
    var autoLockManagers = this.autoLockManagers;

    final json = <String, Object?>{};
    json[r'AutoLockManagers'] = autoLockManagers;
    return json;
  }

  SwarmSpecEncryptionConfig copyWith({bool? autoLockManagers}) {
    return SwarmSpecEncryptionConfig(
      autoLockManagers: autoLockManagers ?? this.autoLockManagers,
    );
  }
}

/// Orchestration configuration.
class SwarmSpecOrchestration {
  /// The number of historic tasks to keep per instance or node. If
  /// negative, never remove completed or failed tasks.
  final int? taskHistoryRetentionLimit;

  SwarmSpecOrchestration({this.taskHistoryRetentionLimit});

  factory SwarmSpecOrchestration.fromJson(Map<String, Object?> json) {
    return SwarmSpecOrchestration(
      taskHistoryRetentionLimit:
          (json[r'TaskHistoryRetentionLimit'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var taskHistoryRetentionLimit = this.taskHistoryRetentionLimit;

    final json = <String, Object?>{};
    if (taskHistoryRetentionLimit != null) {
      json[r'TaskHistoryRetentionLimit'] = taskHistoryRetentionLimit;
    }
    return json;
  }

  SwarmSpecOrchestration copyWith({int? taskHistoryRetentionLimit}) {
    return SwarmSpecOrchestration(
      taskHistoryRetentionLimit:
          taskHistoryRetentionLimit ?? this.taskHistoryRetentionLimit,
    );
  }
}

/// Raft configuration.
class SwarmSpecRaft {
  /// The number of log entries between snapshots.
  final int? snapshotInterval;

  /// The number of snapshots to keep beyond the current snapshot.
  final int? keepOldSnapshots;

  /// The number of log entries to keep around to sync up slow followers
  /// after a snapshot is created.
  final int? logEntriesForSlowFollowers;

  /// The number of ticks that a follower will wait for a message from
  /// the leader before becoming a candidate and starting an election.
  /// `ElectionTick` must be greater than `HeartbeatTick`.
  ///
  /// A tick currently defaults to one second, so these translate
  /// directly to seconds currently, but this is NOT guaranteed.
  final int? electionTick;

  /// The number of ticks between heartbeats. Every HeartbeatTick ticks,
  /// the leader will send a heartbeat to the followers.
  ///
  /// A tick currently defaults to one second, so these translate
  /// directly to seconds currently, but this is NOT guaranteed.
  final int? heartbeatTick;

  SwarmSpecRaft(
      {this.snapshotInterval,
      this.keepOldSnapshots,
      this.logEntriesForSlowFollowers,
      this.electionTick,
      this.heartbeatTick});

  factory SwarmSpecRaft.fromJson(Map<String, Object?> json) {
    return SwarmSpecRaft(
      snapshotInterval: (json[r'SnapshotInterval'] as num?)?.toInt(),
      keepOldSnapshots: (json[r'KeepOldSnapshots'] as num?)?.toInt(),
      logEntriesForSlowFollowers:
          (json[r'LogEntriesForSlowFollowers'] as num?)?.toInt(),
      electionTick: (json[r'ElectionTick'] as num?)?.toInt(),
      heartbeatTick: (json[r'HeartbeatTick'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var snapshotInterval = this.snapshotInterval;
    var keepOldSnapshots = this.keepOldSnapshots;
    var logEntriesForSlowFollowers = this.logEntriesForSlowFollowers;
    var electionTick = this.electionTick;
    var heartbeatTick = this.heartbeatTick;

    final json = <String, Object?>{};
    if (snapshotInterval != null) {
      json[r'SnapshotInterval'] = snapshotInterval;
    }
    if (keepOldSnapshots != null) {
      json[r'KeepOldSnapshots'] = keepOldSnapshots;
    }
    if (logEntriesForSlowFollowers != null) {
      json[r'LogEntriesForSlowFollowers'] = logEntriesForSlowFollowers;
    }
    if (electionTick != null) {
      json[r'ElectionTick'] = electionTick;
    }
    if (heartbeatTick != null) {
      json[r'HeartbeatTick'] = heartbeatTick;
    }
    return json;
  }

  SwarmSpecRaft copyWith(
      {int? snapshotInterval,
      int? keepOldSnapshots,
      int? logEntriesForSlowFollowers,
      int? electionTick,
      int? heartbeatTick}) {
    return SwarmSpecRaft(
      snapshotInterval: snapshotInterval ?? this.snapshotInterval,
      keepOldSnapshots: keepOldSnapshots ?? this.keepOldSnapshots,
      logEntriesForSlowFollowers:
          logEntriesForSlowFollowers ?? this.logEntriesForSlowFollowers,
      electionTick: electionTick ?? this.electionTick,
      heartbeatTick: heartbeatTick ?? this.heartbeatTick,
    );
  }
}

/// Defaults for creating tasks in this cluster.
class SwarmSpecTaskDefaults {
  /// The log driver to use for tasks created in the orchestrator if
  /// unspecified by a service.
  ///
  /// Updating this value only affects new tasks. Existing tasks continue
  /// to use their previously configured log driver until recreated.
  final SwarmSpecTaskDefaultsLogDriver? logDriver;

  SwarmSpecTaskDefaults({this.logDriver});

  factory SwarmSpecTaskDefaults.fromJson(Map<String, Object?> json) {
    return SwarmSpecTaskDefaults(
      logDriver: json[r'LogDriver'] != null
          ? SwarmSpecTaskDefaultsLogDriver.fromJson(
              json[r'LogDriver']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var logDriver = this.logDriver;

    final json = <String, Object?>{};
    if (logDriver != null) {
      json[r'LogDriver'] = logDriver.toJson();
    }
    return json;
  }

  SwarmSpecTaskDefaults copyWith({SwarmSpecTaskDefaultsLogDriver? logDriver}) {
    return SwarmSpecTaskDefaults(
      logDriver: logDriver ?? this.logDriver,
    );
  }
}

/// The log driver to use for tasks created in the orchestrator if
/// unspecified by a service.
///
/// Updating this value only affects new tasks. Existing tasks continue
/// to use their previously configured log driver until recreated.
class SwarmSpecTaskDefaultsLogDriver {
  /// The log driver to use as a default for new tasks.
  final String? name;

  /// Driver-specific options for the selectd log driver, specified
  /// as key/value pairs.
  final Map<String, dynamic>? options;

  SwarmSpecTaskDefaultsLogDriver({this.name, this.options});

  factory SwarmSpecTaskDefaultsLogDriver.fromJson(Map<String, Object?> json) {
    return SwarmSpecTaskDefaultsLogDriver(
      name: json[r'Name'] as String?,
      options: json[r'Options'] as Map<String, Object?>?,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var options = this.options;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (options != null) {
      json[r'Options'] = options;
    }
    return json;
  }

  SwarmSpecTaskDefaultsLogDriver copyWith(
      {String? name, Map<String, dynamic>? options}) {
    return SwarmSpecTaskDefaultsLogDriver(
      name: name ?? this.name,
      options: options ?? this.options,
    );
  }
}

class SystemInfo {
  /// Unique identifier of the daemon.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Note**: The format of the ID itself is not part of the API, and
  /// > should not be considered stable.
  final String? id;

  /// Total number of containers on the host.
  final int? containers;

  /// Number of containers with status `"running"`.
  final int? containersRunning;

  /// Number of containers with status `"paused"`.
  final int? containersPaused;

  /// Number of containers with status `"stopped"`.
  final int? containersStopped;

  /// Total number of images on the host.
  ///
  /// Both _tagged_ and _untagged_ (dangling) images are counted.
  final int? images;

  /// Name of the storage driver in use.
  final String? driver;

  /// Information specific to the storage driver, provided as
  /// "label" / "value" pairs.
  ///
  /// This information is provided by the storage driver, and formatted
  /// in a way consistent with the output of `docker info` on the command
  /// line.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Note**: The information returned in this field, including the
  /// > formatting of values and labels, should not be considered stable,
  /// > and may change without notice.
  final List<List<String>> driverStatus;

  /// Root directory of persistent Docker state.
  ///
  /// Defaults to `/var/lib/docker` on Linux, and `C:ProgramDatadocker`
  /// on Windows.
  final String? dockerRootDir;
  final PluginsInfo? plugins;

  /// Indicates if the host has memory limit support enabled.
  final bool memoryLimit;

  /// Indicates if the host has memory swap limit support enabled.
  final bool swapLimit;

  /// Indicates if the host has kernel memory limit support enabled.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Deprecated**: This field is deprecated as the kernel 5.4 deprecated
  /// > `kmem.limit_in_bytes`.
  final bool kernelMemory;

  /// Indicates if CPU CFS(Completely Fair Scheduler) period is supported by
  /// the host.
  final bool cpuCfsPeriod;

  /// Indicates if CPU CFS(Completely Fair Scheduler) quota is supported by
  /// the host.
  final bool cpuCfsQuota;

  /// Indicates if CPU Shares limiting is supported by the host.
  final bool cpuShares;

  /// Indicates if CPUsets (cpuset.cpus, cpuset.mems) are supported by the host.
  ///
  /// See
  /// [cpuset(7)](https://www.kernel.org/doc/Documentation/cgroup-v1/cpusets.txt)
  final bool cpuSet;

  /// Indicates if the host kernel has PID limit support enabled.
  final bool pidsLimit;

  /// Indicates if OOM killer disable is supported on the host.
  final bool oomKillDisable;

  /// Indicates IPv4 forwarding is enabled.
  final bool iPv4Forwarding;

  /// Indicates if `bridge-nf-call-iptables` is available on the host.
  final bool bridgeNfIptables;

  /// Indicates if `bridge-nf-call-ip6tables` is available on the host.
  final bool bridgeNfIp6tables;

  /// Indicates if the daemon is running in debug-mode / with debug-level
  /// logging enabled.
  final bool debug;

  /// The total number of file Descriptors in use by the daemon process.
  ///
  /// This information is only returned if debug-mode is enabled.
  final int? nFd;

  /// The  number of goroutines that currently exist.
  ///
  /// This information is only returned if debug-mode is enabled.
  final int? nGoroutines;

  /// Current system-time in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt)
  /// format with nano-seconds.
  final String? systemTime;

  /// The logging driver to use as a default for new containers.
  final String? loggingDriver;

  /// The driver to use for managing cgroups.
  final SystemInfoCgroupDriver? cgroupDriver;

  /// The version of the cgroup.
  final SystemInfoCgroupVersion? cgroupVersion;

  /// Number of event listeners subscribed.
  final int? nEventsListener;

  /// Kernel version of the host.
  ///
  /// On Linux, this information obtained from `uname`. On Windows this
  /// information is queried from the
  /// <kbd>HKEY_LOCAL_MACHINESOFTWAREMicrosoftWindows NTCurrentVersion</kbd>
  /// registry value, for example _"10.0 14393
  /// (14393.1198.amd64fre.rs1_release_sec.170427-1353)"_.
  final String? kernelVersion;

  /// Name of the host's operating system, for example: "Ubuntu 16.04.2 LTS"
  /// or "Windows Server 2016 Datacenter"
  final String? operatingSystem;

  /// Version of the host's operating system
  ///
  /// <p>
  /// </p>
  ///
  /// > **Note**: The information returned in this field, including its
  /// > very existence, and the formatting of values, should not be considered
  /// > stable, and may change without notice.
  final String? osVersion;

  /// Generic type of the operating system of the host, as returned by the
  /// Go runtime (`GOOS`).
  ///
  /// Currently returned values are "linux" and "windows". A full list of
  /// possible values can be found in the
  /// [Go documentation](https://golang.org/doc/install/source#environment).
  final String? osType;

  /// Hardware architecture of the host, as returned by the Go runtime
  /// (`GOARCH`).
  ///
  /// A full list of possible values can be found in the
  /// [Go documentation](https://golang.org/doc/install/source#environment).
  final String? architecture;

  /// The number of logical CPUs usable by the daemon.
  ///
  /// The number of available CPUs is checked by querying the operating
  /// system when the daemon starts. Changes to operating system CPU
  /// allocation after the daemon is started are not reflected.
  final int? ncpu;

  /// Total amount of physical memory available on the host, in bytes.
  final int? memTotal;

  /// Address / URL of the index server that is used for image search,
  /// and as a default for user authentication for Docker Hub and Docker Cloud.
  final String? indexServerAddress;
  final RegistryServiceConfig? registryConfig;
  final List<GenericResources> genericResources;

  /// HTTP-proxy configured for the daemon. This value is obtained from the
  /// [`HTTP_PROXY`](https://www.gnu.org/software/wget/manual/html_node/Proxies.html)
  /// environment variable.
  /// Credentials
  /// ([user info component](https://tools.ietf.org/html/rfc3986#section-3.2.1))
  /// in the proxy URL
  /// are masked in the API response.
  ///
  /// Containers do not automatically inherit this configuration.
  final String? httpProxy;

  /// HTTPS-proxy configured for the daemon. This value is obtained from the
  /// [`HTTPS_PROXY`](https://www.gnu.org/software/wget/manual/html_node/Proxies.html)
  /// environment variable.
  /// Credentials
  /// ([user info component](https://tools.ietf.org/html/rfc3986#section-3.2.1))
  /// in the proxy URL
  /// are masked in the API response.
  ///
  /// Containers do not automatically inherit this configuration.
  final String? httpsProxy;

  /// Comma-separated list of domain extensions for which no proxy should be
  /// used. This value is obtained from the
  /// [`NO_PROXY`](https://www.gnu.org/software/wget/manual/html_node/Proxies.html)
  /// environment variable.
  ///
  /// Containers do not automatically inherit this configuration.
  final String? noProxy;

  /// Hostname of the host.
  final String? name;

  /// User-defined labels (key/value metadata) as set on the daemon.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Note**: When part of a Swarm, nodes can both have _daemon_ labels,
  /// > set through the daemon configuration, and _node_ labels, set from a
  /// > manager node in the Swarm. Node labels are not included in this
  /// > field. Node labels can be retrieved using the `/nodes/(id)` endpoint
  /// > on a manager node in the Swarm.
  final List<String> labels;

  /// Indicates if experimental features are enabled on the daemon.
  final bool experimentalBuild;

  /// Version string of the daemon.
  ///
  /// > **Note**: the
  /// [standalone Swarm API](https://docs.docker.com/swarm/swarm-api/)
  /// > returns the Swarm version instead of the daemon  version, for example
  /// > `swarm/1.2.8`.
  final String? serverVersion;

  /// URL of the distributed storage backend.
  ///
  ///
  /// The storage backend is used for multihost networking (to store
  /// network and endpoint information) and by the node discovery mechanism.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Deprecated**: This field is only propagated when using standalone
  /// Swarm
  /// > mode, and overlay networking using an external k/v store. Overlay
  /// > networks with Swarm mode enabled use the built-in raft store, and
  /// > this field will be empty.
  final String? clusterStore;

  /// The network endpoint that the Engine advertises for the purpose of
  /// node discovery. ClusterAdvertise is a `host:port` combination on which
  /// the daemon is reachable by other hosts.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Deprecated**: This field is only propagated when using standalone
  /// Swarm
  /// > mode, and overlay networking using an external k/v store. Overlay
  /// > networks with Swarm mode enabled use the built-in raft store, and
  /// > this field will be empty.
  final String? clusterAdvertise;

  /// List of [OCI compliant](https://github.com/opencontainers/runtime-spec)
  /// runtimes configured on the daemon. Keys hold the "name" used to
  /// reference the runtime.
  ///
  /// The Docker daemon relies on an OCI compliant runtime (invoked via the
  /// `containerd` daemon) as its interface to the Linux kernel namespaces,
  /// cgroups, and SELinux.
  ///
  /// The default runtime is `runc`, and automatically configured. Additional
  /// runtimes can be configured by the user and will be listed here.
  final Map<String, dynamic>? runtimes;

  /// Name of the default OCI runtime that is used when starting containers.
  ///
  /// The default can be overridden per-container at create time.
  final String? defaultRuntime;
  final SwarmInfo? swarm;

  /// Indicates if live restore is enabled.
  ///
  /// If enabled, containers are kept running when the daemon is shutdown
  /// or upon daemon start if running containers are detected.
  final bool liveRestoreEnabled;

  /// Represents the isolation technology to use as a default for containers.
  /// The supported values are platform-specific.
  ///
  /// If no isolation value is specified on daemon start, on Windows client,
  /// the default is `hyperv`, and on Windows server, the default is `process`.
  ///
  /// This option is currently not used on other platforms.
  final SystemInfoIsolation? isolation;

  /// Name and, optional, path of the `docker-init` binary.
  ///
  /// If the path is omitted, the daemon searches the host's `$PATH` for the
  /// binary and uses the first result.
  final String? initBinary;
  final Commit? containerdCommit;
  final Commit? runcCommit;
  final Commit? initCommit;

  /// List of security features that are enabled on the daemon, such as
  /// apparmor, seccomp, SELinux, user-namespaces (userns), and rootless.
  ///
  /// Additional configuration options for each security feature may
  /// be present, and are included as a comma-separated list of key/value
  /// pairs.
  final List<String> securityOptions;

  /// Reports a summary of the product license on the daemon.
  ///
  /// If a commercial license has been applied to the daemon, information
  /// such as number of nodes, and expiration are included.
  final String? productLicense;

  /// List of custom default address pools for local networks, which can be
  /// specified in the daemon.json file or dockerd option.
  ///
  /// Example: a Base "10.10.0.0/16" with Size 24 will define the set of 256
  /// 10.10.[0-255].0/24 address pools.
  final List<SystemInfoDefaultAddressPoolsItem> defaultAddressPools;

  /// List of warnings / informational messages about missing features, or
  /// issues related to the daemon configuration.
  ///
  /// These messages can be printed by the client as information to the user.
  final List<String> warnings;

  SystemInfo(
      {this.id,
      this.containers,
      this.containersRunning,
      this.containersPaused,
      this.containersStopped,
      this.images,
      this.driver,
      List<List<String>>? driverStatus,
      this.dockerRootDir,
      this.plugins,
      bool? memoryLimit,
      bool? swapLimit,
      bool? kernelMemory,
      bool? cpuCfsPeriod,
      bool? cpuCfsQuota,
      bool? cpuShares,
      bool? cpuSet,
      bool? pidsLimit,
      bool? oomKillDisable,
      bool? iPv4Forwarding,
      bool? bridgeNfIptables,
      bool? bridgeNfIp6tables,
      bool? debug,
      this.nFd,
      this.nGoroutines,
      this.systemTime,
      this.loggingDriver,
      this.cgroupDriver,
      this.cgroupVersion,
      this.nEventsListener,
      this.kernelVersion,
      this.operatingSystem,
      this.osVersion,
      this.osType,
      this.architecture,
      this.ncpu,
      this.memTotal,
      this.indexServerAddress,
      this.registryConfig,
      List<GenericResources>? genericResources,
      this.httpProxy,
      this.httpsProxy,
      this.noProxy,
      this.name,
      List<String>? labels,
      bool? experimentalBuild,
      this.serverVersion,
      this.clusterStore,
      this.clusterAdvertise,
      this.runtimes,
      this.defaultRuntime,
      this.swarm,
      bool? liveRestoreEnabled,
      this.isolation,
      this.initBinary,
      this.containerdCommit,
      this.runcCommit,
      this.initCommit,
      List<String>? securityOptions,
      this.productLicense,
      List<SystemInfoDefaultAddressPoolsItem>? defaultAddressPools,
      List<String>? warnings})
      : driverStatus = driverStatus ?? [],
        memoryLimit = memoryLimit ?? false,
        swapLimit = swapLimit ?? false,
        kernelMemory = kernelMemory ?? false,
        cpuCfsPeriod = cpuCfsPeriod ?? false,
        cpuCfsQuota = cpuCfsQuota ?? false,
        cpuShares = cpuShares ?? false,
        cpuSet = cpuSet ?? false,
        pidsLimit = pidsLimit ?? false,
        oomKillDisable = oomKillDisable ?? false,
        iPv4Forwarding = iPv4Forwarding ?? false,
        bridgeNfIptables = bridgeNfIptables ?? false,
        bridgeNfIp6tables = bridgeNfIp6tables ?? false,
        debug = debug ?? false,
        genericResources = genericResources ?? [],
        labels = labels ?? [],
        experimentalBuild = experimentalBuild ?? false,
        liveRestoreEnabled = liveRestoreEnabled ?? false,
        securityOptions = securityOptions ?? [],
        defaultAddressPools = defaultAddressPools ?? [],
        warnings = warnings ?? [];

  factory SystemInfo.fromJson(Map<String, Object?> json) {
    return SystemInfo(
      id: json[r'ID'] as String?,
      containers: (json[r'Containers'] as num?)?.toInt(),
      containersRunning: (json[r'ContainersRunning'] as num?)?.toInt(),
      containersPaused: (json[r'ContainersPaused'] as num?)?.toInt(),
      containersStopped: (json[r'ContainersStopped'] as num?)?.toInt(),
      images: (json[r'Images'] as num?)?.toInt(),
      driver: json[r'Driver'] as String?,
      driverStatus: (json[r'DriverStatus'] as List<Object?>?)
              ?.map((i) =>
                  (i as List<Object?>?)
                      ?.map((i) => i as String? ?? '')
                      .toList() ??
                  [])
              .toList() ??
          [],
      dockerRootDir: json[r'DockerRootDir'] as String?,
      plugins: json[r'Plugins'] != null
          ? PluginsInfo.fromJson(json[r'Plugins']! as Map<String, Object?>)
          : null,
      memoryLimit: json[r'MemoryLimit'] as bool? ?? false,
      swapLimit: json[r'SwapLimit'] as bool? ?? false,
      kernelMemory: json[r'KernelMemory'] as bool? ?? false,
      cpuCfsPeriod: json[r'CpuCfsPeriod'] as bool? ?? false,
      cpuCfsQuota: json[r'CpuCfsQuota'] as bool? ?? false,
      cpuShares: json[r'CPUShares'] as bool? ?? false,
      cpuSet: json[r'CPUSet'] as bool? ?? false,
      pidsLimit: json[r'PidsLimit'] as bool? ?? false,
      oomKillDisable: json[r'OomKillDisable'] as bool? ?? false,
      iPv4Forwarding: json[r'IPv4Forwarding'] as bool? ?? false,
      bridgeNfIptables: json[r'BridgeNfIptables'] as bool? ?? false,
      bridgeNfIp6tables: json[r'BridgeNfIp6tables'] as bool? ?? false,
      debug: json[r'Debug'] as bool? ?? false,
      nFd: (json[r'NFd'] as num?)?.toInt(),
      nGoroutines: (json[r'NGoroutines'] as num?)?.toInt(),
      systemTime: json[r'SystemTime'] as String?,
      loggingDriver: json[r'LoggingDriver'] as String?,
      cgroupDriver: json[r'CgroupDriver'] != null
          ? SystemInfoCgroupDriver.fromValue(json[r'CgroupDriver']! as String)
          : null,
      cgroupVersion: json[r'CgroupVersion'] != null
          ? SystemInfoCgroupVersion.fromValue(json[r'CgroupVersion']! as String)
          : null,
      nEventsListener: (json[r'NEventsListener'] as num?)?.toInt(),
      kernelVersion: json[r'KernelVersion'] as String?,
      operatingSystem: json[r'OperatingSystem'] as String?,
      osVersion: json[r'OSVersion'] as String?,
      osType: json[r'OSType'] as String?,
      architecture: json[r'Architecture'] as String?,
      ncpu: (json[r'NCPU'] as num?)?.toInt(),
      memTotal: (json[r'MemTotal'] as num?)?.toInt(),
      indexServerAddress: json[r'IndexServerAddress'] as String?,
      registryConfig: json[r'RegistryConfig'] != null
          ? RegistryServiceConfig.fromJson(
              json[r'RegistryConfig']! as Map<String, Object?>)
          : null,
      genericResources: (json[r'GenericResources'] as List<Object?>?)
              ?.map((i) => GenericResources.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      httpProxy: json[r'HttpProxy'] as String?,
      httpsProxy: json[r'HttpsProxy'] as String?,
      noProxy: json[r'NoProxy'] as String?,
      name: json[r'Name'] as String?,
      labels: (json[r'Labels'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      experimentalBuild: json[r'ExperimentalBuild'] as bool? ?? false,
      serverVersion: json[r'ServerVersion'] as String?,
      clusterStore: json[r'ClusterStore'] as String?,
      clusterAdvertise: json[r'ClusterAdvertise'] as String?,
      runtimes: json[r'Runtimes'] as Map<String, Object?>?,
      defaultRuntime: json[r'DefaultRuntime'] as String?,
      swarm: json[r'Swarm'] != null
          ? SwarmInfo.fromJson(json[r'Swarm']! as Map<String, Object?>)
          : null,
      liveRestoreEnabled: json[r'LiveRestoreEnabled'] as bool? ?? false,
      isolation: json[r'Isolation'] != null
          ? SystemInfoIsolation.fromValue(json[r'Isolation']! as String)
          : null,
      initBinary: json[r'InitBinary'] as String?,
      containerdCommit: json[r'ContainerdCommit'] != null
          ? Commit.fromJson(json[r'ContainerdCommit']! as Map<String, Object?>)
          : null,
      runcCommit: json[r'RuncCommit'] != null
          ? Commit.fromJson(json[r'RuncCommit']! as Map<String, Object?>)
          : null,
      initCommit: json[r'InitCommit'] != null
          ? Commit.fromJson(json[r'InitCommit']! as Map<String, Object?>)
          : null,
      securityOptions: (json[r'SecurityOptions'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      productLicense: json[r'ProductLicense'] as String?,
      defaultAddressPools: (json[r'DefaultAddressPools'] as List<Object?>?)
              ?.map((i) => SystemInfoDefaultAddressPoolsItem.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      warnings: (json[r'Warnings'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var containers = this.containers;
    var containersRunning = this.containersRunning;
    var containersPaused = this.containersPaused;
    var containersStopped = this.containersStopped;
    var images = this.images;
    var driver = this.driver;
    var driverStatus = this.driverStatus;
    var dockerRootDir = this.dockerRootDir;
    var plugins = this.plugins;
    var memoryLimit = this.memoryLimit;
    var swapLimit = this.swapLimit;
    var kernelMemory = this.kernelMemory;
    var cpuCfsPeriod = this.cpuCfsPeriod;
    var cpuCfsQuota = this.cpuCfsQuota;
    var cpuShares = this.cpuShares;
    var cpuSet = this.cpuSet;
    var pidsLimit = this.pidsLimit;
    var oomKillDisable = this.oomKillDisable;
    var iPv4Forwarding = this.iPv4Forwarding;
    var bridgeNfIptables = this.bridgeNfIptables;
    var bridgeNfIp6tables = this.bridgeNfIp6tables;
    var debug = this.debug;
    var nFd = this.nFd;
    var nGoroutines = this.nGoroutines;
    var systemTime = this.systemTime;
    var loggingDriver = this.loggingDriver;
    var cgroupDriver = this.cgroupDriver;
    var cgroupVersion = this.cgroupVersion;
    var nEventsListener = this.nEventsListener;
    var kernelVersion = this.kernelVersion;
    var operatingSystem = this.operatingSystem;
    var osVersion = this.osVersion;
    var osType = this.osType;
    var architecture = this.architecture;
    var ncpu = this.ncpu;
    var memTotal = this.memTotal;
    var indexServerAddress = this.indexServerAddress;
    var registryConfig = this.registryConfig;
    var genericResources = this.genericResources;
    var httpProxy = this.httpProxy;
    var httpsProxy = this.httpsProxy;
    var noProxy = this.noProxy;
    var name = this.name;
    var labels = this.labels;
    var experimentalBuild = this.experimentalBuild;
    var serverVersion = this.serverVersion;
    var clusterStore = this.clusterStore;
    var clusterAdvertise = this.clusterAdvertise;
    var runtimes = this.runtimes;
    var defaultRuntime = this.defaultRuntime;
    var swarm = this.swarm;
    var liveRestoreEnabled = this.liveRestoreEnabled;
    var isolation = this.isolation;
    var initBinary = this.initBinary;
    var containerdCommit = this.containerdCommit;
    var runcCommit = this.runcCommit;
    var initCommit = this.initCommit;
    var securityOptions = this.securityOptions;
    var productLicense = this.productLicense;
    var defaultAddressPools = this.defaultAddressPools;
    var warnings = this.warnings;

    final json = <String, Object?>{};
    if (id != null) {
      json[r'ID'] = id;
    }
    if (containers != null) {
      json[r'Containers'] = containers;
    }
    if (containersRunning != null) {
      json[r'ContainersRunning'] = containersRunning;
    }
    if (containersPaused != null) {
      json[r'ContainersPaused'] = containersPaused;
    }
    if (containersStopped != null) {
      json[r'ContainersStopped'] = containersStopped;
    }
    if (images != null) {
      json[r'Images'] = images;
    }
    if (driver != null) {
      json[r'Driver'] = driver;
    }
    json[r'DriverStatus'] = driverStatus;
    if (dockerRootDir != null) {
      json[r'DockerRootDir'] = dockerRootDir;
    }
    if (plugins != null) {
      json[r'Plugins'] = plugins.toJson();
    }
    json[r'MemoryLimit'] = memoryLimit;
    json[r'SwapLimit'] = swapLimit;
    json[r'KernelMemory'] = kernelMemory;
    json[r'CpuCfsPeriod'] = cpuCfsPeriod;
    json[r'CpuCfsQuota'] = cpuCfsQuota;
    json[r'CPUShares'] = cpuShares;
    json[r'CPUSet'] = cpuSet;
    json[r'PidsLimit'] = pidsLimit;
    json[r'OomKillDisable'] = oomKillDisable;
    json[r'IPv4Forwarding'] = iPv4Forwarding;
    json[r'BridgeNfIptables'] = bridgeNfIptables;
    json[r'BridgeNfIp6tables'] = bridgeNfIp6tables;
    json[r'Debug'] = debug;
    if (nFd != null) {
      json[r'NFd'] = nFd;
    }
    if (nGoroutines != null) {
      json[r'NGoroutines'] = nGoroutines;
    }
    if (systemTime != null) {
      json[r'SystemTime'] = systemTime;
    }
    if (loggingDriver != null) {
      json[r'LoggingDriver'] = loggingDriver;
    }
    if (cgroupDriver != null) {
      json[r'CgroupDriver'] = cgroupDriver.value;
    }
    if (cgroupVersion != null) {
      json[r'CgroupVersion'] = cgroupVersion.value;
    }
    if (nEventsListener != null) {
      json[r'NEventsListener'] = nEventsListener;
    }
    if (kernelVersion != null) {
      json[r'KernelVersion'] = kernelVersion;
    }
    if (operatingSystem != null) {
      json[r'OperatingSystem'] = operatingSystem;
    }
    if (osVersion != null) {
      json[r'OSVersion'] = osVersion;
    }
    if (osType != null) {
      json[r'OSType'] = osType;
    }
    if (architecture != null) {
      json[r'Architecture'] = architecture;
    }
    if (ncpu != null) {
      json[r'NCPU'] = ncpu;
    }
    if (memTotal != null) {
      json[r'MemTotal'] = memTotal;
    }
    if (indexServerAddress != null) {
      json[r'IndexServerAddress'] = indexServerAddress;
    }
    if (registryConfig != null) {
      json[r'RegistryConfig'] = registryConfig.toJson();
    }
    json[r'GenericResources'] =
        genericResources.map((i) => i.toJson()).toList();
    if (httpProxy != null) {
      json[r'HttpProxy'] = httpProxy;
    }
    if (httpsProxy != null) {
      json[r'HttpsProxy'] = httpsProxy;
    }
    if (noProxy != null) {
      json[r'NoProxy'] = noProxy;
    }
    if (name != null) {
      json[r'Name'] = name;
    }
    json[r'Labels'] = labels;
    json[r'ExperimentalBuild'] = experimentalBuild;
    if (serverVersion != null) {
      json[r'ServerVersion'] = serverVersion;
    }
    if (clusterStore != null) {
      json[r'ClusterStore'] = clusterStore;
    }
    if (clusterAdvertise != null) {
      json[r'ClusterAdvertise'] = clusterAdvertise;
    }
    if (runtimes != null) {
      json[r'Runtimes'] = runtimes;
    }
    if (defaultRuntime != null) {
      json[r'DefaultRuntime'] = defaultRuntime;
    }
    if (swarm != null) {
      json[r'Swarm'] = swarm.toJson();
    }
    json[r'LiveRestoreEnabled'] = liveRestoreEnabled;
    if (isolation != null) {
      json[r'Isolation'] = isolation.value;
    }
    if (initBinary != null) {
      json[r'InitBinary'] = initBinary;
    }
    if (containerdCommit != null) {
      json[r'ContainerdCommit'] = containerdCommit.toJson();
    }
    if (runcCommit != null) {
      json[r'RuncCommit'] = runcCommit.toJson();
    }
    if (initCommit != null) {
      json[r'InitCommit'] = initCommit.toJson();
    }
    json[r'SecurityOptions'] = securityOptions;
    if (productLicense != null) {
      json[r'ProductLicense'] = productLicense;
    }
    json[r'DefaultAddressPools'] =
        defaultAddressPools.map((i) => i.toJson()).toList();
    json[r'Warnings'] = warnings;
    return json;
  }

  SystemInfo copyWith(
      {String? id,
      int? containers,
      int? containersRunning,
      int? containersPaused,
      int? containersStopped,
      int? images,
      String? driver,
      List<List<String>>? driverStatus,
      String? dockerRootDir,
      PluginsInfo? plugins,
      bool? memoryLimit,
      bool? swapLimit,
      bool? kernelMemory,
      bool? cpuCfsPeriod,
      bool? cpuCfsQuota,
      bool? cpuShares,
      bool? cpuSet,
      bool? pidsLimit,
      bool? oomKillDisable,
      bool? iPv4Forwarding,
      bool? bridgeNfIptables,
      bool? bridgeNfIp6tables,
      bool? debug,
      int? nFd,
      int? nGoroutines,
      String? systemTime,
      String? loggingDriver,
      SystemInfoCgroupDriver? cgroupDriver,
      SystemInfoCgroupVersion? cgroupVersion,
      int? nEventsListener,
      String? kernelVersion,
      String? operatingSystem,
      String? osVersion,
      String? osType,
      String? architecture,
      int? ncpu,
      int? memTotal,
      String? indexServerAddress,
      RegistryServiceConfig? registryConfig,
      List<GenericResources>? genericResources,
      String? httpProxy,
      String? httpsProxy,
      String? noProxy,
      String? name,
      List<String>? labels,
      bool? experimentalBuild,
      String? serverVersion,
      String? clusterStore,
      String? clusterAdvertise,
      Map<String, dynamic>? runtimes,
      String? defaultRuntime,
      SwarmInfo? swarm,
      bool? liveRestoreEnabled,
      SystemInfoIsolation? isolation,
      String? initBinary,
      Commit? containerdCommit,
      Commit? runcCommit,
      Commit? initCommit,
      List<String>? securityOptions,
      String? productLicense,
      List<SystemInfoDefaultAddressPoolsItem>? defaultAddressPools,
      List<String>? warnings}) {
    return SystemInfo(
      id: id ?? this.id,
      containers: containers ?? this.containers,
      containersRunning: containersRunning ?? this.containersRunning,
      containersPaused: containersPaused ?? this.containersPaused,
      containersStopped: containersStopped ?? this.containersStopped,
      images: images ?? this.images,
      driver: driver ?? this.driver,
      driverStatus: driverStatus ?? this.driverStatus,
      dockerRootDir: dockerRootDir ?? this.dockerRootDir,
      plugins: plugins ?? this.plugins,
      memoryLimit: memoryLimit ?? this.memoryLimit,
      swapLimit: swapLimit ?? this.swapLimit,
      kernelMemory: kernelMemory ?? this.kernelMemory,
      cpuCfsPeriod: cpuCfsPeriod ?? this.cpuCfsPeriod,
      cpuCfsQuota: cpuCfsQuota ?? this.cpuCfsQuota,
      cpuShares: cpuShares ?? this.cpuShares,
      cpuSet: cpuSet ?? this.cpuSet,
      pidsLimit: pidsLimit ?? this.pidsLimit,
      oomKillDisable: oomKillDisable ?? this.oomKillDisable,
      iPv4Forwarding: iPv4Forwarding ?? this.iPv4Forwarding,
      bridgeNfIptables: bridgeNfIptables ?? this.bridgeNfIptables,
      bridgeNfIp6tables: bridgeNfIp6tables ?? this.bridgeNfIp6tables,
      debug: debug ?? this.debug,
      nFd: nFd ?? this.nFd,
      nGoroutines: nGoroutines ?? this.nGoroutines,
      systemTime: systemTime ?? this.systemTime,
      loggingDriver: loggingDriver ?? this.loggingDriver,
      cgroupDriver: cgroupDriver ?? this.cgroupDriver,
      cgroupVersion: cgroupVersion ?? this.cgroupVersion,
      nEventsListener: nEventsListener ?? this.nEventsListener,
      kernelVersion: kernelVersion ?? this.kernelVersion,
      operatingSystem: operatingSystem ?? this.operatingSystem,
      osVersion: osVersion ?? this.osVersion,
      osType: osType ?? this.osType,
      architecture: architecture ?? this.architecture,
      ncpu: ncpu ?? this.ncpu,
      memTotal: memTotal ?? this.memTotal,
      indexServerAddress: indexServerAddress ?? this.indexServerAddress,
      registryConfig: registryConfig ?? this.registryConfig,
      genericResources: genericResources ?? this.genericResources,
      httpProxy: httpProxy ?? this.httpProxy,
      httpsProxy: httpsProxy ?? this.httpsProxy,
      noProxy: noProxy ?? this.noProxy,
      name: name ?? this.name,
      labels: labels ?? this.labels,
      experimentalBuild: experimentalBuild ?? this.experimentalBuild,
      serverVersion: serverVersion ?? this.serverVersion,
      clusterStore: clusterStore ?? this.clusterStore,
      clusterAdvertise: clusterAdvertise ?? this.clusterAdvertise,
      runtimes: runtimes ?? this.runtimes,
      defaultRuntime: defaultRuntime ?? this.defaultRuntime,
      swarm: swarm ?? this.swarm,
      liveRestoreEnabled: liveRestoreEnabled ?? this.liveRestoreEnabled,
      isolation: isolation ?? this.isolation,
      initBinary: initBinary ?? this.initBinary,
      containerdCommit: containerdCommit ?? this.containerdCommit,
      runcCommit: runcCommit ?? this.runcCommit,
      initCommit: initCommit ?? this.initCommit,
      securityOptions: securityOptions ?? this.securityOptions,
      productLicense: productLicense ?? this.productLicense,
      defaultAddressPools: defaultAddressPools ?? this.defaultAddressPools,
      warnings: warnings ?? this.warnings,
    );
  }
}

class SystemInfoCgroupDriver {
  static const cgroupfs = SystemInfoCgroupDriver._('cgroupfs');
  static const systemd = SystemInfoCgroupDriver._('systemd');
  static const none = SystemInfoCgroupDriver._('none');

  static const values = [
    cgroupfs,
    systemd,
    none,
  ];
  final String value;

  const SystemInfoCgroupDriver._(this.value);

  static SystemInfoCgroupDriver fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => SystemInfoCgroupDriver._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

class SystemInfoCgroupVersion {
  static const $1 = SystemInfoCgroupVersion._('1');
  static const $2 = SystemInfoCgroupVersion._('2');

  static const values = [
    $1,
    $2,
  ];
  final String value;

  const SystemInfoCgroupVersion._(this.value);

  static SystemInfoCgroupVersion fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => SystemInfoCgroupVersion._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

class SystemInfoIsolation {
  static const default$ = SystemInfoIsolation._('default');
  static const hyperv = SystemInfoIsolation._('hyperv');
  static const process = SystemInfoIsolation._('process');

  static const values = [
    default$,
    hyperv,
    process,
  ];
  final String value;

  const SystemInfoIsolation._(this.value);

  static SystemInfoIsolation fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => SystemInfoIsolation._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

class SystemInfoDefaultAddressPoolsItem {
  /// The network address in CIDR format
  final String? base;

  /// The network pool size
  final int? size;

  SystemInfoDefaultAddressPoolsItem({this.base, this.size});

  factory SystemInfoDefaultAddressPoolsItem.fromJson(
      Map<String, Object?> json) {
    return SystemInfoDefaultAddressPoolsItem(
      base: json[r'Base'] as String?,
      size: (json[r'Size'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var base = this.base;
    var size = this.size;

    final json = <String, Object?>{};
    if (base != null) {
      json[r'Base'] = base;
    }
    if (size != null) {
      json[r'Size'] = size;
    }
    return json;
  }

  SystemInfoDefaultAddressPoolsItem copyWith({String? base, int? size}) {
    return SystemInfoDefaultAddressPoolsItem(
      base: base ?? this.base,
      size: size ?? this.size,
    );
  }
}

/// Response of Engine API: GET "/version"
class SystemVersion {
  final SystemVersionPlatform? platform;

  /// Information about system components
  final List<SystemVersionComponentsItem> components;

  /// The version of the daemon
  final String? version;

  /// The default (and highest) API version that is supported by the daemon
  final String? apiVersion;

  /// The minimum API version that is supported by the daemon
  final String? minApiVersion;

  /// The Git commit of the source code that was used to build the daemon
  final String? gitCommit;

  /// The version Go used to compile the daemon, and the version of the Go
  /// runtime in use.
  final String? goVersion;

  /// The operating system that the daemon is running on ("linux" or "windows")
  final String? os;

  /// The architecture that the daemon is running on
  final String? arch;

  /// The kernel version (`uname -r`) that the daemon is running on.
  ///
  /// This field is omitted when empty.
  final String? kernelVersion;

  /// Indicates if the daemon is started with experimental features enabled.
  ///
  /// This field is omitted when empty / false.
  final bool experimental;

  /// The date and time that the daemon was compiled.
  final String? buildTime;

  SystemVersion(
      {this.platform,
      List<SystemVersionComponentsItem>? components,
      this.version,
      this.apiVersion,
      this.minApiVersion,
      this.gitCommit,
      this.goVersion,
      this.os,
      this.arch,
      this.kernelVersion,
      bool? experimental,
      this.buildTime})
      : components = components ?? [],
        experimental = experimental ?? false;

  factory SystemVersion.fromJson(Map<String, Object?> json) {
    return SystemVersion(
      platform: json[r'Platform'] != null
          ? SystemVersionPlatform.fromJson(
              json[r'Platform']! as Map<String, Object?>)
          : null,
      components: (json[r'Components'] as List<Object?>?)
              ?.map((i) => SystemVersionComponentsItem.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      version: json[r'Version'] as String?,
      apiVersion: json[r'ApiVersion'] as String?,
      minApiVersion: json[r'MinAPIVersion'] as String?,
      gitCommit: json[r'GitCommit'] as String?,
      goVersion: json[r'GoVersion'] as String?,
      os: json[r'Os'] as String?,
      arch: json[r'Arch'] as String?,
      kernelVersion: json[r'KernelVersion'] as String?,
      experimental: json[r'Experimental'] as bool? ?? false,
      buildTime: json[r'BuildTime'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var platform = this.platform;
    var components = this.components;
    var version = this.version;
    var apiVersion = this.apiVersion;
    var minApiVersion = this.minApiVersion;
    var gitCommit = this.gitCommit;
    var goVersion = this.goVersion;
    var os = this.os;
    var arch = this.arch;
    var kernelVersion = this.kernelVersion;
    var experimental = this.experimental;
    var buildTime = this.buildTime;

    final json = <String, Object?>{};
    if (platform != null) {
      json[r'Platform'] = platform.toJson();
    }
    json[r'Components'] = components.map((i) => i.toJson()).toList();
    if (version != null) {
      json[r'Version'] = version;
    }
    if (apiVersion != null) {
      json[r'ApiVersion'] = apiVersion;
    }
    if (minApiVersion != null) {
      json[r'MinAPIVersion'] = minApiVersion;
    }
    if (gitCommit != null) {
      json[r'GitCommit'] = gitCommit;
    }
    if (goVersion != null) {
      json[r'GoVersion'] = goVersion;
    }
    if (os != null) {
      json[r'Os'] = os;
    }
    if (arch != null) {
      json[r'Arch'] = arch;
    }
    if (kernelVersion != null) {
      json[r'KernelVersion'] = kernelVersion;
    }
    json[r'Experimental'] = experimental;
    if (buildTime != null) {
      json[r'BuildTime'] = buildTime;
    }
    return json;
  }

  SystemVersion copyWith(
      {SystemVersionPlatform? platform,
      List<SystemVersionComponentsItem>? components,
      String? version,
      String? apiVersion,
      String? minApiVersion,
      String? gitCommit,
      String? goVersion,
      String? os,
      String? arch,
      String? kernelVersion,
      bool? experimental,
      String? buildTime}) {
    return SystemVersion(
      platform: platform ?? this.platform,
      components: components ?? this.components,
      version: version ?? this.version,
      apiVersion: apiVersion ?? this.apiVersion,
      minApiVersion: minApiVersion ?? this.minApiVersion,
      gitCommit: gitCommit ?? this.gitCommit,
      goVersion: goVersion ?? this.goVersion,
      os: os ?? this.os,
      arch: arch ?? this.arch,
      kernelVersion: kernelVersion ?? this.kernelVersion,
      experimental: experimental ?? this.experimental,
      buildTime: buildTime ?? this.buildTime,
    );
  }
}

class SystemVersionComponentsItem {
  /// Name of the component
  final String name;

  /// Version of the component
  final String version;

  /// Key/value pairs of strings with additional information about the
  /// component. These values are intended for informational purposes
  /// only, and their content is not defined, and not part of the API
  /// specification.
  ///
  /// These messages can be printed by the client as information to the user.
  final Map<String, dynamic>? details;

  SystemVersionComponentsItem(
      {required this.name, required this.version, this.details});

  factory SystemVersionComponentsItem.fromJson(Map<String, Object?> json) {
    return SystemVersionComponentsItem(
      name: json[r'Name'] as String? ?? '',
      version: json[r'Version'] as String? ?? '',
      details: json[r'Details'] as Map<String, Object?>?,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var version = this.version;
    var details = this.details;

    final json = <String, Object?>{};
    json[r'Name'] = name;
    json[r'Version'] = version;
    if (details != null) {
      json[r'Details'] = details;
    }
    return json;
  }

  SystemVersionComponentsItem copyWith(
      {String? name, String? version, Map<String, dynamic>? details}) {
    return SystemVersionComponentsItem(
      name: name ?? this.name,
      version: version ?? this.version,
      details: details ?? this.details,
    );
  }
}

class SystemVersionPlatform {
  final String name;

  SystemVersionPlatform({required this.name});

  factory SystemVersionPlatform.fromJson(Map<String, Object?> json) {
    return SystemVersionPlatform(
      name: json[r'Name'] as String? ?? '',
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;

    final json = <String, Object?>{};
    json[r'Name'] = name;
    return json;
  }

  SystemVersionPlatform copyWith({String? name}) {
    return SystemVersionPlatform(
      name: name ?? this.name,
    );
  }
}

/// Information about the issuer of leaf TLS certificates and the trusted root
/// CA certificate.
class TLSInfo {
  /// The root CA certificate(s) that are used to validate leaf TLS
  /// certificates.
  final String? trustRoot;

  /// The base64-url-safe-encoded raw subject bytes of the issuer.
  final String? certIssuerSubject;

  /// The base64-url-safe-encoded raw public key bytes of the issuer.
  final String? certIssuerPublicKey;

  TLSInfo({this.trustRoot, this.certIssuerSubject, this.certIssuerPublicKey});

  factory TLSInfo.fromJson(Map<String, Object?> json) {
    return TLSInfo(
      trustRoot: json[r'TrustRoot'] as String?,
      certIssuerSubject: json[r'CertIssuerSubject'] as String?,
      certIssuerPublicKey: json[r'CertIssuerPublicKey'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var trustRoot = this.trustRoot;
    var certIssuerSubject = this.certIssuerSubject;
    var certIssuerPublicKey = this.certIssuerPublicKey;

    final json = <String, Object?>{};
    if (trustRoot != null) {
      json[r'TrustRoot'] = trustRoot;
    }
    if (certIssuerSubject != null) {
      json[r'CertIssuerSubject'] = certIssuerSubject;
    }
    if (certIssuerPublicKey != null) {
      json[r'CertIssuerPublicKey'] = certIssuerPublicKey;
    }
    return json;
  }

  TLSInfo copyWith(
      {String? trustRoot,
      String? certIssuerSubject,
      String? certIssuerPublicKey}) {
    return TLSInfo(
      trustRoot: trustRoot ?? this.trustRoot,
      certIssuerSubject: certIssuerSubject ?? this.certIssuerSubject,
      certIssuerPublicKey: certIssuerPublicKey ?? this.certIssuerPublicKey,
    );
  }
}

class Task {
  /// The ID of the task.
  final String? id;
  final ObjectVersion? version;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Name of the task.
  final String? name;

  /// User-defined key/value metadata.
  final Map<String, dynamic>? labels;
  final TaskSpec? spec;

  /// The ID of the service this task is part of.
  final String? serviceId;
  final int? slot;

  /// The ID of the node that this task is on.
  final String? nodeId;
  final List<GenericResources> assignedGenericResources;
  final TaskStatus? status;
  final TaskState? desiredState;

  /// If the Service this Task belongs to is a job-mode service, contains
  /// the JobIteration of the Service this Task was created for. Absent if
  /// the Task was created for a Replicated or Global Service.
  final ObjectVersion? jobIteration;

  Task(
      {this.id,
      this.version,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.labels,
      this.spec,
      this.serviceId,
      this.slot,
      this.nodeId,
      List<GenericResources>? assignedGenericResources,
      this.status,
      this.desiredState,
      this.jobIteration})
      : assignedGenericResources = assignedGenericResources ?? [];

  factory Task.fromJson(Map<String, Object?> json) {
    return Task(
      id: json[r'ID'] as String?,
      version: json[r'Version'] != null
          ? ObjectVersion.fromJson(json[r'Version']! as Map<String, Object?>)
          : null,
      createdAt: DateTime.tryParse(json[r'CreatedAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json[r'UpdatedAt'] as String? ?? ''),
      name: json[r'Name'] as String?,
      labels: json[r'Labels'] as Map<String, Object?>?,
      spec: json[r'Spec'] != null
          ? TaskSpec.fromJson(json[r'Spec']! as Map<String, Object?>)
          : null,
      serviceId: json[r'ServiceID'] as String?,
      slot: (json[r'Slot'] as num?)?.toInt(),
      nodeId: json[r'NodeID'] as String?,
      assignedGenericResources:
          (json[r'AssignedGenericResources'] as List<Object?>?)
                  ?.map((i) => GenericResources.fromJson(
                      i as Map<String, Object?>? ?? const {}))
                  .toList() ??
              [],
      status: json[r'Status'] != null
          ? TaskStatus.fromJson(json[r'Status']! as Map<String, Object?>)
          : null,
      desiredState: json[r'DesiredState'] != null
          ? TaskState.fromJson(json[r'DesiredState']! as Map<String, Object?>)
          : null,
      jobIteration: json[r'JobIteration'] != null
          ? ObjectVersion.fromJson(
              json[r'JobIteration']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var id = this.id;
    var version = this.version;
    var createdAt = this.createdAt;
    var updatedAt = this.updatedAt;
    var name = this.name;
    var labels = this.labels;
    var spec = this.spec;
    var serviceId = this.serviceId;
    var slot = this.slot;
    var nodeId = this.nodeId;
    var assignedGenericResources = this.assignedGenericResources;
    var status = this.status;
    var desiredState = this.desiredState;
    var jobIteration = this.jobIteration;

    final json = <String, Object?>{};
    if (id != null) {
      json[r'ID'] = id;
    }
    if (version != null) {
      json[r'Version'] = version.toJson();
    }
    if (createdAt != null) {
      json[r'CreatedAt'] = createdAt.toIso8601String();
    }
    if (updatedAt != null) {
      json[r'UpdatedAt'] = updatedAt.toIso8601String();
    }
    if (name != null) {
      json[r'Name'] = name;
    }
    if (labels != null) {
      json[r'Labels'] = labels;
    }
    if (spec != null) {
      json[r'Spec'] = spec.toJson();
    }
    if (serviceId != null) {
      json[r'ServiceID'] = serviceId;
    }
    if (slot != null) {
      json[r'Slot'] = slot;
    }
    if (nodeId != null) {
      json[r'NodeID'] = nodeId;
    }
    json[r'AssignedGenericResources'] =
        assignedGenericResources.map((i) => i.toJson()).toList();
    if (status != null) {
      json[r'Status'] = status.toJson();
    }
    if (desiredState != null) {
      json[r'DesiredState'] = desiredState.toJson();
    }
    if (jobIteration != null) {
      json[r'JobIteration'] = jobIteration.toJson();
    }
    return json;
  }

  Task copyWith(
      {String? id,
      ObjectVersion? version,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? name,
      Map<String, dynamic>? labels,
      TaskSpec? spec,
      String? serviceId,
      int? slot,
      String? nodeId,
      List<GenericResources>? assignedGenericResources,
      TaskStatus? status,
      TaskState? desiredState,
      ObjectVersion? jobIteration}) {
    return Task(
      id: id ?? this.id,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      labels: labels ?? this.labels,
      spec: spec ?? this.spec,
      serviceId: serviceId ?? this.serviceId,
      slot: slot ?? this.slot,
      nodeId: nodeId ?? this.nodeId,
      assignedGenericResources:
          assignedGenericResources ?? this.assignedGenericResources,
      status: status ?? this.status,
      desiredState: desiredState ?? this.desiredState,
      jobIteration: jobIteration ?? this.jobIteration,
    );
  }
}

/// User modifiable task configuration.
class TaskSpec {
  /// Plugin spec for the service.  *(Experimental release only.)*
  ///
  /// <p>
  /// </p>
  ///
  /// > **Note**: ContainerSpec, NetworkAttachmentSpec, and PluginSpec are
  /// > mutually exclusive. PluginSpec is only used when the Runtime field
  /// > is set to `plugin`. NetworkAttachmentSpec is used when the Runtime
  /// > field is set to `attachment`.
  final TaskSpecPluginSpec? pluginSpec;

  /// Container spec for the service.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Note**: ContainerSpec, NetworkAttachmentSpec, and PluginSpec are
  /// > mutually exclusive. PluginSpec is only used when the Runtime field
  /// > is set to `plugin`. NetworkAttachmentSpec is used when the Runtime
  /// > field is set to `attachment`.
  final TaskSpecContainerSpec? containerSpec;

  /// Read-only spec type for non-swarm containers attached to swarm overlay
  /// networks.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Note**: ContainerSpec, NetworkAttachmentSpec, and PluginSpec are
  /// > mutually exclusive. PluginSpec is only used when the Runtime field
  /// > is set to `plugin`. NetworkAttachmentSpec is used when the Runtime
  /// > field is set to `attachment`.
  final TaskSpecNetworkAttachmentSpec? networkAttachmentSpec;

  /// Resource requirements which apply to each individual container created
  /// as part of the service.
  final TaskSpecResources? resources;

  /// Specification for the restart policy which applies to containers
  /// created as part of this service.
  final TaskSpecRestartPolicy? restartPolicy;
  final TaskSpecPlacement? placement;

  /// A counter that triggers an update even if no relevant parameters have
  /// been changed.
  final int? forceUpdate;

  /// Runtime is the type of runtime specified for the task executor.
  final String? runtime;

  /// Specifies which networks the service should attach to.
  final List<NetworkAttachmentConfig> networks;

  /// Specifies the log driver to use for tasks created from this spec. If
  /// not present, the default one for the swarm will be used, finally
  /// falling back to the engine default if not specified.
  final TaskSpecLogDriver? logDriver;

  TaskSpec(
      {this.pluginSpec,
      this.containerSpec,
      this.networkAttachmentSpec,
      this.resources,
      this.restartPolicy,
      this.placement,
      this.forceUpdate,
      this.runtime,
      List<NetworkAttachmentConfig>? networks,
      this.logDriver})
      : networks = networks ?? [];

  factory TaskSpec.fromJson(Map<String, Object?> json) {
    return TaskSpec(
      pluginSpec: json[r'PluginSpec'] != null
          ? TaskSpecPluginSpec.fromJson(
              json[r'PluginSpec']! as Map<String, Object?>)
          : null,
      containerSpec: json[r'ContainerSpec'] != null
          ? TaskSpecContainerSpec.fromJson(
              json[r'ContainerSpec']! as Map<String, Object?>)
          : null,
      networkAttachmentSpec: json[r'NetworkAttachmentSpec'] != null
          ? TaskSpecNetworkAttachmentSpec.fromJson(
              json[r'NetworkAttachmentSpec']! as Map<String, Object?>)
          : null,
      resources: json[r'Resources'] != null
          ? TaskSpecResources.fromJson(
              json[r'Resources']! as Map<String, Object?>)
          : null,
      restartPolicy: json[r'RestartPolicy'] != null
          ? TaskSpecRestartPolicy.fromJson(
              json[r'RestartPolicy']! as Map<String, Object?>)
          : null,
      placement: json[r'Placement'] != null
          ? TaskSpecPlacement.fromJson(
              json[r'Placement']! as Map<String, Object?>)
          : null,
      forceUpdate: (json[r'ForceUpdate'] as num?)?.toInt(),
      runtime: json[r'Runtime'] as String?,
      networks: (json[r'Networks'] as List<Object?>?)
              ?.map((i) => NetworkAttachmentConfig.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      logDriver: json[r'LogDriver'] != null
          ? TaskSpecLogDriver.fromJson(
              json[r'LogDriver']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var pluginSpec = this.pluginSpec;
    var containerSpec = this.containerSpec;
    var networkAttachmentSpec = this.networkAttachmentSpec;
    var resources = this.resources;
    var restartPolicy = this.restartPolicy;
    var placement = this.placement;
    var forceUpdate = this.forceUpdate;
    var runtime = this.runtime;
    var networks = this.networks;
    var logDriver = this.logDriver;

    final json = <String, Object?>{};
    if (pluginSpec != null) {
      json[r'PluginSpec'] = pluginSpec.toJson();
    }
    if (containerSpec != null) {
      json[r'ContainerSpec'] = containerSpec.toJson();
    }
    if (networkAttachmentSpec != null) {
      json[r'NetworkAttachmentSpec'] = networkAttachmentSpec.toJson();
    }
    if (resources != null) {
      json[r'Resources'] = resources.toJson();
    }
    if (restartPolicy != null) {
      json[r'RestartPolicy'] = restartPolicy.toJson();
    }
    if (placement != null) {
      json[r'Placement'] = placement.toJson();
    }
    if (forceUpdate != null) {
      json[r'ForceUpdate'] = forceUpdate;
    }
    if (runtime != null) {
      json[r'Runtime'] = runtime;
    }
    json[r'Networks'] = networks.map((i) => i.toJson()).toList();
    if (logDriver != null) {
      json[r'LogDriver'] = logDriver.toJson();
    }
    return json;
  }

  TaskSpec copyWith(
      {TaskSpecPluginSpec? pluginSpec,
      TaskSpecContainerSpec? containerSpec,
      TaskSpecNetworkAttachmentSpec? networkAttachmentSpec,
      TaskSpecResources? resources,
      TaskSpecRestartPolicy? restartPolicy,
      TaskSpecPlacement? placement,
      int? forceUpdate,
      String? runtime,
      List<NetworkAttachmentConfig>? networks,
      TaskSpecLogDriver? logDriver}) {
    return TaskSpec(
      pluginSpec: pluginSpec ?? this.pluginSpec,
      containerSpec: containerSpec ?? this.containerSpec,
      networkAttachmentSpec:
          networkAttachmentSpec ?? this.networkAttachmentSpec,
      resources: resources ?? this.resources,
      restartPolicy: restartPolicy ?? this.restartPolicy,
      placement: placement ?? this.placement,
      forceUpdate: forceUpdate ?? this.forceUpdate,
      runtime: runtime ?? this.runtime,
      networks: networks ?? this.networks,
      logDriver: logDriver ?? this.logDriver,
    );
  }
}

/// Container spec for the service.
///
/// <p>
/// </p>
///
/// > **Note**: ContainerSpec, NetworkAttachmentSpec, and PluginSpec are
/// > mutually exclusive. PluginSpec is only used when the Runtime field
/// > is set to `plugin`. NetworkAttachmentSpec is used when the Runtime
/// > field is set to `attachment`.
class TaskSpecContainerSpec {
  /// The image name to use for the container
  final String? image;

  /// User-defined key/value data.
  final Map<String, dynamic>? labels;

  /// The command to be run in the image.
  final List<String> command;

  /// Arguments to the command.
  final List<String> args;

  /// The hostname to use for the container, as a valid
  /// [RFC 1123](https://tools.ietf.org/html/rfc1123) hostname.
  final String? hostname;

  /// A list of environment variables in the form `VAR=value`.
  final List<String> env;

  /// The working directory for commands to run in.
  final String? dir;

  /// The user inside the container.
  final String? user;

  /// A list of additional groups that the container process will run as.
  final List<String> groups;

  /// Security options for the container
  final TaskSpecContainerSpecPrivileges? privileges;

  /// Whether a pseudo-TTY should be allocated.
  final bool tty;

  /// Open `stdin`
  final bool openStdin;

  /// Mount the container's root filesystem as read only.
  final bool readOnly;

  /// Specification for mounts to be added to containers created as part
  /// of the service.
  final List<Mount> mounts;

  /// Signal to stop the container.
  final String? stopSignal;

  /// Amount of time to wait for the container to terminate before
  /// forcefully killing it.
  final int? stopGracePeriod;
  final HealthConfig? healthCheck;

  /// A list of hostname/IP mappings to add to the container's `hosts`
  /// file. The format of extra hosts is specified in the
  /// [hosts(5)](http://man7.org/linux/man-pages/man5/hosts.5.html)
  /// man page:
  ///
  ///     IP_address canonical_hostname [aliases...]
  final List<String> hosts;

  /// Specification for DNS related configurations in resolver configuration
  /// file (`resolv.conf`).
  final TaskSpecContainerSpecDNSConfig? dnsConfig;

  /// Secrets contains references to zero or more secrets that will be
  /// exposed to the service.
  final List<TaskSpecContainerSpecSecretsItem> secrets;

  /// Configs contains references to zero or more configs that will be
  /// exposed to the service.
  final List<TaskSpecContainerSpecConfigsItem> configs;

  /// Isolation technology of the containers running the service.
  /// (Windows only)
  final TaskSpecContainerSpecIsolation? isolation;

  /// Run an init inside the container that forwards signals and reaps
  /// processes. This field is omitted if empty, and the default (as
  /// configured on the daemon) is used.
  final bool init;

  /// Set kernel namedspaced parameters (sysctls) in the container.
  /// The Sysctls option on services accepts the same sysctls as the
  /// are supported on containers. Note that while the same sysctls are
  /// supported, no guarantees or checks are made about their
  /// suitability for a clustered environment, and it's up to the user
  /// to determine whether a given sysctl will work properly in a
  /// Service.
  final Map<String, dynamic>? sysctls;

  /// A list of kernel capabilities to add to the default set
  /// for the container.
  final List<String> capabilityAdd;

  /// A list of kernel capabilities to drop from the default set
  /// for the container.
  final List<String> capabilityDrop;

  /// A list of resource limits to set in the container. For example: `{"Name":
  /// "nofile", "Soft": 1024, "Hard": 2048}`"
  final List<TaskSpecContainerSpecUlimitsItem> ulimits;

  TaskSpecContainerSpec(
      {this.image,
      this.labels,
      List<String>? command,
      List<String>? args,
      this.hostname,
      List<String>? env,
      this.dir,
      this.user,
      List<String>? groups,
      this.privileges,
      bool? tty,
      bool? openStdin,
      bool? readOnly,
      List<Mount>? mounts,
      this.stopSignal,
      this.stopGracePeriod,
      this.healthCheck,
      List<String>? hosts,
      this.dnsConfig,
      List<TaskSpecContainerSpecSecretsItem>? secrets,
      List<TaskSpecContainerSpecConfigsItem>? configs,
      this.isolation,
      bool? init,
      this.sysctls,
      List<String>? capabilityAdd,
      List<String>? capabilityDrop,
      List<TaskSpecContainerSpecUlimitsItem>? ulimits})
      : command = command ?? [],
        args = args ?? [],
        env = env ?? [],
        groups = groups ?? [],
        tty = tty ?? false,
        openStdin = openStdin ?? false,
        readOnly = readOnly ?? false,
        mounts = mounts ?? [],
        hosts = hosts ?? [],
        secrets = secrets ?? [],
        configs = configs ?? [],
        init = init ?? false,
        capabilityAdd = capabilityAdd ?? [],
        capabilityDrop = capabilityDrop ?? [],
        ulimits = ulimits ?? [];

  factory TaskSpecContainerSpec.fromJson(Map<String, Object?> json) {
    return TaskSpecContainerSpec(
      image: json[r'Image'] as String?,
      labels: json[r'Labels'] as Map<String, Object?>?,
      command: (json[r'Command'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      args: (json[r'Args'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      hostname: json[r'Hostname'] as String?,
      env: (json[r'Env'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      dir: json[r'Dir'] as String?,
      user: json[r'User'] as String?,
      groups: (json[r'Groups'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      privileges: json[r'Privileges'] != null
          ? TaskSpecContainerSpecPrivileges.fromJson(
              json[r'Privileges']! as Map<String, Object?>)
          : null,
      tty: json[r'TTY'] as bool? ?? false,
      openStdin: json[r'OpenStdin'] as bool? ?? false,
      readOnly: json[r'ReadOnly'] as bool? ?? false,
      mounts: (json[r'Mounts'] as List<Object?>?)
              ?.map(
                  (i) => Mount.fromJson(i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      stopSignal: json[r'StopSignal'] as String?,
      stopGracePeriod: (json[r'StopGracePeriod'] as num?)?.toInt(),
      healthCheck: json[r'HealthCheck'] != null
          ? HealthConfig.fromJson(json[r'HealthCheck']! as Map<String, Object?>)
          : null,
      hosts: (json[r'Hosts'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      dnsConfig: json[r'DNSConfig'] != null
          ? TaskSpecContainerSpecDNSConfig.fromJson(
              json[r'DNSConfig']! as Map<String, Object?>)
          : null,
      secrets: (json[r'Secrets'] as List<Object?>?)
              ?.map((i) => TaskSpecContainerSpecSecretsItem.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      configs: (json[r'Configs'] as List<Object?>?)
              ?.map((i) => TaskSpecContainerSpecConfigsItem.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      isolation: json[r'Isolation'] != null
          ? TaskSpecContainerSpecIsolation.fromValue(
              json[r'Isolation']! as String)
          : null,
      init: json[r'Init'] as bool? ?? false,
      sysctls: json[r'Sysctls'] as Map<String, Object?>?,
      capabilityAdd: (json[r'CapabilityAdd'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      capabilityDrop: (json[r'CapabilityDrop'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      ulimits: (json[r'Ulimits'] as List<Object?>?)
              ?.map((i) => TaskSpecContainerSpecUlimitsItem.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var image = this.image;
    var labels = this.labels;
    var command = this.command;
    var args = this.args;
    var hostname = this.hostname;
    var env = this.env;
    var dir = this.dir;
    var user = this.user;
    var groups = this.groups;
    var privileges = this.privileges;
    var tty = this.tty;
    var openStdin = this.openStdin;
    var readOnly = this.readOnly;
    var mounts = this.mounts;
    var stopSignal = this.stopSignal;
    var stopGracePeriod = this.stopGracePeriod;
    var healthCheck = this.healthCheck;
    var hosts = this.hosts;
    var dnsConfig = this.dnsConfig;
    var secrets = this.secrets;
    var configs = this.configs;
    var isolation = this.isolation;
    var init = this.init;
    var sysctls = this.sysctls;
    var capabilityAdd = this.capabilityAdd;
    var capabilityDrop = this.capabilityDrop;
    var ulimits = this.ulimits;

    final json = <String, Object?>{};
    if (image != null) {
      json[r'Image'] = image;
    }
    if (labels != null) {
      json[r'Labels'] = labels;
    }
    json[r'Command'] = command;
    json[r'Args'] = args;
    if (hostname != null) {
      json[r'Hostname'] = hostname;
    }
    json[r'Env'] = env;
    if (dir != null) {
      json[r'Dir'] = dir;
    }
    if (user != null) {
      json[r'User'] = user;
    }
    json[r'Groups'] = groups;
    if (privileges != null) {
      json[r'Privileges'] = privileges.toJson();
    }
    json[r'TTY'] = tty;
    json[r'OpenStdin'] = openStdin;
    json[r'ReadOnly'] = readOnly;
    json[r'Mounts'] = mounts.map((i) => i.toJson()).toList();
    if (stopSignal != null) {
      json[r'StopSignal'] = stopSignal;
    }
    if (stopGracePeriod != null) {
      json[r'StopGracePeriod'] = stopGracePeriod;
    }
    if (healthCheck != null) {
      json[r'HealthCheck'] = healthCheck.toJson();
    }
    json[r'Hosts'] = hosts;
    if (dnsConfig != null) {
      json[r'DNSConfig'] = dnsConfig.toJson();
    }
    json[r'Secrets'] = secrets.map((i) => i.toJson()).toList();
    json[r'Configs'] = configs.map((i) => i.toJson()).toList();
    if (isolation != null) {
      json[r'Isolation'] = isolation.value;
    }
    json[r'Init'] = init;
    if (sysctls != null) {
      json[r'Sysctls'] = sysctls;
    }
    json[r'CapabilityAdd'] = capabilityAdd;
    json[r'CapabilityDrop'] = capabilityDrop;
    json[r'Ulimits'] = ulimits.map((i) => i.toJson()).toList();
    return json;
  }

  TaskSpecContainerSpec copyWith(
      {String? image,
      Map<String, dynamic>? labels,
      List<String>? command,
      List<String>? args,
      String? hostname,
      List<String>? env,
      String? dir,
      String? user,
      List<String>? groups,
      TaskSpecContainerSpecPrivileges? privileges,
      bool? tty,
      bool? openStdin,
      bool? readOnly,
      List<Mount>? mounts,
      String? stopSignal,
      int? stopGracePeriod,
      HealthConfig? healthCheck,
      List<String>? hosts,
      TaskSpecContainerSpecDNSConfig? dnsConfig,
      List<TaskSpecContainerSpecSecretsItem>? secrets,
      List<TaskSpecContainerSpecConfigsItem>? configs,
      TaskSpecContainerSpecIsolation? isolation,
      bool? init,
      Map<String, dynamic>? sysctls,
      List<String>? capabilityAdd,
      List<String>? capabilityDrop,
      List<TaskSpecContainerSpecUlimitsItem>? ulimits}) {
    return TaskSpecContainerSpec(
      image: image ?? this.image,
      labels: labels ?? this.labels,
      command: command ?? this.command,
      args: args ?? this.args,
      hostname: hostname ?? this.hostname,
      env: env ?? this.env,
      dir: dir ?? this.dir,
      user: user ?? this.user,
      groups: groups ?? this.groups,
      privileges: privileges ?? this.privileges,
      tty: tty ?? this.tty,
      openStdin: openStdin ?? this.openStdin,
      readOnly: readOnly ?? this.readOnly,
      mounts: mounts ?? this.mounts,
      stopSignal: stopSignal ?? this.stopSignal,
      stopGracePeriod: stopGracePeriod ?? this.stopGracePeriod,
      healthCheck: healthCheck ?? this.healthCheck,
      hosts: hosts ?? this.hosts,
      dnsConfig: dnsConfig ?? this.dnsConfig,
      secrets: secrets ?? this.secrets,
      configs: configs ?? this.configs,
      isolation: isolation ?? this.isolation,
      init: init ?? this.init,
      sysctls: sysctls ?? this.sysctls,
      capabilityAdd: capabilityAdd ?? this.capabilityAdd,
      capabilityDrop: capabilityDrop ?? this.capabilityDrop,
      ulimits: ulimits ?? this.ulimits,
    );
  }
}

class TaskSpecContainerSpecIsolation {
  static const default$ = TaskSpecContainerSpecIsolation._('default');
  static const process = TaskSpecContainerSpecIsolation._('process');
  static const hyperv = TaskSpecContainerSpecIsolation._('hyperv');

  static const values = [
    default$,
    process,
    hyperv,
  ];
  final String value;

  const TaskSpecContainerSpecIsolation._(this.value);

  static TaskSpecContainerSpecIsolation fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => TaskSpecContainerSpecIsolation._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

class TaskSpecContainerSpecConfigsItem {
  /// File represents a specific target that is backed by a file.
  ///
  /// <p>
  /// <p>
  ///
  /// > **Note**: `Configs.File` and `Configs.Runtime` are mutually exclusive
  final TaskSpecContainerSpecConfigsItemFile? file;

  /// Runtime represents a target that is not mounted into the
  /// container but is used by the task
  ///
  /// <p>
  /// <p>
  ///
  /// > **Note**: `Configs.File` and `Configs.Runtime` are mutually
  /// > exclusive
  final Map<String, dynamic>? runtime;

  /// ConfigID represents the ID of the specific config that we're
  /// referencing.
  final String? configId;

  /// ConfigName is the name of the config that this references,
  /// but this is just provided for lookup/display purposes. The
  /// config in the reference will be identified by its ID.
  final String? configName;

  TaskSpecContainerSpecConfigsItem(
      {this.file, this.runtime, this.configId, this.configName});

  factory TaskSpecContainerSpecConfigsItem.fromJson(Map<String, Object?> json) {
    return TaskSpecContainerSpecConfigsItem(
      file: json[r'File'] != null
          ? TaskSpecContainerSpecConfigsItemFile.fromJson(
              json[r'File']! as Map<String, Object?>)
          : null,
      runtime: json[r'Runtime'] as Map<String, Object?>?,
      configId: json[r'ConfigID'] as String?,
      configName: json[r'ConfigName'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var file = this.file;
    var runtime = this.runtime;
    var configId = this.configId;
    var configName = this.configName;

    final json = <String, Object?>{};
    if (file != null) {
      json[r'File'] = file.toJson();
    }
    if (runtime != null) {
      json[r'Runtime'] = runtime;
    }
    if (configId != null) {
      json[r'ConfigID'] = configId;
    }
    if (configName != null) {
      json[r'ConfigName'] = configName;
    }
    return json;
  }

  TaskSpecContainerSpecConfigsItem copyWith(
      {TaskSpecContainerSpecConfigsItemFile? file,
      Map<String, dynamic>? runtime,
      String? configId,
      String? configName}) {
    return TaskSpecContainerSpecConfigsItem(
      file: file ?? this.file,
      runtime: runtime ?? this.runtime,
      configId: configId ?? this.configId,
      configName: configName ?? this.configName,
    );
  }
}

/// File represents a specific target that is backed by a file.
///
/// <p>
/// <p>
///
/// > **Note**: `Configs.File` and `Configs.Runtime` are mutually exclusive
class TaskSpecContainerSpecConfigsItemFile {
  /// Name represents the final filename in the filesystem.
  final String? name;

  /// UID represents the file UID.
  final String? uid;

  /// GID represents the file GID.
  final String? gid;

  /// Mode represents the FileMode of the file.
  final int? mode;

  TaskSpecContainerSpecConfigsItemFile(
      {this.name, this.uid, this.gid, this.mode});

  factory TaskSpecContainerSpecConfigsItemFile.fromJson(
      Map<String, Object?> json) {
    return TaskSpecContainerSpecConfigsItemFile(
      name: json[r'Name'] as String?,
      uid: json[r'UID'] as String?,
      gid: json[r'GID'] as String?,
      mode: (json[r'Mode'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var uid = this.uid;
    var gid = this.gid;
    var mode = this.mode;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (uid != null) {
      json[r'UID'] = uid;
    }
    if (gid != null) {
      json[r'GID'] = gid;
    }
    if (mode != null) {
      json[r'Mode'] = mode;
    }
    return json;
  }

  TaskSpecContainerSpecConfigsItemFile copyWith(
      {String? name, String? uid, String? gid, int? mode}) {
    return TaskSpecContainerSpecConfigsItemFile(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      gid: gid ?? this.gid,
      mode: mode ?? this.mode,
    );
  }
}

/// Specification for DNS related configurations in resolver configuration
/// file (`resolv.conf`).
class TaskSpecContainerSpecDNSConfig {
  /// The IP addresses of the name servers.
  final List<String> nameservers;

  /// A search list for host-name lookup.
  final List<String> search;

  /// A list of internal resolver variables to be modified (e.g.,
  /// `debug`, `ndots:3`, etc.).
  final List<String> options;

  TaskSpecContainerSpecDNSConfig(
      {List<String>? nameservers, List<String>? search, List<String>? options})
      : nameservers = nameservers ?? [],
        search = search ?? [],
        options = options ?? [];

  factory TaskSpecContainerSpecDNSConfig.fromJson(Map<String, Object?> json) {
    return TaskSpecContainerSpecDNSConfig(
      nameservers: (json[r'Nameservers'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      search: (json[r'Search'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      options: (json[r'Options'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var nameservers = this.nameservers;
    var search = this.search;
    var options = this.options;

    final json = <String, Object?>{};
    json[r'Nameservers'] = nameservers;
    json[r'Search'] = search;
    json[r'Options'] = options;
    return json;
  }

  TaskSpecContainerSpecDNSConfig copyWith(
      {List<String>? nameservers,
      List<String>? search,
      List<String>? options}) {
    return TaskSpecContainerSpecDNSConfig(
      nameservers: nameservers ?? this.nameservers,
      search: search ?? this.search,
      options: options ?? this.options,
    );
  }
}

/// Security options for the container
class TaskSpecContainerSpecPrivileges {
  /// CredentialSpec for managed service account (Windows only)
  final TaskSpecContainerSpecPrivilegesCredentialSpec? credentialSpec;

  /// SELinux labels of the container
  final TaskSpecContainerSpecPrivilegesSELinuxContext? seLinuxContext;

  TaskSpecContainerSpecPrivileges({this.credentialSpec, this.seLinuxContext});

  factory TaskSpecContainerSpecPrivileges.fromJson(Map<String, Object?> json) {
    return TaskSpecContainerSpecPrivileges(
      credentialSpec: json[r'CredentialSpec'] != null
          ? TaskSpecContainerSpecPrivilegesCredentialSpec.fromJson(
              json[r'CredentialSpec']! as Map<String, Object?>)
          : null,
      seLinuxContext: json[r'SELinuxContext'] != null
          ? TaskSpecContainerSpecPrivilegesSELinuxContext.fromJson(
              json[r'SELinuxContext']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var credentialSpec = this.credentialSpec;
    var seLinuxContext = this.seLinuxContext;

    final json = <String, Object?>{};
    if (credentialSpec != null) {
      json[r'CredentialSpec'] = credentialSpec.toJson();
    }
    if (seLinuxContext != null) {
      json[r'SELinuxContext'] = seLinuxContext.toJson();
    }
    return json;
  }

  TaskSpecContainerSpecPrivileges copyWith(
      {TaskSpecContainerSpecPrivilegesCredentialSpec? credentialSpec,
      TaskSpecContainerSpecPrivilegesSELinuxContext? seLinuxContext}) {
    return TaskSpecContainerSpecPrivileges(
      credentialSpec: credentialSpec ?? this.credentialSpec,
      seLinuxContext: seLinuxContext ?? this.seLinuxContext,
    );
  }
}

/// CredentialSpec for managed service account (Windows only)
class TaskSpecContainerSpecPrivilegesCredentialSpec {
  /// Load credential spec from a Swarm Config with the given ID.
  /// The specified config must also be present in the Configs
  /// field with the Runtime property set.
  ///
  /// <p>
  /// </p>
  ///
  ///
  /// > **Note**: `CredentialSpec.File`, `CredentialSpec.Registry`,
  /// > and `CredentialSpec.Config` are mutually exclusive.
  final String? config;

  /// Load credential spec from this file. The file is read by
  /// the daemon, and must be present in the `CredentialSpecs`
  /// subdirectory in the docker data directory, which defaults
  /// to `C:ProgramDataDocker` on Windows.
  ///
  /// For example, specifying `spec.json` loads
  /// `C:ProgramDataDockerCredentialSpecsspec.json`.
  ///
  /// <p>
  /// </p>
  ///
  /// > **Note**: `CredentialSpec.File`, `CredentialSpec.Registry`,
  /// > and `CredentialSpec.Config` are mutually exclusive.
  final String? file;

  /// Load credential spec from this value in the Windows
  /// registry. The specified registry value must be located in:
  ///
  /// `HKLMSOFTWAREMicrosoftWindows
  /// NTCurrentVersionVirtualizationContainersCredentialSpecs`
  ///
  /// <p>
  /// </p>
  ///
  ///
  /// > **Note**: `CredentialSpec.File`, `CredentialSpec.Registry`,
  /// > and `CredentialSpec.Config` are mutually exclusive.
  final String? registry;

  TaskSpecContainerSpecPrivilegesCredentialSpec(
      {this.config, this.file, this.registry});

  factory TaskSpecContainerSpecPrivilegesCredentialSpec.fromJson(
      Map<String, Object?> json) {
    return TaskSpecContainerSpecPrivilegesCredentialSpec(
      config: json[r'Config'] as String?,
      file: json[r'File'] as String?,
      registry: json[r'Registry'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var config = this.config;
    var file = this.file;
    var registry = this.registry;

    final json = <String, Object?>{};
    if (config != null) {
      json[r'Config'] = config;
    }
    if (file != null) {
      json[r'File'] = file;
    }
    if (registry != null) {
      json[r'Registry'] = registry;
    }
    return json;
  }

  TaskSpecContainerSpecPrivilegesCredentialSpec copyWith(
      {String? config, String? file, String? registry}) {
    return TaskSpecContainerSpecPrivilegesCredentialSpec(
      config: config ?? this.config,
      file: file ?? this.file,
      registry: registry ?? this.registry,
    );
  }
}

/// SELinux labels of the container
class TaskSpecContainerSpecPrivilegesSELinuxContext {
  /// Disable SELinux
  final bool disable;

  /// SELinux user label
  final String? user;

  /// SELinux role label
  final String? role;

  /// SELinux type label
  final String? type;

  /// SELinux level label
  final String? level;

  TaskSpecContainerSpecPrivilegesSELinuxContext(
      {bool? disable, this.user, this.role, this.type, this.level})
      : disable = disable ?? false;

  factory TaskSpecContainerSpecPrivilegesSELinuxContext.fromJson(
      Map<String, Object?> json) {
    return TaskSpecContainerSpecPrivilegesSELinuxContext(
      disable: json[r'Disable'] as bool? ?? false,
      user: json[r'User'] as String?,
      role: json[r'Role'] as String?,
      type: json[r'Type'] as String?,
      level: json[r'Level'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var disable = this.disable;
    var user = this.user;
    var role = this.role;
    var type = this.type;
    var level = this.level;

    final json = <String, Object?>{};
    json[r'Disable'] = disable;
    if (user != null) {
      json[r'User'] = user;
    }
    if (role != null) {
      json[r'Role'] = role;
    }
    if (type != null) {
      json[r'Type'] = type;
    }
    if (level != null) {
      json[r'Level'] = level;
    }
    return json;
  }

  TaskSpecContainerSpecPrivilegesSELinuxContext copyWith(
      {bool? disable,
      String? user,
      String? role,
      String? type,
      String? level}) {
    return TaskSpecContainerSpecPrivilegesSELinuxContext(
      disable: disable ?? this.disable,
      user: user ?? this.user,
      role: role ?? this.role,
      type: type ?? this.type,
      level: level ?? this.level,
    );
  }
}

class TaskSpecContainerSpecSecretsItem {
  /// File represents a specific target that is backed by a file.
  final TaskSpecContainerSpecSecretsItemFile? file;

  /// SecretID represents the ID of the specific secret that we're
  /// referencing.
  final String? secretId;

  /// SecretName is the name of the secret that this references,
  /// but this is just provided for lookup/display purposes. The
  /// secret in the reference will be identified by its ID.
  final String? secretName;

  TaskSpecContainerSpecSecretsItem({this.file, this.secretId, this.secretName});

  factory TaskSpecContainerSpecSecretsItem.fromJson(Map<String, Object?> json) {
    return TaskSpecContainerSpecSecretsItem(
      file: json[r'File'] != null
          ? TaskSpecContainerSpecSecretsItemFile.fromJson(
              json[r'File']! as Map<String, Object?>)
          : null,
      secretId: json[r'SecretID'] as String?,
      secretName: json[r'SecretName'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var file = this.file;
    var secretId = this.secretId;
    var secretName = this.secretName;

    final json = <String, Object?>{};
    if (file != null) {
      json[r'File'] = file.toJson();
    }
    if (secretId != null) {
      json[r'SecretID'] = secretId;
    }
    if (secretName != null) {
      json[r'SecretName'] = secretName;
    }
    return json;
  }

  TaskSpecContainerSpecSecretsItem copyWith(
      {TaskSpecContainerSpecSecretsItemFile? file,
      String? secretId,
      String? secretName}) {
    return TaskSpecContainerSpecSecretsItem(
      file: file ?? this.file,
      secretId: secretId ?? this.secretId,
      secretName: secretName ?? this.secretName,
    );
  }
}

/// File represents a specific target that is backed by a file.
class TaskSpecContainerSpecSecretsItemFile {
  /// Name represents the final filename in the filesystem.
  final String? name;

  /// UID represents the file UID.
  final String? uid;

  /// GID represents the file GID.
  final String? gid;

  /// Mode represents the FileMode of the file.
  final int? mode;

  TaskSpecContainerSpecSecretsItemFile(
      {this.name, this.uid, this.gid, this.mode});

  factory TaskSpecContainerSpecSecretsItemFile.fromJson(
      Map<String, Object?> json) {
    return TaskSpecContainerSpecSecretsItemFile(
      name: json[r'Name'] as String?,
      uid: json[r'UID'] as String?,
      gid: json[r'GID'] as String?,
      mode: (json[r'Mode'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var uid = this.uid;
    var gid = this.gid;
    var mode = this.mode;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (uid != null) {
      json[r'UID'] = uid;
    }
    if (gid != null) {
      json[r'GID'] = gid;
    }
    if (mode != null) {
      json[r'Mode'] = mode;
    }
    return json;
  }

  TaskSpecContainerSpecSecretsItemFile copyWith(
      {String? name, String? uid, String? gid, int? mode}) {
    return TaskSpecContainerSpecSecretsItemFile(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      gid: gid ?? this.gid,
      mode: mode ?? this.mode,
    );
  }
}

class TaskSpecContainerSpecUlimitsItem {
  /// Name of ulimit
  final String? name;

  /// Soft limit
  final int? soft;

  /// Hard limit
  final int? hard;

  TaskSpecContainerSpecUlimitsItem({this.name, this.soft, this.hard});

  factory TaskSpecContainerSpecUlimitsItem.fromJson(Map<String, Object?> json) {
    return TaskSpecContainerSpecUlimitsItem(
      name: json[r'Name'] as String?,
      soft: (json[r'Soft'] as num?)?.toInt(),
      hard: (json[r'Hard'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var soft = this.soft;
    var hard = this.hard;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (soft != null) {
      json[r'Soft'] = soft;
    }
    if (hard != null) {
      json[r'Hard'] = hard;
    }
    return json;
  }

  TaskSpecContainerSpecUlimitsItem copyWith(
      {String? name, int? soft, int? hard}) {
    return TaskSpecContainerSpecUlimitsItem(
      name: name ?? this.name,
      soft: soft ?? this.soft,
      hard: hard ?? this.hard,
    );
  }
}

/// Specifies the log driver to use for tasks created from this spec. If
/// not present, the default one for the swarm will be used, finally
/// falling back to the engine default if not specified.
class TaskSpecLogDriver {
  final String? name;
  final Map<String, dynamic>? options;

  TaskSpecLogDriver({this.name, this.options});

  factory TaskSpecLogDriver.fromJson(Map<String, Object?> json) {
    return TaskSpecLogDriver(
      name: json[r'Name'] as String?,
      options: json[r'Options'] as Map<String, Object?>?,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var options = this.options;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (options != null) {
      json[r'Options'] = options;
    }
    return json;
  }

  TaskSpecLogDriver copyWith({String? name, Map<String, dynamic>? options}) {
    return TaskSpecLogDriver(
      name: name ?? this.name,
      options: options ?? this.options,
    );
  }
}

/// Read-only spec type for non-swarm containers attached to swarm overlay
/// networks.
///
/// <p>
/// </p>
///
/// > **Note**: ContainerSpec, NetworkAttachmentSpec, and PluginSpec are
/// > mutually exclusive. PluginSpec is only used when the Runtime field
/// > is set to `plugin`. NetworkAttachmentSpec is used when the Runtime
/// > field is set to `attachment`.
class TaskSpecNetworkAttachmentSpec {
  /// ID of the container represented by this task
  final String? containerId;

  TaskSpecNetworkAttachmentSpec({this.containerId});

  factory TaskSpecNetworkAttachmentSpec.fromJson(Map<String, Object?> json) {
    return TaskSpecNetworkAttachmentSpec(
      containerId: json[r'ContainerID'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var containerId = this.containerId;

    final json = <String, Object?>{};
    if (containerId != null) {
      json[r'ContainerID'] = containerId;
    }
    return json;
  }

  TaskSpecNetworkAttachmentSpec copyWith({String? containerId}) {
    return TaskSpecNetworkAttachmentSpec(
      containerId: containerId ?? this.containerId,
    );
  }
}

class TaskSpecPlacement {
  /// An array of constraint expressions to limit the set of nodes where
  /// a task can be scheduled. Constraint expressions can either use a
  /// _match_ (`==`) or _exclude_ (`!=`) rule. Multiple constraints find
  /// nodes that satisfy every expression (AND match). Constraints can
  /// match node or Docker Engine labels as follows:
  ///
  /// node attribute       | matches                        | example
  /// ---------------------|--------------------------------|-----------------------------------------------
  /// `node.id`            | Node ID                        |
  /// `node.id==2ivku8v2gvtg4`
  /// `node.hostname`      | Node hostname                  |
  /// `node.hostname!=node-2`
  /// `node.role`          | Node role (`manager`/`worker`) |
  /// `node.role==manager`
  /// `node.platform.os`   | Node operating system          |
  /// `node.platform.os==windows`
  /// `node.platform.arch` | Node architecture              |
  /// `node.platform.arch==x86_64`
  /// `node.labels`        | User-defined node labels       |
  /// `node.labels.security==high`
  /// `engine.labels`      | Docker Engine's labels         |
  /// `engine.labels.operatingsystem==ubuntu-14.04`
  ///
  /// `engine.labels` apply to Docker Engine labels like operating system,
  /// drivers, etc. Swarm administrators add `node.labels` for operational
  /// purposes by using the [`node update endpoint`](#operation/NodeUpdate).
  final List<String> constraints;

  /// Preferences provide a way to make the scheduler aware of factors
  /// such as topology. They are provided in order from highest to
  /// lowest precedence.
  final List<TaskSpecPlacementPreferencesItem> preferences;

  /// Maximum number of replicas for per node (default value is 0, which
  /// is unlimited)
  final int? maxReplicas;

  /// Platforms stores all the platforms that the service's image can
  /// run on. This field is used in the platform filter for scheduling.
  /// If empty, then the platform filter is off, meaning there are no
  /// scheduling restrictions.
  final List<Platform> platforms;

  TaskSpecPlacement(
      {List<String>? constraints,
      List<TaskSpecPlacementPreferencesItem>? preferences,
      this.maxReplicas,
      List<Platform>? platforms})
      : constraints = constraints ?? [],
        preferences = preferences ?? [],
        platforms = platforms ?? [];

  factory TaskSpecPlacement.fromJson(Map<String, Object?> json) {
    return TaskSpecPlacement(
      constraints: (json[r'Constraints'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
      preferences: (json[r'Preferences'] as List<Object?>?)
              ?.map((i) => TaskSpecPlacementPreferencesItem.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
      maxReplicas: (json[r'MaxReplicas'] as num?)?.toInt(),
      platforms: (json[r'Platforms'] as List<Object?>?)
              ?.map((i) =>
                  Platform.fromJson(i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var constraints = this.constraints;
    var preferences = this.preferences;
    var maxReplicas = this.maxReplicas;
    var platforms = this.platforms;

    final json = <String, Object?>{};
    json[r'Constraints'] = constraints;
    json[r'Preferences'] = preferences.map((i) => i.toJson()).toList();
    if (maxReplicas != null) {
      json[r'MaxReplicas'] = maxReplicas;
    }
    json[r'Platforms'] = platforms.map((i) => i.toJson()).toList();
    return json;
  }

  TaskSpecPlacement copyWith(
      {List<String>? constraints,
      List<TaskSpecPlacementPreferencesItem>? preferences,
      int? maxReplicas,
      List<Platform>? platforms}) {
    return TaskSpecPlacement(
      constraints: constraints ?? this.constraints,
      preferences: preferences ?? this.preferences,
      maxReplicas: maxReplicas ?? this.maxReplicas,
      platforms: platforms ?? this.platforms,
    );
  }
}

class TaskSpecPlacementPreferencesItem {
  final TaskSpecPlacementPreferencesItemSpread? spread;

  TaskSpecPlacementPreferencesItem({this.spread});

  factory TaskSpecPlacementPreferencesItem.fromJson(Map<String, Object?> json) {
    return TaskSpecPlacementPreferencesItem(
      spread: json[r'Spread'] != null
          ? TaskSpecPlacementPreferencesItemSpread.fromJson(
              json[r'Spread']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var spread = this.spread;

    final json = <String, Object?>{};
    if (spread != null) {
      json[r'Spread'] = spread.toJson();
    }
    return json;
  }

  TaskSpecPlacementPreferencesItem copyWith(
      {TaskSpecPlacementPreferencesItemSpread? spread}) {
    return TaskSpecPlacementPreferencesItem(
      spread: spread ?? this.spread,
    );
  }
}

class TaskSpecPlacementPreferencesItemSpread {
  /// label descriptor, such as `engine.labels.az`.
  final String? spreadDescriptor;

  TaskSpecPlacementPreferencesItemSpread({this.spreadDescriptor});

  factory TaskSpecPlacementPreferencesItemSpread.fromJson(
      Map<String, Object?> json) {
    return TaskSpecPlacementPreferencesItemSpread(
      spreadDescriptor: json[r'SpreadDescriptor'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    var spreadDescriptor = this.spreadDescriptor;

    final json = <String, Object?>{};
    if (spreadDescriptor != null) {
      json[r'SpreadDescriptor'] = spreadDescriptor;
    }
    return json;
  }

  TaskSpecPlacementPreferencesItemSpread copyWith({String? spreadDescriptor}) {
    return TaskSpecPlacementPreferencesItemSpread(
      spreadDescriptor: spreadDescriptor ?? this.spreadDescriptor,
    );
  }
}

/// Plugin spec for the service.  *(Experimental release only.)*
///
/// <p>
/// </p>
///
/// > **Note**: ContainerSpec, NetworkAttachmentSpec, and PluginSpec are
/// > mutually exclusive. PluginSpec is only used when the Runtime field
/// > is set to `plugin`. NetworkAttachmentSpec is used when the Runtime
/// > field is set to `attachment`.
class TaskSpecPluginSpec {
  /// The name or 'alias' to use for the plugin.
  final String? name;

  /// The plugin image reference to use.
  final String? remote;

  /// Disable the plugin once scheduled.
  final bool disabled;
  final List<TaskSpecPluginSpecPluginPrivilegeItem> pluginPrivilege;

  TaskSpecPluginSpec(
      {this.name,
      this.remote,
      bool? disabled,
      List<TaskSpecPluginSpecPluginPrivilegeItem>? pluginPrivilege})
      : disabled = disabled ?? false,
        pluginPrivilege = pluginPrivilege ?? [];

  factory TaskSpecPluginSpec.fromJson(Map<String, Object?> json) {
    return TaskSpecPluginSpec(
      name: json[r'Name'] as String?,
      remote: json[r'Remote'] as String?,
      disabled: json[r'Disabled'] as bool? ?? false,
      pluginPrivilege: (json[r'PluginPrivilege'] as List<Object?>?)
              ?.map((i) => TaskSpecPluginSpecPluginPrivilegeItem.fromJson(
                  i as Map<String, Object?>? ?? const {}))
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var remote = this.remote;
    var disabled = this.disabled;
    var pluginPrivilege = this.pluginPrivilege;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (remote != null) {
      json[r'Remote'] = remote;
    }
    json[r'Disabled'] = disabled;
    json[r'PluginPrivilege'] = pluginPrivilege.map((i) => i.toJson()).toList();
    return json;
  }

  TaskSpecPluginSpec copyWith(
      {String? name,
      String? remote,
      bool? disabled,
      List<TaskSpecPluginSpecPluginPrivilegeItem>? pluginPrivilege}) {
    return TaskSpecPluginSpec(
      name: name ?? this.name,
      remote: remote ?? this.remote,
      disabled: disabled ?? this.disabled,
      pluginPrivilege: pluginPrivilege ?? this.pluginPrivilege,
    );
  }
}

/// Describes a permission accepted by the user upon installing the
/// plugin.
class TaskSpecPluginSpecPluginPrivilegeItem {
  final String? name;
  final String? description;
  final List<String> value;

  TaskSpecPluginSpecPluginPrivilegeItem(
      {this.name, this.description, List<String>? value})
      : value = value ?? [];

  factory TaskSpecPluginSpecPluginPrivilegeItem.fromJson(
      Map<String, Object?> json) {
    return TaskSpecPluginSpecPluginPrivilegeItem(
      name: json[r'Name'] as String?,
      description: json[r'Description'] as String?,
      value: (json[r'Value'] as List<Object?>?)
              ?.map((i) => i as String? ?? '')
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var description = this.description;
    var value = this.value;

    final json = <String, Object?>{};
    if (name != null) {
      json[r'Name'] = name;
    }
    if (description != null) {
      json[r'Description'] = description;
    }
    json[r'Value'] = value;
    return json;
  }

  TaskSpecPluginSpecPluginPrivilegeItem copyWith(
      {String? name, String? description, List<String>? value}) {
    return TaskSpecPluginSpecPluginPrivilegeItem(
      name: name ?? this.name,
      description: description ?? this.description,
      value: value ?? this.value,
    );
  }
}

/// Resource requirements which apply to each individual container created
/// as part of the service.
class TaskSpecResources {
  /// Define resources limits.
  final Limit? limits;

  /// Define resources reservation.
  final ResourceObject? reservation;

  TaskSpecResources({this.limits, this.reservation});

  factory TaskSpecResources.fromJson(Map<String, Object?> json) {
    return TaskSpecResources(
      limits: json[r'Limits'] != null
          ? Limit.fromJson(json[r'Limits']! as Map<String, Object?>)
          : null,
      reservation: json[r'Reservation'] != null
          ? ResourceObject.fromJson(
              json[r'Reservation']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var limits = this.limits;
    var reservation = this.reservation;

    final json = <String, Object?>{};
    if (limits != null) {
      json[r'Limits'] = limits.toJson();
    }
    if (reservation != null) {
      json[r'Reservation'] = reservation.toJson();
    }
    return json;
  }

  TaskSpecResources copyWith({Limit? limits, ResourceObject? reservation}) {
    return TaskSpecResources(
      limits: limits ?? this.limits,
      reservation: reservation ?? this.reservation,
    );
  }
}

/// Specification for the restart policy which applies to containers
/// created as part of this service.
class TaskSpecRestartPolicy {
  /// Condition for restart.
  final TaskSpecRestartPolicyCondition? condition;

  /// Delay between restart attempts.
  final int? delay;

  /// Maximum attempts to restart a given container before giving up
  /// (default value is 0, which is ignored).
  final int? maxAttempts;

  /// Windows is the time window used to evaluate the restart policy
  /// (default value is 0, which is unbounded).
  final int? window;

  TaskSpecRestartPolicy(
      {this.condition, this.delay, this.maxAttempts, this.window});

  factory TaskSpecRestartPolicy.fromJson(Map<String, Object?> json) {
    return TaskSpecRestartPolicy(
      condition: json[r'Condition'] != null
          ? TaskSpecRestartPolicyCondition.fromValue(
              json[r'Condition']! as String)
          : null,
      delay: (json[r'Delay'] as num?)?.toInt(),
      maxAttempts: (json[r'MaxAttempts'] as num?)?.toInt(),
      window: (json[r'Window'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var condition = this.condition;
    var delay = this.delay;
    var maxAttempts = this.maxAttempts;
    var window = this.window;

    final json = <String, Object?>{};
    if (condition != null) {
      json[r'Condition'] = condition.value;
    }
    if (delay != null) {
      json[r'Delay'] = delay;
    }
    if (maxAttempts != null) {
      json[r'MaxAttempts'] = maxAttempts;
    }
    if (window != null) {
      json[r'Window'] = window;
    }
    return json;
  }

  TaskSpecRestartPolicy copyWith(
      {TaskSpecRestartPolicyCondition? condition,
      int? delay,
      int? maxAttempts,
      int? window}) {
    return TaskSpecRestartPolicy(
      condition: condition ?? this.condition,
      delay: delay ?? this.delay,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      window: window ?? this.window,
    );
  }
}

class TaskSpecRestartPolicyCondition {
  static const none = TaskSpecRestartPolicyCondition._('none');
  static const onFailure = TaskSpecRestartPolicyCondition._('on-failure');
  static const any = TaskSpecRestartPolicyCondition._('any');

  static const values = [
    none,
    onFailure,
    any,
  ];
  final String value;

  const TaskSpecRestartPolicyCondition._(this.value);

  static TaskSpecRestartPolicyCondition fromValue(String value) =>
      values.firstWhere((e) => e.value == value,
          orElse: () => TaskSpecRestartPolicyCondition._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

class TaskState {
  TaskState();

  factory TaskState.fromJson(Map<String, Object?> json) {
    return TaskState();
  }

  Map<String, Object?> toJson() {
    final json = <String, Object?>{};
    return json;
  }
}

class TaskStatus {
  final DateTime? timestamp;
  final TaskState? state;
  final String? message;
  final String? err;
  final TaskStatusContainerStatus? containerStatus;

  TaskStatus(
      {this.timestamp,
      this.state,
      this.message,
      this.err,
      this.containerStatus});

  factory TaskStatus.fromJson(Map<String, Object?> json) {
    return TaskStatus(
      timestamp: DateTime.tryParse(json[r'Timestamp'] as String? ?? ''),
      state: json[r'State'] != null
          ? TaskState.fromJson(json[r'State']! as Map<String, Object?>)
          : null,
      message: json[r'Message'] as String?,
      err: json[r'Err'] as String?,
      containerStatus: json[r'ContainerStatus'] != null
          ? TaskStatusContainerStatus.fromJson(
              json[r'ContainerStatus']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var timestamp = this.timestamp;
    var state = this.state;
    var message = this.message;
    var err = this.err;
    var containerStatus = this.containerStatus;

    final json = <String, Object?>{};
    if (timestamp != null) {
      json[r'Timestamp'] = timestamp.toIso8601String();
    }
    if (state != null) {
      json[r'State'] = state.toJson();
    }
    if (message != null) {
      json[r'Message'] = message;
    }
    if (err != null) {
      json[r'Err'] = err;
    }
    if (containerStatus != null) {
      json[r'ContainerStatus'] = containerStatus.toJson();
    }
    return json;
  }

  TaskStatus copyWith(
      {DateTime? timestamp,
      TaskState? state,
      String? message,
      String? err,
      TaskStatusContainerStatus? containerStatus}) {
    return TaskStatus(
      timestamp: timestamp ?? this.timestamp,
      state: state ?? this.state,
      message: message ?? this.message,
      err: err ?? this.err,
      containerStatus: containerStatus ?? this.containerStatus,
    );
  }
}

class TaskStatusContainerStatus {
  final String? containerId;
  final int? pid;
  final int? exitCode;

  TaskStatusContainerStatus({this.containerId, this.pid, this.exitCode});

  factory TaskStatusContainerStatus.fromJson(Map<String, Object?> json) {
    return TaskStatusContainerStatus(
      containerId: json[r'ContainerID'] as String?,
      pid: (json[r'PID'] as num?)?.toInt(),
      exitCode: (json[r'ExitCode'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var containerId = this.containerId;
    var pid = this.pid;
    var exitCode = this.exitCode;

    final json = <String, Object?>{};
    if (containerId != null) {
      json[r'ContainerID'] = containerId;
    }
    if (pid != null) {
      json[r'PID'] = pid;
    }
    if (exitCode != null) {
      json[r'ExitCode'] = exitCode;
    }
    return json;
  }

  TaskStatusContainerStatus copyWith(
      {String? containerId, int? pid, int? exitCode}) {
    return TaskStatusContainerStatus(
      containerId: containerId ?? this.containerId,
      pid: pid ?? this.pid,
      exitCode: exitCode ?? this.exitCode,
    );
  }
}

class ThrottleDevice {
  /// Device path
  final String? path;

  /// Rate
  final int? rate;

  ThrottleDevice({this.path, this.rate});

  factory ThrottleDevice.fromJson(Map<String, Object?> json) {
    return ThrottleDevice(
      path: json[r'Path'] as String?,
      rate: (json[r'Rate'] as num?)?.toInt(),
    );
  }

  Map<String, Object?> toJson() {
    var path = this.path;
    var rate = this.rate;

    final json = <String, Object?>{};
    if (path != null) {
      json[r'Path'] = path;
    }
    if (rate != null) {
      json[r'Rate'] = rate;
    }
    return json;
  }

  ThrottleDevice copyWith({String? path, int? rate}) {
    return ThrottleDevice(
      path: path ?? this.path,
      rate: rate ?? this.rate,
    );
  }
}

class Volume {
  /// Name of the volume.
  final String name;

  /// Name of the volume driver used by the volume.
  final String driver;

  /// Mount path of the volume on the host.
  final String mountpoint;

  /// Date/Time the volume was created.
  final DateTime? createdAt;

  /// Low-level details about the volume, provided by the volume driver.
  /// Details are returned as a map with key/value pairs:
  /// `{"key":"value","key2":"value2"}`.
  ///
  /// The `Status` field is optional, and is omitted if the volume driver
  /// does not support this feature.
  final Map<String, dynamic>? status;

  /// User-defined key/value metadata.
  final Map<String, dynamic> labels;

  /// The level at which the volume exists. Either `global` for cluster-wide,
  /// or `local` for machine level.
  final VolumeScope scope;

  /// The driver specific options used when creating the volume.
  final Map<String, dynamic> options;

  /// Usage details about the volume. This information is used by the
  /// `GET /system/df` endpoint, and omitted in other endpoints.
  final VolumeUsageData? usageData;

  Volume(
      {required this.name,
      required this.driver,
      required this.mountpoint,
      this.createdAt,
      this.status,
      required this.labels,
      required this.scope,
      required this.options,
      this.usageData});

  factory Volume.fromJson(Map<String, Object?> json) {
    return Volume(
      name: json[r'Name'] as String? ?? '',
      driver: json[r'Driver'] as String? ?? '',
      mountpoint: json[r'Mountpoint'] as String? ?? '',
      createdAt: DateTime.tryParse(json[r'CreatedAt'] as String? ?? ''),
      status: json[r'Status'] as Map<String, Object?>?,
      labels: json[r'Labels'] as Map<String, Object?>? ?? {},
      scope: VolumeScope.fromValue(json[r'Scope'] as String? ?? ''),
      options: json[r'Options'] as Map<String, Object?>? ?? {},
      usageData: json[r'UsageData'] != null
          ? VolumeUsageData.fromJson(
              json[r'UsageData']! as Map<String, Object?>)
          : null,
    );
  }

  Map<String, Object?> toJson() {
    var name = this.name;
    var driver = this.driver;
    var mountpoint = this.mountpoint;
    var createdAt = this.createdAt;
    var status = this.status;
    var labels = this.labels;
    var scope = this.scope;
    var options = this.options;
    var usageData = this.usageData;

    final json = <String, Object?>{};
    json[r'Name'] = name;
    json[r'Driver'] = driver;
    json[r'Mountpoint'] = mountpoint;
    if (createdAt != null) {
      json[r'CreatedAt'] = createdAt.toIso8601String();
    }
    if (status != null) {
      json[r'Status'] = status;
    }
    json[r'Labels'] = labels;
    json[r'Scope'] = scope.value;
    json[r'Options'] = options;
    if (usageData != null) {
      json[r'UsageData'] = usageData.toJson();
    }
    return json;
  }

  Volume copyWith(
      {String? name,
      String? driver,
      String? mountpoint,
      DateTime? createdAt,
      Map<String, dynamic>? status,
      Map<String, dynamic>? labels,
      VolumeScope? scope,
      Map<String, dynamic>? options,
      VolumeUsageData? usageData}) {
    return Volume(
      name: name ?? this.name,
      driver: driver ?? this.driver,
      mountpoint: mountpoint ?? this.mountpoint,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      labels: labels ?? this.labels,
      scope: scope ?? this.scope,
      options: options ?? this.options,
      usageData: usageData ?? this.usageData,
    );
  }
}

class VolumeScope {
  static const local = VolumeScope._('local');
  static const global = VolumeScope._('global');

  static const values = [
    local,
    global,
  ];
  final String value;

  const VolumeScope._(this.value);

  static VolumeScope fromValue(String value) => values
      .firstWhere((e) => e.value == value, orElse: () => VolumeScope._(value));

  /// An enum received from the server but this version of the client doesn't recognize it.
  bool get isUnknown => values.every((v) => v.value != value);

  @override
  String toString() => value;
}

/// Usage details about the volume. This information is used by the
/// `GET /system/df` endpoint, and omitted in other endpoints.
class VolumeUsageData {
  /// Amount of disk space used by the volume (in bytes). This information
  /// is only available for volumes created with the `"local"` volume
  /// driver. For volumes created with other volume drivers, this field
  /// is set to `-1` ("not available")
  final int size;

  /// The number of containers referencing this volume. This field
  /// is set to `-1` if the reference-count is not available.
  final int refCount;

  VolumeUsageData({required this.size, required this.refCount});

  factory VolumeUsageData.fromJson(Map<String, Object?> json) {
    return VolumeUsageData(
      size: (json[r'Size'] as num?)?.toInt() ?? 0,
      refCount: (json[r'RefCount'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, Object?> toJson() {
    var size = this.size;
    var refCount = this.refCount;

    final json = <String, Object?>{};
    json[r'Size'] = size;
    json[r'RefCount'] = refCount;
    return json;
  }

  VolumeUsageData copyWith({int? size, int? refCount}) {
    return VolumeUsageData(
      size: size ?? this.size,
      refCount: refCount ?? this.refCount,
    );
  }
}
