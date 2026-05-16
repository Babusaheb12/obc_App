part of 'getspares_bloc.dart';

sealed class GetsparesState {}

final class GetsparesInitial extends GetsparesState {}

final class CategoryLoading extends GetsparesState {}

final class CategoryLoaded extends GetsparesState {
  final List<CategoryModel> categories;

  CategoryLoaded(this.categories);
}

final class CategoryError extends GetsparesState {
  final String message;

  CategoryError(this.message);
}
