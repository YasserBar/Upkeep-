import 'package:equatable/equatable.dart';

class Foundation extends Equatable {
  final int id;
  final String name;
  final String photo;
  final String description;

  const Foundation({
    required this.id,
    required this.name,
    required this.photo,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, photo, description];
}
