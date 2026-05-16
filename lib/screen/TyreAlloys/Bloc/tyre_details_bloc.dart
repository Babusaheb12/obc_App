import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../../Api/Api_url.dart';
import '../../../../Api/ConnectivityService.dart';
import 'dart:developer' as developer;

part 'tyre_details_event.dart';
part 'tyre_details_state.dart';

class TyreDetailsBloc extends Bloc<TyreDetailsEvent, TyreDetailsState> {
  TyreDetailsBloc() : super(TyreDetailsInitial()) {
    on<FetchTyreDetailsEvent>(_onFetchTyreDetails);
  }

  Future<void> _onFetchTyreDetails(
    FetchTyreDetailsEvent event,
    Emitter<TyreDetailsState> emit,
  ) async {
    final bool isConnected = await ConnectivityService.isConnected();
    if (!isConnected) {
      emit(TyreDetailsError('No internet connection.'));
      return;
    }

    emit(TyreDetailsLoading());

    try {
      developer.log(
        'Fetching tyre details from: ${ApiUrls.tyreDetails}',
        name: 'tyre_details_api',
      );
      developer.log(
        'Request Body: tyre_id=${event.tyreId}',
        name: 'tyre_details_api',
      );

      final response = await http.post(
        Uri.parse(ApiUrls.tyreDetails),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'tyre_id': event.tyreId},
      );

      developer.log(
        'API Response Status: ${response.statusCode}',
        name: 'tyre_details_api',
      );
      developer.log(
        'API Response Body: ${response.body}',
        name: 'tyre_details_api',
      );

      if (response.statusCode != 200) {
        emit(TyreDetailsError('Failed to load data. Status: ${response.statusCode}'));
        return;
      }

      final responseBody = json.decode(response.body);
      
      if (responseBody is Map<String, dynamic>) {
        if (responseBody['status'] == 'success' || responseBody['success'] == true) {
          final data = responseBody['data'];
          if (data is Map<String, dynamic>) {
            emit(TyreDetailsLoaded(data));
          } else if (data is List && data.isNotEmpty) {
            final firstItem = data[0];
            if (firstItem is Map<String, dynamic>) {
              emit(TyreDetailsLoaded(firstItem));
            } else {
              emit(TyreDetailsLoaded(responseBody));
            }
          } else {
            emit(TyreDetailsLoaded(responseBody)); // Fallback to whole response
          }
        } else {
          emit(TyreDetailsError(responseBody['message'] ?? 'Failed to load details.'));
        }
      } else {
        emit(TyreDetailsError('Invalid response format.'));
      }
    } catch (e, stack) {
      developer.log(
        'Error fetching tyre details: $e\n$stack',
        name: 'tyre_details_api',
        error: e,
        stackTrace: stack,
      );
      emit(TyreDetailsError('Something went wrong: ${e.toString()}'));
    }
  }
}
