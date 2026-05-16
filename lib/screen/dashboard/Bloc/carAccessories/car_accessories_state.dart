part of 'car_accessories_bloc.dart';

@immutable
sealed class CarAccessoriesState {}

final class CarAccessoriesInitial extends CarAccessoriesState {}

final class CarAccessoriesLoading extends CarAccessoriesState {}

final class CarAccessoriesLoaded extends CarAccessoriesState {
  final List<CarAccessory> accessories;
  
  CarAccessoriesLoaded({required this.accessories});
}

final class CarAccessoriesError extends CarAccessoriesState {
  final String message;
  CarAccessoriesError(this.message);
}

class CarAccessory {
  final String id;
  final String name;
  final String image;
  final String price;
  final String sellingPrice;
  final String origin;
  final String description;
  final String featured;

  CarAccessory({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.sellingPrice,
    required this.origin,
    required this.description,
    required this.featured,
  });

  factory CarAccessory.fromJson(Map<String, dynamic> json) {
    return CarAccessory(
      id: json['access_id']?.toString() ?? '',
      name: json['ass_name']?.toString() ?? '',
      image: json['ass_image']?.toString() ?? '',
      price: json['ass_pro_price']?.toString() ?? '',
      sellingPrice: json['ass_pro_selling_price']?.toString() ?? '',
      origin: json['ass_pro_origin']?.toString() ?? '',
      description: json['ass_description']?.toString() ?? '',
      featured: json['ass_pro_featured']?.toString() ?? '',
    );
  }
}
