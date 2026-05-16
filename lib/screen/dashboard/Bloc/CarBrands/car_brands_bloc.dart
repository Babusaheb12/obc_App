import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../../Api/Api_url.dart';
import '../../../../Api/ConnectivityService.dart';
import 'dart:developer' as developer;

part 'car_brands_event.dart';

part 'car_brands_state.dart';

class CarBrandsBloc extends Bloc<CarBrandsEvent, CarBrandsState> {
  CarBrandsBloc() : super(CarBrandsInitial()) {
    on<FetchCarBrandsEvent>(_onFetchCarBrands);
  }

  Future<void> _onFetchCarBrands(
    FetchCarBrandsEvent event,
    Emitter<CarBrandsState> emit,
  ) async {
    final bool isConnected = await ConnectivityService.isConnected();
    if (!isConnected) {
      emit(
        CarBrandsError(
          'No internet connection. Please check your network and try again.',
        ),
      );
      return;
    }

    emit(CarBrandsLoading());

    try {
      // ✅ API REQUEST LOG
      developer.log(
        'Fetching car brands data from: ${ApiUrls.carBrandLogo}',
        name: 'car_brands_api',
      );

      final response = await http.get(
        Uri.parse(ApiUrls.carBrandLogo),
        headers: {'Content-Type': 'application/json'},
      );

      // ✅ API RESPONSE LOGS
      developer.log(
        'API Response Status: ${response.statusCode}',
        name: 'car_brands_api',
      );
      developer.log(
        'API Response Body: ${response.body}',
        name: 'car_brands_api',
      );

      // ✅ SEPARATE RESPONSE LOG
      developer.log('''
================ CAR BRANDS API RESPONSE ================

${response.body}

=========================================================
''', name: 'car_brands_api');

      if (response.statusCode != 200) {
        emit(
          CarBrandsError(
            'Failed to load car brands. Status: ${response.statusCode}',
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
        emit(CarBrandsError(message));
        return;
      }

      // Parse car brands data
      List<CarBrand> brands = [];
      if (responseBody['data'] is List) {
        brands = (responseBody['data'] as List)
            .whereType<Map<String, dynamic>>()
            .map((item) => CarBrand.fromJson(item))
            .where((brand) => brand.id.isNotEmpty && brand.name.isNotEmpty)
            .toList();
      }

      // ✅ SUCCESS LOG
      developer.log(
        'Successfully loaded ${brands.length} car brands',
        name: 'car_brands_api',
      );

      emit(CarBrandsLoaded(brands: brands));
    } catch (e, stack) {
      // ✅ ERROR LOG
      developer.log(
        'Error fetching car brands: $e\n$stack',
        name: 'car_brands_api',
        error: e,
        stackTrace: stack,
      );
      emit(CarBrandsError('Something went wrong: ${e.toString()}'));
    }
  }
}
