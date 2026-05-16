import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import '../../../../Api/Api_url.dart';
import '../../../../Api/ConnectivityService.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(VerifyOtpInitial()) {
    on<SubmitOtpEvent>(_onSubmitOtp);
  }

  Future<void> _onSubmitOtp(SubmitOtpEvent event, Emitter<VerifyOtpState> emit) async {
    // Check for internet connectivity before making API request
    bool isConnected = await ConnectivityService.isConnected();
    if (!isConnected) {
      emit(VerifyOtpError(error: 'No internet connection. Please check your network and try again.'));
      return;
    }

    emit(VerifyOtpLoading());

    try {
      dev.log('Sending OTP verification request to: ${ApiUrls.verifyOtp}', name: 'VerifyOtpBloc');
      dev.log('Request Fields (Form Data): otp=${event.otp}, mobile=${event.mobile}', name: 'VerifyOtpBloc');

      final url = Uri.parse(ApiUrls.verifyOtp);
      final request = http.MultipartRequest('POST', url);
      request.fields['otp'] = event.otp;
      request.fields['mobile'] = event.mobile;
      
      dev.log('Sending POST with Multipart Form Data: otp=${event.otp}, mobile=${event.mobile}', name: 'VerifyOtpBloc');
      
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      dev.log(
        'Response Status: ${response.statusCode}',
        name: 'VerifyOtpBloc',
      );
      dev.log(
        'Response Body: ${response.body}',
        name: 'VerifyOtpBloc',
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        dev.log('API Response Body: $responseBody', name: 'VerifyOtpBloc');
        
        if (responseBody['status'] == true) {
          emit(VerifyOtpSuccess(message: responseBody['msg'] ?? 'OTP verified successfully'));
        } else {
          String errorMessage = responseBody['msg'] ?? 'Failed to verify OTP';
          dev.log('API Error Response: $errorMessage', name: 'VerifyOtpBloc');
          emit(VerifyOtpError(error: 'Server Error: $errorMessage'));
        }
      } else {
        dev.log(
          'OTP verification failed',
          name: 'VerifyOtpBloc',
          level: 1000, // Error level
        );
        emit(VerifyOtpError(error: 'OTP verification failed with status: ${response.statusCode}. Please check your OTP and try again.'));
      }
    } catch (e, stacktrace) {
      dev.log('Exception during OTP verification', name: 'VerifyOtpBloc', error: e, stackTrace: stacktrace);
      if (e is FormatException) {
        emit(VerifyOtpError(error: 'Invalid response format from server'));
      } else {
        emit(VerifyOtpError(error: 'An error occurred: $e'));
      }
    }
  }
}
