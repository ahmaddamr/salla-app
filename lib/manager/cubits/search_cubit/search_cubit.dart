import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_app/models/search_model.dart';
import 'package:salla_app/network/local/cache_helper.dart';
import 'package:salla_app/network/remote/dio_helper.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;
  void searchItem(String text) {
    emit(SearchLoading());
    String token = CacheHelper.getData(key: 'token');
    DioHelper.postData(
            url: 'products/search', data: {'text': text}, token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print('done search ${value.statusMessage}');
      emit(SearchSuccess());
    }).catchError((error) {
      emit(SearchError(error: error));
    });
  }
}
