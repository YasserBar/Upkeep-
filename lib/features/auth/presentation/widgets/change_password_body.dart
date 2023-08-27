import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/core/helpers/snackbar_message.dart';
import '../../../../core/helpers/regex.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../../domain/entities/change_password.dart';
import '../bloc/change_password_logout_bloc/change_password_logout_bloc.dart';
import '../bloc/change_password_logout_bloc/change_password_logout_event.dart';
import '../bloc/change_password_logout_bloc/change_password_logout_state.dart';
import '../../../../injection_countainer.dart' as di;

import 'custom_textfiled.dart';
import 'custome_button.dart';

// ignore: must_be_immutable
class ChangePasswordBody extends StatelessWidget {
  ChangePasswordBody({Key? key}) : super(key: key);
//////////////????!!
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController =
      TextEditingController(); //////////////????!!
  final formfey = GlobalKey<FormState>();

  @override
  Widget build(context) {
    return BlocProvider<ChangePasswordLogoutBloc>(
      create: (context) => di.sl<ChangePasswordLogoutBloc>(),
      child: BlocConsumer<ChangePasswordLogoutBloc, ChangePasswordLogoutState>(
        listener: (context, state) {
          if (state is SuccessChangePasswordLogoutState) {
            Navigator.pop(context);
            SnackBarMessage()
                .showSuccessSnackBar(message: state.message, context: context);
          } else if (state is ErrorChangePasswordLogoutState) {
            SnackBarMessage()
                .showErrorSnackBar(message: state.message, context: context);
          }
        },
        builder: (context, state) {
          if (state is LoadingChangePasswordLogoutState) {
            return const LoadingWidget();
          }
          return SingleChildScrollView(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formfey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      CustomTextFiled(
                        title: "كلمة المرور القديمة ",
                        hintT: "ادخل كلمة المرور القديمة",
                        icon: Icons.lock_open_sharp,
                        controller: oldPasswordController,
                      ),
                      CustomTextFiled(
                        title: "كلمة المرور الجديدة ",
                        hintT: "ادخل كلمة المرور الجديدة",
                        icon: Icons.lock_open_sharp,
                        controller: newPasswordController,
                        validator: (value) => validatePassword(value),
                      ),
                      CustomTextFiled(
                        title: " تأكيد كلمة المرور الجديدة ",
                        hintT: "أعد ادخل كلمة المرور الجديدة",
                        icon: Icons.lock_open_sharp,
                        controller: confirmNewPasswordController,
                        validator: (value) => validatePassword(value),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomButton(
                          title1: 'تأكيد',
                          title2: '',
                          onPressButton: () {
                            final isValidForm =
                                formfey.currentState!.validate();
                            if (isValidForm) {
                              BlocProvider.of<ChangePasswordLogoutBloc>(context)
                                  .add(
                                ChangePasswordEvent(
                                  changePassword: ChangePassword(
                                    oldPassword: oldPasswordController.text,
                                    password: newPasswordController.text,
                                    passwordConfirmation:
                                        confirmNewPasswordController.text,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
