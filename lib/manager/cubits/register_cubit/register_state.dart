part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitialState extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterSuccessState extends RegisterState 
{
  RegisterModel registerModel;
  RegisterSuccessState({required this.registerModel});
}

final class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState({required this.error});
}
