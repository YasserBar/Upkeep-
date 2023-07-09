import 'package:equatable/equatable.dart';

import 'base.dart';

class Signup extends Base with EquatableMixin {
  final String fName;
  final String lName;
  final String gender;
  final String dateOfBirth;
  final int country;
  final int city;
  final int region;
  final String mobilePhoneNumber;

  const Signup({
    required String email,
    required String password,
    required this.fName,
    required this.lName,
    required this.gender,
    required this.dateOfBirth,
    required this.country,
    required this.city,
    required this.region,
    required this.mobilePhoneNumber,
  }) : super(email: email, password: password);

  @override
  List<Object> get props {
    return [
      email,
      password,
      fName,
      lName,
      gender,
      dateOfBirth,
      country,
      city,
      region,
      mobilePhoneNumber
    ];
  }
}
