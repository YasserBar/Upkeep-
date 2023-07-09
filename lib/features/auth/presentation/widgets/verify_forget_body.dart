import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import '../../../../core/helpers/regex.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utilities/loading_widget.dart';
import '../../../../core/utilities/snackbar_message.dart';
import '../../domain/entities/verify_pin_forget.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import 'custom_textfiled.dart';
import 'custome_button.dart';
import 'remember_me.dart';

class VerifyBody extends StatefulWidget {
  const VerifyBody({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  State<VerifyBody> createState() => _VerifyBodyState();
}

class _VerifyBodyState extends State<VerifyBody> {
  bool _onEditing = true;

  bool rememberMe = false;

  void updateRememberMe() {
    rememberMe = !rememberMe;
  }

  String code = "0000000";
  TextEditingController emailController = TextEditingController();
  //////////////????!!
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formfey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessAuthState) {
          Navigator.pop(context);
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
                child: Form(
                  key: formfey,
                  autovalidateMode: AutovalidateMode.always,
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
                              ),
                            ),
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
                              underlineColor: Colors.amber,
                              length: 6,
                              cursorColor: Colors.blue,
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
                                if (!_onEditing) {
                                  FocusScope.of(context).unfocus();
                                }
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
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextFiled(
                        title: "كلمة المرور",
                        icon: Icons.lock_outline_sharp,
                        controller: passwordController,
                        validator: (value) => validatePassword(value),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomTextFiled(
                        title: "تأكيد كلمة المرور",
                        icon: Icons.lock_outline_sharp,
                        controller: confirmPasswordController,
                        validator: (value) => validatePassword(value),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomButton(
                        title1: 'اعادة ارسال الرمز',
                        title2: '',
                        onPressButton: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            ResendPinEvent(widget.email),
                          );
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CustomButton(
                        title1: 'تاكيد',
                        title2: '',
                        onPressButton: () {
                          final isValidForm = formfey.currentState!.validate();
                          if (isValidForm) {
                            BlocProvider.of<AuthBloc>(context).add(
                              VerifyPinForgetEvent(
                                VerifyPinForget(
                                  verificationCode: int.parse(code),
                                  passwordConfirmation:
                                      confirmPasswordController.text,
                                  email: widget.email,
                                  password: passwordController.text,
                                ),
                                rememberMe,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
