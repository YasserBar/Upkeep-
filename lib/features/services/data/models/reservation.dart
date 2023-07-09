import '../../domain/entities/reservation.dart';

class ReservationModel extends Reservation {
  const ReservationModel({
    required int id,
    required String date,
    required String description,
  }) : super(id: id, date: date, description: description);

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      ReservationModel(
        id: json['id'] as int,
        date: json['date'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'description': description,
      };
}
