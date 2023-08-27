import 'package:equatable/equatable.dart';

class Foundation extends Equatable {
  final int id;
  final int? active;
  final String name;
  final String photo;
  final String description;

  const Foundation({
    required this.id,
    this.active,
    required this.name,
    required this.photo,
    required this.description,
  });

  @override
  List<Object?> get props => [id, active, name, photo, description];
}
