// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swagger_spec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Spec _$SpecFromJson(Map<String, dynamic> json) {
  return Spec(
    json['basePath'] as String,
    Info.fromJson(json['info'] as Map<String, dynamic>),
    (json['tags'] as List<dynamic>?)
        ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['definitions'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, Schema.fromJson(e as Map<String, dynamic>)),
    ),
    (json['paths'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, e as Map<String, dynamic>),
    ),
  );
}

Info _$InfoFromJson(Map<String, dynamic> json) {
  return Info(
    title: json['title'] as String,
    description: json['description'] as String?,
    version: json['version'] as String?,
  );
}

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag(
    name: json['name'] as String,
    description: json['description'] as String?,
  );
}

Path _$PathFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const [
    'summary',
    'tags',
    'description',
    'operationId',
    'deprecated',
    'parameters',
    'responses',
    'produces',
    'consumes'
  ]);
  return Path(
    description: json['description'] as String?,
    operationId: json['operationId'] as String?,
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    summary: json['summary'] as String?,
    deprecated: json['deprecated'] as bool?,
    parameters: (json['parameters'] as List<dynamic>?)
        ?.map((e) => Parameter.fromJson(e as Map<String, dynamic>))
        .toList(),
    responses: (json['responses'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Response.fromJson(e as Map<String, dynamic>)),
    ),
    produces:
        (json['produces'] as List<dynamic>?)?.map((e) => e as String).toList(),
    consumes:
        (json['consumes'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Request _$RequestFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const [
    'content',
    'required',
    'description',
    r'$ref',
    'x-examples'
  ]);
  return Request(
    (json['content'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Content.fromJson(e as Map<String, dynamic>)),
    ),
    required: json['required'] as bool?,
    description: json['description'] as String?,
    ref: json[r'$ref'] as String?,
  )..examples = json['x-examples'];
}

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
    description: json['description'] as String?,
    schema: json['schema'] == null
        ? null
        : Schema.fromJson(json['schema'] as Map<String, dynamic>),
  );
}

Content _$ContentFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      allowedKeys: const ['description', 'example', 'examples', 'schema']);
  return Content(
    description: json['description'] as String?,
    schema: json['schema'] == null
        ? null
        : Schema.fromJson(json['schema'] as Map<String, dynamic>),
    example: json['example'],
    examples: json['examples'],
  );
}

Parameter _$ParameterFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const [
    'in',
    'name',
    'description',
    'required',
    'type',
    'schema',
    'items',
    'style',
    'explode',
    'deprecated',
    'x-showInExample',
    'example',
    'x-changes',
    r'$ref',
    'default',
    'pattern',
    'enum',
    'format'
  ]);
  return Parameter(
    _$enumDecodeNullable(_$ParameterLocationEnumMap, json['in']) ??
        ParameterLocation.query,
    json['name'] as String?,
    json['description'] as String?,
    json['required'] as bool?,
    json['type'] as String?,
    json['schema'] == null
        ? null
        : Schema.fromJson(json['schema'] as Map<String, dynamic>),
    json['items'] == null
        ? null
        : Schema.fromJson(json['items'] as Map<String, dynamic>),
    json['style'] as String?,
    json['explode'] as bool?,
    json[r'$ref'] as String?,
    json['deprecated'] as bool? ?? false,
    json['default'],
    json['pattern'] as String?,
    (json['enum'] as List<dynamic>?)?.map((e) => e as String).toList(),
    json['format'] as String?,
  )
    ..showInExample = json['x-showInExample']
    ..example = json['example']
    ..changes = json['x-changes'];
}

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$ParameterLocationEnumMap = {
  ParameterLocation.query: 'query',
  ParameterLocation.path: 'path',
  ParameterLocation.formData: 'formData',
  ParameterLocation.header: 'header',
  ParameterLocation.body: 'body',
};

Schema _$SchemaFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const [
    'type',
    'format',
    'properties',
    'additionalProperties',
    'description',
    'required',
    'allOf',
    'anyOf',
    'oneOf',
    'example',
    'discriminator',
    'title',
    'deprecated',
    'uniqueItems',
    'readOnly',
    'writeOnly',
    'x-nullable',
    'x-go-name',
    'xml',
    'maxLength',
    'minLength',
    'maxItems',
    'minItems',
    'maxProperties',
    'minProperties',
    'maximum',
    'minimum',
    'pattern',
    'default',
    'enum',
    r'$ref',
    'items'
  ]);
  return Schema(
    json['type'] as String?,
    json['format'] as String?,
    (json['properties'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Schema.fromJson(e as Map<String, dynamic>)),
    ),
    json['additionalProperties'],
    json['enum'] as List<dynamic>?,
    json[r'$ref'] as String?,
    json['items'] == null
        ? null
        : Schema.fromJson(json['items'] as Map<String, dynamic>),
    json['description'] as String?,
    (json['required'] as List<dynamic>?)?.map((e) => e as String).toList(),
    (json['allOf'] as List<dynamic>?)
        ?.map((e) => Schema.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['anyOf'] as List<dynamic>?)
        ?.map((e) => Schema.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['oneOf'] as List<dynamic>?)
        ?.map((e) => Schema.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['deprecated'] as bool? ?? false,
    json['uniqueItems'] as bool? ?? false,
    json['readOnly'] as bool? ?? false,
    json['writeOnly'] as bool? ?? false,
    json['x-nullable'] as bool? ?? true,
    json['xml'] as Map<String, dynamic>?,
    json['maxLength'] as int?,
    json['minLength'] as int?,
    json['maxItems'] as int?,
    json['minItems'] as int?,
    json['minProperties'] as int?,
    json['maxProperties'] as int?,
    json['maximum'] as int?,
    json['minimum'] as int?,
    json['pattern'] as String?,
    json['default'],
    json['example'],
    json['discriminator'],
    json['title'] as String?,
    json['x-go-name'] as String?,
  );
}
