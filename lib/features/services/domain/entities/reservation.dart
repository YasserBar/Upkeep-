import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final int id;
  final String date;
  final String description;

  const Reservation(
      {required this.id, required this.date, required this.description});

  @override
  List<Object?> get props => [id, date, description];
}
