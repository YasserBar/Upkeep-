part of 'get_all_orders_bloc.dart';

abstract class GetAllOrdersState extends Equatable {
  final List<MyOrder>? myOrders;
  final bool hasMore;
  final bool loaded;
  const GetAllOrdersState(this.myOrders, this.hasMore, this.loaded);

  @override
  List<Object> get props => [myOrders!, hasMore, loaded];
}

class GetAllOrdersInitial extends GetAllOrdersState {
  const GetAllOrdersInitial(super.myOrders, super.hasMore, super.loaded);

  @override
  List<Object> get props => [];
}

class LoadingGetAllOrdersState extends GetAllOrdersState {
  const LoadingGetAllOrdersState(super.myOrders, super.hasMore, super.loaded);

  @override
  List<Object> get props => [];
}

class ErrorGetAllOrdersState extends GetAllOrdersState {
  final String message;

  const ErrorGetAllOrdersState(this.message) : super(null, false, true);

  @override
  List<Object> get props => [message];
}

class SuccessGetAllOrdersState extends GetAllOrdersState {
  const SuccessGetAllOrdersState(
      {required myOrders, required hasMore, required loaded})
      : super(myOrders, hasMore, loaded);

  @override
  List<Object> get props => [myOrders!, hasMore, loaded];
}
