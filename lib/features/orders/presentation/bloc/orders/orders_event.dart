part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}
class GetAllOrdersEvent extends OrdersEvent {
}
class CancelOrderEvent extends OrdersEvent{}

