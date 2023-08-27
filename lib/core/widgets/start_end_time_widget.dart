import 'package:flutter/material.dart';
import 'package:upkeep_plus/core/constants/days_time.dart';

import '../theme/colors.dart';
import 'time_service_widget.dart';

class StartEndTimeService extends StatefulWidget {
  const StartEndTimeService({
    Key? key,
    required this.onTimeChangedStart,
    required this.onTimeChangedEnd,
    required this.index,
  }) : super(key: key);
  final Function(DateTime) onTimeChangedStart;
  final Function(DateTime) onTimeChangedEnd;
  final int index;
  @override
  // ignore: library_private_types_in_public_api
  _StartEndTimeServiceState createState() => _StartEndTimeServiceState();
}

class _StartEndTimeServiceState extends State<StartEndTimeService> {
  TextEditingController dateController = TextEditingController();

  void setDate(String date) {
    setState(() {
      dateController.text = date;
    });
  }

  DateTime? selectedTimeStart;
  DateTime? selectedTimeEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            " وقت بدأ وانتهاء الخدمة ليوم ${nameDays[widget.index]}",
            style: const TextStyle(color: primaryColor),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .02,
        ),
        Row(
          children: [
            TimeServiceWidget(
              start: true,
              title: 'يبدأ',
              colorTitle: const Color(0xff0CDC5F),
              onTimeChanged: (dateTime) {
                setState(() {
                  selectedTimeStart = dateTime;
                });
                widget.onTimeChangedStart(dateTime);
              },
            ),
            const Spacer(),
            TimeServiceWidget(
              start: false,
              title: 'ينتهي',
              colorTitle: Colors.red,
              onTimeChanged: (dateTime) {
                setState(() {
                  selectedTimeEnd = dateTime;
                });
                widget.onTimeChangedEnd(dateTime);
              },
            ),
          ],
        ),
      ],
    );
  }
}
