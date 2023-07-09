import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import '../../../../../core/widgets/navigation_provider.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utilities/loading_widget.dart';
import '../../../../core/utilities/snackbar_message.dart';
import '../../domain/entities/verify_pin_signup.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import 'custome_button.dart';
import 'remember_me.dart';

class VerifySignupBody extends StatefulWidget {
  final String email;
  final String password;

  const VerifySignupBody({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  State<VerifySignupBody> createState() => _VerifySignupBodyState();
}

class _VerifySignupBodyState extends State<VerifySignupBody> {
  bool _onEditing = true;
  String code = "000000";

  bool rememberMe = false;

  void updateRememberMe() {
    rememberMe = !rememberMe;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessAuthState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NavigationProvider()),
          );
        } else if (state is ErrorAuthState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
      builder: (context, state) {
        if (state is LoadingAuthState) {
          return const LoadingWidget();
        }
        return CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0, top: 200),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.26,
                      child: Column(
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
                            itemSize:
                                MediaQuery.of(context).size.height * 0.046,

                            autofocus: true,
                            fullBorder: true,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                            keyboardType: TextInputType.number,
                            underlineColor: Colors
                                .amber, // If this is null it will use primaryColor: Colors.red from Theme
                            length: 6,
                            cursorColor: Colors
                                .blue, // If this is null it will default to the ambient
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
                                code = value;
                              });
                            },
                            onEditing: (bool value) {
                              setState(() {
                                _onEditing = value;
                              });
                              if (!_onEditing) FocusScope.of(context).unfocus();
                            },
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
                              children: [
                                const Text(''),
                                const Spacer(),
                                RememberMe(
                                    isChecked: rememberMe,
                                    onTap: updateRememberMe,
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    CustomButton(
                      title1: 'اعادة ارسال الرمز',
                      title2: '',
                      onPressButton: () {
                        BlocProvider.of<AuthBloc>(context).add(ResendPinEvent(
                          widget.email,
                        ));
                      },
                    ),
                    CustomButton(
                      title1: 'تاكيد',
                      title2: '',
                      onPressButton: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          VerifyPinSignupEvent(
                              VerifyPinSignup(
                                email: widget.email,
                                password: widget.password,
                                verificationCode: int.parse(code),
                              ),
                              rememberMe),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
