import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../core/aseets/assets.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/helpers/loading_widget.dart';
import '../../../../services/presentation/pages/customer/service _details_page.dart';

class ServiceProviderContainer extends StatelessWidget {
  final String name;
  final String description;
  final String? photo;
  final int id;
  const ServiceProviderContainer({
    super.key,
    required this.name,
    required this.description,
    required this.photo,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double conWidth = (358 / 390) * width;
    double titleWidth = (141 / 358) * conWidth;
    double photoWidth = (143 / 358) * conWidth;
    double disWidth = (190 / 358) * conWidth;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ServiceDetails(
              name: name,
              photo: photo,
              description: description,
              id: id,
            ),
          ),
        ),
        child: Container(
          width: conWidth,
          height: (133 / 358) * conWidth,
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(35))),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5, top: 10),
                    width: titleWidth,
                    height: (28 / 141) * titleWidth,
                    // color: Colors.black12,

                    child: AutoSizeText(
                      name,
                      maxFontSize: 18,
                      minFontSize: 10,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: secondryColor,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Container(
                      width: disWidth,
                      height: (85 / 190) * disWidth,
                      margin: const EdgeInsets.only(left: 15, right: 5),
                      child: AutoSizeText(
                        description,
                        maxFontSize: 14,
                        minFontSize: 8,
                        maxLines: 3,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                        textDirection: TextDirection.rtl,
                      )),
                ],
              ),
              // ignore: unnecessary_null_comparison
              photo != null
                  ? Container(
                      width: photoWidth,
                      height: (111 / 143) * photoWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: secondryColor, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: CachedNetworkImage(
                        imageUrl: photo!,
                        placeholder: (context, url) => const LoadingWidget(),
                        errorWidget: (context, url, error) =>
                            Image.asset(AssetClass.Logo),
                        fadeOutDuration: const Duration(seconds: 1),
                        fadeInDuration: const Duration(seconds: 3),
                      ),
                    )
                  : Container(
                      width: photoWidth,
                      height: (111 / 143) * photoWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: secondryColor, width: 1),
                        image: const DecorationImage(
                          image: AssetImage(AssetClass.Logo),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
