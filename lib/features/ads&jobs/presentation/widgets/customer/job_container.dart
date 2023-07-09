import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../core/aseets/assets.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/utilities/loading_widget.dart';
import '../../../domain/entities/sliders_ads_jobs.dart';

class JobContainer extends StatelessWidget {
  final SlidersAdsJobs job;
  const JobContainer({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double conWidth = (358 / 390) * width;
    double photoWidth = (347 / 358) * conWidth;
    double textWidth = (288 / 358) * conWidth;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(5),
        width: conWidth,
        height: (343 / 358) * conWidth,
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(42))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ignore: unnecessary_null_comparison
            job.photo != null
                ? Container(
                    width: photoWidth,
                    height: (212 / 347) * photoWidth,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: secondryColor, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(42))),
                    child: CachedNetworkImage(
                      imageUrl: job.photo.toString(),
                      placeholder: (context, url) =>
                          // const CircularProgressIndicator(),
                          const LoadingWidget(),
                      errorWidget: (context, url, error) =>
                          // const Icon(Icons.error),
                          Image.asset(AssetClass.Logo),
                    ),
                  )
                : Container(
                    width: photoWidth,
                    height: (212 / 347) * photoWidth,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: secondryColor, width: 1),
                        image: const DecorationImage(
                          image: AssetImage(AssetClass.Logo),
                          fit: BoxFit.fill,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(42))),
                  ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              width: textWidth,
              height: (78 / 288) * textWidth,
              child: AutoSizeText(
                job.description.toString(),
                maxFontSize: 14,
                minFontSize: 2,
                maxLines: 3,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
