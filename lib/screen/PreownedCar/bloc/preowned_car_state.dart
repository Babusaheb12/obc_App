part of 'preowned_car_bloc.dart';

@immutable
sealed class PreownedCarState {}

final class PreownedCarInitial extends PreownedCarState {}

final class PreownedCarLoading extends PreownedCarState {}

final class PreownedCarLoaded extends PreownedCarState {
  final List<PreownedCarItem> cars;
  PreownedCarLoaded(this.cars);
}

final class PreownedCarError extends PreownedCarState {
  final String message;
  PreownedCarError(this.message);
}

class PreownedCarItem {
  final String id;
  final String title;
  final String brand;
  final String model;
  final String year;
  final String km;
  final String price;
  final String image;
  final String location;
  final String variant;
  final String ownership;
  final String contactNumber;
  final String description;

  PreownedCarItem({
    required this.id,
    required this.title,
    required this.brand,
    required this.model,
    required this.year,
    required this.km,
    required this.price,
    required this.image,
    required this.location,
    required this.variant,
    required this.ownership,
    required this.contactNumber,
    required this.description,
  });

  factory PreownedCarItem.fromJson(Map<String, dynamic> json) {
    return PreownedCarItem(
      id: json['pr_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      brand: json['car_maker_name']?.toString() ?? '',
      model: json['car_model_name']?.toString() ?? '',
      year: json['car_year']?.toString() ?? '',
      km: json['km_driven']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      location: json['city']?.toString() ?? '',
      variant: json['car_variant_name']?.toString() ?? '',
      ownership: json['ownership']?.toString() ?? '',
      contactNumber: json['contact_number']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }
}
