part of 'orders_customer_bloc.dart';

abstract class OrdersCustomerState extends Equatable {
  final List<MyOrder>? myOrders;
  final bool hasMore;
  final bool loaded;
  const OrdersCustomerState(this.myOrders, this.hasMore, this.loaded);

  @override
  List<Object> get props => [myOrders!, hasMore, loaded];
}

class OrdersCustomerInitial extends OrdersCustomerState {
  const OrdersCustomerInitial(super.myOrders, super.hasMore, super.loaded);
}

class LoadingOrdersCustomerState extends OrdersCustomerState {
  const LoadingOrdersCustomerState(super.myOrders, super.hasMore, super.loaded);
}

class FailureOrdersCustomerState extends OrdersCustomerState {
  final String message;

  const FailureOrdersCustomerState({required this.message})
      : super(null, false, true);
  @override
  List<Object> get props => [message];
}

class MessageOrdersCustomerState extends OrdersCustomerState {
  final String message;

  const MessageOrdersCustomerState({required this.message})
      : super(null, false, true);
  @override
  List<Object> get props => [message];
}

class LoadedOrdersCustomerState extends OrdersCustomerState {
  const LoadedOrdersCustomerState(
      {required myOrders, required hasMore, required loaded})
      : super(myOrders, hasMore, loaded);
  @override
  List<Object> get props => [myOrders!, hasMore, loaded];
}
