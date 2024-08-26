part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeChangeBottomNav extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState({required this.error});
}

final class HomeSuccessState extends HomeState {
  final HomeModel homeModel;

  HomeSuccessState({required this.homeModel});
}

final class CategorySuccessState extends HomeState {
  final CategoryModel categoryModel;

  CategorySuccessState({required this.categoryModel});
}

final class CategoryErrorState extends HomeState {
  final String error;

  CategoryErrorState({required this.error});
}

final class ChangeFaavouriteSuccessState extends HomeState {}

final class ChangeFaavouriteErrorState extends HomeState {
  final String error;

  ChangeFaavouriteErrorState({required this.error});
}

final class GetFavoriteSuccessState extends HomeState {}

final class GetFavoriteErrorState extends HomeState {
  final String error;

  GetFavoriteErrorState({required this.error});
}

final class GetProfileLoadingState extends HomeState {}

final class GetProfileSuccessState extends HomeState {}

final class GetProfileErrorState extends HomeState {
  final String error;

  GetProfileErrorState({required this.error});
}

final class GetDetailsSuccessState extends HomeState {}

final class GetDetailsErrorState extends HomeState {
  final String error;

  GetDetailsErrorState({required this.error});
}
