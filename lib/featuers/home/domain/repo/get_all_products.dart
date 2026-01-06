import 'package:clean_architecture/core/network/failuer.dart';
import 'package:dartz/dartz.dart';

import '../entity/product_data.dart';

abstract class GetAllProducts{
  Future<Either<Failuer,List<ProductsResponseData>>> getAllProducts();
}