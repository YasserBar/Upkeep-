import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/core/helpers/snackbar_message.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../../../../main.dart';
import '../../../auth/presentation/widgets/custome_button.dart';
import '../../domain/entities/job_ad.dart';
import '../bloc/add_job_bloc/add_job_bloc.dart';

class AddJopFoundation extends StatefulWidget {
  const AddJopFoundation({Key? key}) : super(key: key);

  @override
  State<AddJopFoundation> createState() => _AddJopFoundationState();
}

class _AddJopFoundationState extends State<AddJopFoundation> {
  TextEditingController descriptionController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddJobBloc, AddJobState>(
      listener: (context, state) {
        if (state is SuccessAddJobState) {
          Navigator.of(context).pop();
          SnackBarMessage()
              .showSuccessSnackBar(message: state.message, context: context);
        } else if (state is ErrorAddJobState) {
          Navigator.of(context).pop();
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
      builder: (context, state) {
        if (state is LoadingAddJobState) {
          return const SizedBox(height: 200.0, child: LoadingWidget());
        }
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .12,
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "اسم الخدمة ",
                        style: TextStyle(color: primaryColor),
                      ),
                      TextFormField(
                        style: const TextStyle(color: primaryColor),
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5)),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
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
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
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
                title1: 'اقتراح العمل',
                title2: '',
                onPressButton: () {
                  BlocProvider.of<AddJobBloc>(context).add(
                    AddJobForFoundationEvent(
                      JobAd(
                        title: nameController.text,
                        description: descriptionController.text,
                      ),
                      globalFoundationId!,
                    ),
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .10,
              ),
            ],
          ),
        );
      },
    );
  }
}
