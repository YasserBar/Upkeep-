// import 'package:flutter/material.dart';

// import '../../../../../core/theme/colors.dart';
// import '../../../../auth/presentation/widgets/custome_button.dart';

// class D {
//   static openDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         actionsAlignment: MainAxisAlignment.start,
//         actions: [
//           CustomButton(
//             onPressButton: () {
//               Navigator.of(context).pop();
//             },
//             title2: '',
//             title1: 'احجز',
//           )
//         ],
//         title: const Directionality(
//           textDirection: TextDirection.rtl,
//           child: Row(
//             children: [
//               Icon(
//                 Icons.note_add_outlined,
//                 color: primaryColor,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 "إضافة شرح للطلب ",
//                 style: TextStyle(color: primaryColor),
//               ),
//             ],
//           ),
//         ),
//         content: Directionality(
//           textDirection: TextDirection.rtl,
//           child: TextFormField(
//             keyboardType: TextInputType.multiline,
//             minLines: 8,
//             maxLines: 8,
//             decoration: const InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(8)),
//               ),
//               hintText: 'يمكنك ادخال شرح عن طلبك',
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
