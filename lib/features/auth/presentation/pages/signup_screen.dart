import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/features/locations/presentation/bloc/getLocations/get_locations_bloc.dart';
import 'package:upkeep_plus/features/locations/presentation/bloc/getLocations/get_locations_event.dart';
import '../../../../../injection_countainer.dart' as di;

import '../widgets/signup_body.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (_) =>
              di.sl<GetLocationsBloc>()..add(const GetAllCountryEvent()),
          child: const SignupBody()),
    );
  }
}
