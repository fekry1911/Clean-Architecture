import 'package:clean_architecture/core/data/mapper/error_mapper.dart';
import 'package:clean_architecture/core/domain/error_entity.dart';
import 'package:clean_architecture/core/network/exception.dart';
import 'package:clean_architecture/core/network/failuer.dart';
import 'package:clean_architecture/featuers/home/data/mapper/productModel.dart';
import 'package:clean_architecture/featuers/home/data/service/get_products.dart';
import 'package:clean_architecture/featuers/home/domain/entity/product_data.dart';
import 'package:clean_architecture/featuers/home/domain/repo/get_all_products.dart';
import 'package:dartz/dartz.dart';

class GetAllProductsImpl extends GetAllProducts {
  GetProductsService api;

  GetAllProductsImpl(this.api);

  @override
  Future<Either<Failuer, List<ProductsResponseData>>> getAllProducts() async {
    try {
      var data = await api.getAllProducts();
      List<ProductsResponseData> products = data
          .map((product) => product.toEntity())
          .toList();
      return right(products);
    } on NetWorkException catch (e) {
      return left(NetWorkFailuer("something went wrong", 500));
    } on ServerException catch (e) {
      ErrorModel errorModel = e.data.toEntity();

      return left(ServerFailuer(errorModel.message, errorModel.code));
    }
  }
}
