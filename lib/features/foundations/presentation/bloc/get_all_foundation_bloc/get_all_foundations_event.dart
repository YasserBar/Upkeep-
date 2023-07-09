part of 'get_all_foundations_bloc.dart';

abstract class GetAllFoundationsEvent extends Equatable {
  const GetAllFoundationsEvent();
  @override
  List<Object> get props => [];
}

class GetAllFoundationOwnerEvent extends GetAllFoundationsEvent {
  const GetAllFoundationOwnerEvent();

  @override
  List<Object> get props => [];
}

class LoadMoreFoundationOwnerEvent extends GetAllFoundationsEvent {
  const LoadMoreFoundationOwnerEvent();

  @override
  List<Object> get props => [];
}
