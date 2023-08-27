// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class TimeDateWidget extends StatefulWidget {
//   const TimeDateWidget({
//     Key? key,
//     this.hintT = 'DD-MM-YYYY',
//     this.isDate = true,
//     this.sizeFont = 18,
//     required this.onDateTimeChanged,
//   }) : super(key: key);

//   final bool isDate;
//   final String hintT;
//   final double sizeFont;
//   final Function(DateTime) onDateTimeChanged;

//   @override
//   // ignore: library_private_types_in_public_api
//   _TimeDateWidgetState createState() => _TimeDateWidgetState();
// }

// class _TimeDateWidgetState extends State<TimeDateWidget> {
//   DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(0);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: GestureDetector(
//         onTap: () {
//           showModalBottomSheet(
//             context: context,
//             builder: (BuildContext builder) {
//               return SizedBox(
//                 height: MediaQuery.of(context).copyWith().size.height / 3,
//                 child: CupertinoDatePicker(
//                   mode: widget.isDate
//                       ? CupertinoDatePickerMode.date
//                       : CupertinoDatePickerMode.time,
//                   minimumYear: 1900,
//                   maximumYear: 2023,
//                   onDateTimeChanged: (val) {
//                     setState(() {
//                       dateTime = val;
//                       widget.onDateTimeChanged(dateTime);
//                     });
//                   },
//                 ),
//               );
//             },
//           );
//         },
//         child: Text(
//           widget.isDate
//               ? DateFormat('dd-MM-yyyy').format(dateTime)
//               : DateFormat('hh:mm a').format(dateTime),
//           style: TextStyle(
//             fontSize: widget.sizeFont,
//             color: Colors.grey[600],
//           ),
//         ),
//       ),
//     );
//   }
// }
