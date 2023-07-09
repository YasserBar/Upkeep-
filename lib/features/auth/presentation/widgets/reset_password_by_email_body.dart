import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/verify_forget_password.dart';
import '../../../../core/helpers/regex.dart';
import '../../../../core/utilities/loading_widget.dart';
import '../../../../core/utilities/snackbar_message.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import 'custom_textfiled.dart';
import 'custome_button.dart';
import 'reset_password_text.dart';

// ignore: must_be_immutable
class ResetPasswordByEmailBody extends StatelessWidget {
  ResetPasswordByEmailBody({Key? key}) : super(key: key);
  final formfey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessAuthState) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyForgetScreen(
                      email: emailController.text,
                    )),
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

        return SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: formfey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .2,
                          ),
                          height: MediaQuery.of(context).size.height * .6,
                          child: Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const ResetPasswordText(),
                                CustomTextFiled(
                                  title: "أيميل",
                                  hintT: "example@gmail.com",
                                  icon: Icons.email_outlined,
                                  controller: emailController,
                                  validator: (value) => validateEmail(value),
                                ),
                                CustomButton(
                                  title1: "ارسل رمز التحقق",
                                  title2: "",
                                  onPressButton: () {
                                    final isValidForm =
                                        formfey.currentState!.validate();
                                    if (isValidForm) {
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(ForgetPasswordEvent(
                                        emailController.text,
                                      ));
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
