import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/aseets/assets.dart';
import '../../../../core/constants/days_time.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utilities/loading_widget.dart';
import '../../../../core/utilities/snackbar_message.dart';
import '../../../../core/widgets/switch_button.dart';
import '../../../../core/widgets/week_widget.dart';
import '../../../../main.dart';
import '../../../auth/presentation/widgets/custome_button.dart';
import '../../../categories/presentation/bloc/categories/categories_bloc.dart';
import '../../../categories/presentation/bloc/categories/categories_state.dart';
import '../../domain/entities/add_service.dart';
import '../bloc/add_service_foundation/add_service_foundation_bloc.dart';

class AddServiceFormWidget extends StatefulWidget {
  const AddServiceFormWidget({
    super.key,
  });

  @override
  State<AddServiceFormWidget> createState() => _AddServiceFormWidgetState();
}

class _AddServiceFormWidgetState extends State<AddServiceFormWidget> {
  String? selctedCate;

  String? selctedName;

  @override
  void initState() {
    super.initState();
    init();
  }

  String? numberOfResource;
  String? serviceCost;
  String? durationWork;
  String durationW(String duration) {
    return "$duration:00:00";
  }

  String convertDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "00:00:00".toString();
    }

    // Extract the time components from the DateTime object
    int hours = dateTime.hour;
    int minutes = dateTime.minute;
    int seconds = dateTime.second;

    // Format the time as a string
    String formattedTime =
        '${_padZero(hours)}:${_padZero(minutes)}:${_padZero(seconds)}';

    return formattedTime;
  }

  String _padZero(int value) {
    return value.toString().padLeft(2, '0');
  }

  String startFriFormatted = "00:00:00";
  String endFriFormatted = "00:00:00";
  String startMonFormatted = "00:00:00";
  String endMonFormatted = "00:00:00";
  String startSutFormatted = "00:00:00";
  String endSutFormatted = "00:00:00";
  String startSunFormatted = "00:00:00";
  String endSunFormatted = "00:00:00";
  String starThuFormatted = "00:00:00";
  String endThuFormatted = "00:00:00";
  String startTusFormatted = "00:00:00";
  String endTusFormatted = "00:00:00";
  String startWenFormatted = "00:00:00";
  String endWenFormatted = "00:00:00";

  void init() {
    startFriFormatted = startFri != null ? convertDate(startFri) : "00:00:0";
    endFriFormatted = endFri != null ? convertDate(endFri) : "00:00:0";
    startMonFormatted = startMon != null ? convertDate(startMon) : "00:00:00";
    endMonFormatted = endMon != null ? convertDate(endMon) : "00:00:00";
    startSutFormatted = startSut != null ? convertDate(startSut) : "00:00:00";
    endSutFormatted = endSut != null ? convertDate(endSut) : "00:00:00";
    startSunFormatted = startSun != null ? convertDate(startSun) : "00:00:00";
    endSunFormatted = endSun != null ? convertDate(endSun) : "00:00:00";
    starThuFormatted = starThu != null ? convertDate(starThu) : "00:00:00";
    endThuFormatted = endThu != null ? convertDate(endThu) : "00:00:00";
    startTusFormatted = startTus != null ? convertDate(startTus) : "00:00:00";
    endTusFormatted = endTus != null ? convertDate(endTus) : "00:00:00";
    startWenFormatted = startWen != null ? convertDate(startWen) : "00:00:00";
    endWenFormatted = endWen != null ? convertDate(endWen) : "00:00:00";
  }

  bool _isSwitched = false;
  int counterDay = 0;

  void _handleValueChanged(bool value) {
    _isSwitched = value;
    // Do something with the updated value
  }

  int countDayAllowed(String start, String end) {
    if (start == "00:00:00" || end == "00:00:00") {
      return counterDay;
    }
    return ++counterDay;
  }

  int needActive(bool value) {
    if (_isSwitched == false) {
      return 0;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddServiceFoundationBloc, AddServiceFoundationState>(
      listener: (context, state) {
        if (state is SuccessAddServiceFoundationState) {
          startFri = null;
          endFri = null;
          startSut = null;
          endSut = null;
          startSun = null;
          endSun = null;
          startWen = null;
          endWen = null;
          startTus = null;
          endTus = null;
          starThu = null;
          endThu = null;
          startMon = null;
          endMon = null;

          SnackBarMessage()
              .showSuccessSnackBar(message: state.message, context: context);
        } else if (state is ErrorAddServiceFoundationState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
      builder: (context, state) {
        if (state is LoadingAddServiceFoundationState) {
          return const LoadingWidget();
        }
        return SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  BlocBuilder<CategoriesBloc, CategoriesState>(
                    builder: (context, state) {
                      if (state is LoadedCategoriesState) {
                        return Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                hint: const Text(
                                  'صنف الخدمة',
                                  style: TextStyle(color: primaryColor),
                                ),
                                value: selctedCate,
                                onChanged: (value) {
                                  setState(() {
                                    selctedCate = value!;
                                  });
                                },
                                items: state.categories!.map((city) {
                                  return DropdownMenuItem(
                                    value: city.description,
                                    child: Text(
                                      city.name,
                                      style:
                                          const TextStyle(color: primaryColor),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                hint: const Text(
                                  'اسم الخدمة',
                                  style: TextStyle(color: primaryColor),
                                ),
                                value: selctedName,
                                onChanged: (value) {
                                  setState(() {
                                    selctedName = value!;
                                  });
                                },
                                items: state.categories!.map((city) {
                                  return DropdownMenuItem(
                                    value: city.description,
                                    child: Text(
                                      city.name,
                                      style:
                                          const TextStyle(color: primaryColor),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      }

                      return Container();
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.justify,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "الكلفة",
                        suffix: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "ل.س",
                          ),
                        ),
                        hintStyle: TextStyle(color: primaryColor, fontSize: 16),
                        suffixStyle:
                            TextStyle(color: primaryColor, fontSize: 16),
                      ),
                      onChanged: (value) {
                        setState(() {
                          serviceCost = value;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      textAlign: TextAlign.justify,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "وقت انجاز الخدمة الوسطى",
                          hintStyle:
                              TextStyle(color: primaryColor, fontSize: 16)),
                      onChanged: (value) {
                        setState(() {
                          durationWork = value;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.justify,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "عدد موارد الخدمة",
                          hintStyle:
                              TextStyle(color: primaryColor, fontSize: 16)),
                      onChanged: (value) {
                        setState(() {
                          numberOfResource = value;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  const WeekWidget(),

                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "تحتاج تأكيد الطلب/ رفض",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SwitchButton(onValueChanged: _handleValueChanged),
                        ],
                      )),
                  const CompanyFees(),
                  CustomButton(
                      title1: "اضافة خدمة",
                      title2: "",
                      onPressButton: () {
                        init();

                        countDayAllowed(startFriFormatted, endFriFormatted);
                        countDayAllowed(startSutFormatted, endSutFormatted);
                        countDayAllowed(startSunFormatted, endSunFormatted);
                        countDayAllowed(startMonFormatted, endMonFormatted);
                        countDayAllowed(startTusFormatted, endTusFormatted);
                        countDayAllowed(starThuFormatted, endThuFormatted);
                        countDayAllowed(startWenFormatted, endWenFormatted);

                        BlocProvider.of<AddServiceFoundationBloc>(context)
                            .add(AddServiceToFoundationEvent(AddService(
                          serviceId: 9,
                          foundationId: globalFoundationId,
                          description: 's',
                          serviceCost: int.parse(serviceCost!),
                          numberOfResource: int.parse(numberOfResource!),
                          needActive: needActive(_isSwitched),
                          dayAllowed: counterDay,
                          durationWork: durationW(durationWork!),
                          startFriday: startFriFormatted,
                          endFriday: endFriFormatted,
                          startMonday: startMonFormatted,
                          endMonday: endMonFormatted,
                          startSaturday: startSutFormatted,
                          endSaturday: endSutFormatted,
                          startSunday: startSunFormatted,
                          endSunday: endSunFormatted,
                          startThursday: starThuFormatted,
                          endThursday: endThuFormatted,
                          startTuesday: startTusFormatted,
                          endTuesday: endTusFormatted,
                          startWednesday: startWenFormatted,
                          endWednesday: endWenFormatted,
                        )));
                        if (kDebugMode) {
                          print(AddService(
                            serviceId: 9,
                            foundationId: globalFoundationId,
                            description: 's',
                            serviceCost: int.parse(serviceCost!),
                            numberOfResource: int.parse(numberOfResource!),
                            needActive: needActive(_isSwitched),
                            dayAllowed: counterDay,
                            durationWork: durationW(durationWork!),
                            startFriday: startFriFormatted,
                            endFriday: endFriFormatted,
                            startMonday: startMonFormatted,
                            endMonday: endMonFormatted,
                            startSaturday: startSutFormatted,
                            endSaturday: endSutFormatted,
                            startSunday: startSunFormatted,
                            endSunday: endSunFormatted,
                            startThursday: starThuFormatted,
                            endThursday: endThuFormatted,
                            startTuesday: startTusFormatted,
                            endTuesday: endTusFormatted,
                            startWednesday: startWenFormatted,
                            endWednesday: endWenFormatted,
                          ));
                        }
                      })

                  // ElevatedButton(
                  //   child: const Text('Close BottomSheet'),
                  //   onPressed: () => Navigator.pop(context),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
          padding: EdgeInsets.only(top:12.0),
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
