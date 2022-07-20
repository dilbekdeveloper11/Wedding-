part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();
  
  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Event> events;

  const EventLoaded(this.events);
}

class EventErorr extends EventState {}
