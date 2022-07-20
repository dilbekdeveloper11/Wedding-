import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wedding_app/data/galery.dart';

import '../../services/galery_service.dart';

part 'galery_event.dart';
part 'galery_state.dart';

class GaleryBloc extends Bloc<GaleryEvent, GaleryState> {
  final GaleryService _galeryService = GaleryService();

  GaleryBloc() : super(GaleryInitial()) {
    on<GaleryLoad>((event, emit) async {
      emit(GaleryLoading());
      try {
        final galeries = await _galeryService.getGalery();
        emit(GaleryLoaded(galeries));
      } catch (e) {
        emit(GaleryErorr());
      }
    });
  }
}
