import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'swagger_spec.g.dart';

class HttpMethod {
  static const get = HttpMethod('get');
  static const post = HttpMethod('post');
  static const put = HttpMethod('put');
  static const delete = HttpMethod('delete');
  static const head = HttpMethod('head');

  static const all = [get, post, put, delete, head];

  final String name;
  const HttpMethod(this.name);
}

@JsonSerializable(createToJson: false)
class Spec {
  final String basePath;
  final Info info;
  final List<Tag>? tags;
  final Map<String, Schema> definitions;
  final Map<String, Map<String, Object?>> paths;

  Spec(
    this.basePath,
    this.info,
    this.tags,
    this.definitions,
    this.paths,
  );

  factory Spec.fromJson(Map<String, dynamic> json) => _$SpecFromJson(json);
}

@JsonSerializable(createToJson: false)
class Info {
  final String title;
  final String description;
  final String? version;

  Info({required this.title, String? description, this.version})
      : description = description ?? '';

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
}

@JsonSerializable(createToJson: false)
class Tag {
  final String name;
  final String description;

  Tag({required this.name, String? description})
      : description = description ?? '';

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

@JsonSerializable(createToJson: false, disallowUnrecognizedKeys: true)
class Path {
  final String summary;
  final List<String> tags;
  final String description;
  final String? operationId;
  final bool deprecated;
  final List<Parameter> parameters;
  final Map<String, Response> responses;
  final List<String> produces;
  final List<String> consumes;

  Path({
    String? description,
    this.operationId,
    List<String>? tags,
    String? summary,
    bool? deprecated,
    List<Parameter>? parameters,
    Map<String, Response>? responses,
    List<String>? produces,
    List<String>? consumes,
  })  : description = description ?? '',
        summary = summary ?? '',
        tags = tags ?? const [],
        deprecated = deprecated ?? false,
        parameters = parameters ?? const [],
        responses = responses ?? const {},
        produces = produces ?? const [],
        consumes = consumes ?? const [];

  factory Path.fromJson(Map<String, dynamic> json) => _$PathFromJson(json);
}

@JsonSerializable(createToJson: false, disallowUnrecognizedKeys: true)
class Request {
  final Map<String, Content>? content;
  final bool required;
  final String? description;

  @JsonKey(name: r'$ref')
  final String? ref;

  @JsonKey(name: r'x-examples')
  Object? examples;

  Request(this.content, {bool? required, this.description, this.ref})
      : required = required ?? false;

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);
}

@JsonSerializable(createToJson: false)
class Response {
  final String description;
  final Schema? schema;

  Response({String? description, this.schema})
      : description = description ?? '';

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
}

@JsonSerializable(createToJson: false, disallowUnrecognizedKeys: true)
class Content {
  final String description;
  final Object? example, examples;
  final Schema? schema;

  Content({
    String? description,
    bool? required,
    this.schema,
    this.example,
    this.examples,
  }) : description = description ?? '';

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}

enum ParameterLocation { query, path, formData, header, body }

@JsonSerializable(createToJson: false, disallowUnrecognizedKeys: true)
class Parameter {
  @JsonKey(name: 'in', defaultValue: ParameterLocation.query)
  final ParameterLocation location;

  final String name;
  final String description;
  final bool required;
  final String? type;
  final Schema? schema;
  final Schema? items;
  final String? style;
  final bool? explode;

  @JsonKey(defaultValue: false)
  final bool deprecated;

  @JsonKey(name: 'x-showInExample')
  Object? showInExample;

  Object? example;

  @JsonKey(name: 'x-changes')
  Object? changes;

  @JsonKey(name: r'$ref')
  final String? ref;

  @JsonKey(name: r'default')
  final Object? defaultValue;

  @JsonKey(name: r'pattern')
  final String? pattern;

  @JsonKey(name: 'enum')
  final List<String>? enums;

  @JsonKey(name: 'format')
  final String? format;

  Parameter(
    this.location,
    String? name,
    String? description,
    bool? required,
    this.type,
    this.schema,
    this.items,
    this.style,
    this.explode,
    this.ref,
    this.deprecated,
    this.defaultValue,
    this.pattern,
    this.enums,
    this.format,
  )   : name = name ?? '',
        description = description ?? '',
        required = required ?? false;

  factory Parameter.fromJson(Map<String, dynamic> json) =>
      _$ParameterFromJson(json);
}

@JsonSerializable(createToJson: false, disallowUnrecognizedKeys: true)
class Schema {
  final String? type;
  final String? format;
  final Map<String, Schema> properties;
  final Object? additionalProperties;
  final String description;
  final List<String> required;
  final List<Schema>? allOf, anyOf, oneOf;
  final Object? example;
  final Object? discriminator;
  final String? title;

  @JsonKey(defaultValue: false)
  final bool deprecated;

  @JsonKey(defaultValue: false)
  final bool uniqueItems;

  @JsonKey(defaultValue: false)
  final bool readOnly;

  @JsonKey(defaultValue: false)
  final bool writeOnly;

  @JsonKey(name: 'x-nullable', defaultValue: true)
  final bool nullable;

  @JsonKey(name: 'x-go-name')
  final String? goName;

  final Map<String, Object?>? xml;

  final int? maxLength,
      minLength,
      maxItems,
      minItems,
      maxProperties,
      minProperties,
      maximum,
      minimum;
  final String? pattern;

  @JsonKey(name: 'default')
  final Object? defaultValue;

  @JsonKey(name: 'enum')
  final List<Object>? enums;

  @JsonKey(name: r'$ref')
  final String? ref;

  final Schema? items;

  Schema(
    this.type,
    this.format,
    Map<String, Schema>? properties,
    this.additionalProperties,
    List<Object?>? enums,
    this.ref,
    this.items,
    String? description,
    List<String>? required,
    this.allOf,
    this.anyOf,
    this.oneOf,
    this.deprecated,
    this.uniqueItems,
    this.readOnly,
    this.writeOnly,
    this.nullable,
    this.xml,
    this.maxLength,
    this.minLength,
    this.maxItems,
    this.minItems,
    this.minProperties,
    this.maxProperties,
    this.maximum,
    this.minimum,
    this.pattern,
    this.defaultValue,
    this.example,
    this.discriminator,
    this.title,
    this.goName,
  )   : properties = properties ?? const {},
        required = required ?? const [],
        description = description ?? '',
        enums = _nullIfEmpty(enums?.whereNotNull().toList());

  factory Schema.fromJson(Map<String, dynamic> json) => _$SchemaFromJson(json);

  static List<Object>? _nullIfEmpty(List<Object>? list) {
    if (list == null || list.isEmpty) {
      return null;
    }
    return list;
  }

  @override
  String toString() =>
      'Schema(description: $description, type: $type, format: $format, properties: $properties)';
}
