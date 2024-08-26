import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_app/models/login_model.dart';
import 'package:salla_app/network/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? shopLoginModel;

  void userLogin({required email, required password}) {
    emit(LoginLoading());
    DioHelper.postData(
        url: 'login',
        data: {"email": email, "password": password}).then((value) {
      print(value.data);
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      print(shopLoginModel?.message);
      print(shopLoginModel?.data?.token);
      emit(LoginSuccess(loginModel: shopLoginModel));
    }).catchError((error) {
      print(error.toString());
      emit(
        LoginError(
          error: error.toString(),
        ),
      );
    });
  }
}
