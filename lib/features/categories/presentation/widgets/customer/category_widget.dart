import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/aseets/assets.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/helpers/loading_widget.dart';
import '../../bloc/subservice/subservice_bloc.dart';

class CategoryWidget extends StatelessWidget {
  final void Function(int) onTap;
  final int id;
  final String name;
  final String? photo;
  const CategoryWidget({
    super.key,
    required this.onTap,
    required this.id,
    required this.name,
    required this.photo,
  });
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double conheight = height * 0.3;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 100,
        height: conheight,
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  onTap(id);
                  BlocProvider.of<SubServiceBloc>(context)
                      .add(GetAllSubServiceEvent(id));
                },
                child: photo != null
                    ? Container(
                        width: 98,
                        height: 98,
                        decoration: BoxDecoration(
                            border: Border.all(color: secondryColor, width: 3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100))),
                        child: CachedNetworkImage(
                          imageUrl: photo.toString(),
                          placeholder: (context, url) => const LoadingWidget(),
                          errorWidget: (context, url, error) =>
                              Image.asset(AssetClass.Logo),
                          fadeOutDuration: const Duration(seconds: 1),
                          fadeInDuration: const Duration(seconds: 3),
                        ),
                      )
                    : Container(
                        width: 98,
                        height: 98,
                        decoration: BoxDecoration(
                            border: Border.all(color: secondryColor, width: 3),
                            image: const DecorationImage(
                              image: AssetImage(AssetClass.Logo),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100))),
                      )),
            const SizedBox(
              height: 15,
            ),
            AutoSizeText(
              name,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxFontSize: 16,
              minFontSize: 1,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: secondryColor),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
