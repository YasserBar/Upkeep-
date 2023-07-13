import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/core/helpers/snackbar_message.dart';
import '../../../../core/aseets/assets.dart';
import '../../../../core/theme/colors.dart';
import '../../../../injection_countainer.dart' as di;

import '../bloc/accept_cancel_order_bloc/accept_rejected_order_bloc.dart';

class IncomingRequestShowItem extends StatelessWidget {
  const IncomingRequestShowItem({
    super.key,
    required this.serviceName,
    required this.serviceImg,
    required this.serviceDate,
    required this.serviceDescription,
    required this.requestId,
  });

  final String serviceName;
  final String serviceImg;
  final String serviceDate;
  final String serviceDescription;
  final int requestId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AcceptRejectedOrderBloc>(
      create: (_) => di.sl<AcceptRejectedOrderBloc>(),
      child: BlocConsumer<AcceptRejectedOrderBloc, AcceptRejectOrderState>(
        listener: (context, state) {
          if (state is SuccessAcceptRejectOrderState) {
            SnackBarMessage()
                .showSuccessSnackBar(message: state.message, context: context);
          }
          if (state is ErrorAcceptRejectOrderState) {
            SnackBarMessage()
                .showErrorSnackBar(message: state.message, context: context);
          }
        },
        builder: (context, state) {
          if (state is LoadingAcceptRejectOrderState) {}
          return Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: serviceImg,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Image.asset(
                            AssetClass.StaticLogo,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            serviceName,
                            style: const TextStyle(
                              color: secondryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  serviceDate,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Builder(builder: (context) {
                              return TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                    'هل انت متاكد من قبول الخدمة؟'),
                                                const SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    AcceptRejectedOrderBloc>(
                                                                context)
                                                            .add(
                                                                AcceptOrderEvent(
                                                                    requestId));
                                                      },
                                                      child: const Text('نعم'),
                                                    ),
                                                    const Spacer(),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      },
                                                      child: const Text('لا'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Image.asset(AssetClass.Correct),
                              );
                            }),
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(60))),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 30),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  'شرح طلب الزبون',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22),
                                                )),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                serviceDescription,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Image.asset(
                                AssetClass.Chat,
                              ),
                            ),
                            Builder(builder: (context) {
                              return TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                    'هل انت متاكد من رفض الخدمة؟'),
                                                const SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    AcceptRejectedOrderBloc>(
                                                                context)
                                                            .add(
                                                                RejectedOrderEvent(
                                                          requestId,
                                                        ));
                                                      },
                                                      child: const Text('نعم'),
                                                    ),
                                                    const Spacer(),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      },
                                                      child: const Text('لا'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Image.asset(AssetClass.False),
                              );
                            }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
