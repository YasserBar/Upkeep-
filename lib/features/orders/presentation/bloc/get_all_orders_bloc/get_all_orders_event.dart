part of 'get_all_orders_bloc.dart';

abstract class GetAllOrdersEvent extends Equatable {
  final int? id;
  final int? foundationId;
  const GetAllOrdersEvent(this.id, this.foundationId);

  @override
  List<Object> get props => [];
}

class GetAllOrderForFoundationEvent extends GetAllOrdersEvent {
  const GetAllOrderForFoundationEvent({required foundationId})
      : super(null, foundationId);
  @override
  List<Object> get props => [foundationId!];
}

class GetAllOrderForServiceEvent extends GetAllOrdersEvent {
  const GetAllOrderForServiceEvent({required id}) : super(id, null);
  @override
  List<Object> get props => [id];
}

class LoadMoreOrderEvent extends GetAllOrdersEvent {
  const LoadMoreOrderEvent({required id, required foundationId}) : super(id, foundationId);
  @override
  List<Object> get props => [];
}

class GetAllOrderInSystemEvent extends GetAllOrdersEvent {
  const GetAllOrderInSystemEvent() : super(null, null);
  @override
  List<Object> get props => [];
}

class LoadMoreOrderInSystemEvent extends GetAllOrdersEvent {
  const LoadMoreOrderInSystemEvent() : super(null, null);
  @override
  List<Object> get props => [];
}
