import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:path/path.dart' as p;
import 'http_unix_client.dart';

class ApiClient {
  final HttpUnixClient _client;
  final String basePath;

  ApiClient({String? socketPath, required this.basePath})
      : _client = HttpUnixClient(socketPath ??
            (Platform.isWindows
                ? '//./pipe/docker_engine'
                : '/var/run/docker.sock'));

  Future<T> send<T>(
    String method,
    String pathTemplate, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    var path = pathTemplate;

    if (pathParameters != null) {
      for (var pathParameter in pathParameters.entries) {
        path = path.replaceAll(
            '{${pathParameter.key}}', Uri.encodeComponent(pathParameter.value));
      }
    }
    assert(!path.contains('{'));

    if (path.startsWith('/')) {
      path = path.substring(1);
    }

    var uri = Uri.http('docker', p.url.join(basePath, path));
    if (queryParameters != null) {
      uri = uri.replace(queryParameters: {
        ...uri.queryParameters,
        ...queryParameters,
      });
    }

    var bodyRequest = Request(method, uri);
    var request = bodyRequest;

    if (body != null) {
      bodyRequest
        ..headers['content-type'] = 'application/json'
        ..body = jsonEncode(body);
    }

    if (headers != null) {
      request.headers.addAll(headers);
    }

    var response = await Response.fromStream(await _client.send(request));
    ApiException.checkResponse(response);

    var decoded = _decode(response);
    return decoded as T;
  }

  dynamic _decode(Response response) {
    var bytes = response.bodyBytes;
    if (bytes.isEmpty) return null;

    var responseBody = utf8.decode(bytes);
    return jsonDecode(responseBody);
  }

  void close() => _client.close();
}

class ApiException implements Exception {
  final Uri? url;
  final int statusCode;
  final String? reasonPhrase;
  final String? errorMessage;

  ApiException(this.url, this.statusCode, this.reasonPhrase,
      {this.errorMessage});

  factory ApiException.fromResponse(Response response) {
    String? errorMessage;
    if (response.body.isNotEmpty) {
      try {
        var decodedBody = jsonDecode(response.body);
        if (decodedBody is Map<String, dynamic>) {
          // TODO(xha): find out the format
          errorMessage = decodedBody['message'] as String? ??
              decodedBody['errorMessage'] as String?;
        } else {
          decodedBody = '$decodedBody';
        }
      } catch (e) {
        // Fail to parse as Json

      }
      errorMessage ??= response.body;
    }
    return ApiException(
        response.request?.url, response.statusCode, response.reasonPhrase,
        errorMessage: errorMessage);
  }

  @override
  String toString() =>
      'ApiException($statusCode, $reasonPhrase, url: $url, message: $errorMessage)';

  static void checkResponse(Response response) {
    if (response.statusCode >= 400) {
      throw ApiException.fromResponse(response);
    }
  }
}
