part of 'car_models_bloc.dart';

@immutable
sealed class CarModelsEvent {}

class FetchCarModelsEvent extends CarModelsEvent {
  final String carMakerId;
  FetchCarModelsEvent({required this.carMakerId});
}
