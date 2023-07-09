import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/textfiled_full_name.dart';
import '../../../../core/aseets/assets.dart';
import '../../../../core/helpers/regex.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../../../../core/widgets/dropdown_list.dart';
import '../../../ads&jobs/domain/entities/country.dart';
import '../../../locations/presentation/bloc/getLocations/get_locations_bloc.dart';
import '../../../locations/presentation/bloc/getLocations/get_locations_state.dart';
import '../../domain/entities/signup.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../pages/verify_signup.dart';
import 'custom_textfiled.dart';
import 'custome_appbar_auth.dart';
import 'custome_button.dart';
import 'dropdown_item.dart';
import 'textfiled_number.dart';
import 'ttime_date_widget.dart';

class SignupBody extends StatefulWidget {
  const SignupBody({Key? key}) : super(key: key);

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  late String selectedGender;
  void setDate(String date) {
    setState(() {
      dateController.text = date;
    });
  }

  int selectedCity = 0;
  final formfey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  //////////////????!!
  TextEditingController passwordController = TextEditingController();
  ////
  TextEditingController phoneController = TextEditingController();
  ////
  TextEditingController dateController = TextEditingController();
  ////
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessAuthState) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerifySignupScreen(
                    email: emailController.text,
                    password: passwordController.text)),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifySignupScreen(
                email: emailController.text,
                password: passwordController.text,
              ),
            ),
          );
        } else if (state is ErrorAuthState) {
          if (kDebugMode) {
            print(state.message);
          }
        }
      },
      builder: (context, state) {
        if (state is LoadingAuthState) {
          return const LoadingWidget();
        }
        return CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  const Expanded(
                      child: CostumeAppBarAuth(
                    title: 'قم  بإنشاء  حساب  الآن  ',
                  )),
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Form(
                          key: formfey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomTextFiled(
                                title: 'أيميل',
                                hintT: "example@mail.com",
                                icon: Icons.email_outlined,
                                controller: emailController,
                                validator: (value) => validateEmail(value),
                              ),
                              CustomTextFiled(
                                title: 'كلمة المرور',
                                hintT: "************",
                                icon: Icons.lock_outline,
                                controller: passwordController,
                                validator: (value) => validatePassword(value),
                              ),
                              TexetFiledNumber(
                                controller: phoneController,
                                validator: (value) => validatePhone(value),
                              ),
                              TextFiledFullName(
                                firstController: firstNameController,
                                lastController: lastNameController,
                              ),
                              Column(
                                children: [
                                  const TitleTextFiled(
                                      title: "تاريخ الميلاد",
                                      icon: Icons.date_range_outlined),
                                  TimeDatePicker(
                                    setDateController: setDate,
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .06,
                                  child: DropdownButtonWidget(
                                    s: gender,
                                    title: "الجنس",
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender = value;
                                      });
                                    },
                                  )),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .06,
                                  child: BlocBuilder<GetLocationsBloc,
                                      GetLocationsState>(
                                    builder: (context, state) {
                                      if (state is LoadedGetAllCountryState) {
                                        return DropdownButtonWidget(
                                          s: state.country,
                                          title: "الموقع",
                                          onChanged: (value) {
                                            setState(() {
                                              if (value == "دمشق") {
                                                selectedCity = 1;
                                              }
                                              if (value == "حمص") {
                                                selectedCity = 2;
                                              } else {
                                                selectedCity = 3;
                                              }
                                            });
                                          },
                                        );
                                      } else if (state
                                          is FailureGetLocationsState) {
                                        return (Text(state.message));
                                      } else {
                                        return const LoadingWidget();
                                      }
                                    },
                                  )),
                              CustomButton(
                                title1: "انشاء الحساب",
                                title2: " ",
                                onPressButton: () {
                                  final isValidForm =
                                      formfey.currentState!.validate();
                                  if (isValidForm) {
                                    BlocProvider.of<AuthBloc>(context)
                                        .add(SignupEvent(Signup(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      fName: firstNameController.text,
                                      lName: lastNameController.text,
                                      gender: selectedGender,
                                      dateOfBirth: dateController.text,
                                      country: selectedCity,
                                      region: selectedCity,
                                      city: selectedCity,
                                      mobilePhoneNumber:
                                          "+963${phoneController.text}",
                                    )));
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

// ignore: unused_element
Widget _buildDropdownButton(List<Country> countryList) {
  return PopupMenuButton<String>(
    elevation: 0,
    position: PopupMenuPosition.under,
    itemBuilder: (BuildContext context) {
      return countryList.map((country) {
        return PopupMenuItem(
          value: country.name,
          child: Text(country.name),
        );
      }).toList();
    },
    onSelected: (value) {},
    child: CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      child: Image.asset(
        AssetClass.Location,
        width: 21.82,
        height: 29.09,
      ),
    ),
  );
}
