part of 'mobile_login_bloc.dart';

@immutable
sealed class MobileLoginState {}

final class MobileLoginInitial extends MobileLoginState {}

// Loading state
final class MobileLoginLoading extends MobileLoginState {}

// Success state
final class MobileLoginSuccess extends MobileLoginState {
  final String message;
  
  MobileLoginSuccess({required this.message});
}

// Error state
final class MobileLoginError extends MobileLoginState {
  final String error;
  
  MobileLoginError({required this.error});
}
