import 'package:equatable/equatable.dart';

import '../../../domain/entities/reservation.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object> get props => [];
}

class AddReservationEvent extends ReservationEvent {
  final Reservation reservation;

  const AddReservationEvent({required this.reservation});

  @override
  List<Object> get props => [reservation];
}