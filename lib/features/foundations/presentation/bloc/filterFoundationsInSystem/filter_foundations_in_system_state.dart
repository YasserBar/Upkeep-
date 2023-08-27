part of 'filter_foundations_in_system_bloc.dart';

abstract class FilterFoundationsInSystemState extends Equatable {
  final List<Foundation>? foundations;
  final bool hasMore;
  final bool loaded;
  const FilterFoundationsInSystemState(this.foundations, this.hasMore, this.loaded);

  @override
  List<Object> get props => [foundations!, hasMore, loaded];
}

class FilterFoundationsInSystemInitial extends FilterFoundationsInSystemState {
  const FilterFoundationsInSystemInitial(
      super.foundations, super.hasMore, super.loaded);
}

class LoadingFilterFoundationsInSystemState extends FilterFoundationsInSystemState {
  const LoadingFilterFoundationsInSystemState(
      super.foundations, super.hasMore, super.loaded);
}

class FailureFilterFoundationsInSystemState extends FilterFoundationsInSystemState {
  final String message;

  const FailureFilterFoundationsInSystemState({required this.message})
      : super(null, false, true);
  @override
  List<Object> get props => [message];
}

class LoadedFilterFoundationsInSystemState extends FilterFoundationsInSystemState {
  const LoadedFilterFoundationsInSystemState(
      {required foundations, required hasMore, required loaded})
      : super(foundations, hasMore, loaded);
  @override
  List<Object> get props => [foundations!, hasMore, loaded];
}
