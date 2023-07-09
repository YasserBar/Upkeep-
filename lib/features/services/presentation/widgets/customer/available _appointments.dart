// ignore_for_file: file_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theme/colors.dart';
import '../../../domain/entities/date.dart';
import 'booking_button.dart';

class Booking extends StatelessWidget {
  final List<Date> dateList;
  final int id;
  const Booking({
    super.key,
    required this.dateList,
    required this.id,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double rowWidth = (358 / 390) * width;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: dateList.length,
      itemBuilder: (BuildContext context, int index) {
        String dateTime = dateList[index].date.toString();

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: rowWidth,
            height: (50 / 358) * rowWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BookingButton(
                  id: id,
                  date: dateTime,
                ),
                const SizedBox(
                  width: 5,
                ),
                AutoSizeText(
                  DateFormat('yyyy/MM/dd EEE hh:mm')
                      .format(DateTime.parse(dateTime)),
                  maxFontSize: 18,
                  minFontSize: 9,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
