part of 'stop_foundation_bloc.dart';

abstract class StopFoundationEvent extends Equatable {
  @override
  List<Object> get props => [];

  const StopFoundationEvent();
}
class DoStopFoundationEvent extends StopFoundationEvent {
  final int id;

  const DoStopFoundationEvent(this.id);

  @override
  List<Object> get props => [id];
}
