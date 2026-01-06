import 'package:clean_architecture/core/const/api_const.dart';
import 'package:clean_architecture/core/data/model/error_response.dart';
import 'package:clean_architecture/featuers/login/data/models/login_request_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/domain/error_entity.dart';
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
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetWorkException();
      }

      // هنا السيرفر رد بس بحالة غلط
      if (e.response?.data != null) {
        ErrorResponse errorResponse=ErrorResponse.fromJson(e.response!.data);

        throw ServerException(errorResponse);
      }

      throw ServerException(
        ErrorResponse(
          message: "Unknown server error",
          data: [],
          status: false,
          code: 500,
        )
      );
    }
  }
}
