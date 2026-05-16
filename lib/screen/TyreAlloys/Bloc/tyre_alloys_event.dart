part of 'tyre_alloys_bloc.dart';

@immutable
sealed class TyreAlloysEvent {}

class FetchTyreAlloysEvent extends TyreAlloysEvent {
  final String type; // 'tyre' or 'alloy'
  
  FetchTyreAlloysEvent({required this.type});
}
