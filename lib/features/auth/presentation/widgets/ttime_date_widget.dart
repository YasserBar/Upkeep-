// // import 'package:date_time_picker/date_time_picker.dart';
// // import 'package:flutter/material.dart';
// //
// // class TimeDatePicker extends StatelessWidget {
// //   const TimeDatePicker({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return  Container(
// //
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //
// //
// //
// //           Container(
// //
// //             height:  MediaQuery.of(context).size.height * .06,
// //             width: double.infinity,
// //             margin: EdgeInsets.symmetric(horizontal: 10),
// //             decoration:const BoxDecoration(
// //               borderRadius: BorderRadius.all(Radius.circular(10)),
// //               color: Colors.white,
// //
// //
// //             ),
// //             child: TimeDateWidget(),
// //           ),
// //
// //         ],
// //
// //       ),
// //     );
// //   }
// // }
// //
// // class TimeDateWidget extends StatelessWidget {
// //
// //   const TimeDateWidget({
// //     super.key,  this.hintT = 'DD-MM-YYYY',  this.isDate = true, this.sizeFont =18,
// //   });
// //   final bool isDate;
// //   final String hintT;
// //   final double sizeFont;
// //   @override
// //   Widget build(BuildContext context) {
// //     return DateTimePicker(
// //
// //       textAlign: TextAlign.center,
// //
// //       decoration:  InputDecoration(
// //
// //
// //         hintText:  hintT,
// //
// //         hintStyle: TextStyle(color: Color(0xffC0BEBE,),fontWeight: FontWeight.bold
// //           ,fontSize: sizeFont,),
// //
// //         border: InputBorder.none,
// //         //       contentPadding: EdgeInsets.symmetric(vertical: 18),
// //
// //         alignLabelWithHint: true,
// //       ),
// //
// //       style: const TextStyle(
// //
// //           color: Color(0xff838383),
// //
// //           fontSize: 30,
// //
// //           fontWeight: FontWeight.bold),
// //
// //       type:isDate ?  DateTimePickerType.date :  DateTimePickerType.time,
// //
// //       firstDate: DateTime(1900),
// //       lastDate: DateTime(2100),
// //       onChanged: (val) => print(val),
// //       use24HourFormat: false,
// //       validator: (val) {
// //
// //         print(val);
// //
// //         return null;
// //
// //       },
// //
// //       onSaved: (val) => print(val),
// //
// //     );
// //   }
// // }
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class TimeDatePicker extends StatelessWidget {
//    TimeDatePicker({Key? key, this.controller}) : super(key: key);
//   final TextEditingController? controller;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           height: MediaQuery.of(context).size.height * .06,
//           width: double.infinity,
//           margin: const EdgeInsets.symmetric(horizontal: 10),
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             color: Colors.white,
//           ),
//           child: const TimeDateWidget(),
//         ),
//       ],
//     );
//   }
// }
//
// class TimeDateWidget extends StatefulWidget {
//   const TimeDateWidget({
//     Key? key,
//     this.hintT = 'DD-MM-YYYY',
//     this.isDate = true,
//     this.sizeFont = 18,
//   }) : super(key: key);
//
//   final bool isDate;
//   final String hintT;
//   final double sizeFont;
//
//   @override
//   _TimeDateWidgetState createState() => _TimeDateWidgetState();
// }
//
// class _TimeDateWidgetState extends State<TimeDateWidget> {
//   DateTime dateTime = DateTime.now();
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: GestureDetector(
//         onTap: () {
//           showModalBottomSheet(
//             context: context,
//             builder: (BuildContext builder) {
//               return SizedBox(
//                 height: MediaQuery.of(context).copyWith().size.height / 3,
//                 child: CupertinoDatePicker(
//
//                   mode: widget.isDate
//                       ? CupertinoDatePickerMode.date
//                       : CupertinoDatePickerMode.time,
//                   initialDateTime: DateTime.now(),
//                   minimumYear: 1900,
//                   maximumYear: 2100,
//                   onDateTimeChanged: (val) {
//                     setState(() {
//                       dateTime = val;
//                     });
//                   },
//                   use24hFormat: false,
//                 ),
//               );
//             },
//           );
//         },
//         child: Text(
//           widget.isDate
//               ? DateFormat('dd-MM-yyyy').format(dateTime)
//               : DateFormat('hh:mm a').format(dateTime),
//           style: TextStyle(fontSize: widget.sizeFont, color: Colors.grey[600]),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeDatePicker extends StatelessWidget {
  const TimeDatePicker({Key? key, this.setDateController}) : super(key: key);
  final Function(String)? setDateController;

  void _updateControllerValue(DateTime dateTime) {
    final DateFormat formatter = DateFormat('hh:mm a');
    final String date = formatter.format(dateTime);
    setDateController!(date); // call the function to update the dateController
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .06,
          alignment: Alignment.centerRight,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: TimeDateWidget(
            onDateTimeChanged: _updateControllerValue,
          ),
        ),
      ],
    );
  }
}

class TimeDateWidget extends StatefulWidget {
  const TimeDateWidget({
    Key? key,
    this.hintT = 'DD-MM-YYYY',
    this.isDate = true,
    this.sizeFont = 18,
    required this.onDateTimeChanged,
  }) : super(key: key);

  final bool isDate;
  final String hintT;
  final double sizeFont;
  final Function(DateTime) onDateTimeChanged;

  @override
  // ignore: library_private_types_in_public_api
  _TimeDateWidgetState createState() => _TimeDateWidgetState();
}

class _TimeDateWidgetState extends State<TimeDateWidget> {
  DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext builder) {
              return SizedBox(
                height: MediaQuery.of(context).copyWith().size.height / 3,
                child: CupertinoDatePicker(
                  mode: widget.isDate
                      ? CupertinoDatePickerMode.date
                      : CupertinoDatePickerMode.time,
                  minimumYear: 1900,
                  maximumYear: 2023,
                  onDateTimeChanged: (val) {
                    setState(() {
                      dateTime = val;
                      widget.onDateTimeChanged(dateTime);
                    });
                  },
                  use24hFormat: true,
                ),
              );
            },
          );
        },
        child: Text(
          widget.isDate
              ? DateFormat('dd-MM-yyyy').format(dateTime)
              : DateFormat('hh:mm a').format(dateTime),
          style: TextStyle(
            fontSize: widget.sizeFont,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
