part of 'orders_customer_bloc.dart';

abstract class OrdersCustomerEvent extends Equatable {
  final int? orderId;
  final int? assessment;
  const OrdersCustomerEvent(this.orderId, this.assessment);

  @override
  List<Object> get props => [];
}

class GetAllOrdersEvent extends OrdersCustomerEvent {
  const GetAllOrdersEvent() : super(null, null);
}

class LoadMoreOrdersEvent extends OrdersCustomerEvent {
  const LoadMoreOrdersEvent() : super(null, null);

  @override
  List<Object> get props => [];
}

class CancelOrderEvent extends OrdersCustomerEvent {
  const CancelOrderEvent({required orderId}) : super(orderId, null);
  @override
  List<Object> get props => [orderId!];
}

class SetAssessmentEvent extends OrdersCustomerEvent {
  const SetAssessmentEvent({required orderId, required assessment})
      : super(orderId, assessment);
  @override
  List<Object> get props => [orderId!, assessment!];
}
