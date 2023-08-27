import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:upkeep_plus/core/helpers/snackbar_message.dart';
import 'package:upkeep_plus/features/categories/domain/entities/service.dart';
import 'package:upkeep_plus/features/categories/presentation/bloc/subservice/subservice_bloc.dart';
import 'package:upkeep_plus/features/locations/presentation/widgets/appbar.dart';
import '../../../../core/aseets/assets.dart';
import '../../../../core/constants/days_time.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../../../../core/widgets/switch_button.dart';
import '../../../../core/widgets/week_widget.dart';
import '../../../../main.dart';
import '../../../auth/presentation/widgets/custome_button.dart';
import '../../../categories/presentation/bloc/categories/categories_bloc.dart';
import '../../../categories/presentation/bloc/categories/categories_state.dart';
import '../../domain/entities/add_service.dart';
import '../bloc/add_service_foundation/add_service_foundation_bloc.dart';
import '../../../../injection_countainer.dart' as di;

class AddServiceFormWidget extends StatefulWidget {
  const AddServiceFormWidget({
    super.key,
  });

  @override
  State<AddServiceFormWidget> createState() => _AddServiceFormWidgetState();
}

class _AddServiceFormWidgetState extends State<AddServiceFormWidget> {
  int? selctedCate;

  int? selctedName;

  @override
  void initState() {
    super.initState();
    init();
  }

