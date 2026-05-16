part of 'tyre_details_bloc.dart';

@immutable
sealed class TyreDetailsEvent {}

class FetchTyreDetailsEvent extends TyreDetailsEvent {
  final String tyreId;
  FetchTyreDetailsEvent(this.tyreId);
}
