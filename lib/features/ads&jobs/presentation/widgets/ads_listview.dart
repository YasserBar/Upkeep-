import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/core/theme/colors.dart';
import 'package:upkeep_plus/main.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../../../auth/presentation/widgets/title_of_listview.dart';
import '../../domain/entities/job_ad.dart';
import '../bloc/ads_foundation_bloc/ads_foundation_bloc.dart';
import 'ads_item_widget.dart';

class AdsListview extends StatelessWidget {
  const AdsListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const TiltleOfListview(
            title: 'الاعلانات',
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<AdsFoundationBloc, AdsFoundationState>(
            builder: (context, state) {
              if (state is SuccessAdsFoundationState) {
                List<JobAd> myAdsFoundations = state.myAdsFoundations!;
                if (myAdsFoundations.isEmpty) {
                  return const Center(child: Text("لا يوجد اعلانات "));
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height * .38,
                  width: double.infinity,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.builder(
                      controller:
                          context.read<AdsFoundationBloc>().scrollController,
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: myAdsFoundations.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < myAdsFoundations.length) {
                          return AdsItemWidget(
                            imgUrl: myAdsFoundations[index].photo.toString(),
                            title: myAdsFoundations[index].title,
                            description: myAdsFoundations[index].description,
                          );
                        } else {
                          return state.loaded
                              ? const SizedBox()
                              : Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 40),
                                  child: state.hasMore
                                      ? const LoadingWidget(vertical: 0.0)
                                      : const Center(
                                          child: Text(
                                              "لا يوجد المزيد من الاعلانات"),
                                        ),
                                );
                        }
                      },
                    ),
                  ),
                );
              } else if (state is LoadingAdsFoundationState) {
                return const Center(child: LoadingWidget());
              } else if (state is ErrorAdsFoundationState) {
                return Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blueGrey[50],
                        child: IconButton(
                          onPressed: () {
                            context.read<AdsFoundationBloc>().add(
                                ShowAllAdsForFoundationEvent(
                                    id: globalFoundationId!));
                          },
                          icon: const Icon(
                            Icons.replay_sharp,
                            color: secondryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
