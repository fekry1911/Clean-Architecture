import 'package:clean_architecture/featuers/home/data/model/products_model.dart';
import 'package:clean_architecture/featuers/home/domain/entity/product_data.dart';

extension ProductMapper on Product{
  ProductsResponseData toEntity() {
    return ProductsResponseData(
      id,
      title,
      price,
      image,
    );
  }
}