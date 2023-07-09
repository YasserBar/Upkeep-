import 'package:flutter/material.dart';

import '../widgets/reset_password_by_email_body.dart';

class ResetPasswordByEmailScreen extends StatelessWidget {
  const ResetPasswordByEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ResetPasswordByEmailBody(),

    );
  }
}
