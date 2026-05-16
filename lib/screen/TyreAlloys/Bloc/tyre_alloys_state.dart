part of 'tyre_alloys_bloc.dart';

class TyreAlloysState {
  final List<TyreAlloyItem> tyres;
  final List<TyreAlloyItem> alloys;
  final bool isTyreLoading;
  final bool isAlloyLoading;
  final String? error;

  TyreAlloysState({
    this.tyres = const [],
    this.alloys = const [],
    this.isTyreLoading = false,
    this.isAlloyLoading = false,
    this.error,
  });

  TyreAlloysState copyWith({
    List<TyreAlloyItem>? tyres,
    List<TyreAlloyItem>? alloys,
    bool? isTyreLoading,
    bool? isAlloyLoading,
    String? error,
  }) {
    return TyreAlloysState(
      tyres: tyres ?? this.tyres,
      alloys: alloys ?? this.alloys,
      isTyreLoading: isTyreLoading ?? this.isTyreLoading,
      isAlloyLoading: isAlloyLoading ?? this.isAlloyLoading,
      error: error,
    );
  }
}

class TyreAlloyItem {
  final String id;
  final String image;
  final String brand;
  final String title;
  final String wheel;
  final String sellingPrice;
  final String price;
  final String origin;
  final List<String> galleryImages;

  TyreAlloyItem({
    required this.id,
    required this.image,
    required this.brand,
    required this.title,
    required this.wheel,
    required this.sellingPrice,
    required this.price,
    required this.origin,
    required this.galleryImages,
  });

  factory TyreAlloyItem.fromJson(Map<String, dynamic> json) {
    return TyreAlloyItem(
      id: json['tyre_id']?.toString() ?? '',
      image: json['tyre_image']?.toString() ?? '',
      brand: json['tyre_brand']?.toString() ?? '',
      title: json['tyre_title']?.toString() ?? '',
      wheel: json['tyre_wheel']?.toString() ?? '',
      sellingPrice: json['tyre_sellingprice']?.toString() ?? '',
      price: json['tyre_price']?.toString() ?? '',
      origin: json['tyre_origin']?.toString() ?? '',
      galleryImages: (json['gallery_images'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
