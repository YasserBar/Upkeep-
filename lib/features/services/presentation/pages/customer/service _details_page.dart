// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/pages/pages/empty_home_page.dart';
import '../../../../../core/theme/colors.dart';

import '../../../../../core/utilities/loading_widget.dart';
import '../../../../auth/presentation/widgets/custome_button.dart';
import '../../../../locations/presentation/widgets/appbar.dart';
import '../../bloc/availableTime/get_available_time_bloc.dart';
import '../../bloc/availableTime/get_available_time_event.dart';
import '../../bloc/availableTime/get_available_time_state.dart';
import '../../widgets/customer/available _appointments.dart';
import '../../widgets/customer/details.dart';
import '../../widgets/customer/price.dart';
import '../../widgets/customer/service _details_container.dart';
import '../../widgets/customer/title_details.dart';
import '../../../../../injection_countainer.dart' as di;

class ServiceDetails extends StatelessWidget {
  final String name;
  final String description;
  final String? photo;
  final int id;
  const ServiceDetails({
    super.key,
    required this.name,
    required this.description,
    this.photo,
    required this.id,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double availaleTime = (318 / 390) * width;
    return Scaffold(
      body: Column(
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ServiceDetailsContainer(
                        photo: photo.toString(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TitleDetails(name: name),
                      const Divider(
                          color: primaryColor, thickness: 2, indent: 10),
                      const Price(),
                      const Divider(),
                      Details(
                        description: description,
                      ),
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
                                      TitleDetails(
                                        name: name,
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
                                        create: (_) =>
                                            di.sl<AvailableTimeBloc>()
                                              ..add(LoadedGetAvailableTimeEvent(
                                                  id: id)),
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
                                              id: id,
                                            );
                                          } else if (state
                                              is FailureGetAvailableTimeState) {
                                            return Center(
                                              child: Text(state.message),
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
    );
  }
}
