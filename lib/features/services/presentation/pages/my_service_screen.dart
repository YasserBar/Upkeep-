import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';
import '../bloc/edit_service_foundation_bloc/edit_service_foundation_bloc.dart';
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
          BlocProvider<EditServiceFoundationBloc>(
              create: (_) => di.sl<EditServiceFoundationBloc>()),
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
