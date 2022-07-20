import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wedding_app/data/event_location.dart';
import 'package:wedding_app/services/location_service.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final _locationService = LocationService();
  LocationBloc() : super(LocationInitial()) {
    on<LocationLoad>((event, emit)  async{
       emit(LocationLoading());
      try {
        final eventList = await _locationService.getLocations(id: event.id);
        emit(LocationLoaded(eventList));
      } catch (e) {
        emit(LocationError());
      }
    });
  }
}
