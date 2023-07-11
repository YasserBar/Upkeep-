import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/pages/pages/empty_home_page.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../locations/presentation/widgets/appbar.dart';
import '../../../domain/entities/sliders_ads_jobs.dart';
import '../../bloc/job/job_bloc.dart';
import '../../../../../injection_countainer.dart' as di;
import '../../widgets/customer/job_container.dart';

class JobPage extends StatelessWidget {
  const JobPage({super.key});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double listViewWidth = (358 / 390) * width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 130),
              BlocProvider(
                create: (_) => di.sl<JobBloc>()..add(const GetAllJobEvent()),
                child: BlocBuilder<JobBloc, JobState>(
                  builder: (context, state) {
                    if (state is LoadingJobState) {
                      return const LoadingWidget(
                        vertical: 200,
                      );
                    } else if (state is LoadedJobState) {
                      List<SlidersAdsJobs> jobs = state.jobs!;

                      if (jobs.isEmpty) {
                        EmptyWidget(
                          height: height * 0.3 - 37,
                          text: 'لا يوجد فرص عمل',
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          controller: context.read<JobBloc>().scrollController,
                          clipBehavior: Clip.none,
                          physics: const BouncingScrollPhysics(),
                          itemCount: jobs.length + 1,
                          itemBuilder: (context, index) {
                            if (index < jobs.length) {
                              return JobContainer(
                                job: jobs[index],
                              );
                            } else {
                              return state.loaded
                                  ? const SizedBox()
                                  : Container(
                                      padding: const EdgeInsets.only(top: 20,bottom: 40),
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
                    } else if (state is FailureJobState) {
                      return Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(state.message));
                    }
                    return const LoadingWidget(
                      vertical: 200,
                    );
                  },
                ),
              )
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBarrr(
              enableLocation: false,
              pageName: 'فرص العمل',
              setCountryId: () {},
              setCityId: () {},
              setRegionId: () {},
            ),
          ),
        ],
      ),
    );
  }
}
