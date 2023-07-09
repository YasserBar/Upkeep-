part of 'filter_foundations_bloc.dart';

abstract class FilterFoundationsEvent extends Equatable {
  final FilterFoundations filterFoundations;
  const FilterFoundationsEvent(this.filterFoundations);

  @override
  List<Object> get props => [];
}

class LoadedFilterFoundationsEvent extends FilterFoundationsEvent {
  const LoadedFilterFoundationsEvent({required filterFoundations})
      : super(filterFoundations);
  @override
  List<Object> get props => [filterFoundations];
}

class LoadMoreFilterFoundationsEvent extends FilterFoundationsEvent {
  const LoadMoreFilterFoundationsEvent(super.filterFoundations);

  @override
  List<Object> get props => [];
}