  String? numberOfResource;
  String? serviceCost;
  String? description;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  String convertDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "00:00:00".toString();
    }

    int hours = dateTime.hour;
    int minutes = dateTime.minute;
    int seconds = dateTime.second;

    String formattedTime =
        '${_padZero(hours)}:${_padZero(minutes)}:${_padZero(seconds)}';

    return formattedTime;
  }

  String _padZero(int value) {
    return value.toString().padLeft(2, '0');
  }

  DateTime? t;

  void init() {
    t = DateTime.now();
    t = DateTime(t!.year, t!.month, t!.day, 1, 0);
  }

  bool _isSwitched = false;
  int counterDay = 0;
  void _handleValueChanged(bool value) {
    _isSwitched = value;
    // Do something with the updated value
  }

  int countDayAllowed(int index) {
    if (startTimes[index] == null || endTimes[index] == null) {
      return counterDay;
    }
    return ++counterDay;
  }

  int needActive() {
    return _isSwitched ? 1 : 0;
  }

  bool isPeriodSelected = false;

  final _formKey = GlobalKey<FormState>();
  final timeFormat = intl.DateFormat('HH:mm');
  final formatter = CustomTimeFormatter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddServiceFoundationBloc>(
          create: (_) => di.sl<AddServiceFoundationBloc>(),
        ),
        BlocProvider<SubServiceBloc>(
          create: (_) => di.sl<SubServiceBloc>(),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 90),
                BlocConsumer<AddServiceFoundationBloc,
                    AddServiceFoundationState>(
                  listener: (context, state) {
                    if (state is SuccessAddServiceFoundationState) {
                      startTimes = List.filled(7, null);
                      endTimes = List.filled(7, null);
                      Navigator.of(context).pop();
                      SnackBarMessage().showSuccessSnackBar(
                          message: state.message, context: context);
                    } else if (state is ErrorAddServiceFoundationState) {
                      startTimes = List.filled(7, null);
                      endTimes = List.filled(7, null);
                      Navigator.of(context).pop();
                      SnackBarMessage().showErrorSnackBar(
                          message: state.message, context: context);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingAddServiceFoundationState) {
                      return const Expanded(
                          child: Center(child: LoadingWidget()));
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: SingleChildScrollView(
                        clipBehavior: Clip.none,
                        physics: const BouncingScrollPhysics(),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  BlocBuilder<CategoriesBloc, CategoriesState>(
                                    builder: (context, state) {
                                      if (state is FailureCategoriesState) {
                                        return Center(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  state.message,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              CircleAvatar(
                                                backgroundColor:
                                                    Colors.blueGrey[50],
                                                child: IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<CategoriesBloc>()
                                                        .add(
                                                            const GetAllCategoriesEvent());
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
                                      } else if (state
                                          is LoadingCategoriesState) {
                                        return const LoadingWidget();
                                      } else if (state
                                          is LoadedCategoriesState) {
                                        return Column(
                                          children: [
                                            DropdownButtonFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'يرجى اختيار صنف الخدمة';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              hint: const Text(
                                                'صنف الخدمة',
                                                style: TextStyle(
                                                    color: primaryColor),
                                              ),
                                              value: selctedCate,
                                              onChanged: (value) {
                                                setState(() {
                                                  selctedCate = value!;
                                                  selctedName = null;
                                                });
                                                BlocProvider.of<SubServiceBloc>(
                                                        context)
                                                    .add(GetAllSubServiceEvent(
                                                        selctedCate));
                                              },
                                              items: state.categories!
                                                  .map((category) {
                                                return DropdownMenuItem(
                                                  value: category.id,
                                                  child: Text(
                                                    category.name,
                                                    style: const TextStyle(
                                                        color: primaryColor),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                            if (selctedCate != null)
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .02),
                                                  BlocBuilder<SubServiceBloc,
                                                      SubServiceState>(
                                                    builder: (context, state) {
                                                      final subServicesBloc =
                                                          context.read<
                                                              SubServiceBloc>();
                                                      subServicesBloc
                                                              .serviceId =
                                                          selctedCate!;

                                                      if (state
                                                          is LoadingSubServiceState) {
                                                        return const LoadingWidget();
                                                      } else if (state
                                                          is LoadedSubServiceState) {
                                                        List<Service>
                                                            subServices =
                                                            state.subService!;
                                                        if (subServices
                                                            .isEmpty) {
                                                          return const Text(
                                                              'لا يوجد خدمات');
                                                        }
                                                        return DropdownButtonFormField(
                                                          validator: (value) {
                                                            if (value == null) {
                                                              return 'يرجى اختيار اسم الخدمة';
                                                            }
                                                            return null;
                                                          },
                                                          autovalidateMode:
                                                              AutovalidateMode
                                                                  .onUserInteraction,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color:
                                                                          primaryColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color:
                                                                          primaryColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color:
                                                                          primaryColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color:
                                                                          primaryColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color:
                                                                          primaryColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                          hint: const Text(
                                                            'اسم الخدمة',
                                                            style: TextStyle(
                                                                color:
                                                                    primaryColor),
                                                          ),
                                                          value: selctedName,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selctedName =
                                                                  value!;
                                                            });
                                                          },
                                                          items: subServices
                                                              .map(
                                                                  (subService) {
                                                            return DropdownMenuItem(
                                                              value:
                                                                  subService.id,
                                                              child: Text(
                                                                subService.name,
                                                                style: const TextStyle(
                                                                    color:
                                                                        primaryColor),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        );
                                                      } else if (state
                                                          is FailureSubServiceState) {
                                                        return Center(
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child: Text(
                                                                  state.message,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.blueGrey[
                                                                        50],
                                                                child:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    context
                                                                        .read<
                                                                            SubServiceBloc>()
                                                                        .add(GetAllSubServiceEvent(
                                                                            selctedCate));
                                                                  },
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .replay_sharp,
                                                                    color:
                                                                        secondryColor,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      } else {
                                                        return Container();
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                          ],
                                        );
                                      }

                                      return Container();
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .02,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'يرجى إدخال الكلفة';
                                      }
                                      return null;
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: primaryColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: primaryColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: primaryColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: primaryColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: primaryColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: "الكلفة",
                                      suffix: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "ل.س",
                                        ),
                                      ),
                                      hintStyle: const TextStyle(
                                          color: primaryColor, fontSize: 16),
                                      suffixStyle: const TextStyle(
                                          color: primaryColor, fontSize: 16),
                                    ),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.justify,
                                    onChanged: (value) {
                                      setState(() {
                                        serviceCost = value;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .02,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (!isPeriodSelected) {
                                        return 'يرجى اختيار متوسط وقت انجاز الخدمة';
                                      }
                                      return null;
                                    },
                                    enableInteractiveSelection: false,
                                    readOnly: true,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    showCursor: false,
                                    textAlign: TextAlign.justify,
                                    textAlignVertical: TextAlignVertical.center,
                                    controller: dateController,
                                    style: const TextStyle(
                                        overflow: TextOverflow.clip),
                                    onTap: () {
                                      dateController.text =
                                          timeFormat.format(t!);
                                      isPeriodSelected = true;
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext builder) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .copyWith()
                                                      .size
                                                      .height /
                                                  2.3,
                                              child: CupertinoDatePicker(
                                                initialDateTime: t,
                                                use24hFormat: true,
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                onDateTimeChanged: (val) {
                                                  t = val;
                                                  String time =
                                                      timeFormat.format(val);
                                                  dateController.text = time;
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    decoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText: "وقت انجاز الخدمة الوسطي",
                                        hintStyle: const TextStyle(
                                            color: primaryColor, fontSize: 16)),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .02,
                                  ),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'يرجى إدخال عدد موارد الخدمة';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.justify,
                                    decoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText: "عدد موارد الخدمة",
                                        hintStyle: const TextStyle(
                                            color: primaryColor, fontSize: 16)),
                                    onChanged: (value) {
                                      setState(() {
                                        numberOfResource = value;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .01),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: descriptionController,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 6,
                                      minLines: 6,
                                      textAlign: TextAlign.justify,
                                      decoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText: "الوصف",
                                        hintStyle: const TextStyle(
                                            color: primaryColor, fontSize: 16),
                                        counterText: '',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          description = value;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .01),
                                  const WeekWidget(),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .01),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: primaryColor, width: 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              "تحتاج تأكيد الطلب/ رفض",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SwitchButton(
                                              onValueChanged:
                                                  _handleValueChanged),
                                        ],
                                      )),
                                  const CompanyFees(),
                                  CustomButton(
                                    title1: "اضافة خدمة",
                                    title2: "",
                                    onPressButton: () {
                                      countDayAllowed(0);
                                      countDayAllowed(1);
                                      countDayAllowed(2);
                                      countDayAllowed(3);
                                      countDayAllowed(4);
                                      countDayAllowed(5);
                                      countDayAllowed(6);
                                      if (_formKey.currentState!.validate()) {
                                        if (kDebugMode) {
                                          // print(selctedName);
                                          print(AddService(
                                            serviceId: selctedName!,
                                            foundationId: globalFoundationId!,
                                            description: description!,
                                            serviceCost:
                                                int.parse(serviceCost!),
                                            numberOfResource:
                                                int.parse(numberOfResource!),
                                            needActive: needActive(),
                                            dayAllowed: counterDay,
                                            durationWork: dateController.text,
                                            startSaturday:
                                                convertDate(startTimes[0]),
                                            endSaturday:
                                                convertDate(endTimes[0]),
                                            startSunday:
                                                convertDate(startTimes[1]),
                                            endSunday: convertDate(endTimes[1]),
                                            startMonday:
                                                convertDate(startTimes[2]),
                                            endMonday: convertDate(endTimes[2]),
                                            startTuesday:
                                                convertDate(startTimes[3]),
                                            endTuesday:
                                                convertDate(endTimes[3]),
                                            startWednesday:
                                                convertDate(startTimes[4]),
                                            endWednesday:
                                                convertDate(endTimes[4]),
                                            startThursday:
                                                convertDate(startTimes[5]),
                                            endThursday:
                                                convertDate(endTimes[5]),
                                            startFriday:
                                                convertDate(startTimes[6]),
                                            endFriday: convertDate(endTimes[6]),
                                          ));
                                        }
                                        BlocProvider.of<
                                                    AddServiceFoundationBloc>(
                                                context)
                                            .add(AddServiceToFoundationEvent(
                                                AddService(
                                          serviceId: selctedName!,
                                          foundationId: globalFoundationId!,
                                          description: description!,
                                          serviceCost: int.parse(serviceCost!),
                                          numberOfResource:
                                              int.parse(numberOfResource!),
                                          needActive: needActive(),
                                          dayAllowed: counterDay,
                                          durationWork: dateController.text,
                                          startSaturday:
                                              convertDate(startTimes[0]),
                                          endSaturday: convertDate(endTimes[0]),
                                          startSunday:
                                              convertDate(startTimes[1]),
                                          endSunday: convertDate(endTimes[1]),
                                          startMonday:
                                              convertDate(startTimes[2]),
                                          endMonday: convertDate(endTimes[2]),
                                          startTuesday:
                                              convertDate(startTimes[3]),
                                          endTuesday: convertDate(endTimes[3]),
                                          startWednesday:
                                              convertDate(startTimes[4]),
                                          endWednesday:
                                              convertDate(endTimes[4]),
                                          startThursday:
                                              convertDate(startTimes[5]),
                                          endThursday: convertDate(endTimes[5]),
                                          startFriday:
                                              convertDate(startTimes[6]),
                                          endFriday: convertDate(endTimes[6]),
                                        )));
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: AppBarrr(
                  enableLocation: false,
                  pageName: 'إضافة خدمة',
                  setCountryId: () {},
                  setCityId: () {},
                  setRegionId: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTimeFormatter extends intl.DateFormat {
  CustomTimeFormatter() : super('HH:mm');

  @override
  String format(DateTime date) {
    final hour = date.hour;
    final minute = date.minute;
    final period = (hour >= 12) ? 'م' : 'ص';
    final formattedHour = (hour % 12 == 0) ? 12 : hour % 12;
    final formattedMinute = (minute < 10) ? '0$minute' : minute.toString();

    return '$formattedHour:$formattedMinute $period';
  }
}

class CompanyFees extends StatelessWidget {
  const CompanyFees({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            'نسبة الشركة',
            style: TextStyle(color: primaryColor),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: Image.asset(AssetClass.Company)),
      ],
    );
  }
}
