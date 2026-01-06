import 'package:dio/dio.dart';

import '../const/api_const.dart';

class DioConfigProducts {
  DioConfigProducts._();

  late Dio dio;
  static final DioConfigProducts instance = DioConfigProducts._();


  Future<void> init() async {
    dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return status != null && status < 400; // يقبل 304
        },
        baseUrl: ApiConst.baseUrl2,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
  }
}
