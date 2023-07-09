part of 'foundation_services_bloc.dart';

abstract class FoundationServicesEvent extends Equatable {
  final int foundationId;
  const FoundationServicesEvent(this.foundationId);

  @override
  List<Object> get props => [];
}

class GetAllServiceForFoundationEvent extends FoundationServicesEvent {
  const GetAllServiceForFoundationEvent({required foundationId}) : super(foundationId);

  @override
  List<Object> get props => [foundationId];
}

class LoadMoreServiceForFoundationEvent extends FoundationServicesEvent {
  const LoadMoreServiceForFoundationEvent(super.foundationId);

  @override
  List<Object> get props => [];
}