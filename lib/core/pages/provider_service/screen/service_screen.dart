import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/services/presentation/bloc/foundation_services_bloc/foundation_services_bloc.dart';
import '../../../../features/suggestions/presentation/bloc/get_all_my_propose_bloc/get_all_my_propose_bloc.dart';
import '../../../../main.dart';
import '../body/service_body.dart';
import '../../../../injection_countainer.dart' as di;

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<GetAllMyProposeBloc>(
            create: (_) => di.sl<GetAllMyProposeBloc>()
              ..add(GetAllMySuggestionEvent(globalFoundationId!, 1)),
          ),
          BlocProvider<FoundationServicesBloc>(
            create: (_) => di.sl<FoundationServicesBloc>()
              ..add(GetAllServiceForFoundationEvent(
                  foundationId: globalFoundationId!)),
          ),
        ],
        child: const ServiceBody(),
      ),
    );
  }
}
