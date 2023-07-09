// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../../../core/aseets/app_routers.dart';
// import '../../../../core/theme/colors.dart';
// import 'custom_textfiled.dart';
// import 'custome_button.dart';
// import 'reset_password_text.dart';
//
// class ResetPasswordByPhoneNumberBody extends StatelessWidget {
//   const ResetPasswordByPhoneNumberBody({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: CustomScrollView(
//         slivers: [
//           SliverFillRemaining(
//             hasScrollBody: false,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.symmetric(
//                       vertical: MediaQuery.of(context).size.height * .2,
//                     ),
//                     height: MediaQuery.of(context).size.height * .6,
//                     child: Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           const ResetPasswordText(),
//                           const CustomTextFiled(
//                             title: "رقم الهاتف",
//                             hintT: "phone numper",
//                             icon: Icons.phone,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               TextButton(
//                                   onPressed: () {
//                                     GoRouter.of(context)
//                                         .push(AppRouters.kResetPasswordByEmail);
//                                   },
//                                   child: const Text(
//                                     " الايميل",
//                                     style: TextStyle(
//                                         color: secondryColor,
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold),
//                                   )),
//                               const Text(
//                                 " التحقق عن طريق ",
//                                 style: TextStyle(color: Colors.grey),
//                               ),
//                             ],
//                           ),
//                           CustomButton(
//                             title1: "ارسل رمز التحقق",
//                             title2: "",
//                             onPressButton: () {
//                               GoRouter.of(context)
//                                   .push(AppRouters.kVerifyForgetScreen);
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
