part of 'tyre_details_bloc.dart';

@immutable
sealed class TyreDetailsState {}

final class TyreDetailsInitial extends TyreDetailsState {}

final class TyreDetailsLoading extends TyreDetailsState {}

final class TyreDetailsLoaded extends TyreDetailsState {
  final Map<String, dynamic> data;
  TyreDetailsLoaded(this.data);
}

final class TyreDetailsError extends TyreDetailsState {
  final String message;
  TyreDetailsError(this.message);
}
