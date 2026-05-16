part of 'verify_otp_bloc.dart';

@immutable
sealed class VerifyOtpState {}

final class VerifyOtpInitial extends VerifyOtpState {}

final class VerifyOtpLoading extends VerifyOtpState {}

final class VerifyOtpSuccess extends VerifyOtpState {
  final String message;
  VerifyOtpSuccess({required this.message});
}

final class VerifyOtpError extends VerifyOtpState {
  final String error;
  VerifyOtpError({required this.error});
}
