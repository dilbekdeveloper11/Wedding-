import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wedding_app/data/service.dart';

import '../../services/service_service.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final _serviceService = ServiceService();
  ServiceBloc() : super(ServiceInitial()) {
    on<ServiceLoad>((event, emit)async {
      emit(ServiceLoading());
      try{
        final serviceList = await _serviceService.getServices();
        emit(ServiceLoaded(serviceList));
      }catch(e){
        emit(ServiceError());
      }
    });
  }
}
