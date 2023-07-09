import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/utilities/loading_widget.dart';
import '../../../../core/utilities/snackbar_message.dart';
import '../../../../core/widgets/navigation_provider.dart';
import '../../../../main.dart';
import '../../../auth/presentation/bloc/change_password_logout_bloc/change_password_logout_bloc.dart';
import '../../../auth/presentation/bloc/change_password_logout_bloc/change_password_logout_state.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../../../locations/presentation/widgets/appbar.dart';
import '../../domain/entities/foundation.dart';
import '../bloc/get_all_foundation_bloc/get_all_foundations_bloc.dart';
import '../widgets/foundation_widget.dart';
import '../../../../../injection_countainer.dart' as di;

class MyFoundationsBody extends StatefulWidget {
  const MyFoundationsBody({Key? key}) : super(key: key);

  @override
  State<MyFoundationsBody> createState() => _MyFoundationsBodyState();
}

class _MyFoundationsBodyState extends State<MyFoundationsBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ChangePasswordLogoutBloc, ChangePasswordLogoutState>(
        listener: (context, state) {
          if (state is SuccessChangePasswordLogoutState) {
            if (kDebugMode) {
              print(
                  "==============================logout========================");
            }
            di.sl<SharedPreferences>().clear();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
            );
          } else if (state is ErrorChangePasswordLogoutState) {
            SnackBarMessage()
                .showErrorSnackBar(message: state.message, context: context);
          }
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 117, width: double.infinity),
                  BlocBuilder<GetAllFoundationsBloc, GetAllFoundationsState>(
                    builder: (context, state) {
                      if (kDebugMode) {
                        print("${state.hasMore}&&&&&&&&&&&&&&&&&&&&&&&&&&&");
                      }
                      if (state is SuccessGetAllFoundationsState) {
                        List<Foundation> foundations = state.foundations!;
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * .9,
                          height: MediaQuery.of(context).size.height * .832,
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: context
                                .read<GetAllFoundationsBloc>()
                                .scrollController,
                            clipBehavior: Clip.none,
                            physics: const BouncingScrollPhysics(),
                            itemCount: foundations.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (foundations.isEmpty) {
                                return const Center(
                                  child: Text("لا يوجد مؤسسات"),
                                );
                              } else if (index < foundations.length) {
                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: FoundationWidget(
                                    text: foundations[index].name,
                                    description: foundations[index].description,
                                    imgUrl: foundations[index].photo,
                                    onTap: () {
                                      if (kDebugMode) {
                                        print(globalFoundationId);
                                        print(
                                            "jjjjjjjjjjjjjjjjjj----------------------------------------------------------------------");
                                      }
                                      globalFoundationId = foundations[index].id;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const NavigationProvider()),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return Container(
                                  padding:
                                      const EdgeInsets.only(top: 20, bottom: 40),
                                  child: state.hasMore
                                      ? const LoadingWidget(vertical: 0.0)
                                      : const SizedBox(
                                          height: 30,
                                          child: Center(
                                            child: Text(
                                                "لا يوجد المزيد من المؤسسات"),
                                          ),
                                        ),
                                );
                              }
                            },
                          ),
                        );
                      } else if (state is LoadingGetAllFoundationsState) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width * .9,
                            height: MediaQuery.of(context).size.height * .615,
                            child: const LoadingWidget(
                              vertical: 0.0,
                            ));
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
           
            Container(
                margin: const EdgeInsets.only(bottom: 4),
                child: AppBarrr(
                  changePassowrd: true,
                  logout: true,
                  enableLocation: false,
                  pageName: "مؤسساتي",
                  setCountryId: () {},
                  setCityId: () {},
                  setRegionId: () {},
                )),
          ],
        ),
      ),
    );
  }
}
