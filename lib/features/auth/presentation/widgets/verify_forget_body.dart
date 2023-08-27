import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:upkeep_plus/core/helpers/snackbar_message.dart';
import '../../../../core/helpers/regex.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../../domain/entities/verify_pin_forget.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import 'custom_textfiled.dart';
import 'custome_button.dart';

class VerifyBody extends StatefulWidget {
  const VerifyBody({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  State<VerifyBody> createState() => _VerifyBodyState();
}

class _VerifyBodyState extends State<VerifyBody> {
  bool _onEditing = true;

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
        if (state is SuccessVerifyPinForgetState) {
          Navigator.pop(context);
          Navigator.pop(context);
          SnackBarMessage()
              .showSuccessSnackBar(message: state.message, context: context);
        } else if (state is ErrorAuthState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
        if (state is SuccessResendPinState) {
          SnackBarMessage()
              .showSuccessSnackBar(message: state.message, context: context);
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 50),
                child: Form(
                  key: formfey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "تأكيد رمز التحقق",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: secondryColor,
                        ),
                      ),
                      const Text(
                        "من فضلك ادخل الرقم والكود المرسل الى ايميلك ",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: primaryColor),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      VerificationCode(
                        itemSize: MediaQuery.of(context).size.height * 0.045,
                        autofocus: true,
                        fullBorder: true,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Theme.of(context).primaryColor),
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
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      CustomTextFiled(
                        title: "تأكيد كلمة المرور",
                        icon: Icons.lock_outline_sharp,
                        controller: confirmPasswordController,
                        validator: (value) => validateConflictPassword(
                            value, passwordController.text),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            width: double.infinity,
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
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          CustomButton(
                            title1: 'تاكيد',
                            title2: '',
                            onPressButton: () {
                              final isValidForm =
                                  formfey.currentState!.validate();
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
                                    false,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
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
