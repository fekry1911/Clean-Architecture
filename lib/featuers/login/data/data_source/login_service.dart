import 'package:clean_architecture/core/const/api_const.dart';
import 'package:clean_architecture/featuers/login/data/models/login_request_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/exception.dart';
import '../models/login_response.dart';

class LoginService {
  final Dio dio;

  LoginService(this.dio);

  Future<LoginResponse> loginUser(LoginCredentials loginModel) async {
    try {
      final response = await dio.post(
        ApiConst.login,
        data: loginModel.toJson(),
      );

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      // Network errors
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetWorkException();
      }

      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }
}
