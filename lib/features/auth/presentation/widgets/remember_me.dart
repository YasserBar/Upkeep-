import 'package:flutter/material.dart';

import '../../../../../../core/theme/colors.dart';

// ignore: must_be_immutable
class RememberMe extends StatefulWidget {
  bool isChecked = false;
  final void Function() onTap;

  RememberMe({
    Key? key,
    required this.isChecked,
    required this.onTap,
  }) : super(key: key);

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(' تذكرني'),
        Checkbox(
          value: widget.isChecked,
          activeColor: primaryColor,
          onChanged: (value) {
            setState(() {
              widget.isChecked = value!;
            });
            widget.onTap();
          },
        ),
      ],
    );
  }
}
