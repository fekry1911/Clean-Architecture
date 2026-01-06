import 'package:clean_architecture/core/domain/error_entity.dart';

abstract class Failuer{
  String message;
  int code;
  Failuer(this.message,this.code);
}

class NetWorkFailuer extends Failuer{
  NetWorkFailuer(super.message, super.code);
}

class ServerFailuer extends Failuer{
  ServerFailuer(super.message, super.code);
}