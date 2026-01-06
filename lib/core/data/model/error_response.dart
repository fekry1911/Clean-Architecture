import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  final String message;
  final List<dynamic> data;
  final bool status;
  final int code;

  ErrorResponse({
    required this.message,
    required this.data,
    required this.status,
    required this.code,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

}