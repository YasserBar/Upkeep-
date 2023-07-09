import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import '../../../../core/theme/colors.dart';

class VerifyForm extends StatefulWidget {
  const VerifyForm({super.key});

  @override
  State<VerifyForm> createState() => _VerifyFormState();
}

class _VerifyFormState extends State<VerifyForm> {
  bool _onEditing = true;
  // ignore: unused_field
  String? _code;

  @override
  build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "تأكيد رمز التحقق",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: secondryColor,
                  ),
                )),
            const Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "من فضلك ادخل الرقم والكود المرسل الى ايميلك ",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: primaryColor),
                )),
            // const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Text(
            //     'Enter your code',
            //     style: TextStyle(fontSize: 20.0),
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            VerificationCode(
              itemSize: MediaQuery.of(context).size.height * 0.046,

              autofocus: true,
              fullBorder: true,
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).primaryColor),
              keyboardType: TextInputType.number,
              underlineColor: Colors
                  .amber, // If this is null it will use primaryColor: Colors.red from Theme
              length: 6,
              cursorColor:
                  Colors.blue, // If this is null it will default to the ambient
              // clearAll is NOT required, you can delete it
              // takes any widget, so you can implement your design
              // clearAll: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     'clear all',
              //     style: TextStyle(
              //         fontSize: 14.0,
              //         decoration: TextDecoration.underline,
              //         color: Colors.blue[700]),
              //   ),
              // ),
              margin: const EdgeInsets.all(12),
              onCompleted: (String value) {
                setState(() {
                  _code = value;
                });
              },
              onEditing: (bool value) {
                setState(() {
                  _onEditing = value;
                });
                if (!_onEditing) FocusScope.of(context).unfocus();
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Center(
            //     child: _onEditing
            //         ? const Text('Please enter full code')
            //         : Text('Your code: $_code'),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
