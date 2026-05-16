part of 'search_category_bloc.dart';

sealed class SearchCategoryEvent {}

class FetchCategoriesEvent extends SearchCategoryEvent {}

class FetchSubCategoriesEvent extends SearchCategoryEvent {
  final String categoryId;

  FetchSubCategoriesEvent(this.categoryId);
}
