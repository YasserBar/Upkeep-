import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/core/helpers/snackbar_message.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/helpers/loading_widget.dart';
import '../../../../auth/presentation/widgets/custome_button.dart';
import '../../../domain/entities/reservation.dart';
import '../../bloc/reservation/reservation_bloc.dart';
import '../../bloc/reservation/reservation_event.dart';
import '../../bloc/reservation/reservation_state.dart';
import '../../../../../injection_countainer.dart' as di;

class BookingButton extends StatelessWidget {
  final int id;
  final String date;
  const BookingButton({super.key, required this.id, required this.date});
  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionController = TextEditingController();
    return TextButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return dialog(context, descriptionController);
            });
      },
      child: Container(
        decoration: const BoxDecoration(
            color: secondryColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: 72,
        height: 38,
        child: const Align(
          alignment: Alignment.center,
          child: Text(
            'احجز',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget dialog(
      BuildContext context, TextEditingController descriptionController) {
    double width = MediaQuery.of(context).size.width;
    double dialogText = (334 / 360) * width;
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.start,
      actions: [
        BlocProvider(
            create: (context) => di.sl<ReservationBloc>(),
            child: BlocConsumer<ReservationBloc, ReservationState>(
                listener: (context, state) {
              if (state is SuccessAddReservationState) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
              } else if (state is ErrorAddReservationState) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            }, builder: (context, state) {
              if (state is LoadingAddReservationState) {
                return const LoadingWidget();
              }
              return CustomButton(
                onPressButton: () {
                  BlocProvider.of<ReservationBloc>(context).add(
                    AddReservationEvent(
                      reservation: Reservation(
                        id: id,
                        description: descriptionController.text,
                        date: date,
                      ),
                    ),
                  );
                },
                title2: '',
                title1: 'احجز',
              );
            })),
      ],
      title: Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          width: dialogText,
          height: (72 / 334) * dialogText,
          child: const Row(
            children: [
              Icon(
                Icons.note_add_outlined,
                color: primaryColor,
              ),
              AutoSizeText(
                ' إضافة شرح للطلب',
                overflow: TextOverflow.ellipsis,
                maxFontSize: 16,
                minFontSize: 8,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
      ),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: descriptionController,
          keyboardType: TextInputType.multiline,
          minLines: 8,
          maxLines: 8,
          decoration: const InputDecoration(
            focusColor: secondryColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            hintText: 'يمكنك ادخال شرح عن طلبك',
          ),
        ),
      ),
    );
  }
}
