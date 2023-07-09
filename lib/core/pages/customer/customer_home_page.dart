import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/ads&jobs/domain/entities/sliders_ads_jobs.dart';
import '../../../features/ads&jobs/presentation/bloc/ads/ads_bloc.dart';
import '../../../features/ads&jobs/presentation/widgets/customer/ads_widget.dart';
import '../../../features/categories/domain/entities/service.dart';
import '../../../features/categories/presentation/bloc/categories/categories_bloc.dart';
import '../../../features/categories/presentation/bloc/categories/categories_state.dart';
import '../../../features/categories/presentation/bloc/subservice/subservice_bloc.dart';
import '../../../features/categories/presentation/widgets/customer/category_widget.dart';
import '../../../features/categories/presentation/widgets/customer/service_widget.dart';
import '../../../features/locations/presentation/widgets/appbar.dart';
import '../../../injection_countainer.dart' as di;
import '../../theme/colors.dart';
import '../../utilities/loading_widget.dart';
import '../pages/empty_home_page.dart';

// // ignore: must_be_immutable
// class CustomerHomePage extends StatelessWidget {
//   int? countryId;
//   int? cityId;
//   int? regionId;
//   Function setCountryId;
//   Function setRegionId;
//   Function setCityId;
//   CustomerHomePage({
//     this.countryId,
//     this.cityId,
//     this.regionId,
//     required this.setCountryId,
//     required this.setRegionId,
//     required this.setCityId,
//   });
//   bool visualService = false;
//   int id = 0;
//   void updateVisualService(int id) {
//     this.id = id;
//     visualService = !visualService;
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;

//     double conWidth = (330 / 390) * width;

//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               const SizedBox(height: 117),
//               MultiBlocProvider(
//                 providers: [
//                   BlocProvider(
//                       create: (_) =>
//                           di.sl<AdsBloc>()..add(const GetAllAdsEvent())),
//                   BlocProvider(
//                       create: (_) => di.sl<CategoriesBloc>()
//                         ..add(const GetAllCategoriesEvent())),
//                   BlocProvider(create: (_) => di.sl<SubServiceBloc>()),
//                 ],
//                 child: Expanded(
//                   flex: 1,
//                   child: SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     clipBehavior: Clip.none,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         //اعلانات
//                         nameContext('الاعلانات'),
//                         const SizedBox(
//                           height: 2,
//                         ),

//                         //Bloc Ads
//                         BlocBuilder<AdsBloc, AdsState>(
//                           builder: (context, state) {
//                             if (state is LoadingAdsState) {
//                               return const LoadingWidget();
//                             } else if (state is LoadedAdsState) {
//                               List<SlidersAdsJobs> ads = state.ads!;
//                               if (ads.isEmpty) {
//                                 return EmptyWidget(
//                                   height: height * 0.3 - 37,
//                                   text: 'لا يوجد اعلانات',
//                                 );
//                               }
//                               return SizedBox(
//                                 width: MediaQuery.of(context).size.width,
//                                 height: (174 / 318) * conWidth,
//                                 child: Expanded(
//                                   flex: 1,
//                                   child: ListView.builder(
//                                     controller: context
//                                         .read<AdsBloc>()
//                                         .scrollController,
//                                     clipBehavior: Clip.none,
//                                     physics: const BouncingScrollPhysics(),
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount: ads.length + 1,
//                                     itemBuilder: (context, index) {
//                                       if (index < ads.length) {
//                                         return AdsWidget(
//                                           photo: ads[index].photo,
//                                           description: ads[index].description,
//                                         );
//                                       } else {
//                                         return state.loaded
//                                             ? const SizedBox()
//                                             : Container(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10),
//                                                 child: state.hasMore
//                                                     ? const LoadingWidget()
//                                                     : const Center(
//                                                         child: Text(
//                                                             "لا يوجد المزيد من الاعلانات"),
//                                                       ),
//                                               );
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               );
//                             } else if (state is FailureAdsState) {
//                               return Center(child: Text(state.message));
//                             }
//                             return const LoadingWidget();
//                           },
//                         ),

//                         const SizedBox(
//                           height: 20,
//                         ),
//                         // التصنيفات
//                         nameContext('التصنيفات'),

//                         const SizedBox(
//                           height: 2,
//                         ),

