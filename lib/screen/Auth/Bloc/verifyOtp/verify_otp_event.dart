part of 'verify_otp_bloc.dart';

@immutable
sealed class VerifyOtpEvent {}

class SubmitOtpEvent extends VerifyOtpEvent {
  final String otp;
  final String mobile;
  SubmitOtpEvent({required this.otp, required this.mobile});
}
