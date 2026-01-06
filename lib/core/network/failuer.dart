abstract class Failuer{
  String message;
  Failuer(this.message);
}

class NetWorkFailuer extends Failuer{
  NetWorkFailuer(super.message);
}

class ServerFailuer extends Failuer{
  ServerFailuer(super.message);


}