import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upkeep_plus/core/helpers/snackbar_message.dart';
import '../../../../core/constants/keys.dart';
import '../../../../core/helpers/regex.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../../../../core/widgets/navigation_customer.dart';
import '../../domain/entities/login.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../pages/my_foundations_screeen.dart';
import 'custom_textfiled.dart';
import 'custome_appbar_auth.dart';
import 'custome_button.dart';
import 'dont_have_an_account_text.dart';
import 'forget_remember_widget.dart';
import 'remember_me.dart';
import '../../../../injection_countainer.dart' as di;

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool rememberMe = false;

  final formKey = GlobalKey<FormState>();

  void updateRememberMe() {
    rememberMe = !rememberMe;
  }

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessAuthState) {
          di.sl<SharedPreferences>().setBool(CUSTOMER, true);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const NavigationCustomer()),
            (Route<dynamic> route) => false,
          );
        } else if (state is SuccessAuthProviderState) {
          di.sl<SharedPreferences>().setBool(CUSTOMER, false);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MyFoundationsScreen()),
            (Route<dynamic> route) => false,
          );
        } else if (state is ErrorAuthState) {
          SnackBarMessage().showErrorSnackBar(
            message: state.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state is LoadingAuthState) {
          return const LoadingWidget();
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CostumeAppBarAuth(
                title: 'قم بتسجيل الدخول إلى حسابك',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextFiled(
                          controller: emailController,
                          validator: (value) => validateEmail(value),
                          title: 'بريد إلكتروني',
                          hintT: 'example@mail.com',
                          icon: Icons.email_outlined,
                        ),
                        CustomTextFiled(
                          validator: (value) => validatePassword(value),
                          controller: passwordController,
                          title: 'كلمة المرور',
                          hintT: '************',
                          icon: Icons.lock_outline,
                        ),
                        Row(
                          children: [
                            const ForgetTextWidget(),
                            const Spacer(),
                            RememberMe(
                              isChecked: rememberMe,
                              onTap: updateRememberMe,
                            ),
                          ],
                        ),
                        CustomButton(
                          title1: 'تسجيل الدخول كزبون',
                          onPressButton: () {
                            final isValidForm =
                                formKey.currentState!.validate();
                            if (isValidForm) {
                              if (kDebugMode) {
                                print(emailController.text);
                                print(passwordController.text);
                                print(rememberMe);
                                print('qwe===========================qwe');
                              }
                              BlocProvider.of<AuthBloc>(context).add(
                                LoginCustomerEvent(
                                  Login(
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                  rememberMe,
                                ),
                              );
                            }
                          },
                          title2: '',
                        ),
                        CustomButton(
                          title1: 'تسجيل الدخول كمقدم خدمة',
                          onPressButton: () {
                            final isValidForm =
                                formKey.currentState!.validate();
                            if (isValidForm) {
                              if (kDebugMode) {
                                print(emailController.text);
                                print(passwordController.text);
                                print(rememberMe);
                                print('qwe===========================qwe');
                              }
                              BlocProvider.of<AuthBloc>(context).add(
                                LoginProviderEvent(
                                  Login(
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                  rememberMe,
                                ),
                              );
                            }
                          },
                          title2: '',
                        ),
                        const DontHaveAccount(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
