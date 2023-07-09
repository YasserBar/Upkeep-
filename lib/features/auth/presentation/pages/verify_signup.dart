import 'package:flutter/material.dart';

import '../widgets/verify_signup_body.dart';

class VerifySignupScreen extends StatelessWidget {
  final String email;
  final String password;

  const VerifySignupScreen({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VerifySignupBody(
        email: email,
        password: password,
      ),
    );
  }
}
