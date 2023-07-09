part of 'get_all_my_propose_bloc.dart';

abstract class GetAllMyProposeState extends Equatable {
  const GetAllMyProposeState();

  @override
  List<Object> get props => [];
}

class GetAllMyProposeInitial extends GetAllMyProposeState {
  @override
  List<Object> get props => [];
}

class LoadingGetAllMyPropose extends GetAllMyProposeState {
  @override
  List<Object> get props => [];
}

class ErrorGetAllMyPropose extends GetAllMyProposeState {
  final String message;

  const ErrorGetAllMyPropose({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessGetAllMyPropose extends GetAllMyProposeState {
  final List<MySuggestion> mySuggestion;

  const SuccessGetAllMyPropose(this.mySuggestion);

  @override
  List<Object> get props => [mySuggestion];
}
