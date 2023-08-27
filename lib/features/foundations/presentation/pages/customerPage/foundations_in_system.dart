// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/core/helpers/loading_widget.dart';
import 'package:upkeep_plus/core/theme/colors.dart';
import 'package:upkeep_plus/features/foundations/domain/entities/filter_foundations.dart';
import 'package:upkeep_plus/features/foundations/domain/entities/foundation.dart';
import 'package:upkeep_plus/features/foundations/presentation/bloc/filterFoundationsInSystem/filter_foundations_in_system_bloc.dart';
import 'package:upkeep_plus/features/foundations/presentation/pages/customerPage/customer_service_page.dart';
import 'package:upkeep_plus/features/foundations/presentation/widgets/foundation_widget.dart';
import 'package:upkeep_plus/features/locations/presentation/widgets/appbar.dart';
import 'package:upkeep_plus/main.dart';

import '../../../../../injection_countainer.dart' as di;

class FoundationsInSystem extends StatefulWidget {
  int? countryId;
  int? cityId;
  int? regionId;
  int? subServiceId;
  Function setCountryId;
  Function setRegionId;
  Function setCityId;
  FoundationsInSystem({
    Key? key,
    this.countryId,
    this.cityId,
    this.regionId,
    this.subServiceId,
    required this.setCountryId,
    required this.setRegionId,
    required this.setCityId,
  }) : super(key: key);

  @override
  State<FoundationsInSystem> createState() => _FoundationsInSystemState();
}

class _FoundationsInSystemState extends State<FoundationsInSystem> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FilterFoundationsInSystemBloc>(
      create: (context) => di.sl<FilterFoundationsInSystemBloc>()
        ..add(LoadedFilterFoundationsInSystemEvent(
          filterFoundations: FilterFoundations(
            countryId: widget.countryId,
            cityId: widget.cityId,
            regionId: widget.regionId,
            subServiceId: null,
          ),
        )),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 90, width: double.infinity),
                BlocBuilder<FilterFoundationsInSystemBloc,
                    FilterFoundationsInSystemState>(
                  builder: (context, state) {
                    if (kDebugMode) {
                      print("${state.hasMore}&&&&&&&&&&&&&&&&&&&&&&&&&&&");
                    }
                    if (state is LoadedFilterFoundationsInSystemState) {
                      context.read<FilterFoundationsInSystemBloc>().filterFoun =
                          FilterFoundations(
                        countryId: widget.countryId,
                        cityId: widget.cityId,
                        regionId: widget.regionId,
                        subServiceId: null,
                      );
                      List<Foundation> foundations = state.foundations!;
                      if (foundations.isEmpty) {
                        return const Center(
                          child: Text("لا يوجد مؤسسات"),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          controller: context
                              .read<FilterFoundationsInSystemBloc>()
                              .scrollController,
                          clipBehavior: Clip.none,
                          physics: const BouncingScrollPhysics(),
                          itemCount: foundations.length + 1,
                          itemBuilder: (context, index) {
                            if (index < foundations.length) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: FoundationWidget(
                                  text: foundations[index].name,
                                  description: foundations[index].description,
                                  imgUrl: foundations[index].photo,
                                  onTap: () {
                                    if (kDebugMode) {
                                      print(globalFoundationId);
                                      print(
                                          "jjjjjjjjjjjjjjjjjj----------------------------------------------------------------------");
                                    }
                                    globalFoundationId = foundations[index].id;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ServiceProviderPage(
                                          notFoundation: false,
                                          countryId: null,
                                          cityId: null,
                                          regionId: null,
                                          subServiceId: null,
                                          setCountryId: () {},
                                          setCityId: () {},
                                          setRegionId: () {},
                                        ),
                                      ),
                                    );
                                  },
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
                                                  "لا يوجد المزيد من مزودي الخدمة"),
                                            ),
                                    );
                            }
                          },
                        ),
                      );
                    } else if (state is LoadingFilterFoundationsInSystemState) {
                      return Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .9,
                          child: const LoadingWidget(),
                        ),
                      );
                    } else if (state is FailureFilterFoundationsInSystemState) {
                      return Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .9,
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
                                          .read<FilterFoundationsInSystemBloc>()
                                          .add(
                                            const LoadedFilterFoundationsInSystemEvent(
                                              filterFoundations:
                                                  FilterFoundations(
                                                countryId: null,
                                                cityId: null,
                                                regionId: null,
                                                subServiceId: null,
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
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 4),
                child: AppBarrr(
                  filterF: true,
                  enableLocation: true,
                  pageName: "مزودي الخدمة",
                  setCountryId: widget.setCountryId,
                  setCityId: widget.setCityId,
                  setRegionId: widget.setRegionId,
                )),
          ],
        ),
      ),
    );
  }
}
