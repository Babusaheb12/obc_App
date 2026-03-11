part of 'slider_bloc.dart';

@immutable
sealed class SliderState {}

final class SliderInitial extends SliderState {}

final class SliderLoading extends SliderState {}

final class SliderLoaded extends SliderState {
  final List<String> sliderImages;   // for hero carousel
  final List<String> offerImages;    // for promo banners

  SliderLoaded({
    required this.sliderImages,
    required this.offerImages,
  });
}

final class SliderError extends SliderState {
  final String message;
  SliderError(this.message);
}
