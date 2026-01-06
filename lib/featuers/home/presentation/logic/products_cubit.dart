import 'package:bloc/bloc.dart';
import 'package:clean_architecture/featuers/home/domain/repo/get_all_products.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/product_data.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  GetAllProducts getAllProducts;

  ProductsCubit(this.getAllProducts) : super(ProductsInitial());

  Future<void> getAllProductsData() async {
    emit(ProductsLoading());
    var result = await getAllProducts.getAllProducts();
    result.fold(
      (failuer) => emit(ProductsError(failuer.message)),
      (products) => emit(ProductsSuccess(products)),
    );
  }
}
