import 'package:equatable/equatable.dart';

class Propose extends Equatable {
  final int foundationId;
  final String description;
  final int classService;
  final String nameService;

  const Propose({
    required this.foundationId,
    required this.description,
    required this.classService,
    required this.nameService,
  });

  @override
  List<Object> get props {
    return [
      foundationId,
      description,
      classService,
      nameService,
    ];
  }
}
