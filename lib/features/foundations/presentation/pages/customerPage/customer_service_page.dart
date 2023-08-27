import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/core/theme/colors.dart';
import 'package:upkeep_plus/features/foundations/presentation/widgets/customerWidget/servicefoundation.dart';
import 'package:upkeep_plus/features/services/domain/entities/service_foundation.dart';
import '../../../../../core/pages/pages/empty_pages.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../locations/presentation/widgets/appbar.dart';
import '../../../domain/entities/filter_foundations.dart';
import '../../bloc/filterFoundations/filter_foundations_bloc.dart';
import '../../../../../../../injection_countainer.dart' as di;

// ignore: must_be_immutable
class ServiceProviderPage extends StatelessWidget {
  int? countryId;
  int? cityId;
  int? regionId;
  int? subServiceId;
  Function setCountryId;
  Function setRegionId;
  Function setCityId;
  bool notFoundation;
  ServiceProviderPage({
    super.key,
    this.notFoundation = true,
    this.countryId,
    this.cityId,
    this.regionId,
    this.subServiceId,
    required this.setCountryId,
    required this.setRegionId,
    required this.setCityId,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => di.sl<FilterServicesFoundationsBloc>()
          ..add(
            LoadedFilterServicesFoundationsEvent(
              filterFoundations: FilterFoundations(
                countryId: countryId,
                cityId: cityId,
                regionId: regionId,
                subServiceId: subServiceId,
              ),
            ),
          ),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 100),
                BlocBuilder<FilterServicesFoundationsBloc,
                    FilterServicesFoundationsState>(
                  builder: (context, state) {
                    context
                        .read<FilterServicesFoundationsBloc>()
                        .filterServicesFoundations = FilterFoundations(
                      countryId: countryId,
                      cityId: cityId,
                      regionId: regionId,
                      subServiceId: subServiceId,
                    );
                    if (state is LoadingFilterServicesFoundationsState) {
                      return const Center(child: LoadingWidget(vertical: 200));
                    } else if (state is LoadedFilterServicesFoundationsState) {
                      List<ServiceFoundation> servicefoundations =
                          state.servicefoundations!;
                      if (servicefoundations.isEmpty) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            EmptyPages(),
                            Text("لا يوجد خدمات"),
                          ],
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          controller: context
                              .read<FilterServicesFoundationsBloc>()
                              .scrollController,
                          clipBehavior: Clip.none,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: servicefoundations.length + 1,
                          itemBuilder: (context, index) {
                            if (index < servicefoundations.length) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: ServicefoundationsDetailsItem(
                                  service: servicefoundations[index],
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
                    } else if (state is FailureFilterServicesFoundationsState) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                                    context
                                        .read<FilterServicesFoundationsBloc>()
                                        .add(
                                          LoadedFilterServicesFoundationsEvent(
                                            filterFoundations:
                                                FilterFoundations(
                                              countryId: countryId,
                                              cityId: cityId,
                                              regionId: regionId,
                                              subServiceId: subServiceId,
                                            ),
                                          ),
                                        );
                                  },
                                  icon: const Icon(
                                    Icons.replay_sharp,
                                    color: secondryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return const Center(child: LoadingWidget(vertical: 200));
                  },
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBarrr(
                subServiceId: subServiceId,
                enableLocation: notFoundation,
                pageName: 'الخدمات',
                setCountryId: setCountryId,
                setCityId: setCityId,
                setRegionId: setRegionId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
