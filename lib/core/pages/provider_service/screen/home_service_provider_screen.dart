import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/ads&jobs/presentation/bloc/ads_foundation_bloc/ads_foundation_bloc.dart';
import '../../../../features/ads&jobs/presentation/bloc/get_jop_foundation_bloc/get_jop_foundation_bloc.dart';
import '../../../../main.dart';
import '../body/home_service_provider_body.dart';
import '../../../../injection_countainer.dart' as di;

class HomeServiceProviderScreen extends StatefulWidget {
  const HomeServiceProviderScreen({Key? key}) : super(key: key);

  @override
  State<HomeServiceProviderScreen> createState() =>
      _HomeServiceProviderScreenState();
}

class _HomeServiceProviderScreenState extends State<HomeServiceProviderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          // BlocProvider<FoundationServicesBloc>(
          //   create: (_) => di.sl<FoundationServicesBloc>()
          //     ..add(GetAllServiceForFoundationEvent(
          //         foundationId: globalFoundationId!)),
          // ),
          BlocProvider<AdsFoundationBloc>(
            create: (_) => di.sl<AdsFoundationBloc>()
              ..add(ShowAllAdsForFoundationEvent(id: globalFoundationId!)),
          ),
          BlocProvider<GetJopFoundationBloc>(
              create: (_) => di.sl<GetJopFoundationBloc>()
                ..add(ShowAllJopsForFoundationEvent(id: globalFoundationId!))),
        ],
        child: const HomeServiceProviderBody(),
      ),
    );
  }
}
