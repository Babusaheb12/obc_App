import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'dart:developer' as dev; // 1. Import the developer library
import 'package:http/http.dart' as http;
import '../../../../Api/Api_url.dart';
import '../../../../Api/ConnectivityService.dart';

part 'mobile_login_event.dart';
part 'mobile_login_state.dart';

class MobileLoginBloc extends Bloc<MobileLoginEvent, MobileLoginState> {
  MobileLoginBloc() : super(MobileLoginInitial()) {
    on<SendOtpEvent>(_onSendOtp);
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<MobileLoginState> emit) async {
    String cleanMobile = event.mobile.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (!_isValidMobile(event.mobile)) {
      emit(MobileLoginError(error: 'Please enter a valid 10-digit Indian mobile number (starting with 6-9)'));
      return;
    }

    // Check for internet connectivity before making API request
    bool isConnected = await ConnectivityService.isConnected();
    if (!isConnected) {
      emit(MobileLoginError(error: 'No internet connection. Please check your network and try again.'));
      return;
    }

    emit(MobileLoginLoading());

    try {
      dev.log('Cleaned mobile: $cleanMobile, length: ${cleanMobile.length}', name: 'MobileLoginBloc');
      dev.log('Sending OTP request to: ${ApiUrls.mobileLogin}', name: 'MobileLoginBloc');
      dev.log('Request body: {"mobile": "$cleanMobile"} (10-digit format)', name: 'MobileLoginBloc');

      // Use MultipartRequest for form-data as requested
      final url = Uri.parse(ApiUrls.mobileLogin);
      final request = http.MultipartRequest('POST', url);
      request.fields['mobile'] = cleanMobile;
      
      dev.log('Sending POST with Multipart Form Data: mobile=$cleanMobile', name: 'MobileLoginBloc');
      
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      dev.log(
        'Response Status: ${response.statusCode}',
        name: 'MobileLoginBloc',
      );
      dev.log(
        'Response Body: ${response.body}',
        name: 'MobileLoginBloc',
      );

      if (response.statusCode == 200) {
        // Parse the response to check API status
        final responseBody = jsonDecode(response.body);
        dev.log('API Response Body: $responseBody', name: 'MobileLoginBloc');
        
        if (responseBody['status'] == true) {
          emit(MobileLoginSuccess(message: 'OTP sent successfully'));
        } else {
          String errorMessage = responseBody['msg'] ?? 'Failed to send OTP';
          dev.log('API Error Response: $errorMessage', name: 'MobileLoginBloc');
          emit(MobileLoginError(error: 'Server Error: $errorMessage'));
        }
      } else {
        dev.log(
          'OTP request failed',
          name: 'MobileLoginBloc',
          level: 1000, // Error level
        );
        emit(MobileLoginError(error: 'OTP request failed with status: ${response.statusCode}. Please check your mobile number and try again.'));
      }
    } catch (e, stacktrace) {
      // 2. Log the actual error and stacktrace for easier debugging
      dev.log('Exception during OTP request', name: 'MobileLoginBloc', error: e, stackTrace: stacktrace,);
      if (e is FormatException) {
        emit(MobileLoginError(error: 'Invalid response format from server'));
      } else {
        emit(MobileLoginError(error: 'An error occurred: $e'));
      }
    }
  }

  bool _isValidMobile(String mobile) {
    String cleanMobile = mobile.replaceAll(RegExp(r'[^0-9]'), '');
    // Log the cleaned mobile number for debugging
    dev.log('Validation - Original: $mobile, Cleaned: $cleanMobile, Length: ${cleanMobile.length}', name: 'MobileLoginBloc');
    bool isValid = cleanMobile.length == 10 && RegExp(r'^[6-9]').hasMatch(cleanMobile);
    dev.log('Validation result: $isValid', name: 'MobileLoginBloc');
    return isValid;
  }
}