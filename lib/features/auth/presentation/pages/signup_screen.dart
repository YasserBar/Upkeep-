import 'package:flutter/material.dart';

import '../widgets/signup_body.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignupBody(),
    );
  }
}
