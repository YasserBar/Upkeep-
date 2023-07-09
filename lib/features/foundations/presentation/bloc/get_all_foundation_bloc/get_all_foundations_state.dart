part of 'get_all_foundations_bloc.dart';

abstract class GetAllFoundationsState extends Equatable {
  final List<Foundation>? foundations;
  final bool hasMore;
  final bool loaded;
  const GetAllFoundationsState(this.foundations, this.hasMore, this.loaded);
  @override
  List<Object> get props => [foundations!, hasMore];
}

class GetAllFoundationsInitial extends GetAllFoundationsState {
  const GetAllFoundationsInitial(
      super.foundations, super.hasMore, super.loaded);
}

class LoadingGetAllFoundationsState extends GetAllFoundationsState {
  const LoadingGetAllFoundationsState(
      super.foundations, super.hasMore, super.loaded);
}

class ErrorGetAllFoundationsState extends GetAllFoundationsState {
  final String message;

  const ErrorGetAllFoundationsState(
      super.foundations, super.hasMore, super.loaded,
      {required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessGetAllFoundationsState extends GetAllFoundationsState {
  const SuccessGetAllFoundationsState(
      {required foundations, required hasMore, required loaded})
      : super(foundations, hasMore, loaded);

  @override
  List<Object> get props => [foundations!, hasMore, loaded];
}
