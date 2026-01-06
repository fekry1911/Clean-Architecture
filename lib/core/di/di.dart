import 'package:clean_architecture/core/network/dio_config.dart';
import 'package:clean_architecture/featuers/login/data/data_source/login_service.dart';
import 'package:clean_architecture/featuers/login/data/repo/login_repo_impl.dart';
import 'package:clean_architecture/featuers/login/domain/repo/logi_repo.dart';
import 'package:clean_architecture/featuers/login/presentation/logic/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  Dio dio = DioConfig.instance.dio;
  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<LoginService>(() => LoginService(getIt()));
  getIt.registerLazySingleton<LoginRepo>(
    () => LoginUserImpl(getIt<LoginService>()),
  );
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginRepo>()));
}
