import 'package:flutter/material.dart';

import '../../../../features/ads&jobs/presentation/widgets/ads_listview.dart';
import '../../../../features/locations/presentation/widgets/appbar.dart';
import '../../../../features/orders/presentation/widgets/get_all_jop_foundation_listview.dart';

class HomeServiceProviderBody extends StatelessWidget {
  const HomeServiceProviderBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 100),
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                clipBehavior: Clip.none,
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .02),
                        const AdsListview(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .02),
                        const GetAllJopFoundationListview(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .01),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBarrr(
            enableLocation: false,
            pageName: 'الرئيسية',
            setCountryId: () {},
            setCityId: () {},
            setRegionId: () {},
          ),
        ),
      ],
    );
  }
}
