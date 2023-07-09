import '../../domain/entities/signup.dart';

class SignupModel extends Signup {
  const SignupModel({
    required String email,
    required String password,
    required String fName,
    required String lName,
    required String gender,
    required String dateOfBirth,
    required int country,
    required int city,
    required int region,
    required String mobilePhoneNumber,
  }) : super(
          email: email,
          password: password,
          fName: fName,
          lName: lName,
          gender: gender,
          dateOfBirth: dateOfBirth,
          country: country,
          city: city,
          region: region,
          mobilePhoneNumber: mobilePhoneNumber,
        );

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      email: json['email'] as String,
      password: json['password'] as String,
      fName: json['f_name'] as String,
      lName: json['l_name'] as String,
      gender: json['gender'] as String,
      dateOfBirth: json['date_of_birth'] as String,
      country: json['country'] as int,
      city: json['city'] as int,
      region: json['region'] as int,
      mobilePhoneNumber: json['mobile_phone_Number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'f_name': fName,
      'l_name': lName,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'country': country,
      'city': city,
      'region': region,
      'mobile_phone_Number': mobilePhoneNumber,
    };
  }
}
