import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/core/helpers/loading_widget.dart';
import 'package:upkeep_plus/core/helpers/snackbar_message.dart';
import 'package:upkeep_plus/features/services/presentation/bloc/stop_service_bloc/stop_service_bloc.dart';
import '../../../../core/aseets/assets.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/custom_service_button.dart';
import '../../../auth/presentation/widgets/custome_button.dart';
import '../../domain/entities/service_foundation.dart';
import 'edit_service_form_widget.dart';

class MySeviceDetailsItem extends StatefulWidget {
  const MySeviceDetailsItem({
    super.key,
    required this.onPressButton,
    required this.service,
  });
  final void Function() onPressButton;
  final ServiceFoundation service;

  @override
  State<MySeviceDetailsItem> createState() => _MySeviceDetailsItemState();
}

class _MySeviceDetailsItemState extends State<MySeviceDetailsItem> {
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                margin: const EdgeInsets.only(top: 10),
                child: CachedNetworkImage(
                  imageUrl: widget.service.photo,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                    AssetClass.StaticLogo,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                widget.service.service_name,
                style: const TextStyle(
                  color: secondryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                overflow: TextOverflow.clip,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      widget.service.services_description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ))),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "المؤسسة: ${widget.service.foundations_name}",
                      style: const TextStyle(
                        color: secondryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ))),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: secondryColor,
                          ),
                        ),
                        Text(
                          "${widget.service.countries_name}-${widget.service.cities_name}-${widget.service.regions_name}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ))),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.watch_later_outlined,
                            color: secondryColor,
                          ),
                        ),
                        Text(
                          widget.service.duration_work,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ))),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.attach_money_outlined,
                            color: secondryColor,
                          ),
                        ),
                        Text(
                          widget.service.service_cost.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ))),
            CustomButton(
              title1: 'تعديل الخدمة',
              title2: '',
              onPressButton: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditServiceFormWidget(
                      srvice: widget.service,
                    ),
                  ),
                );
                // showModalBottomSheet<void>(
                //   isScrollControlled: false,
                //   shape: const RoundedRectangleBorder(
                //       borderRadius:
                //           BorderRadius.vertical(top: Radius.circular(60))),
                //   context: context,
                //   builder: (BuildContext context) {
                //     return BlocProvider<EditServiceFoundationBloc>(
                //       create: (_) => di.sl<EditServiceFoundationBloc>(),
                //       child: Directionality(
                //         textDirection: TextDirection.rtl,
                //         child: SingleChildScrollView(
                //           child: Column(
                //             mainAxisSize: MainAxisSize.max,
                //             children: [
                //               EditServiceFormWidget(
                //                 srvice: widget.service,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // );
              },
              bgColor: Colors.white,
              colorTitle1: secondryColor,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .01),
            CustomButton(
              title1: 'طلبات الخدمة',
              title2: '',
              onPressButton: widget.onPressButton,
              bgColor: secondryColor,
              colorTitle1: Colors.white,
            ),
            BlocConsumer<StopServiceBloc, StopServiceState>(
              listener: (context, state) {
                if (state is SuccessStopServiceState) {
                  SnackBarMessage().showSuccessSnackBar(
                      message: state.message, context: context);
                  isActive = !isActive;
                } else if (state is ErrorStopServiceState) {
                  SnackBarMessage().showErrorSnackBar(
                      message: state.message, context: context);
                }
              },
              builder: (context, state) {
                if (state is LoadingStopServiceState) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 10),
                    child: const LoadingWidget(),
                  );
                }
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  child: isActive
                      ? Directionality(
                          textDirection: TextDirection.ltr,
                          child: CustomServiceButton(
                            title: 'تشغيل العمل',
                            icon: Icons.check_circle,
                            bgColor: Colors.white,
                            bsColor: Colors.green,
                            onPressed: () {
                              BlocProvider.of<StopServiceBloc>(context).add(
                                DoStopServiceEvent(
                                  widget.service.id,
                                ),
                              );
                            },
                          ),
                        )
                      : Directionality(
                          textDirection: TextDirection.ltr,
                          child: CustomServiceButton(
                            title: 'ايقاف العمل',
                            icon: Icons.dnd_forwardslash,
                            bgColor: Colors.white,
                            bsColor: Colors.red,
                            onPressed: () {
                              BlocProvider.of<StopServiceBloc>(context).add(
                                DoStopServiceEvent(
                                  widget.service.id,
                                ),
                              );
                            },
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
