import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upkeep_plus/features/services/presentation/widgets/add_service_form.dart';

class TimeServiceWidget extends StatefulWidget {
  const TimeServiceWidget({
    Key? key,
    required this.start,
    required this.title,
    required this.colorTitle,
    required this.onTimeChanged,
  }) : super(key: key);

  final bool start;
  final String title;
  final Color colorTitle;
  final Function(DateTime) onTimeChanged;

  @override
  // ignore: library_private_types_in_public_api
  _TimeServiceWidgetState createState() => _TimeServiceWidgetState();
}

class _TimeServiceWidgetState extends State<TimeServiceWidget> {
  final formatter = CustomTimeFormatter();
  String time = '';
  DateTime? t;

  @override
  void initState() {
    super.initState();
    t = DateTime.now();
    t = widget.start
        ? DateTime(t!.year, t!.month, t!.day, 8, 0)
        : DateTime(t!.year, t!.month, t!.day, 16, 0);
    time = formatter.format(t!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext builder) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SizedBox(
                height: MediaQuery.of(context).copyWith().size.height / 2.3,
                child: CupertinoDatePicker(
                  initialDateTime: t,
                  use24hFormat: false,
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (val) {
                    t = val;
                    setState(() {
                      time = formatter.format(val);
                    });
                    widget.onTimeChanged(val);
                  },
                ),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        height: MediaQuery.of(context).size.height * .12,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.colorTitle,
                ),
              ),
              Text(
                time,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
