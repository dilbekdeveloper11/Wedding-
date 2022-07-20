part of 'service_bloc.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();
  
  @override
  List<Object> get props => [];
}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final List<Service> services;

  const ServiceLoaded(this.services);
}

class ServiceError extends ServiceState {}


