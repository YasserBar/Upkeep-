import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../../../ads&jobs/domain/entities/job_ad.dart';
import '../../../ads&jobs/presentation/bloc/get_jop_foundation_bloc/get_jop_foundation_bloc.dart';
import '../../../auth/presentation/widgets/title_of_listview.dart';
import 'get_all_jop_item.dart';

class GetAllJopFoundationListview extends StatelessWidget {
  const GetAllJopFoundationListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TiltleOfListview(
              title: "فرص العمل",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            BlocBuilder<GetJopFoundationBloc, GetJopFoundationState>(
              builder: (context, state) {
                if (state is SuccessGetJopFoundationState) {
                  List<JobAd> myJobFoundations = state.myJobFoundations!;
                  if (myJobFoundations.isEmpty) {
                    return const Center(child: Text("لا يوجد فرص عمل"));
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * .3,
                    width: double.infinity,
                    child: ListView.builder(
                      controller:
                          context.read<GetJopFoundationBloc>().scrollController,
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: myJobFoundations.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < myJobFoundations.length) {
                          return GetAllJopFoundationItem(
                            imgUrl: myJobFoundations[index].photo.toString(),
                            description: myJobFoundations[index].description,
                          );
                        } else {
                          return state.loaded
                              ? const SizedBox()
                              : Container(
                                  padding:
                                      const EdgeInsets.only(left: 20,right: 40),
                                  child: state.hasMore
                                      ? const LoadingWidget(vertical: 0.0)
                                      : const Center(
                                          child: Text(
                                              "لا يوجد المزيد من فرص العمل"),
                                        ),
                                );
                        }
                      },
                    ),
                  );
                } else if (state is ErrorGetJopFoundationState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(child: LoadingWidget());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
