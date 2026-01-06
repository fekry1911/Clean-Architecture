part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState{}

final class LoginSuccess extends LoginState
{
  final UserNameAndToken loginData;
  LoginSuccess(this.loginData);
}
final class LoginFailure extends LoginState
{
  final String message;
  final int code;
  LoginFailure(this.message,this.code);
}

