import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upkeep_plus/core/helpers/snackbar_message.dart';
import 'package:upkeep_plus/core/theme/colors.dart';
import '../../../../core/helpers/loading_widget.dart';
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 90, width: double.infinity),
                BlocBuilder<GetAllFoundationsBloc, GetAllFoundationsState>(
                  builder: (context, state) {
                    if (kDebugMode) {
                      print("${state.hasMore}&&&&&&&&&&&&&&&&&&&&&&&&&&&");
                    }
                    if (state is SuccessGetAllFoundationsState) {
                      List<Foundation> foundations = state.foundations!;
                      if (foundations.isEmpty) {
                        return const Center(
                          child: Text("لا يوجد مؤسسات"),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          controller: context
                              .read<GetAllFoundationsBloc>()
                              .scrollController,
                          clipBehavior: Clip.none,
                          physics: const BouncingScrollPhysics(),
                          itemCount: foundations.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < foundations.length) {
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
                                    isActive = foundations[index].active! == 0
                                        ? true
                                        : false;

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
                              return state.loaded
                                  ? const SizedBox()
                                  : Container(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 40),
                                      child: state.hasMore
                                          ? const LoadingWidget(vertical: 0.0)
                                          : const Center(
                                              child: Text(
                                                  "لا يوجد المزيد من المؤسسات"),
                                            ),
                                    );
                            }
                          },
                        ),
                      );
                    } else if (state is LoadingGetAllFoundationsState) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * .9,
                        height: MediaQuery.of(context).size.height * .8,
                        child: const LoadingWidget(
                          vertical: 0.0,
                        ),
                      );
                    } else if (state is ErrorGetAllFoundationsState) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * .9,
                        height: MediaQuery.of(context).size.height * .8,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  state.message,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.blueGrey[50],
                                child: IconButton(
                                  onPressed: () {
                                    context.read<GetAllFoundationsBloc>().add(
                                          const GetAllFoundationOwnerEvent(),
                                        );
                                  },
                                  icon: const Icon(
                                    Icons.replay_sharp,
                                    color: secondryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: Text('asdasdasdasd'));
                    }
                  },
                ),
              ],
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
