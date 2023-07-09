import 'package:equatable/equatable.dart';

abstract class GetAvailableTimeEvent extends Equatable {
  const GetAvailableTimeEvent();

  @override
  List<Object> get props => [];
}

class LoadedGetAvailableTimeEvent extends GetAvailableTimeEvent {
  final int id;

  const LoadedGetAvailableTimeEvent({required this.id});
    @override
  List<Object> get props => [id];
}
