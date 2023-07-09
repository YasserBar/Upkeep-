import 'package:equatable/equatable.dart';

class Region extends Equatable {
  final int id;
  final String name;

  const Region({required this.id, required this.name});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  List<Object> get props => [id, name];
}
