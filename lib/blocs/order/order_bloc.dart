import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wedding_app/services/order_service.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final _orderService = OrderService();
  OrderBloc() : super(OrderInitial()) {
    on<OrderLoad>((event, emit) async {
      emit(OrderLoading());

      try {
        await _orderService.sendOrder(event.id, event.serives);
        emit(OrderLoaded());
      } catch (e) {
        emit(OrderError());
      }
    });
  }
}
