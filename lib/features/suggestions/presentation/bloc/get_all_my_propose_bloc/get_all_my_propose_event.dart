part of 'get_all_my_propose_bloc.dart';

abstract class GetAllMyProposeEvent extends Equatable {
  const GetAllMyProposeEvent();
  @override
  List<Object> get props => [];
}

class GetAllMySuggestionEvent extends GetAllMyProposeEvent {
  final int foundationId;

  final int page;

  @override
  List<Object> get props => [foundationId, page];

  const GetAllMySuggestionEvent(this.foundationId, this.page);
}
