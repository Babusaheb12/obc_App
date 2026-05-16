import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import '../../../Api/Api_url.dart';
import '../../../Api/ConnectivityService.dart';
import '../../Spares/model/category_model.dart';
import '../model/sub_category_model.dart';

part 'search_category_event.dart';
part 'search_category_state.dart';

class SearchCategoryBloc extends Bloc<SearchCategoryEvent, SearchCategoryState> {
  SearchCategoryBloc() : super(SearchCategoryState()) {
    on<FetchCategoriesEvent>(_onFetchCategories);
    on<FetchSubCategoriesEvent>(_onFetchSubCategories);
  }

  Future<void> _onFetchCategories(
    FetchCategoriesEvent event,
    Emitter<SearchCategoryState> emit,
  ) async {
    final bool isConnected = await ConnectivityService.isConnected();
    if (!isConnected) {
      emit(state.copyWith(errorMessage: 'No internet connection. Please check your network and try again.'));
      return;
    }

    emit(state.copyWith(isLoadingCategories: true));

    try {
      developer.log(
        'Fetching category data from: ${ApiUrls.category}',
        name: 'category_api',
      );

      final response = await http.get(
        Uri.parse(ApiUrls.category),
        headers: {'Content-Type': 'application/json'},
      );

      developer.log(
        'API Response Status: ${response.statusCode}',
        name: 'category_api',
      );
      
      developer.log(
        '''
================ CATEGORY API RESPONSE ================

${response.body}

=====================================================
''',
        name: 'category_api',
      );

      if (response.statusCode != 200) {
        emit(state.copyWith(isLoadingCategories: false, errorMessage: 'Failed to load data. Status: ${response.statusCode}'));
        return;
      }

      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final bool success = responseBody['success'] == true;

      if (!success) {
        final message = responseBody['message']?.toString() ?? 'API returned unsuccessful response';
        emit(state.copyWith(isLoadingCategories: false, errorMessage: message));
        return;
      }

      final data = responseBody['data'] as List;
      final categories = data.map((e) => CategoryModel.fromJson(e)).toList();

      emit(state.copyWith(isLoadingCategories: false, categories: categories));
    } catch (e, stack) {
      developer.log(
        'Error fetching categories: $e\n$stack',
        name: 'category_api',
        error: e,
        stackTrace: stack,
      );
      emit(state.copyWith(isLoadingCategories: false, errorMessage: 'Something went wrong: ${e.toString()}'));
    }
  }


  Future<void> _onFetchSubCategories(
    FetchSubCategoriesEvent event,
    Emitter<SearchCategoryState> emit,
  ) async {
    final bool isConnected = await ConnectivityService.isConnected();
    if (!isConnected) {
      emit(state.copyWith(errorMessage: 'No internet connection. Please check your network and try again.'));
      return;
    }

    emit(state.copyWith(isLoadingSubCategories: true));

    try {
      developer.log(
        'Fetching subcategory data from: ${ApiUrls.subcategory}',
        name: 'subcategory_api',
      );
      developer.log(
        'Request Body: {category_id: ${event.categoryId}}',
        name: 'subcategory_api',
      );

      final response = await http.post(
        Uri.parse(ApiUrls.subcategory),
        body: {'category_id': event.categoryId},
      );

      developer.log(
        'API Response Status: ${response.statusCode}',
        name: 'subcategory_api',
      );
      
      developer.log(
        '''
================ SUBCATEGORY API RESPONSE ================

${response.body}

=====================================================
''',
        name: 'subcategory_api',
      );

      if (response.statusCode != 200) {
        emit(state.copyWith(isLoadingSubCategories: false, errorMessage: 'Failed to load data. Status: ${response.statusCode}'));
        return;
      }

      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final bool success = responseBody['success'] == true;

      if (!success) {
        final message = responseBody['message']?.toString() ?? 'API returned unsuccessful response';
        emit(state.copyWith(isLoadingSubCategories: false, errorMessage: message));
        return;
      }

      final data = responseBody['data'] as List;
      final subCategories = data.map((e) => SubCategoryModel.fromJson(e)).toList();

      emit(state.copyWith(isLoadingSubCategories: false, subCategories: subCategories));
    } catch (e, stack) {
      developer.log(
        'Error fetching subcategories: $e\n$stack',
        name: 'subcategory_api',
        error: e,
        stackTrace: stack,
      );
      emit(state.copyWith(isLoadingSubCategories: false, errorMessage: 'Something went wrong: ${e.toString()}'));
    }
  }
}
