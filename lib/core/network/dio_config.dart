import 'package:dio/dio.dart';

import '../const/api_const.dart';

class DioConfig {
  DioConfig._();

  late Dio dio;
  static final DioConfig instance = DioConfig._();


  Future<void> init() async {
    dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return status != null && status < 400; // يقبل 304
        },
        baseUrl: ApiConst.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
  }
}
