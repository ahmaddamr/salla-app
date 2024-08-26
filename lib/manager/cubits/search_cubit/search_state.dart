part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchError extends SearchState {
  final String error;

  SearchError({required this.error});
}

final class SearchSuccess extends SearchState {}
