import 'package:flutter/material.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({
    super.key,
    required this.img,
    required this.title,
    required this.descrebtion,
  });
  final String img;
  final String title;
  final String descrebtion;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.fill,
          )),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 20.0, left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFFFFBC00)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              Text(
                descrebtion,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        )
      ],
    );
  }
}
