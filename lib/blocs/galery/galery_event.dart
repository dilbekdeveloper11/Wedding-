part of 'galery_bloc.dart';

abstract class GaleryEvent extends Equatable {
  const GaleryEvent();

  @override
  List<Object> get props => [];
}

class GaleryLoad extends GaleryEvent {}
