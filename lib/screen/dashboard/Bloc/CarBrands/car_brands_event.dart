part of 'car_brands_bloc.dart';

@immutable
sealed class CarBrandsEvent {}

class FetchCarBrandsEvent extends CarBrandsEvent {}
