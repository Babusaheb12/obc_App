part of 'preowned_car_bloc.dart';

@immutable
sealed class PreownedCarEvent {}

class FetchPreownedCarsEvent extends PreownedCarEvent {
  final String? brandId;
  FetchPreownedCarsEvent({this.brandId});
}
