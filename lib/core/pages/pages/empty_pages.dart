import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../aseets/assets.dart';
class EmptyPages extends StatelessWidget {
  const EmptyPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: const EdgeInsets.only(top: 150),
          child: Center(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                AssetClass.NoData,
                alignment: Alignment.center,
                height: 200,
                width: 200,
              ),
            ),
          ),
        );
  }
}
