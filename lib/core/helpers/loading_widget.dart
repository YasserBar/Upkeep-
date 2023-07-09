import 'package:flutter/material.dart';

import '../theme/colors.dart';

class LoadingWidget extends StatelessWidget {
  final double vertical;
  const LoadingWidget({Key? key, this.vertical = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: vertical),
      child: const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            color: secondryColor,
          ),
        ),
      ),
    );
  }
}
