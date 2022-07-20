part of 'galery_bloc.dart';

abstract class GaleryState extends Equatable {
  const GaleryState();
  
  @override
  List<Object> get props => [];
}

class GaleryInitial extends GaleryState {}

class GaleryLoading extends GaleryState {}

class GaleryLoaded extends GaleryState {
  final List<Galery> galeries;

  const GaleryLoaded(this.galeries);
}

class GaleryErorr extends GaleryState {}
