import 'package:flutter/material.dart';

import '../widgets/change_password_body.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe4e4e4),
      body: ChangePasswordBody(),
    );
  }
}
