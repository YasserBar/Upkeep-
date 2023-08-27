part of 'filter_foundations_bloc.dart';

abstract class FilterServicesFoundationsState extends Equatable {
  final List<ServiceFoundation>? servicefoundations;
  final bool hasMore;
  final bool loaded;
  const FilterServicesFoundationsState(this.servicefoundations, this.hasMore, this.loaded);

  @override
  List<Object> get props => [servicefoundations!, hasMore, loaded];
}

class FilterFoundationsInitial extends FilterServicesFoundationsState {
  const FilterFoundationsInitial(
      super.servicefoundations, super.hasMore, super.loaded);
}

class LoadingFilterServicesFoundationsState extends FilterServicesFoundationsState {
  const LoadingFilterServicesFoundationsState(
      super.servicefoundations, super.hasMore, super.loaded);
}

class FailureFilterServicesFoundationsState extends FilterServicesFoundationsState {
  final String message;

  const FailureFilterServicesFoundationsState({required this.message})
      : super(null, false, true);
  @override
  List<Object> get props => [message];
}

class LoadedFilterServicesFoundationsState extends FilterServicesFoundationsState {
  const LoadedFilterServicesFoundationsState(
      {required foundations, required hasMore, required loaded})
      : super(foundations, hasMore, loaded);
  @override
  List<Object> get props => [servicefoundations!, hasMore, loaded];
}
