part of 'mobile_login_bloc.dart';

@immutable
sealed class MobileLoginEvent {}

// Event to trigger mobile login
final class SendOtpEvent extends MobileLoginEvent {
  final String mobile;

  SendOtpEvent({required this.mobile});
}
