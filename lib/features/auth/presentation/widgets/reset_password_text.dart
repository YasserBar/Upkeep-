import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';


class ResetPasswordText extends StatelessWidget {
  const ResetPasswordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(

        children:  [
          const  Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "إعادة تعيين كلمة مرور",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: secondryColor,
                ),
              )),
          SizedBox(height: MediaQuery.of(context).size.height * .01),
          const  Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "أدخل بريدك الإلكتروني أو رقمك وسنرسل لك رمز التحقق",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: primaryColor),
              )),
        ],
      ),
    );
  }
}
