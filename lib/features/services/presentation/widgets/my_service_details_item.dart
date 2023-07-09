import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/aseets/assets.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/custom_service_button.dart';
import '../../../auth/presentation/widgets/custome_button.dart';
import '../../domain/entities/service_foundation.dart';
import '../bloc/edit_service_foundation_bloc/edit_service_foundation_bloc.dart';
import '../../../../injection_countainer.dart' as di;

import 'edit_service_form_widget.dart';

class MySeviceDetailsItem extends StatefulWidget {
  const MySeviceDetailsItem({
    this.serviceName =
        " خدمة غسيل السيارات مع تبديل الزيت و مصفاة البنزين و تنظيف للمحرك ",
    this.serviceKind = "صيانة السيارات",
    super.key,
    required this.imgUrl,
    required this.onPressButton,
    required this.service,
  });
  final String serviceName;
  final void Function() onPressButton;
  final String serviceKind;
  final ServiceFoundation service;
  final String imgUrl;

  @override
  State<MySeviceDetailsItem> createState() => _MySeviceDetailsItemState();
}

class _MySeviceDetailsItemState extends State<MySeviceDetailsItem> {

  bool isClicked = true;

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
                  imageUrl: widget.imgUrl,
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
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      widget.serviceKind,
                      style: const TextStyle(
                          color: secondryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ))),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                widget.serviceName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            CustomButton(
              title1: 'تعديل الخدمة',
              title2: '',
              onPressButton: () {
                showModalBottomSheet<void>(
                  isScrollControlled: false,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(60))),
                  context: context,
                  builder: (BuildContext context) {
                    return BlocProvider<EditServiceFoundationBloc>(
                      create: (_) => di.sl<EditServiceFoundationBloc>(),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              EditServiceFormWidget(
                                srvice: widget.service,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
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
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: isClicked
                  ? CustomServiceButton(
                      title: 'تشغيل العمل',
                      icon: Icons.check_circle,
                      bgColor: Colors.white,
                      bsColor: Colors.green,
                      onPressed: () {
                        setState(() {
                          isClicked = false;
                        });
                      },
                    )
                  : CustomServiceButton(
                      title: 'ايقاف العمل',
                      icon: Icons.dnd_forwardslash,
                      bgColor: Colors.white,
                      bsColor: Colors.red,
                      onPressed: () {
                        setState(() {
                          isClicked = true;
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
