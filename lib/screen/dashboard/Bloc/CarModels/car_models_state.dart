part of 'car_models_bloc.dart';

@immutable
sealed class CarModelsState {}

final class CarModelsInitial extends CarModelsState {}

final class CarModelsLoading extends CarModelsState {}

final class CarModelsLoaded extends CarModelsState {
  final List<CarModel> models;
  
  CarModelsLoaded({required this.models});
}

final class CarModelsError extends CarModelsState {
  final String message;
  CarModelsError(this.message);
}

class CarModel {
  final String id;
  final String makerId;
  final String name;
  final String image;
  
  CarModel({
    required this.id,
    required this.makerId,
    required this.name,
    required this.image,
  });
  
  factory CarModel.fromJson(Map<String, dynamic> json) {
    String img = json['car_model_image']?.toString() ?? '';
    if (img.isNotEmpty && !img.startsWith('http')) {
      img = ApiUrls.imageBaseUrl + img;
    }
    return CarModel(
      id: json['car_id']?.toString() ?? '',
      makerId: json['car_maker_id']?.toString() ?? '',
      name: json['car_model_name']?.toString() ?? '',
      image: img,
    );
  }
}
