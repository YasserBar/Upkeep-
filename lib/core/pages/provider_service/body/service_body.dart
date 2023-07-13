import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../../features/ads&jobs/presentation/bloc/add_job_bloc/add_job_bloc.dart';
import '../../../../features/ads&jobs/presentation/widgets/add_jop_foundation.dart';
import '../../../../features/auth/presentation/pages/my_foundations_screeen.dart';
import '../../../../features/locations/presentation/widgets/appbar.dart';
import '../../../../features/services/presentation/bloc/add_service_foundation/add_service_foundation_bloc.dart';
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
  bool isClicked = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 117),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 15,),
                          Expanded(
                            child: isClicked
                                ? CustomServiceButton(
                                    title: 'تشغيل العمل',
                                    icon: Icons.check_circle,
                                    bgColor: Colors.white,
                                    bsColor: const Color(0xff0CDC5F),
                                    onPressed: () {
                                      setState(() {
                                        isClicked = false;
                                      });
                                    },
                                  )
                                : CustomServiceButton(
                                    title: 'ايقاف العمل',
                                    icon: Icons.dnd_forwardslash,
                                    bgColor: Colors.white,
                                    bsColor: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        isClicked = true;
                                      });
                                    },
                                  ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.height * .01,
                          ),
                          Expanded(
                            child: CustomServiceButton(
                              title: "إضافة خدمة",
                              icon: Icons.add_circle_outline_outlined,
                              bgColor: secondryColor,
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
                                    return BlocProvider<
                                        AddServiceFoundationBloc>(
                                      create: (_) =>
                                          di.sl<AddServiceFoundationBloc>(),
                                      child: const AddServiceFormWidget(),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
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
                                    create: (_) =>
                                        di.sl<ProposeNewServiceBloc>(),
                                    child: const ProposeService(),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
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
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                        child: CustomServiceButton(
                            title: "ادارة مؤسساتي",
                            icon: Icons.manage_accounts_outlined,
                            bgColor: primaryColor,
                            onPressed: () {
                              globalFoundationId = 0;
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MyFoundationsScreen()),
                                (Route<dynamic> route) => false,
                              );
                            }),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      const SuggestionResults(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
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
