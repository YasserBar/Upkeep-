part of 'propose_new_service_bloc.dart';

abstract class ProposeNewServiceEvent extends Equatable {
  const ProposeNewServiceEvent();

  @override
  List<Object> get props => [];
}

class ProposeNewSuggestionEvent extends ProposeNewServiceEvent {
  final Propose propose;

  const ProposeNewSuggestionEvent(this.propose);

  @override
  List<Object> get props => [propose];
}
