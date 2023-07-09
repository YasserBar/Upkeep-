import 'package:equatable/equatable.dart';

class Date extends Equatable {
  final String date;
  const Date({required this.date});

  @override
  List<Object?> get props => [date];
}
