import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../../Api/Api_url.dart';
import '../../../../Api/ConnectivityService.dart';
import 'dart:developer' as developer;

part 'accessories_details_event.dart';
part 'accessories_details_state.dart';

class AccessoriesDetailsBloc extends Bloc<AccessoriesDetailsEvent, AccessoriesDetailsState> {
  AccessoriesDetailsBloc() : super(AccessoriesDetailsInitial()) {
    on<FetchAccessoriesDetailsEvent>(_onFetchAccessoriesDetails);
  }

  Future<void> _onFetchAccessoriesDetails(
    FetchAccessoriesDetailsEvent event,
    Emitter<AccessoriesDetailsState> emit,
  ) async {
    final bool isConnected = await ConnectivityService.isConnected();
    if (!isConnected) {
      emit(AccessoriesDetailsError('No internet connection.'));
      return;
    }

    emit(AccessoriesDetailsLoading());

    try {
      developer.log(
        'Fetching accessory details from: ${ApiUrls.getSingleAccessories}',
        name: 'accessories_details_api',
      );
      developer.log(
        'Request Body: accessory_id=${event.accessoryId}',
        name: 'accessories_details_api',
      );

      final response = await http.post(
        Uri.parse(ApiUrls.getSingleAccessories),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'accessory_id': event.accessoryId},
      );

      developer.log(
        'API Response Status: ${response.statusCode}',
        name: 'accessories_details_api',
      );
      developer.log(
        'API Response Body: ${response.body}',
        name: 'accessories_details_api',
      );

      if (response.statusCode != 200) {
        emit(AccessoriesDetailsError('Failed to load data. Status: ${response.statusCode}'));
        return;
      }

      final responseBody = json.decode(response.body);
      
      if (responseBody is Map<String, dynamic>) {
        if (responseBody['success'] == true || responseBody['status'] == 'success') {
          final data = responseBody['data'];
          if (data is Map<String, dynamic>) {
            emit(AccessoriesDetailsLoaded(data));
          } else {
            emit(AccessoriesDetailsError('Invalid data format in response.'));
          }
        } else {
          emit(AccessoriesDetailsError(responseBody['message'] ?? 'Failed to load details.'));
        }
      } else {
        emit(AccessoriesDetailsError('Invalid response format.'));
      }
    } catch (e, stack) {
      developer.log(
        'Error fetching accessory details: $e\n$stack',
        name: 'accessories_details_api',
        error: e,
        stackTrace: stack,
      );
      emit(AccessoriesDetailsError('Something went wrong: ${e.toString()}'));
    }
  }
}
