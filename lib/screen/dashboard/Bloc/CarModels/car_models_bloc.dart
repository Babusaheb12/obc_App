import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../../Api/Api_url.dart';
import '../../../../Api/ConnectivityService.dart';
import 'dart:developer' as developer;

part 'car_models_event.dart';
part 'car_models_state.dart';

class CarModelsBloc extends Bloc<CarModelsEvent, CarModelsState> {
  CarModelsBloc() : super(CarModelsInitial()) {
    on<FetchCarModelsEvent>(_onFetchCarModels);
  }

  Future<void> _onFetchCarModels(
    FetchCarModelsEvent event,
    Emitter<CarModelsState> emit,
  ) async {
    final bool isConnected = await ConnectivityService.isConnected();
    if (!isConnected) {
      emit(
        CarModelsError(
          'No internet connection. Please check your network and try again.',
        ),
      );
      return;
    }

    emit(CarModelsLoading());

    try {
      developer.log(
        'Fetching car models for maker: ${event.carMakerId} from: ${ApiUrls.carModel}',
        name: 'car_models_api',
      );

      final response = await http.post(
        Uri.parse(ApiUrls.carModel),
        body: {'car_maker_id': event.carMakerId},
      );

      developer.log(
        'API Response Status: ${response.statusCode}',
        name: 'car_models_api',
      );
      developer.log(
        'API Response Body: ${response.body}',
        name: 'car_models_api',
      );

      if (response.statusCode != 200) {
        emit(
          CarModelsError(
            'Failed to load car models. Status: ${response.statusCode}',
          ),
        );
        return;
      }

      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final bool hasError = responseBody['error'] == true;

      if (hasError) {
        final message =
            responseBody['message']?.toString() ??
            'API returned error response';
        emit(CarModelsError(message));
        return;
      }

      List<CarModel> models = [];
      if (responseBody['data'] is List) {
        models = (responseBody['data'] as List)
            .whereType<Map<String, dynamic>>()
            .map((item) => CarModel.fromJson(item))
            .toList();
      }

      developer.log(
        'Successfully loaded ${models.length} car models',
        name: 'car_models_api',
      );

      emit(CarModelsLoaded(models: models));
    } catch (e, stack) {
      developer.log(
        'Error fetching car models: $e\n$stack',
        name: 'car_models_api',
        error: e,
        stackTrace: stack,
      );
      emit(CarModelsError('Something went wrong: ${e.toString()}'));
    }
  }
}
