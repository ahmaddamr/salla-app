// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla_app/models/category_model.dart';
import 'package:salla_app/models/details_model.dart';
import 'package:salla_app/models/fav_screen_model.dart';
import 'package:salla_app/models/favorites_model.dart';
import 'package:salla_app/models/home_model.dart';
import 'package:salla_app/models/login_model.dart';
import 'package:salla_app/network/local/cache_helper.dart';
import 'package:salla_app/network/remote/dio_helper.dart';
import 'package:salla_app/modules/user/home/categories/screen/categories_screen.dart';
import 'package:salla_app/modules/user/home/favourite/screen/favourite_screen.dart';
import 'package:salla_app/modules/user/home/products/screen/products_screen.dart';
import 'package:salla_app/modules/user/home/settings/screen/settings_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  int curerntIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouriteScreen(),
    const SettingsScreen(),
  ];
  void changeScreen(int index) {
    curerntIndex = index;
    emit(HomeChangeBottomNav());
  }

  HomeModel? homeModel;
  CategoryModel? categoryModel;
  FavoritesModel? favoritesModel;
  FavScreenModel? favScreenModel;
  ShopLoginModel? loginModel;
  DetailsModel? detailsModel;
  Map<int, bool> favourites = {};
  void HomeData() {
    // String token = '';
    String? token = CacheHelper.getData(key: 'token');
    emit(HomeLoadingState());
    DioHelper.getData(url: 'home', query: null, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data?.products?.forEach((element) {
        favourites.addAll({element.id ?? 0: element.inFavorites ?? false});
      });
      print(homeModel?.data?.products?[0].description);
      print(homeModel?.data?.banners?[0].image);
      emit(HomeSuccessState(homeModel: homeModel!));
    }).catchError((error) {
      print(error.toString());
      emit(
        HomeErrorState(error: error),
      );
    });
  }

  void categoryData() {
    String token = '';
    DioHelper.getData(url: 'categories', query: null, token: token)
        .then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      print('category done${categoryModel?.status}');
      emit(CategorySuccessState(categoryModel: categoryModel!));
    }).catchError((error) {
      print(error.toString());
      emit(CategoryErrorState(error: error));
    });
  }

  void changeFavourites(int productId) {
    favourites[productId] = !(favourites[productId] ?? false);
    emit(ChangeFaavouriteSuccessState());
    // String token = 'JSGNXGTRCwl5kT5UwVjj1vdm1bwQJlTulmsd4zhaz0hcQAlJCF9cv0QcxllJpVRXXXZG6C';
    String? token = CacheHelper.getData(key: 'token');

    DioHelper.postData(
            url: 'favorites', data: {'product_id': productId}, token: token)
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.data);
      // if (favoritesModel?.status == false) {
      //   favourites[productId] = !(favourites[productId] ?? false);
      // } else {
      fetchFavourite();
      // }
      emit(ChangeFaavouriteSuccessState());

      print(favourites.toString());
      print(favoritesModel?.message);
      print(favoritesModel?.status);
    }).catchError((error) {
      emit(ChangeFaavouriteErrorState(error: error));
    });
  }

  void fetchFavourite() {
    String token = CacheHelper.getData(key: 'token');
    DioHelper.getData(url: 'favorites', token: token).then((value) {
      favScreenModel = FavScreenModel.fromJson(value.data);
      print('done fetching ${value.data}');
      emit(GetFavoriteSuccessState());
    }).catchError((error) {
      emit(GetFavoriteErrorState(error: error));
    });
  }

  void getProfile() {
    emit(GetProfileLoadingState());
    String token = CacheHelper.getData(key: 'token');
    DioHelper.getData(url: 'profile', token: token).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print("Done Profile ${value.data}");
      emit(GetProfileSuccessState());
    }).catchError((error) {
      emit(GetProfileErrorState(error: error));
    });
  }

  void getDetails() {
    String token = CacheHelper.getData(key: 'token');
    DioHelper.getData(url: 'products', token: token).then((value) {
      detailsModel = DetailsModel.fromJson(value.data);
      print('done details ${value.statusMessage}');
      emit(GetDetailsSuccessState());
    }).catchError((error) {
      emit(GetDetailsErrorState(error: error));
    });
  }
}
