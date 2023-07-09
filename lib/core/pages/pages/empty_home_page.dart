
import 'package:flutter/material.dart';


class EmptyWidget extends StatelessWidget {
   const EmptyWidget ({super.key,   required this.height, required this.text});
 final double height;
 final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child:  Center(
          child: Text(
        text,
        style: const TextStyle(
            color: Colors.black38, fontSize: 20, fontWeight: FontWeight.w400),
      )),
    );
  }
}
