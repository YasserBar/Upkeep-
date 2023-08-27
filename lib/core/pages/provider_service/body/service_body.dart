import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../../features/ads&jobs/presentation/bloc/add_job_bloc/add_job_bloc.dart';
import '../../../../features/ads&jobs/presentation/widgets/add_jop_foundation.dart';
import '../../../../features/locations/presentation/widgets/appbar.dart';
import '../../../../features/services/presentation/widgets/add_service_form.dart';
import '../../../../features/suggestions/presentation/bloc/propose_new_service_bloc/propose_new_service_bloc.dart';
import '../../../../features/suggestions/presentation/widgets/propose_service_widget.dart';
import '../../../../features/suggestions/presentation/widgets/suggestion_result_widgets.dart';
import '../../../../injection_countainer.dart' as di;
import '../../../../main.dart';
import '../../../widgets/custom_service_button.dart';

class ServiceBody extends StatefulWidget {
  const ServiceBody({Key? key}) : super(key: key);

  @override
  State<ServiceBody> createState() => _ServiceBodyState();
}

class _ServiceBodyState extends State<ServiceBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 90),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: isActive!
                              ? CustomServiceButton(
                                  title: 'المؤسسة نشطة',
                                  icon: Icons.check_circle,
                                  bgColor: Colors.white,
                                  bsColor: const Color(0xff0CDC5F),
                                  onPressed: () {},
                                )
                              : CustomServiceButton(
                                  title: 'تم إيقاف المؤسسة',
                                  icon: Icons.dnd_forwardslash,
                                  bgColor: Colors.white,
                                  bsColor: Colors.red,
                                  onPressed: () {},
                                ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: CustomServiceButton(
                            title: "إضافة خدمة",
                            icon: Icons.add_circle_outline_outlined,
                            bgColor: secondryColor,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AddServiceFormWidget(),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomServiceButton(
                        title: "اقتراح خدمة جديدة",
                        icon: Icons.file_present,
                        bgColor: primaryColor,
                        onPressed: () {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(60),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 30,
                                ),
                                child: BlocProvider<ProposeNewServiceBloc>(
                                  create: (_) => di.sl<ProposeNewServiceBloc>(),
                                  child: const ProposeService(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomServiceButton(
                        title: "اضافة فرصة عمل",
                        icon: Icons.file_present,
                        bgColor: primaryColor,
                        onPressed: () {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(60),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 30,
                                ),
                                child: BlocProvider<AddJobBloc>(
                                  create: (_) => di.sl<AddJobBloc>(),
                                  child: const AddJopFoundation(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomServiceButton(
                          title: "ادارة مؤسساتي",
                          icon: Icons.manage_accounts_outlined,
                          bgColor: primaryColor,
                          onPressed: () {
                            globalFoundationId = null;
                            Navigator.pop(context);
                          }),
                    ),
                    const SizedBox(height: 10),
                    const SuggestionResults(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: AppBarrr(
              enableLocation: false,
              pageName: 'الخدمات',
              setCountryId: () {},
              setCityId: () {},
              setRegionId: () {},
            ),
          ),
        ),
      ],
    );
  }
}
