import 'package:flutter/material.dart';
import '../constants/days_time.dart';
import '../theme/colors.dart';
import 'day_widget.dart';
import 'start_end_time_widget.dart';

class WeekWidget extends StatefulWidget {
  const WeekWidget({
    super.key,
  });

  @override
  State<WeekWidget> createState() => _WeekWidgetState();
}

class _WeekWidgetState extends State<WeekWidget> {
  int selectedContainerIndex = 0;
  DateTime? selectedTimeStart;
  DateTime? selectedTimeEnd;
  void _onContainerPressed(int index) {
    setState(() {
      selectedContainerIndex = index;
    });
  }

  bool clicked1 = false;
  bool clicked2 = false;
  bool clicked3 = false;
  bool clicked4 = false;
  bool clicked5 = false;
  bool clicked6 = false;
  bool clicked7 = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * .01),
        const Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "أيام العطل",
              style: TextStyle(color: primaryColor),
            )),
        SizedBox(height: MediaQuery.of(context).size.height * .01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _onContainerPressed(0);
                setState(() {
                  clicked1 = !clicked1;
                });
              },
              child: DayWidget(
                isClicked: clicked1,
                title: "S",
              ),
            ),
            GestureDetector(
              onTap: () {
                _onContainerPressed(1);

                setState(() {
                  clicked2 = !clicked2;
                });
              },
              child: DayWidget(
                title: "Su",
                isClicked: clicked2,
              ),
            ),
            GestureDetector(
              onTap: () {
                _onContainerPressed(2);
                setState(() {
                  clicked3 = !clicked3;
                });
              },
              child: DayWidget(
                title: "M",
                isClicked: clicked3,
              ),
            ),
            GestureDetector(
              onTap: () {
                _onContainerPressed(3);
                setState(() {
                  clicked4 = !clicked4;
                });
              },
              child: DayWidget(
                title: "Tu",
                isClicked: clicked4,
              ),
            ),
            GestureDetector(
              onTap: () {
                _onContainerPressed(4);
                setState(() {
                  clicked5 = !clicked5;
                });
              },
              child: DayWidget(
                title: "W",
                isClicked: clicked5,
              ),
            ),
            GestureDetector(
              onTap: () {
                _onContainerPressed(5);
                setState(() {
                  clicked6 = !clicked6;
                });
              },
              child: DayWidget(
                title: "Th",
                isClicked: clicked6,
              ),
            ),
            GestureDetector(
              onTap: () {
                _onContainerPressed(6);
                setState(() {
                  clicked7 = !clicked7;
                });
              },
              child: DayWidget(
                title: "F",
                isClicked: clicked7,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .02),
        IndexedStack(
          index: selectedContainerIndex,
          children: [
            Center(
                child: StartEndTimeService(
              onTimeChangedStart: (dateTime) {
                setState(() {
                  startSut = dateTime;
                });
              },
              onTimeChangedEnd: (dateTime) {
                setState(() {
                  endSut = dateTime;
                });
              },
            )),
            Center(
                child: StartEndTimeService(
              onTimeChangedStart: (dateTime) {
                setState(() {
                  startSun = dateTime;
                });
              },
              onTimeChangedEnd: (dateTime) {
                setState(() {
                  endSun = dateTime;
                });
              },
            )),
            Center(
                child: StartEndTimeService(
              onTimeChangedStart: (dateTime) {
                setState(() {
                  startMon = dateTime;
                });
              },
              onTimeChangedEnd: (dateTime) {
                setState(() {
                  endMon = dateTime;
                });
              },
            )),
            Center(
                child: StartEndTimeService(
              onTimeChangedStart: (dateTime) {
                setState(() {
                  startTus = dateTime;
                });
              },
              onTimeChangedEnd: (dateTime) {
                setState(() {
                  endTus = dateTime;
                });
              },
            )),
            Center(
                child: StartEndTimeService(
              onTimeChangedStart: (dateTime) {
                setState(() {
                  startWen = dateTime;
                });
              },
              onTimeChangedEnd: (dateTime) {
                setState(() {
                  endWen = dateTime;
                });
              },
            )),
            Center(
                child: StartEndTimeService(
              onTimeChangedStart: (dateTime) {
                setState(() {
                  starThu = dateTime;
                });
              },
              onTimeChangedEnd: (dateTime) {
                setState(() {
                  endThu = dateTime;
                });
              },
            )),
            Center(
                child: StartEndTimeService(
              onTimeChangedStart: (dateTime) {
                setState(() {
                  startFri = dateTime;
                });
              },
              onTimeChangedEnd: (dateTime) {
                setState(() {
                  endFri = dateTime;
                });
              },
            )),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .02),
      ],
    );
  }
}
