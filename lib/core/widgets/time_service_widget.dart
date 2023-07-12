import 'package:flutter/material.dart';
import 'package:upkeep_plus/core/widgets/Time_picker.dart';

class TimeServiceWidget extends StatefulWidget {
  const TimeServiceWidget({
    Key? key,
    required this.title,
    required this.hintTime,
    required this.colorTitle,
    required this.onTimeChanged,
  }) : super(key: key);

  final String title;
  final String hintTime;
  final Color colorTitle;
  final Function(DateTime) onTimeChanged;

  @override
  // ignore: library_private_types_in_public_api
  _TimeServiceWidgetState createState() => _TimeServiceWidgetState();
}

class _TimeServiceWidgetState extends State<TimeServiceWidget> {
  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      height: MediaQuery.of(context).size.height * .12,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .4,
        child: Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: widget.colorTitle,
                    ),
                  ),
                  Flexible(
                    child: TimeDateWidget(
                      isDate: false,
                      hintT: widget.hintTime,
                      sizeFont: 24,
                      onDateTimeChanged: (dateTime) {
                        setState(() {
                          selectedTime = dateTime;
                        });
                        widget.onTimeChanged(dateTime);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
