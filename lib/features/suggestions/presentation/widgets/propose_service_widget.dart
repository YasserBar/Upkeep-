import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/core/helpers/snackbar_message.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../../../../main.dart';
import '../../../auth/presentation/widgets/custome_button.dart';
import '../../../categories/presentation/bloc/categories/categories_bloc.dart';
import '../../../categories/presentation/bloc/categories/categories_state.dart';
import '../../domain/entities/propose.dart';
import '../bloc/propose_new_service_bloc/propose_new_service_bloc.dart';

class ProposeService extends StatefulWidget {
  const ProposeService({Key? key}) : super(key: key);

  @override
  State<ProposeService> createState() => _ProposeServiceState();
}

class _ProposeServiceState extends State<ProposeService> {
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  String? selectedName;
  int? classService;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProposeNewServiceBloc, ProposeNewServiceState>(
      listener: (context, state) {
        if (state is SuccessProposeNewServiceState) {
          SnackBarMessage()
              .showSuccessSnackBar(message: state.message, context: context);
        } else if (state is ErrorProposeNewServiceState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
      builder: (context, state) {
        if (state is LoadingProposeNewServiceState) {
          return const LoadingWidget();
        }
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                BlocBuilder<CategoriesBloc, CategoriesState>(
                  builder: (context, state) {
                    if (state is LoadedCategoriesState) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10)),
                          hint: const Text(
                            'صنف الخدمة',
                            style: TextStyle(color: primaryColor),
                          ),
                          value: selectedName,
                          onChanged: (value) {
                            setState(() {
                              selectedName = value!;
                            });
                          },
                          items: state.categories!.map((city) {
                            classService = city.id;
                            return DropdownMenuItem(
                              value: city.description,
                              child: Text(
                                city.name,
                                style: const TextStyle(color: primaryColor),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    } else if (state is FailureCategoriesState) {
                      return Text(state.message);
                    }
                    return const LoadingWidget();
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .33,
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "وصف الخدمة",
                        style: TextStyle(color: primaryColor),
                      ),
                      TextFormField(
                        style: const TextStyle(color: primaryColor),
                        controller: descriptionController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15)),
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                CustomButton(
                  title1: 'اقتراح خدمة',
                  title2: '',
                  onPressButton: () {
                    BlocProvider.of<ProposeNewServiceBloc>(context).add(
                      ProposeNewSuggestionEvent(
                        Propose(
                          foundationId: globalFoundationId!,
                          description: descriptionController.text,
                          classService: classService!,
                          nameService: selectedName!,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
