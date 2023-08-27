import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/main.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../bloc/get_all_my_propose_bloc/get_all_my_propose_bloc.dart';

class SuggestionResults extends StatelessWidget {
  const SuggestionResults({
    super.key,
    Key? mykey,
    this.serviceName,
    this.isAccepted,
  });
  final String? serviceName;
  final bool? isAccepted;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Align(
          alignment: Alignment.topRight,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: Text(
                  "نتائج الاقتراحات",
                  style: TextStyle(
                      color: secondryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              BlocBuilder<GetAllMyProposeBloc, GetAllMyProposeState>(
                builder: (context, state) {
                  if (kDebugMode) {
                    print('Current state: $state');
                  }

                  if (state is SuccessGetAllMyPropose) {
                    final mySuggestion = state.mySuggestion;

                    if (mySuggestion.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("لا يوجد اقتراحات"),
                        ),
                      );
                    }

                    return Align(
                      alignment: Alignment.topRight,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: mySuggestion.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final suggestion = mySuggestion[index];
                          if (kDebugMode) {
                            print(
                                'Number of suggestions: ${suggestion.response}');
                          }
                          return Padding(
                            padding: index == 0
                                ? const EdgeInsets.only(bottom: 4.0)
                                : const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                suggestion.response == "ok"
                                    ? const Icon(
                                        Icons.event_available,
                                        color: Colors.green,
                                      )
                                    : suggestion.response != ""
                                        ? const Icon(
                                            Icons.event_busy,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.access_alarms_rounded,
                                            color: primaryColor,
                                          ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                suggestion.response == "ok"
                                    ? const Text(
                                        " تمت الموافقة على خدمة ",
                                        style: TextStyle(
                                          color: primaryColor,
                                        ),
                                      )
                                    : suggestion.response != ""
                                        ? const Text(
                                            " لم تتم الموافقة على خدمة ",
                                            style: TextStyle(
                                              color: primaryColor,
                                            ),
                                          )
                                        : const Text(
                                            " هذه الخدمة قيد الانتظار لحين القبول او الرفض ",
                                            style: TextStyle(
                                              color: primaryColor,
                                            ),
                                          ),
                                Expanded(
                                  child: Text(
                                    suggestion.description,
                                    style: const TextStyle(
                                      color: secondryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is ErrorGetAllMyPropose) {
                    return Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              state.message,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey[50],
                            child: IconButton(
                              onPressed: () {
                                context.read<GetAllMyProposeBloc>().add(
                                      GetAllMySuggestionEvent(
                                          globalFoundationId!, 1),
                                    );
                              },
                              icon: const Icon(
                                Icons.replay_sharp,
                                color: secondryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return const LoadingWidget(
                      vertical: 60,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
