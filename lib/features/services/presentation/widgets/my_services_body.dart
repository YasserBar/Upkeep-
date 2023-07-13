import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../../../locations/presentation/widgets/appbar.dart';
import '../../../orders/presentation/pages/requests_servece_foundation.dart';
import '../../domain/entities/service_foundation.dart';
import '../bloc/foundation_services_bloc/foundation_services_bloc.dart';
import 'my_service_details_item.dart';

class MyServicesBody extends StatelessWidget {
  const MyServicesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 90),
              BlocBuilder<FoundationServicesBloc, FoundationServicesState>(
                builder: (context, state) {
                  if (state is SuccessFoundationServicesState) {
                    List<ServiceFoundation> myServices = state.myServices!;

                    if (myServices.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: Text("لا يوجد خدمات",
                              textDirection: TextDirection.rtl),
                        ),
                      );
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.builder(
                        controller: context
                            .read<FoundationServicesBloc>()
                            .scrollController,
                        clipBehavior: Clip.none,
                        physics: const BouncingScrollPhysics(),
                        itemCount: myServices.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < myServices.length) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: MySeviceDetailsItem(
                                onPressButton: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RequestServiceScreen(
                                        service: myServices[index],
                                      ),
                                    ),
                                  );
                                },
                                serviceKind: myServices[index].description,
                                serviceName: myServices[index].name,
                                imgUrl: myServices[index].photo,
                                service: myServices[index],
                              ),
                            );
                          } else {
                            return state.loaded
                                ? const SizedBox()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 40),
                                    child: state.hasMore
                                        ? const LoadingWidget(vertical: 0.0)
                                        : const Center(
                                            child: Text(
                                                "لا يوجد المزيد من الخدمات"),
                                          ),
                                  );
                          }
                        },
                      ),
                    );
                  } else if (state is LoadingFoundationServicesState) {
                    return const SizedBox(height: 500,child: Center(child: LoadingWidget()));
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
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBarrr(
            enableLocation: false,
            pageName: "خدماتي",
            setCountryId: () {},
            setCityId: () {},
            setRegionId: () {},
          ),
        ),
      ],
    );
  }
}
