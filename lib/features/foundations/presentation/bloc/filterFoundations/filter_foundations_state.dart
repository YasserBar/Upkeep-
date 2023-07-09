part of 'filter_foundations_bloc.dart';

abstract class FilterFoundationsState extends Equatable {
  final List<Foundation>? foundations;
  final bool hasMore;
  final bool loaded;
  const FilterFoundationsState(this.foundations, this.hasMore, this.loaded);

  @override
  List<Object> get props => [foundations!, hasMore, loaded];
}

class FilterFoundationsInitial extends FilterFoundationsState {
  const FilterFoundationsInitial(
      super.foundations, super.hasMore, super.loaded);
}

class LoadingFilterFoundationsState extends FilterFoundationsState {
  const LoadingFilterFoundationsState(
      super.foundations, super.hasMore, super.loaded);
}

class FailureFilterFoundationsState extends FilterFoundationsState {
  final String message;

  const FailureFilterFoundationsState({required this.message})
      : super(null, false, true);
  @override
  List<Object> get props => [message];
}

class LoadedFilterFoundationsState extends FilterFoundationsState {
  const LoadedFilterFoundationsState(
      {required foundations, required hasMore, required loaded})
      : super(foundations, hasMore, loaded);
  @override
  List<Object> get props => [foundations!, hasMore, loaded];
}
