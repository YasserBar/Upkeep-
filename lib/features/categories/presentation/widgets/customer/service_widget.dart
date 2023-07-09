import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../core/aseets/assets.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/helpers/loading_widget.dart';
import '../../../../foundations/presentation/pages/customerPage/customer_service_page.dart';

// ignore: must_be_immutable
class ServiceWidget extends StatelessWidget {
  int? countryId;
  int? cityId;
  int? regionId;
  final int id;
  final String description;
  final String? photo;
  Function setCountryId;
  Function setRegionId;
  Function setCityId;
  ServiceWidget({
    super.key,
    this.countryId,
    this.cityId,
    this.regionId,
    required this.setCountryId,
    required this.setRegionId,
    required this.setCityId,
    required this.id,
    required this.description,
    required this.photo,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double conWidth = (318 / 390) * width;
    double photoWidth = (143 / 318) * conWidth;
    double textWidth = (148 / 318) * conWidth;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ServiceProviderPage(
                countryId: countryId,
                cityId: cityId,
                regionId: regionId,
                subServiceId: id,
                setCountryId: setCountryId,
                setCityId: setCityId,
                setRegionId: setRegionId,
              ),
            ),
          );
        },
        child: Container(
          width: conWidth,
          height: (133 / 318) * conWidth,
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          child: Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 10, left: 5),
                  width: textWidth,
                  child: AutoSizeText(
                    description,
                    maxFontSize: 14,
                    minFontSize: 10,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textDirection: TextDirection.rtl,
                  )),
              photo != null
                  ? Container(
                      height: (111 / 143) * photoWidth,
                      width: photoWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: secondryColor, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
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
                      height: (111 / 143) * photoWidth,
                      width: photoWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: const DecorationImage(
                          image: AssetImage(AssetClass.Logo),
                        ),
                        border: Border.all(color: secondryColor, width: 1),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
