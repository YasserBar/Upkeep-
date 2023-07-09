
import 'package:equatable/equatable.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object> get props => [];
}
class AddReservationInitial extends  ReservationState{}
class LoadingAddReservationState extends ReservationState {}

class ErrorAddReservationState extends ReservationState {
  final String message;

  const ErrorAddReservationState({required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessAddReservationState extends ReservationState {
  final String message;

  const SuccessAddReservationState({required this.message});

  @override
  List<Object> get props => [message];
}