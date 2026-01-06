

import 'package:clean_architecture/featuers/login/data/models/login_request_model.dart';
import 'package:clean_architecture/featuers/login/data/models/login_response.dart';

import '../../domain/entity/user_token.dart';

extension LoginMapper on LoginResponse {
  UserNameAndToken toEntity() {
    return UserNameAndToken(data.username, data.token);
  }
}
