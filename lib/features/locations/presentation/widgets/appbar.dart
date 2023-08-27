import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upkeep_plus/core/constants/keys.dart';
import 'package:upkeep_plus/core/helpers/snackbar_message.dart';
import '../../../../core/theme/colors.dart';
import '../../../../main.dart';
import '../../../auth/data/datasources/auth_local_data_source.dart';
import '../../../auth/presentation/bloc/change_password_logout_bloc/change_password_logout_bloc.dart';
import '../../../auth/presentation/bloc/change_password_logout_bloc/change_password_logout_event.dart';
import '../../../auth/presentation/bloc/change_password_logout_bloc/change_password_logout_state.dart';
import '../../../auth/presentation/pages/change_password_screen.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import 'search.dart';
import '../../../../injection_countainer.dart' as di;

// ignore: must_be_immutable
class AppBarrr extends StatefulWidget {
  Function setCountryId;
  Function setRegionId;
  Function setCityId;
  bool? enableLocation;
  bool logout;
  bool changePassowrd;
  int? subServiceId;
  bool filterF;
  AppBarrr({
    this.filterF = false,
    this.enableLocation = false,
    this.logout = false,
    this.changePassowrd = false,
    super.key,
    required this.pageName,
    required this.setCountryId,
    required this.setRegionId,
    required this.setCityId,
    this.subServiceId,
  });
  final String pageName;

  @override
  State<AppBarrr> createState() => _AppBarrrState();
}

class _AppBarrrState extends State<AppBarrr> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordLogoutBloc>(
      create: (context) => di.sl<ChangePasswordLogoutBloc>(),
      child: BlocListener<ChangePasswordLogoutBloc, ChangePasswordLogoutState>(
        listener: (context, state) async {
          if (state is SuccessChangePasswordLogoutState) {
            if (kDebugMode) {
              print(
                  "==============================logout========================");
            }
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => const LoginScreen()),
            //   (Route<dynamic> route) => false,
            // );
            await di.sl<SharedPreferences>().clear();
            await di.sl<AuthLocalDataSource>().removeCachedResponse();
          } else if (state is ErrorChangePasswordLogoutState) {
            SnackBarMessage()
                .showErrorSnackBar(message: state.message, context: context);
          }
        },
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  height: 90,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0).copyWith(bottom: 6.0),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.pageName,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                widget.logout
                    ? Positioned(
                        right: 20,
                        height: 100,
                        child: Builder(builder: (context) {
                          return IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AlertDialog(
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                                'هل انت متاكد من تسجيل الخروج؟'),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            ChangePasswordLogoutBloc>()
                                                        .add(
                                                            const LogoutEvent());
                                                    di.sl<SharedPreferences>()
                                                      ..remove(CUSTOMER)
                                                      ..remove(CACHED_RESPONSE);
                                                    token = null;
                                                    globalFoundationId = null;
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const LoginScreen()),
                                                      (Route<dynamic> route) =>
                                                          false,
                                                    );
                                                  },
                                                  child: const Text(
                                                      'تسجيل الخروج'),
                                                ),
                                                const Spacer(),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(false);
                                                  },
                                                  child: const Text('إلغاء'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.logout_outlined,
                              color: Colors.white,
                            ),
                          );
                        }),
                      )
                    : const SizedBox(),
                widget.changePassowrd
                    ? Positioned(
                        left: 20,
                        height: 100,
                        child: IconButton(
                          onPressed: () {
                            globalContext = context;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangePasswordScreen()),
                            );
                          },
                          icon: const Icon(
                            Icons.lock_reset_outlined,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const SizedBox(),
                widget.enableLocation!
                    ? Searchh(
                        filterF: widget.filterF,
                        subServiceId: widget.subServiceId,
                        setCountryId: widget.setCountryId,
                        setCityId: widget.setCityId,
                        setRegionId: widget.setRegionId,
                      )
                    : const SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
