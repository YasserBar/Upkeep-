import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/domain/entities/service_foundation.dart';
import '../bloc/get_all_orders_bloc/get_all_orders_bloc.dart';
import '../widgets/request_service_widget.dart';
import '../../../../injection_countainer.dart' as di;

class RequestServiceScreen extends StatelessWidget {
  const RequestServiceScreen({Key? key, required this.service})
      : super(key: key);
  final ServiceFoundation service;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<GetAllOrdersBloc>(
              create: (_) => di.sl<GetAllOrdersBloc>()
                ..add(GetAllOrderForServiceEvent(id: service.service_id))),
        ],
        child: RequestServiceBody(
          service: service,
        ),
      ),
    );
  }
}
