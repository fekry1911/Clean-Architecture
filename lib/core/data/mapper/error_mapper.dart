import 'package:clean_architecture/core/domain/error_entity.dart';

import '../model/error_response.dart';

extension ErrorMapper on ErrorResponse {
  ErrorModel toEntity (){
    return ErrorModel(message, code);
  }
}