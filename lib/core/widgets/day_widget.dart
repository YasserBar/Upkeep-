import 'package:flutter/material.dart';

import '../theme/colors.dart';

// ignore: must_be_immutable
class DayWidget extends StatefulWidget {
   DayWidget({
    this.isClicked=false,
    Key? key,
    required this.title,
  }) : super(key: key);
  bool isClicked ;
  final String title;
  @override
  State<DayWidget> createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {


  @override
  Widget build(BuildContext context) {
    return InkWell(

      child: Container(
        decoration: BoxDecoration(
          color: widget.isClicked ? primaryColor : Colors.white,
          border: Border.all(color: secondryColor),
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
        height: MediaQuery.of(context).size.height * .05,
        width: MediaQuery.of(context).size.width * .1,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: widget.isClicked ? Colors.white : primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
