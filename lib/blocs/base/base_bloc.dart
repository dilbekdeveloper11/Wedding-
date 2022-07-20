import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wedding_app/data/base.dart';

import '../../services/base_service.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  final  _baseService = BaseService();
  BaseBloc() : super(BaseInitial()) {
    on<BaseLoad>((event, emit)async {
      emit(BaseLoading());
      try {
        final baseList = await _baseService.getBase();
        emit(BaseLoaded(baseList));
      } catch (e) {
        emit(BaseError());
      }
    });
  }
}
