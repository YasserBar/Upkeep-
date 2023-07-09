part of 'subservice_bloc.dart';

abstract class SubServiceEvent extends Equatable {
  final int serviceId;
  const SubServiceEvent(this.serviceId);

  @override
  List<Object> get props => [serviceId];
}

class GetAllSubServiceEvent extends SubServiceEvent {
  const GetAllSubServiceEvent(serviceId) : super(serviceId);

  @override
  List<Object> get props => [serviceId];
}

class LoadMoreSubServiceEvent extends SubServiceEvent {
  const LoadMoreSubServiceEvent(super.serviceId);

  @override
  List<Object> get props => [];
}
