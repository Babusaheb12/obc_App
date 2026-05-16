part of 'car_accessories_bloc.dart';

@immutable
sealed class CarAccessoriesEvent {}

class FetchCarAccessoriesEvent extends CarAccessoriesEvent {}
