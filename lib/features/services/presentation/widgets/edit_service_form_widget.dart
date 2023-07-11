import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/core/helpers/snackbar_message.dart';
import '../../../../core/constants/days_time.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../../../../core/widgets/switch_button.dart';
import '../../../../core/widgets/week_widget.dart';
import '../../../../main.dart';
import '../../../auth/presentation/widgets/custome_button.dart';
import '../../domain/entities/add_service.dart';
import '../../domain/entities/service_foundation.dart';
import '../bloc/add_service_foundation/add_service_foundation_bloc.dart';
import '../bloc/edit_service_foundation_bloc/edit_service_foundation_bloc.dart';

class EditServiceFormWidget extends StatefulWidget {
  const EditServiceFormWidget({
    super.key,
    required this.srvice,
  });
  final ServiceFoundation srvice;
  @override
  State<EditServiceFormWidget> createState() => _EditServiceFormWidgetState();
}

class _EditServiceFormWidgetState extends State<EditServiceFormWidget> {
  String? numberOfResource;
  String? serviceCost;
  String? durationWork;
  String durationW(String duration) {
    return "$duration:00:00";
  }

  String convertDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "00:00:01".toString();
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
    startFriFormatted = startFri != null ? convertDate(startFri) : "00:00:01";
    endFriFormatted = endFri != null ? convertDate(endFri) : "00:00:01";
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
  int countDayAllowed(String start, String end) {
    if (start == "00:00:00" || end == "00:00:00") {
      return counterDay;
    }
    return ++counterDay;
  }

  void _handleValueChanged(bool value) {
    _isSwitched = value;
    // Do something with the updated value
  }

  int needActive(bool value) {
    if (_isSwitched == false) {
      return 0;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditServiceFoundationBloc, EditServiceFoundationState>(
      listener: (context, state) {
        if (state is SuccessEditServiceFoundationState) {
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
        } else if (state is ErrorEditServiceFoundationState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
      builder: (context, state) {
        if (state is LoadingAddServiceFoundationState) {
          return const LoadingWidget();
        }
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // DropdownButtonWidget(
                  //   s: serviceKind,
                  //   title: "صنف الخدمة",
                  //   bColor: primaryColor,
                  //   titleColor: primaryColor,
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  // DropdownButtonWidget(
                  //   s: serviceName,
                  //   title: "اسم الخدمة",
                  //   bColor: primaryColor,
                  //   titleColor: primaryColor,
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextFormField(
                      textAlign: TextAlign.justify,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefix: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("الكلفة "),
                        ),
                        suffix: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "ل.س",
                          ),
                        ),
                        prefixStyle:
                            TextStyle(color: primaryColor, fontSize: 16),
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
                  // DropdownButtonWidget(
                  //   s: numberServiceCases,
                  //   title: "عرض موارد الخدمة",
                  //   bColor: primaryColor,
                  //   titleColor: primaryColor,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       numberOfResource = value;
                  //     });
                  //   },
                  // ),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  const WeekWidget(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor, width: 1),
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "تحتاج تأكيد الطلب/ رفض",
                          style: TextStyle(
                              fontSize: 16,
                              color: primaryColor,
                              fontWeight: FontWeight.w400),
                        ),
                        SwitchButton(onValueChanged: _handleValueChanged),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20,),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "ايقاف الخدمة ",
                            style: TextStyle(
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: FontWeight.w400),
                          ),
                          SwitchButton(onValueChanged: _handleValueChanged),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: CustomButton(
                          title1: "تعديل الخدمة",
                          title2: "",
                          onPressButton: () {
                            countDayAllowed(startFriFormatted, endFriFormatted);
                            countDayAllowed(startSutFormatted, endSutFormatted);
                            countDayAllowed(startSunFormatted, endSunFormatted);
                            countDayAllowed(startMonFormatted, endMonFormatted);
                            countDayAllowed(startTusFormatted, endTusFormatted);
                            countDayAllowed(starThuFormatted, endThuFormatted);
                            countDayAllowed(startWenFormatted, endWenFormatted);

                            BlocProvider.of<EditServiceFoundationBloc>(context)
                                .add(EditServiceForFoundationEvent(AddService(
                              serviceId: widget.srvice.id,
                              foundationId: globalFoundationId,
                              description: 's',
                              serviceCost: widget.srvice.serviceCost,
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
                            BlocProvider.of<EditServiceFoundationBloc>(context)
                                .add(
                              const StopServiceForFoundationEvent(1),
                            );
                          })),
                ],
              )),

          // ElevatedButton(
          //   child: const Text('Close BottomSheet'),
          //   onPressed: () => Navigator.pop(context),
          // ),
        );
      },
    );
  }
}
