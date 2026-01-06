import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String message;
  final LoginData data;
  final bool status;
  final int code;

  LoginResponse({
    required this.message,
    required this.data,
    required this.status,
    required this.code,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

}

@JsonSerializable()
class LoginData {
  final String token;
  final String username;

  LoginData({
    required this.token,
    required this.username,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

}