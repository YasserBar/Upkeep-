// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/aseets/assets.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/helpers/loading_widget.dart';

class ServiceDetailsContainer extends StatelessWidget {
  const ServiceDetailsContainer({super.key, required this.photo});
  final String photo;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double photoWidth = (357 / 390) * width;
    // ignore: unnecessary_null_comparison
    return photo != null
        ? Container(
            // margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
            width: photoWidth,
            height: (245 / 357) * photoWidth,
            decoration: BoxDecoration(
              color: primaryColor,
              border: Border.all(color: secondryColor, width: 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(35),
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: photo.toString(),
              placeholder: (context, url) => const LoadingWidget(),
              errorWidget: (context, url, error) =>
                  // const Icon(Icons.error),
                  Image.asset(AssetClass.Logo),
              fadeOutDuration: const Duration(seconds: 1),
              fadeInDuration: const Duration(seconds: 3),
            ),
          )
        : Container(
            margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
            width: photoWidth,
            height: (245 / 357) * photoWidth,
            decoration: BoxDecoration(
              color: primaryColor,
              border: Border.all(color: secondryColor, width: 1),
              image: const DecorationImage(
                image: AssetImage(AssetClass.Logo),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(35),
              ),
            ),
          );
  }
}
