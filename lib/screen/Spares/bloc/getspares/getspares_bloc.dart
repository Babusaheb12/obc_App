import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import '../../../../Api/Api_url.dart';
import '../../../../Api/ConnectivityService.dart';
import '../../model/category_model.dart';

part 'getspares_event.dart';
part 'getspares_state.dart';

class GetsparesBloc extends Bloc<GetsparesEvent, GetsparesState> {
  GetsparesBloc() : super(GetsparesInitial()) {
    on<FetchCategoryEvent>(_onFetchCategory);
  }

  Future<void> _onFetchCategory(
    FetchCategoryEvent event,
    Emitter<GetsparesState> emit,
  ) async {
    final bool isConnected = await ConnectivityService.isConnected();
    if (!isConnected) {
      emit(CategoryError('No internet connection. Please check your network and try again.'));
      return;
    }

    emit(CategoryLoading());

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
      
      // ✅ FULL RESPONSE SEPARATE
      developer.log(
        '''
================ CATEGORY API RESPONSE ================

${response.body}

=====================================================
''',
        name: 'category_api',
      );

      if (response.statusCode != 200) {
        emit(CategoryError('Failed to load data. Status: ${response.statusCode}'));
        return;
      }

      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final bool success = responseBody['success'] == true;

      if (!success) {
        final message = responseBody['message']?.toString() ?? 'API returned unsuccessful response';
        emit(CategoryError(message));
        return;
      }

      final data = responseBody['data'] as List;
      final categories = data.map((e) => CategoryModel.fromJson(e)).toList();

      emit(CategoryLoaded(categories));
    } catch (e, stack) {
      developer.log(
        'Error fetching categories: $e\n$stack',
        name: 'category_api',
        error: e,
        stackTrace: stack,
      );
      emit(CategoryError('Something went wrong: ${e.toString()}'));
    }
  }
}
