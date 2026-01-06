import 'package:clean_architecture/core/network/dio_config.dart';
import 'package:clean_architecture/featuers/home/data/repo_impl/get_all_products_impl.dart';
import 'package:clean_architecture/featuers/home/data/service/get_products.dart';
import 'package:clean_architecture/featuers/home/domain/repo/get_all_products.dart';
import 'package:clean_architecture/featuers/home/presentation/logic/products_cubit.dart';
import 'package:clean_architecture/featuers/login/data/data_source/login_service.dart';
import 'package:clean_architecture/featuers/login/data/repo/login_repo_impl.dart';
import 'package:clean_architecture/featuers/login/domain/repo/logi_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../featuers/login/presentation/logic/login_cubit.dart';
import '../network/dio_config_products.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  final dioAuth = DioConfig.instance.dio;
  final dioProducts = DioConfigProducts.instance.dio;

  getIt.registerLazySingleton<Dio>(
        () => dioAuth,
    instanceName: 'authDio',
  );

  getIt.registerLazySingleton<Dio>(
        () => dioProducts,
    instanceName: 'productsDio',
  );

  // services
  getIt.registerLazySingleton<LoginService>(
        () => LoginService(getIt<Dio>(instanceName: 'authDio')),
  );

  getIt.registerLazySingleton<GetProductsService>(
        () => GetProductsService(getIt<Dio>(instanceName: 'productsDio')),
  );

  // repos
  getIt.registerLazySingleton<LoginRepo>(
        () => LoginUserImpl(getIt<LoginService>()),
  );

  getIt.registerLazySingleton<GetAllProducts>(
        () => GetAllProductsImpl(getIt<GetProductsService>()),
  );

  // cubits
  getIt.registerFactory<LoginCubit>(
        () => LoginCubit(getIt<LoginRepo>()),
  );

  getIt.registerFactory<ProductsCubit>(
        () => ProductsCubit(getIt<GetAllProducts>()),
  );
}
