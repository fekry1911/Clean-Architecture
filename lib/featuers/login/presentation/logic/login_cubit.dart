import 'package:bloc/bloc.dart';
import 'package:clean_architecture/featuers/login/data/models/login_response.dart';
import 'package:meta/meta.dart';

import '../../data/models/login_request_model.dart';
import '../../domain/entity/user_token.dart';
import '../../domain/repo/logi_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());
  final LoginRepo loginRepo;

  Future<void> loginUser(LoginCredentials loginModel) async {
    emit(LoginLoading());
    var result = await loginRepo.loginUser(loginModel);
    result.fold(
      (failuer) {
        emit(LoginFailure(failuer.message,failuer.code));
      },
      (loginData) {
        emit(LoginSuccess(loginData));
      },
    );
  }
}
