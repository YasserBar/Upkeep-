
import 'package:equatable/equatable.dart';

import '../../../domain/entities/date.dart';

abstract class GetAvailableTimeState extends Equatable {
  const GetAvailableTimeState();

  @override
  List<Object> get props => [];
}
class GetAvailableTimeInitial extends  GetAvailableTimeState{}
class LoadingGetAvailableTimeState extends GetAvailableTimeState {}

class LoadedGetAvailableTimeState extends  GetAvailableTimeState{
  final List<Date> date;
  const LoadedGetAvailableTimeState({required this.date});
  @override
  List<Object> get props => [date];
}
class FailureGetAvailableTimeState extends  GetAvailableTimeState{
  final String message;

  const FailureGetAvailableTimeState({required this.message});
  @override
  List<Object> get props => [message];
}