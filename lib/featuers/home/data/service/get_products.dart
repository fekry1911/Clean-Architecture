import 'package:clean_architecture/core/const/api_const.dart';
import 'package:clean_architecture/core/data/model/error_response.dart';
import 'package:clean_architecture/featuers/home/data/model/products_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/exception.dart';

class GetProductsService {
  Dio dio;

  GetProductsService(this.dio);

  Future<List<Product>> getAllProducts() async {
    try {
      Response response = await dio.get(ApiConst.products);
      final List<dynamic> data = response.data as List<dynamic>;

      final List<Product> products = data
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();

      return products;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.connectionError) {
        print(e.type);
        throw NetWorkException();
      }
      if (e.response?.data != null) {
        print(e.response!.data);
        ErrorResponse errorResponse = ErrorResponse.fromJson(e.response!.data);
        throw ServerException(errorResponse);
      }
      print(e.type);
      throw ServerException(
        ErrorResponse(
          message: "Unknown server error",
          data: [],
          status: false,
          code: 500,
        ),
      );
    } catch (e) {
      print(e);
      throw ServerException(
        ErrorResponse(
          message: "UnDefined Error",
          data: [],
          status: false,
          code: 500,
        ),
      );
    }
  }
}
