import 'package:clean_architecture/core/network/exception.dart';
import 'package:clean_architecture/core/network/failuer.dart';
import 'package:clean_architecture/featuers/login/data/mapper/login_mapper.dart';
import 'package:clean_architecture/featuers/login/data/models/login_request_model.dart';
import 'package:clean_architecture/featuers/login/data/models/login_response.dart';
import 'package:clean_architecture/featuers/login/domain/entity/user_token.dart';
import 'package:clean_architecture/featuers/login/domain/repo/logi_repo.dart';
import 'package:dartz/dartz.dart';

import '../data_source/login_service.dart';

class LoginUserImpl extends LoginRepo {
  final LoginService loginService;

  LoginUserImpl(this.loginService);

  @override
  Future<Either<Failuer, UserNameAndToken>> loginUser(
    LoginCredentials loginModel,
  ) async {
    try {
      LoginResponse loginResponse = await loginService.loginUser(loginModel);
      print(loginResponse);
      return right(loginResponse.toEntity());
    } on NetWorkException {
      return left(NetWorkFailuer("something went wrong"));
    } catch (_) {
      return left(ServerFailuer("something went wrong"));
    }
  }
}
