import 'package:clean_architecture/featuers/login/data/models/login_request_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/failuer.dart';
import '../../data/models/login_response.dart';
import '../entity/user_token.dart';

abstract class LoginRepo{
 Future<Either<Failuer,UserNameAndToken>> loginUser(LoginCredentials loginModel);
}