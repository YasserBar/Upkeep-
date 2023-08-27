part of 'filter_foundations_bloc.dart';

abstract class FilterServicesFoundationsEvent extends Equatable {
  final FilterFoundations filterFoundations;
  const FilterServicesFoundationsEvent(this.filterFoundations);

  @override
  List<Object> get props => [];
}

class LoadedFilterServicesFoundationsEvent extends FilterServicesFoundationsEvent {
  const LoadedFilterServicesFoundationsEvent({required filterFoundations})
      : super(filterFoundations);
  @override
  List<Object> get props => [filterFoundations];
}

class LoadMoreFilterServicesFoundationsEvent extends FilterServicesFoundationsEvent {
  const LoadMoreFilterServicesFoundationsEvent(super.filterFoundations);

  @override
  List<Object> get props => [];
}