//                         BlocBuilder<CategoriesBloc, CategoriesState>(
//                             builder: (context, state) {
//                           if (state is LoadingCategoriesState) {
//                             return const LoadingWidget();
//                           } else if (state is LoadedCategoriesState) {
//                             List<Service> categories = state.categories!;
//                             if (categories.isEmpty) {
//                               return EmptyWidget(
//                                 height: height * 0.3 - 37,
//                                 text: 'لا يوجد تصنيفات',
//                               );
//                             }
//                             return SizedBox(
//                               width: width,
//                               height: height * 0.3,
//                               child: Expanded(
//                                 flex: 1,
//                                 child: ListView.builder(
//                                   controller: context
//                                       .read<CategoriesBloc>()
//                                       .scrollController,
//                                   clipBehavior: Clip.none,
//                                   physics: const BouncingScrollPhysics(),
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: categories.length + 1,
//                                   itemBuilder: (context, index) {
//                                     if (index < categories.length) {
//                                       return CategoryWidget(
//                                         id: categories[index].id,
//                                         photo: categories[index].photo,
//                                         name: categories[index].name,
//                                         onTap: updateVisualService,
//                                       );
//                                     } else {
//                                       return state.loaded
//                                           ? const SizedBox()
//                                           : Container(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 10),
//                                               child: state.hasMore
//                                                   ? const LoadingWidget()
//                                                   : const Center(
//                                                       child: Text(
//                                                           "لا يوجد المزيد من التصنيفات"),
//                                                     ),
//                                             );
//                                     }
//                                   },
//                                 ),
//                               ),
//                             );
//                           } else if (state is FailureCategoriesState) {
//                             return Center(child: Text(state.message));
//                           }
//                           return const LoadingWidget();
//                         }),

