import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';
import '../bloc/get_all_orders_bloc/get_all_orders_bloc.dart';
import '../widgets/incoming_requests_body.dart';
import '../../../../injection_countainer.dart' as di;

class IncomingRequestScreen extends StatelessWidget {
  const IncomingRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<GetAllOrdersBloc>(
            create: (_) => di.sl<GetAllOrdersBloc>()
              ..add(
                GetAllOrderForFoundationEvent(
                  foundationId: globalFoundationId!,
                ),
              ),
          ),
        ],
        child: const IncomingRequestBody(),
      ),
    );
  }
}
