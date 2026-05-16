import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../../Api/Api_url.dart';
import '../../../../Api/ConnectivityService.dart';
import 'dart:developer' as developer;

part 'preowned_car_event.dart';
part 'preowned_car_state.dart';

class PreownedCarBloc extends Bloc<PreownedCarEvent, PreownedCarState> {
  PreownedCarBloc() : super(PreownedCarInitial()) {
    on<FetchPreownedCarsEvent>(_onFetchPreownedCars);
  }

  Future<void> _onFetchPreownedCars(
    FetchPreownedCarsEvent event,
    Emitter<PreownedCarState> emit,
  ) async {
    final bool isConnected = await ConnectivityService.isConnected();
    if (!isConnected) {
      emit(PreownedCarError('No internet connection.'));
      return;
    }

    emit(PreownedCarLoading());

    try {
      final uri = Uri.parse(ApiUrls.getPreownedCars).replace(queryParameters: {
        if (event.brandId != null) 'brand_id': event.brandId!,
      });

      developer.log(
        'Fetching preowned cars from: $uri',
        name: 'preowned_car_api',
      );

      final response = await http.get(uri);

      developer.log(
        'API Response Status: ${response.statusCode}',
        name: 'preowned_car_api',
      );
      developer.log(
        'API Response Body: ${response.body}',
        name: 'preowned_car_api',
      );

      if (response.statusCode != 200) {
        emit(PreownedCarError('Failed to load data. Status: ${response.statusCode}'));
        return;
      }

      final responseBody = json.decode(response.body);
      
      List<PreownedCarItem> cars = [];
      
      if (responseBody is Map<String, dynamic>) {
        final data = responseBody['data'];
        if (data is List) {
          cars = data.map((item) => PreownedCarItem.fromJson(item)).toList();
        }
      } else if (responseBody is List) {
        cars = responseBody.map((item) => PreownedCarItem.fromJson(item)).toList();
      }

      developer.log(
        'Successfully loaded ${cars.length} preowned cars',
        name: 'preowned_car_api',
      );

      emit(PreownedCarLoaded(cars));
    } catch (e, stack) {
      developer.log(
        'Error fetching preowned cars: $e\n$stack',
        name: 'preowned_car_api',
        error: e,
        stackTrace: stack,
      );
      emit(PreownedCarError('Something went wrong: ${e.toString()}'));
    }
  }
}
