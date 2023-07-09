
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, required this.vertical}) : super(key: key);
final double vertical;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: vertical),
      child: const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
