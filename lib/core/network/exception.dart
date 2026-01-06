import 'package:clean_architecture/core/data/model/error_response.dart';

import '../domain/error_entity.dart';

class NetWorkException<T> implements Exception{

}
class ServerException<T> implements Exception{
  ErrorResponse data;
  ServerException(this.data);
}