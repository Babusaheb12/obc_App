part of 'accessories_details_bloc.dart';

@immutable
sealed class AccessoriesDetailsEvent {}

class FetchAccessoriesDetailsEvent extends AccessoriesDetailsEvent {
  final String accessoryId;
  FetchAccessoriesDetailsEvent(this.accessoryId);
}
