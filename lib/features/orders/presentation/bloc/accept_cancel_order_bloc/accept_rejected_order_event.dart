part of 'accept_rejected_order_bloc.dart';

abstract class AcceptRejectOrderEvent extends Equatable {
  const AcceptRejectOrderEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class CancelOrderEvent extends AcceptRejectOrderEvent {
  int orderId;

  CancelOrderEvent(this.orderId);

  @override
  List<Object> get props => [orderId];
}

// ignore: must_be_immutable
class AcceptOrderEvent extends AcceptRejectOrderEvent {
  int orderId;

  AcceptOrderEvent(this.orderId);

  @override
  List<Object> get props => [orderId];
}

// ignore: must_be_immutable
class RejectedOrderEvent extends AcceptRejectOrderEvent {
  int orderId;
  RejectedOrderEvent(this.orderId);
  @override
  List<Object> get props => [orderId];
}
