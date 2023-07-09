import '../../domain/entities/propose.dart';

class ProposeModel extends Propose {
  const ProposeModel({
    required int foundationId,
    required String description,
    required int classService,
    required String nameService,
  }) : super(
          foundationId: foundationId,
          description: description,
          classService: classService,
          nameService: nameService,
        );

  factory ProposeModel.fromJson(Map<String, dynamic> json) => ProposeModel(
        foundationId: json['foundation_id'] as int,
        description: json['description'] as String,
        classService: json['class_service'] as int,
        nameService: json['name_service'] as String,
      );

  Map<String, dynamic> toJson() => {
        'foundation_id': foundationId,
        'description': description,
        'class_service': classService,
        'name_service': nameService,
      };
}
