import '../../domain/entities/my_suggestions.dart';

class MySuggestionModel extends MySuggestion {
  const MySuggestionModel(
      {required String description, required String response})
      : super(description: description, response: response);

  factory MySuggestionModel.fromJson(Map<String, dynamic> json) {
    final responseList = json['response'] as List<dynamic>;
    final response = responseList.isNotEmpty ? responseList[0]['response'] : '';

    return MySuggestionModel(
      description: json['description'] as String,
      response: response as String,
    );
  }
  Map<String, dynamic> toJson() => {
    'description': description,
    'response': response,
  };
}

// class MySuggestionModel extends MySuggestion {
//   const MySuggestionModel({
//     required String description,
//     required dynamic response,
//   }) : super(description: description, response: response);
//
//   factory MySuggestionModel.fromJson(Map<String, dynamic> json) {
//     final responseList = json['response'] as List<dynamic>;
//     final response = responseList.isNotEmpty ? responseList[0]['response'] : null;
//
//     return MySuggestionModel(
//       description: json['description'] as String,
//       response: response as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'description': description,
//     'response': response,
//   };
// }
