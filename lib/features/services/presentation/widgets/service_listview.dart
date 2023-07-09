import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/presentation/widgets/service_item_wedgit.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../../../auth/presentation/widgets/title_of_listview.dart';
import '../../domain/entities/service_foundation.dart';
import '../bloc/foundation_services_bloc/foundation_services_bloc.dart';

class ServiceListview extends StatelessWidget {
  const ServiceListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TiltleOfListview(
              title: 'خدماتي',
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            BlocBuilder<FoundationServicesBloc, FoundationServicesState>(
              builder: (context, state) {
                if (state is LoadingFoundationServicesState) {
                  return const Center(child: LoadingWidget());
                } else if (state is SuccessFoundationServicesState) {
                  List<ServiceFoundation> myServices = state.myServices!;
                  if (myServices.isEmpty) {
                    return const Center(child: Text("لا يوجد خدمات "));
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * .15,
                    width: double.infinity,
                    child: ListView.builder(
                      controller: context
                          .read<FoundationServicesBloc>()
                          .scrollController,
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: myServices.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < myServices.length) {
                          return ServiceShowWidget(
                            text: myServices[index].description,
                            imgUrl: myServices[index].durationWork,
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
                                          child:
                                              Text("لا يوجد المزيد من الخدمات"),
                                        ),
                                );
                        }
                      },
                    ),
                  );
                } else if (state is ErrorFoundationServicesState) {
                  return Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(state.message));
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
