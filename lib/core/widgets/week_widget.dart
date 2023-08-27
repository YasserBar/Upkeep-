import 'package:flutter/material.dart';
import '../constants/days_time.dart';
import '../theme/colors.dart';
import 'day_widget.dart';
import 'start_end_time_widget.dart';

class WeekWidget extends StatefulWidget {
  const WeekWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<WeekWidget> createState() => _WeekWidgetState();
}

class _WeekWidgetState extends State<WeekWidget> {
  List<bool> clickedDays = List.filled(7, false);

  void _onContainerPressed(int index) {
    setState(() {
      clickedDays[index] = !clickedDays[index];
    });
  }

  DateTime t = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * .01),
        const Align(
          alignment: Alignment.bottomRight,
          child: Text(
            "حدد أيام العمل",
            style: TextStyle(color: primaryColor),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < days.length; i++)
              GestureDetector(
                onTap: () {
                  _onContainerPressed(i);
                  startTimes[i] = clickedDays[i]
                      ? DateTime(t.year, t.month, t.day, 8, 0)
                      : null;
                  endTimes[i] = clickedDays[i]
                      ? DateTime(t.year, t.month, t.day, 16, 0)
                      : null;
                },
                child: DayWidget(
                  title: days[i],
                  isClicked: clickedDays[i],
                ),
              ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .02),
        Column(
          children: [
            for (int i = 0; i < days.length; i++)
              if (clickedDays[i])
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: StartEndTimeService(
                    index: i,
                    onTimeChangedStart: (dateTime) {
                      setState(() {
                        startTimes[i] = dateTime;
                      });
                    },
                    onTimeChangedEnd: (dateTime) {
                      setState(() {
                        endTimes[i] = dateTime;
                      });
                    },
                  ),
                ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .02),
      ],
    );
  }
}
