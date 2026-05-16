import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../../Api/Api_url.dart';
import '../../../../Api/ConnectivityService.dart';
import 'dart:developer' as developer;

part 'car_accessories_event.dart';
part 'car_accessories_state.dart';

class CarAccessoriesBloc extends Bloc<CarAccessoriesEvent, CarAccessoriesState> {
  CarAccessoriesBloc() : super(CarAccessoriesInitial()) {
    on<FetchCarAccessoriesEvent>(_onFetchCarAccessories);
  }

  Future<void> _onFetchCarAccessories(
    FetchCarAccessoriesEvent event,
    Emitter<CarAccessoriesState> emit,
  ) async {
    final bool isConnected = await ConnectivityService.isConnected();
    if (!isConnected) {
      emit(
        CarAccessoriesError(
          'No internet connection. Please check your network and try again.',
        ),
      );
      return;
    }

    emit(CarAccessoriesLoading());

    try {
      developer.log(
        'Fetching car accessories from: ${ApiUrls.carAccessories}',
        name: 'car_accessories_api',
      );

      final response = await http.get(
        Uri.parse(ApiUrls.carAccessories),
      );

      developer.log(
        'API Response Status: ${response.statusCode}',
        name: 'car_accessories_api',
      );
      developer.log(
        'API Response Body: ${response.body}',
        name: 'car_accessories_api',
      );

      if (response.statusCode != 200) {
        emit(
          CarAccessoriesError(
            'Failed to load accessories. Status: ${response.statusCode}',
          ),
        );
        return;
      }

      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final bool success = responseBody['success'] == true;

      if (!success) {
        final message =
            responseBody['message']?.toString() ??
            'API returned unsuccessful response';
        emit(CarAccessoriesError(message));
        return;
      }

      List<CarAccessory> accessories = [];
      if (responseBody['data'] is List) {
        accessories = (responseBody['data'] as List)
            .whereType<Map<String, dynamic>>()
            .map((item) => CarAccessory.fromJson(item))
            .toList();
      }

      developer.log(
        'Successfully loaded ${accessories.length} accessories',
        name: 'car_accessories_api',
      );

      emit(CarAccessoriesLoaded(accessories: accessories));
    } catch (e, stack) {
      developer.log(
        'Error fetching car accessories: $e\n$stack',
        name: 'car_accessories_api',
        error: e,
        stackTrace: stack,
      );
      emit(CarAccessoriesError('Something went wrong: ${e.toString()}'));
    }
  }
}
