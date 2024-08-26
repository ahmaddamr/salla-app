import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_app/models/register_model.dart';
import 'package:salla_app/network/remote/dio_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  RegisterModel? registerModel;
  // String token = CacheHelper.getData(key: 'token');
  void userRegister(
      {required String name,
      required String email,
      required String phone,
      required String password}) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: 'register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      print("Register Done ${value.data}");
      emit(RegisterSuccessState(registerModel: registerModel!));
    }).catchError(
      (error) {
        emit(
          RegisterErrorState(error: error),
        );
      },
    );
  }
}
