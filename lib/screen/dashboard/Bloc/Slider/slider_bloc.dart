import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../../Api/Api_url.dart';
import '../../../../Api/ConnectivityService.dart';
import 'dart:developer' as developer;
part 'slider_event.dart';
part 'slider_state.dart';

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  SliderBloc() : super(SliderInitial()) {
    on<FetchSliderEvent>(_onFetchSlider);
  }

  Future<void> _onFetchSlider(
      FetchSliderEvent event,
      Emitter<SliderState> emit,
      ) async {
    final bool isConnected = await ConnectivityService.isConnected();
    if (!isConnected) {
      emit(SliderError('No internet connection. Please check your network and try again.'));
      return;
    }

    emit(SliderLoading());

    try {
      developer.log(
        'Fetching slider data from: ${ApiUrls.slider}',
        name: 'slider_api',
      );

      final response = await http.get(
        Uri.parse(ApiUrls.slider),
        headers: {'Content-Type': 'application/json'},
      );

      developer.log(
        'API Response Status: ${response.statusCode}',
        name: 'slider_api',
      );
      developer.log(
        'API Response Body: ${response.body}',
        name: 'slider_api',
      );

      if (response.statusCode != 200) {
        emit(SliderError('Failed to load data. Status: ${response.statusCode}'));
        return;
      }

      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final bool success = responseBody['success'] == true;

      if (!success) {
        final message = responseBody['message']?.toString() ?? 'API returned unsuccessful response';
        emit(SliderError(message));
        return;
      }

      // ── Preferred: use pre-filtered keys from backend
      List<String> sliderImgs = _extractUrlList(responseBody['slider']);
      List<String> offerImgs = _extractUrlList(responseBody['offer']);

      // ── Fallback: parse from 'data' if the nice keys are missing
      if (sliderImgs.isEmpty && responseBody['data'] is List) {
        sliderImgs = _extractImages(responseBody['data'] as List, 'slider');
      }
      if (offerImgs.isEmpty && responseBody['data'] is List) {
        offerImgs = _extractImages(responseBody['data'] as List, 'offer');
      }

      emit(SliderLoaded(
        sliderImages: sliderImgs.isNotEmpty ? sliderImgs : [],
        offerImages: offerImgs.isNotEmpty ? offerImgs : [],
      ));
    } catch (e, stack) {
      developer.log(
        'Error fetching slider: $e\n$stack',
        name: 'slider_api',
        error: e,
        stackTrace: stack,
      );
      emit(SliderError('Something went wrong: ${e.toString()}'));
    }
  }

  // Helper: safely extract image URLs from a list that may be null/malformed
  List<String> _extractUrlList(dynamic value) {
    if (value is! List) return [];
    return value
        .whereType<Map<String, dynamic>>()
        .map((e) => e['image']?.toString() ?? '')
        .where((url) => url.trim().isNotEmpty)
        .toList();
  }

  // Fallback helper: filter by 'type'
  List<String> _extractImages(List<dynamic> items, String desiredType) {
    return items
        .whereType<Map<String, dynamic>>()
        .where((item) => item['type'] == desiredType)
        .map((item) => item['image']?.toString() ?? '')
        .where((url) => url.trim().isNotEmpty)
        .toList();
  }
}
