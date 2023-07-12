import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../core/aseets/assets.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/helpers/loading_widget.dart';

class AdsWidget extends StatelessWidget {
  final String? photo;
  final String title;
  final String description;

  const AdsWidget(
      {super.key,
      required this.photo,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double conWidth = (330 / 390) * width;
    double opConWidth = (200 / 318) * conWidth;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          // ignore: unnecessary_null_comparison
          photo != null
              ? Container(
                  width: conWidth,
                  height: (174 / 330) * conWidth,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    border: Border.all(color: secondryColor, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: photo.toString(),
                    placeholder: (context, url) => const LoadingWidget(),
                    errorWidget: (context, url, error) =>
                        // const Icon(Icons.error),
                        Image.asset(
                      AssetClass.Logo,
                    ),
                    fadeOutDuration: const Duration(seconds: 1),
                    fadeInDuration: const Duration(seconds: 3),
                  ),
                )
              : Container(
                  width: conWidth,
                  height: (174 / 330) * conWidth,
                  decoration: BoxDecoration(
                    border: Border.all(color: secondryColor, width: 1),
                    image: const DecorationImage(
                      image: AssetImage(AssetClass.Logo),
                    ),
                    color: primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black12.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            margin: const EdgeInsets.only(top: 52, right: 20),
            padding: const EdgeInsets.only(right: 8, top: 4),
            width: opConWidth,
            height: (90 / 200) * opConWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: secondryColor),
                  textDirection: TextDirection.rtl,
                ),
                AutoSizeText(
                  description.toString(),
                  maxFontSize: 12,
                  minFontSize: 10,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
