import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/pages/pages/empty_pages.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../locations/presentation/widgets/appbar.dart';
import '../../../domain/entities/filter_foundations.dart';
import '../../../domain/entities/foundation.dart';
import '../../bloc/filterFoundations/filter_foundations_bloc.dart';
import '../../widgets/customerWidget/servise_provider_container.dart';
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
  ServiceProviderPage({
    super.key,
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 117),
              BlocProvider(
                create: (_) => di.sl<FilterFoundationsBloc>()
                  ..add(
                    LoadedFilterFoundationsEvent(
                      filterFoundations: FilterFoundations(
                        countryId: countryId,
                        cityId: cityId,
                        regionId: regionId,
                        subServiceId: subServiceId,
                      ),
                    ),
                  ),
                child:
                    BlocBuilder<FilterFoundationsBloc, FilterFoundationsState>(
                  builder: (context, state) {
                    context.read<FilterFoundationsBloc>().filterFoundations =
                        FilterFoundations(
                      countryId: countryId,
                      cityId: cityId,
                      regionId: regionId,
                      subServiceId: subServiceId,
                    );
                    if (state is LoadingFilterFoundationsState) {
                      return const Center(child: LoadingWidget(vertical: 200));
                    } else if (state is LoadedFilterFoundationsState) {
                      List<Foundation> foundations = state.foundations!;
                      if (foundations.isEmpty) {
                        return const EmptyPages();
                      }
                      return Expanded(
                        child: ListView.builder(
                          controller: context
                              .read<FilterFoundationsBloc>()
                              .scrollController,
                          clipBehavior: Clip.none,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: foundations.length + 1,
                          itemBuilder: (context, index) {
                            if (index < foundations.length) {
                              return ServiceProviderContainer(
                                id: foundations[index].id,
                                name: foundations[index].name,
                                description: foundations[index].description,
                                photo: foundations[index].photo,
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
                                                  "لا يوجد المزيد من مزودي الخدمة"),
                                            ),
                                    );
                            }
                          },
                        ),
                      );
                    } else if (state is FailureFilterFoundationsState) {
                      return Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(state.message));
                    }
                    return const Center(child: LoadingWidget(vertical: 200));
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
              pageName: 'مزودي الخدمة',
              setCountryId: setCountryId,
              setCityId: setCityId,
              setRegionId: setRegionId,
            ),
          ),
        ],
      ),
    );
  }
}
