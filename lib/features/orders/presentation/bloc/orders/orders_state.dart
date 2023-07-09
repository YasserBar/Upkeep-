part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
  
  @override
  List<Object> get props => [];
}
class OrdersInitial extends OrdersState {}
class LoadingOrdersState extends OrdersState {}
class LoadedOrdersState extends  OrdersState{
  final List<MyOrder> orders;
  const LoadedOrdersState(this.orders);
  @override
  List<Object> get props => [orders];
}
class FailureOrdersState extends  OrdersState{
  final String message;

  const FailureOrdersState({required this.message});
  @override
  List<Object> get props => [message];
}