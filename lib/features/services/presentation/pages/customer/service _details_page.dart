// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/features/services/domain/entities/service_foundation.dart';

import '../../../../../core/pages/pages/empty_home_page.dart';
import '../../../../../core/theme/colors.dart';

import '../../../../../core/helpers/loading_widget.dart';
import '../../../../auth/presentation/widgets/custome_button.dart';
import '../../../../locations/presentation/widgets/appbar.dart';
import '../../bloc/availableTime/get_available_time_bloc.dart';
import '../../bloc/availableTime/get_available_time_event.dart';
import '../../bloc/availableTime/get_available_time_state.dart';
import '../../widgets/customer/available _appointments.dart';
import '../../widgets/customer/details.dart';
import '../../widgets/customer/service _details_container.dart';
import '../../widgets/customer/title_details.dart';
import '../../../../../injection_countainer.dart' as di;

class ServiceDetails extends StatelessWidget {
  final ServiceFoundation service;

  const ServiceDetails({
    super.key,
    required this.service,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double availaleTime = (318 / 390) * width;
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            AppBarrr(
              pageName: 'تفاصيل الخدمة',
              setCountryId: () {},
              setCityId: () {},
              setRegionId: () {},
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        ServiceDetailsContainer(
                          photo: service.photo,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TitleDetails(name: service.service_name),
                        const Divider(
                            color: primaryColor, thickness: 2, indent: 10),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0).copyWith(top: 0.0),
                          child: Details(
                            description: service.services_description,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 8, top: 10),
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  service.foundations_name,
                                  style: const TextStyle(
                                    color: secondryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        Container(
                            margin: const EdgeInsets.only(left: 20, right: 8),
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  service.foundations_description,
                                  style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ))),
                        Container(
                          margin: const EdgeInsets.only(left: 20, top: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.attach_money_outlined,
                                    color: secondryColor,
                                  ),
                                ),
                                Text(
                                  service.service_cost.toString(),
                                  style: const TextStyle(
                                    color: secondryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 20, top: 10),
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Icon(
                                        Icons.location_on_outlined,
                                        color: secondryColor,
                                      ),
                                    ),
                                    Text(
                                      "${service.countries_name}-${service.cities_name}-${service.regions_name}",
                                      style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ))),
                        Container(
                            margin: const EdgeInsets.only(left: 20, top: 10),
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Icon(
                                        Icons.watch_later_outlined,
                                        color: secondryColor,
                                      ),
                                    ),
                                    Text(
                                      service.duration_work,
                                      style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ))),
                        const SizedBox(
                          height: 30,
                        ),
                        BlocProvider(
                          create: (context) => di.sl<AvailableTimeBloc>(),
                          child: CustomButton(
                            title1: 'اطلب',
                            title2: "",
                            onPressButton: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30)),
                                ),
                                builder: (context) => ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                                  0.8 -
                                              50),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TitleDetails(
                                            name: service.service_name,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: availaleTime,
                                          height: (30 / 318) * availaleTime,
                                          child: const Text(
                                            'المواعيد المتاحة',
                                            style: TextStyle(
                                                color: secondryColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                        BlocProvider(
                                          create: (_) => di
                                              .sl<AvailableTimeBloc>()
                                            ..add(LoadedGetAvailableTimeEvent(
                                                id: service.id)),
                                          child: BlocBuilder<AvailableTimeBloc,
                                                  GetAvailableTimeState>(
                                              builder: (context, state) {
                                            if (state
                                                is LoadingGetAvailableTimeState) {
                                              return const LoadingWidget();
                                            } else if (state
                                                is LoadedGetAvailableTimeState) {
                                              if (state.date.isEmpty) {
                                                return EmptyWidget(
                                                  height: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.3 -
                                                      37,
                                                  text: 'لا يوجد مواعيد متاحة',
                                                );
                                              }
                                              if (kDebugMode) {
                                                print(state.date);
                                              }
                                              return Booking(
                                                dateList: state.date,
                                                id: service.id,
                                              );
                                            } else if (state
                                                is FailureGetAvailableTimeState) {
                                              return Center(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Text(
                                                        state.message,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 30.0),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.blueGrey[50],
                                                        child: IconButton(
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    AvailableTimeBloc>()
                                                                .add(
                                                                  LoadedGetAvailableTimeEvent(
                                                                      id: service
                                                                          .id),
                                                                );
                                                          },
                                                          icon: const Icon(
                                                            Icons.replay_sharp,
                                                            color: secondryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }

                                            return Container();
                                          }),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
