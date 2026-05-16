part of 'accessories_details_bloc.dart';

@immutable
sealed class AccessoriesDetailsState {}

final class AccessoriesDetailsInitial extends AccessoriesDetailsState {}

final class AccessoriesDetailsLoading extends AccessoriesDetailsState {}

final class AccessoriesDetailsLoaded extends AccessoriesDetailsState {
  final Map<String, dynamic> data;
  AccessoriesDetailsLoaded(this.data);
}

final class AccessoriesDetailsError extends AccessoriesDetailsState {
  final String message;
  AccessoriesDetailsError(this.message);
}
