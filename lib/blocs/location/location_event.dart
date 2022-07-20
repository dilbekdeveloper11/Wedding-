part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationLoad extends LocationEvent {
  final int id;

  const LocationLoad(this.id);
}
