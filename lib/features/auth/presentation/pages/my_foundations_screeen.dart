import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../foundations/presentation/bloc/get_all_foundation_bloc/get_all_foundations_bloc.dart';
import '../../../foundations/presentation/pages/my_foundations_body.dart';
import '../../../../injection_countainer.dart' as di;
import '../bloc/change_password_logout_bloc/change_password_logout_bloc.dart';

// ignore: must_be_immutable
class MyFoundationsScreen extends StatelessWidget {
  const MyFoundationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAllFoundationsBloc>(
          create: (context) => di.sl<GetAllFoundationsBloc>()
            ..add(const GetAllFoundationOwnerEvent()),
        ),
        BlocProvider<ChangePasswordLogoutBloc>(
          create: (context) => di.sl<ChangePasswordLogoutBloc>(),
        ),
      ],
      child: const MyFoundationsBody(),
    );
  }
}