//                         BlocBuilder<SubServiceBloc, SubServiceState>(
//                             builder: (context, state) {
//                           context.read<SubServiceBloc>().serviceId = id;
//                           if (state is LoadingSubServiceState) {
//                             return const Center(child: LoadingWidget());
//                           } else if (state is LoadedSubServiceState) {
//                             List<Service> subService = state.subService!;
//                             if (subService.isEmpty) {
//                               return EmptyWidget(
//                                 height: height * 0.3 - 37,
//                                 text: 'لا يوجد خدمات',
//                               );
//                             }
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 //الخدمات
//                                 nameContext('الخدمات'),
//                                 Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: SizedBox(
//                                     width: MediaQuery.of(context).size.width,
//                                     height: height * 0.2 - 10,
//                                     child: Expanded(
//                                       flex: 1,
//                                       child: ListView.builder(
//                                         controller: context
//                                             .read<SubServiceBloc>()
//                                             .scrollController,
//                                         clipBehavior: Clip.none,
//                                         physics: const BouncingScrollPhysics(),
//                                         scrollDirection: Axis.horizontal,
//                                         itemCount: subService.length + 1,
//                                         itemBuilder: (context, index) {
//                                           if (index < subService.length) {
//                                             return ServiceWidget(
//                                               description:
//                                                   subService[index].description,
//                                               id: subService[index].id,
//                                               photo: subService[index].photo,
//                                               countryId: countryId,
//                                               cityId: cityId,
//                                               regionId: regionId,
//                                               setCountryId: setCountryId,
//                                               setCityId: setCityId,
//                                               setRegionId: setRegionId,
//                                             );
//                                           } else {
//                                             return state.loaded
//                                                 ? const SizedBox()
//                                                 : Container(
//                                                     padding: const EdgeInsets
//                                                             .symmetric(
//                                                         horizontal: 10),
//                                                     child: state.hasMore
//                                                         ? const LoadingWidget()
//                                                         : const Center(
//                                                             child: Text(
//                                                                 "لا يوجد المزيد من الخدمات"),
//                                                           ),
//                                                   );
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           } else if (state is FailureSubServiceState) {
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 //الخدمات
//                                 nameContext('الخدمات'),
//                                 Center(child: Text(state.message)),
//                               ],
//                             );
//                           }
//                           return const SizedBox();
//                         }),

//                         const SizedBox(
//                           height: 20,
//                           width: double.infinity,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: AppBarrr(
//               logout: true,
//               pageName: 'الرئيسية',
//               setCountryId: setCountryId,
//               setCityId: setCityId,
//               setRegionId: setRegionId,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget nameContext(String name) {
//     return Container(
//       margin: const EdgeInsets.only(right: 20),
//       child: Text(
//         name,
//         style: const TextStyle(
//             fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
//       ),
//     );
//   }
// }
class CustomerHomePage extends StatefulWidget {
  final int? countryId;
  final int? cityId;
  final int? regionId;
  final Function setCountryId;
  final Function setRegionId;
  final Function setCityId;

  const CustomerHomePage({
    Key? key,
    this.countryId,
    this.cityId,
    this.regionId,
    required this.setCountryId,
    required this.setRegionId,
    required this.setCityId,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  bool visualService = false;
  int id = 0;

  void updateVisualService(int id) {
    setState(() {
      this.id = id;
      visualService = !visualService;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double conWidth = (330 / 390) * width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 117),
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) =>
                        di.sl<AdsBloc>()..add(const GetAllAdsEvent()),
                  ),
                  BlocProvider(
                    create: (_) => di.sl<CategoriesBloc>()
                      ..add(const GetAllCategoriesEvent()),
                  ),
                  BlocProvider(
                    create: (_) => di.sl<SubServiceBloc>(),
                  ),
                ],
                child: Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    clipBehavior: Clip.none,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 20),
                        // اعلانات
                        nameContext('الاعلانات'),
                        const SizedBox(height: 2),

                        // Bloc Ads
                        BlocBuilder<AdsBloc, AdsState>(
                          builder: (context, state) {
                            if (state is LoadingAdsState) {
                              return const LoadingWidget();
                            } else if (state is LoadedAdsState) {
                              List<SlidersAdsJobs> ads = state.ads!;
                              if (ads.isEmpty) {
                                return EmptyWidget(
                                  height: height * 0.3 - 37,
                                  text: 'لا يوجد اعلانات',
                                );
                              }
                              return SizedBox(
                                height: (174 / 318) * conWidth,
                                child: ListView.builder(
                                  controller:
                                      context.read<AdsBloc>().scrollController,
                                  clipBehavior: Clip.none,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: ads.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index < ads.length) {
                                      return AdsWidget(
                                        photo: ads[index].photo,
                                        description: ads[index].description,
                                      );
                                    } else {
                                      return state.loaded
                                          ? const SizedBox()
                                          : Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: state.hasMore
                                                  ? const LoadingWidget()
                                                  : const Center(
                                                      child: Text(
                                                          "لا يوجد المزيد من الاعلانات"),
                                                    ),
                                            );
                                    }
                                  },
                                ),
                              );
                            } else if (state is FailureAdsState) {
                              return Center(child: Text(state.message));
                            }
                            return const LoadingWidget();
                          },
                        ),

                        const SizedBox(height: 20),
                        // التصنيفات
                        nameContext('التصنيفات'),
                        const SizedBox(height: 2),

                        BlocBuilder<CategoriesBloc, CategoriesState>(
                          builder: (context, state) {
                            if (state is LoadingCategoriesState) {
                              return const LoadingWidget();
                            } else if (state is LoadedCategoriesState) {
                              List<Service> categories = state.categories!;
                              if (categories.isEmpty) {
                                return EmptyWidget(
                                  height: height * 0.3 - 37,
                                  text: 'لا يوجد تصنيفات',
                                );
                              }
                              return SizedBox(
                                height: height * 0.3,
                                child: ListView.builder(
                                  controller: context
                                      .read<CategoriesBloc>()
                                      .scrollController,
                                  clipBehavior: Clip.none,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categories.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index < categories.length) {
                                      return CategoryWidget(
                                        id: categories[index].id,
                                        photo: categories[index].photo,
                                        name: categories[index].name,
                                        onTap: updateVisualService,
                                      );
                                    } else {
                                      return state.loaded
                                          ? const SizedBox()
                                          : Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: state.hasMore
                                                  ? const LoadingWidget()
                                                  : const Center(
                                                      child: Text(
                                                          "لا يوجد المزيد من التصنيفات"),
                                                    ),
                                            );
                                    }
                                  },
                                ),
                              );
                            } else if (state is FailureCategoriesState) {
                              return Center(child: Text(state.message));
                            }
                            return const LoadingWidget();
                          },
                        ),

                        BlocBuilder<SubServiceBloc, SubServiceState>(
                          builder: (context, state) {
                            context.read<SubServiceBloc>().serviceId = id;
                            if (state is LoadingSubServiceState) {
                              return const Center(child: LoadingWidget());
                            } else if (state is LoadedSubServiceState) {
                              List<Service> subService = state.subService!;
                              if (subService.isEmpty) {
                                return EmptyWidget(
                                  height: height * 0.3 - 37,
                                  text: 'لا يوجد خدمات',
                                );
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // الخدمات
                                  nameContext('الخدمات'),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      height: height * 0.2 - 10,
                                      child: ListView.builder(
                                        controller: context
                                            .read<SubServiceBloc>()
                                            .scrollController,
                                        clipBehavior: Clip.none,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: subService.length + 1,
                                        itemBuilder: (context, index) {
                                          if (index < subService.length) {
                                            return ServiceWidget(
                                              description:
                                                  subService[index].description,
                                              id: subService[index].id,
                                              photo: subService[index].photo,
                                              countryId: widget.countryId,
                                              cityId: widget.cityId,
                                              regionId: widget.regionId,
                                              setCountryId: widget.setCountryId,
                                              setCityId: widget.setCityId,
                                              setRegionId: widget.setRegionId,
                                            );
                                          } else {
                                            return state.loaded
                                                ? const SizedBox()
                                                : Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: state.hasMore
                                                        ? const LoadingWidget()
                                                        : const Center(
                                                            child: Text(
                                                                "لا يوجد المزيد من الخدمات"),
                                                          ),
                                                  );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else if (state is FailureSubServiceState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  nameContext('الخدمات'),
                                  Center(child: Text(state.message)),
                                ],
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBarrr(
              logout: true,
              pageName: 'الرئيسية',
              setCountryId: widget.setCountryId,
              setCityId: widget.setCityId,
              setRegionId: widget.setRegionId,
            ),
          ),
        ],
      ),
    );
  }

  Widget nameContext(String name) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
        ),
      ),
    );
  }
}
