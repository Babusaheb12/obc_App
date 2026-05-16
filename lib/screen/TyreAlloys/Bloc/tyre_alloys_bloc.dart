import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../../Api/Api_url.dart';
import '../../../../Api/ConnectivityService.dart';
import 'dart:developer' as developer;

part 'tyre_alloys_event.dart';
part 'tyre_alloys_state.dart';

class TyreAlloysBloc extends Bloc<TyreAlloysEvent, TyreAlloysState> {
  TyreAlloysBloc() : super(TyreAlloysState()) {
    on<FetchTyreAlloysEvent>(_onFetchTyreAlloys);
  }

  Future<void> _onFetchTyreAlloys(
    FetchTyreAlloysEvent event,
    Emitter<TyreAlloysState> emit,
  ) async {
    final bool isConnected = await ConnectivityService.isConnected();
    if (!isConnected) {
      emit(state.copyWith(error: 'No internet connection.'));
      return;
    }

    if (event.type == 'tyre') {
      emit(state.copyWith(isTyreLoading: true, error: null));
    } else {
      emit(state.copyWith(isAlloyLoading: true, error: null));
    }

    try {
      developer.log(
        'Fetching tyre/alloys from: ${ApiUrls.tyreAlloys} with type: ${event.type}',
        name: 'tyre_alloys_api',
      );

      final response = await http.post(
        Uri.parse(ApiUrls.tyreAlloys),
        body: {'tyre_alloy': event.type},
      );

      developer.log(
        'API Response Status: ${response.statusCode}',
        name: 'tyre_alloys_api',
      );
      developer.log(
        'API Response Body: ${response.body}',
        name: 'tyre_alloys_api',
      );

      if (response.statusCode != 200) {
        emit(
          state.copyWith(
            isTyreLoading: false,
            isAlloyLoading: false,
            error: 'Failed to load data. Status: ${response.statusCode}',
          ),
        );
        return;
      }

      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final bool success = responseBody['status'] == 'success';

      if (!success) {
        final message =
            responseBody['message']?.toString() ??
            'API returned unsuccessful response';
        emit(
          state.copyWith(
            isTyreLoading: false,
            isAlloyLoading: false,
            error: message,
          ),
        );
        return;
      }

      List<TyreAlloyItem> items = [];
      if (responseBody['data'] is List) {
        items = (responseBody['data'] as List)
            .whereType<Map<String, dynamic>>()
            .map((item) => TyreAlloyItem.fromJson(item))
            .toList();
      }

      developer.log(
        'Successfully loaded ${items.length} items for type: ${event.type}',
        name: 'tyre_alloys_api',
      );

      if (event.type == 'tyre') {
        emit(
          state.copyWith(
            tyres: items,
            isTyreLoading: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            alloys: items,
            isAlloyLoading: false,
          ),
        );
      }
    } catch (e, stack) {
      developer.log(
        'Error fetching tyre/alloys: $e\n$stack',
        name: 'tyre_alloys_api',
        error: e,
        stackTrace: stack,
      );
      emit(
        state.copyWith(
          isTyreLoading: false,
          isAlloyLoading: false,
          error: 'Something went wrong: ${e.toString()}',
        ),
      );
    }
  }
}
