import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wedding_app/data/event.dart';
import 'package:wedding_app/services/event_service.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventService _eventService = EventService();

  EventBloc() : super(EventInitial()) {
    on<EventLoad>((event, emit) async {
      emit(EventLoading());
      try {
        final eventList = await _eventService.getEvents();
        emit(EventLoaded(eventList));
      } catch (e) {
        emit(EventErorr());
      }
    });
  }
}
