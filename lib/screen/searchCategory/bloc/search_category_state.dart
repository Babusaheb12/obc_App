part of 'search_category_bloc.dart';

class SearchCategoryState {
  final List<CategoryModel> categories;
  final List<SubCategoryModel> subCategories;
  final bool isLoadingCategories;
  final bool isLoadingSubCategories;
  final String? errorMessage;

  SearchCategoryState({
    this.categories = const [],
    this.subCategories = const [],
    this.isLoadingCategories = false,
    this.isLoadingSubCategories = false,
    this.errorMessage,
  });

  SearchCategoryState copyWith({
    List<CategoryModel>? categories,
    List<SubCategoryModel>? subCategories,
    bool? isLoadingCategories,
    bool? isLoadingSubCategories,
    String? errorMessage,
  }) {
    return SearchCategoryState(
      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      isLoadingSubCategories: isLoadingSubCategories ?? this.isLoadingSubCategories,
      errorMessage: errorMessage,
    );
  }
}

