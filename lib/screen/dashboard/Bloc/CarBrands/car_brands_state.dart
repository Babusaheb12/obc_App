part of 'car_brands_bloc.dart';

@immutable
sealed class CarBrandsState {}

final class CarBrandsInitial extends CarBrandsState {}

final class CarBrandsLoading extends CarBrandsState {}

final class CarBrandsLoaded extends CarBrandsState {
  final List<CarBrand> brands;
  
  CarBrandsLoaded({required this.brands});
}

final class CarBrandsError extends CarBrandsState {
  final String message;
  CarBrandsError(this.message);
}

// Model class for car brand data
class CarBrand {
  final String id;
  final String name;
  final String imageUrl;
  
  CarBrand({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
  
  factory CarBrand.fromJson(Map<String, dynamic> json) {
    return CarBrand(
      id: json['id']?.toString() ?? '',
      name: json['car_maker_name']?.toString() ?? '',
      imageUrl: json['car_maker_image']?.toString() ?? '',
    );
  }
}
