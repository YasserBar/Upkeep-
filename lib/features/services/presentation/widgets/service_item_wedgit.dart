import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/aseets/assets.dart';
import '../../../../../core/theme/colors.dart';

class ServiceShowWidget extends StatelessWidget {
  const ServiceShowWidget({
    super.key,
    required this.text,
    required this.imgUrl,
  });
  final String text;
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: primaryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: secondryColor),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(18))),
                width: MediaQuery.of(context).size.width * .32,
                margin: const EdgeInsets.only(left: 15, right: 10),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                    AssetClass.StaticLogo,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            )),
          ],
        ),
      ),
    );
  }
}
