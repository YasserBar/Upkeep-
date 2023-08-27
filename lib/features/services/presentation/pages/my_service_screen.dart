import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/features/services/presentation/bloc/stop_service_bloc/stop_service_bloc.dart';

import '../../../../main.dart';
import '../bloc/foundation_services_bloc/foundation_services_bloc.dart';
import '../widgets/my_services_body.dart';
import '../../../../injection_countainer.dart' as di;

class MyServicesScreen extends StatelessWidget {
  const MyServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<StopServiceBloc>(
              create: (_) => di.sl<StopServiceBloc>()),
          BlocProvider<FoundationServicesBloc>(
            create: (_) => di.sl<FoundationServicesBloc>()
              ..add(GetAllServiceForFoundationEvent(
                  foundationId: globalFoundationId!)),
          ),
        ],
        child: const MyServicesBody(),
      ),
    );
  }
}
