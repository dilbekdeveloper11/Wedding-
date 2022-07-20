part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderLoad extends OrderEvent {
  final int id;
  final List serives;

  const OrderLoad({required this.id, required this.serives});
}
