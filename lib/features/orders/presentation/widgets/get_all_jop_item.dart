import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../core/aseets/assets.dart';
import '../../../../../core/theme/colors.dart';

class GetAllJopFoundationItem extends StatelessWidget {
  const GetAllJopFoundationItem(
      {Key? key, required this.imgUrl, required this.description})
      : super(key: key);
  final String imgUrl;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: MediaQuery.of(context).size.width * .55,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: primaryColor,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
              width: MediaQuery.of(context).size.width * .4,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
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
            Expanded(
                child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.fade,
                ),
                maxLines: 1,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
