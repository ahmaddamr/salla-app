part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState 
{
  final ShopLoginModel? loginModel;

  LoginSuccess({required this.loginModel});
}

final class LoginError extends LoginState {
  final String error;

  LoginError({required this.error});
}
