part of 'accept_rejected_order_bloc.dart';

abstract class AcceptRejectOrderState extends Equatable {
  const AcceptRejectOrderState();

  @override
  List<Object> get props => [];
}

class AcceptRejectOrderInitial extends AcceptRejectOrderState {}

class LoadingAcceptRejectOrderState extends AcceptRejectOrderState {
  const LoadingAcceptRejectOrderState();

  @override
  List<Object> get props => [];
}

class SuccessAcceptRejectOrderState extends AcceptRejectOrderState {
  final String message;

  const SuccessAcceptRejectOrderState(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorAcceptRejectOrderState extends AcceptRejectOrderState {
  final String message;

  const ErrorAcceptRejectOrderState(this.message);

  @override
  List<Object> get props => [message];
}
