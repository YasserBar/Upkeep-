part of 'get_jop_foundation_bloc.dart';

abstract class GetJopFoundationEvent extends Equatable {
    final int id;
  const GetJopFoundationEvent(this.id);

  @override
  List<Object> get props => [];
}

class ShowAllJopsForFoundationEvent extends GetJopFoundationEvent {

  const ShowAllJopsForFoundationEvent({required id}) : super(id);

  @override
  List<Object> get props => [id];
}

class LoadMoreJopsForFoundationEvent extends GetJopFoundationEvent {
  const LoadMoreJopsForFoundationEvent(super.id);

  @override
  List<Object> get props => [];
}