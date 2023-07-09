import '../../domain/entities/response_auth.dart';

class ResponseAuthModel extends ResponseAuth {
  const ResponseAuthModel({required String token}) : super(token: token);

  factory ResponseAuthModel.fromJson(Map<String, dynamic> json) {
    return ResponseAuthModel(
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}
