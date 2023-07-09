import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../pages/reset_password_by_email_screen.dart';

class ForgetTextWidget extends StatefulWidget {
  const ForgetTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForgetTextWidgetState createState() => _ForgetTextWidgetState();
}

class _ForgetTextWidgetState extends State<ForgetTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ResetPasswordByEmailScreen()),
          );
        },
        child: const Text(
          "نسيت كلمة المرور؟",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
