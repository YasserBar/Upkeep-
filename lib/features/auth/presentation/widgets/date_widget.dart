import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:upkeep_plus/features/auth/presentation/widgets/custom_textfiled.dart';

class DatePicker extends StatelessWidget {
  DatePicker({Key? key, required this.dateController}) : super(key: key);

  TextEditingController dateController = TextEditingController();
  bool v = false;
  @override
  Widget build(BuildContext context) {
    return CustomTextFiled(
      title: "تاريخ الميلاد",
      icon: Icons.date_range_outlined,
      controller: dateController,
      hintT: "YYYY-MM-DD",
      readOnly: true,
      enableInteractiveSelection: false,
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext builder) {
            return GestureDetector(
              onTap: () {
                if (v == false) {
                  dateController.text =
                      DateFormat('yyyy-MM-dd').format(DateTime.now());
                }
                Navigator.of(context).pop();
              },
              child: SizedBox(
                height: MediaQuery.of(context).copyWith().size.height / 2.3,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  minimumYear: 1900,
                  maximumYear: DateTime.now().year,
                  onDateTimeChanged: (val) {
                    String date = DateFormat('yyyy-MM-dd').format(val);
                    dateController.text = date;
                    v = true;
                  },
                  use24hFormat: true,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
