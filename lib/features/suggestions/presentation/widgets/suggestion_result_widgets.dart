import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/aseets/assets.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utilities/loading_widget.dart';
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
        height: MediaQuery.of(context).size.height * .2,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              BlocBuilder<GetAllMyProposeBloc, GetAllMyProposeState>(
                builder: (context, state) {
                  if (kDebugMode) {
                    print('Current state: $state');
                  }

                  if (state is SuccessGetAllMyPropose) {
                    final mySuggestion = state.mySuggestion;

                    if (mySuggestion.isEmpty) {
                      return const Align(
                        alignment: Alignment.center,
                        child: Text("لا يوجد اقتراحات"),
                      );
                    }

                    return Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: ListView.builder(
                          itemCount: mySuggestion.length,
                          itemBuilder: (BuildContext context, int index) {
                            final suggestion = mySuggestion[index];
                            if (kDebugMode) {
                              print(
                                  'Number of suggestions: ${suggestion.response}');
                            }
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                suggestion.response == "ok"
                                    ? Image.asset(
                                        AssetClass.Accepted,
                                        width: 20,
                                        height: 20,
                                      )
                                    : suggestion.response != ""
                                        ? Image.asset(
                                            AssetClass.Refused,
                                            width: 20,
                                            height: 20,
                                          )
                                        : const SizedBox(width: 20, height: 20),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                suggestion.response == "ok"
                                    ? const Text(
                                        "تمت الموافقة على خدمة ",
                                        style: TextStyle(
                                          color: primaryColor,
                                        ),
                                      )
                                    : suggestion.response != ""
                                        ? const Text(
                                            "لم تتم الموافقة على خدمة ",
                                            style: TextStyle(
                                              color: primaryColor,
                                            ),
                                          )
                                        : const Text(
                                            "    هذه الخدمة قيد الانتظار لحين القبول او الرفض :  ",
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
                                    overflow: TextOverflow
                                        .ellipsis, 
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  } else if (state is ErrorGetAllMyPropose) {
                    return Text(state.message);
                  } else {
                    return const LoadingWidget();
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
