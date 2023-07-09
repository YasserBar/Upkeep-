import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../pages/signup_screen.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupScreen()),
            );
          },
          child: const Text(
            "أنشئ حسابك الآن",
            style: TextStyle(
                color: secondryColor,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
        ),
        const Text(
          "ليس لديك حساب؟",
          style: TextStyle(
              color: Color(0xff749DAB),
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
