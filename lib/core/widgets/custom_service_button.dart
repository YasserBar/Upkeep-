import 'package:flutter/material.dart';

class CustomServiceButton extends StatelessWidget {
  const CustomServiceButton({
    super.key,
    required this.title,
    required this.icon,
    required this.bgColor,
    this.bsColor = Colors.white,
    this.onPressed,
  });
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color bsColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .05,
      decoration: BoxDecoration(
          border: Border.all(color: bsColor),
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: TextButton(
        onPressed: onPressed,
        child: Align(
          alignment: Alignment.topRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: bsColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                icon,
                color: bsColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
