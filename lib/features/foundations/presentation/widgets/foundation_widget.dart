import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../core/aseets/assets.dart';
import '../../../../../core/theme/colors.dart';

class FoundationWidget extends StatelessWidget {
  const FoundationWidget({
    super.key,
    required this.text,
    required this.description,
    required this.imgUrl,
    this.onTap,
  });
  final String text;
  final String description;
  final String imgUrl;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(37)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: MediaQuery.of(context).size.width * .4,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * .05,
                            ),
                            child: RichText(
                              textDirection: TextDirection.rtl,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: text,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: secondryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width * .47,
                    decoration: BoxDecoration(
                      border: Border.all(color: secondryColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                    ),
                    child: Container(
                      child: imgUrl !=
                              "http://upkeepplus.tech/jobs_and_service_class_photo"
                          ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: imgUrl,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : Image.asset(AssetClass.Ads),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
