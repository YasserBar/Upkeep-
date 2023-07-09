import 'package:flutter/material.dart';

import '../widgets/verify_forget_body.dart';

class VerifyForgetScreen extends StatelessWidget {
  const VerifyForgetScreen({Key? key, required this.email}) : super(key: key);
final String email;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: VerifyBody(email: email,),
    );
  }
}
