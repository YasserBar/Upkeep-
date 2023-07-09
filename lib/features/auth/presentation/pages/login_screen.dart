import 'package:flutter/material.dart';

import '../widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Color(0xffe4e4e4),
        body: SafeArea(child: LoginBody()),
      ),
    );
  }
}
