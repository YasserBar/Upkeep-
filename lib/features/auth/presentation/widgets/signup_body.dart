import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/core/theme/colors.dart';
import 'package:upkeep_plus/features/locations/domain/entities/city.dart';
import 'package:upkeep_plus/features/locations/domain/entities/country.dart';
import 'package:upkeep_plus/features/locations/domain/entities/region.dart';
import 'package:upkeep_plus/features/locations/presentation/bloc/getLocations/get_locations_event.dart';
import '../widgets/textfiled_full_name.dart';
import '../../../../core/helpers/regex.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../../../../core/widgets/dropdown_list.dart';
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
import 'date_widget.dart';

class SignupBody extends StatefulWidget {
  const SignupBody({Key? key}) : super(key: key);

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  late String selectedGender;
  Country? selectedCountry;
  City? selectedCity;
  Region? selectedRegion;
  final formfey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessSignupState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifySignupScreen(
                  email: emailController.text,
                  password: passwordController.text),
            ),
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
        return SingleChildScrollView(
          child: Column(
            children: [
              const CostumeAppBarAuth(
                title: 'قم بإنشاء حساب جديد الآن',
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Form(
                  key: formfey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFiled(
                        title: 'بريد إلكتروني',
                        hintT: "example@mail.com",
                        icon: Icons.email_outlined,
                        controller: emailController,
                        validator: (value) => validateEmail(value),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFiled(
                        title: 'كلمة المرور',
                        hintT: "************",
                        icon: Icons.lock_outline,
                        controller: passwordController,
                        validator: (value) => validatePassword(value),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TexetFiledNumber(
                        controller: phoneController,
                        validator: (value) => validatePhone(value),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFiledFullName(
                        firstController: firstNameController,
                        firstValidator: (value) => validateName(value),
                        lastController: lastNameController,
                        lastValidator: (value) => validateLastName(value),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DatePicker(
                        title: "تاريخ الميلاد",
                        dateController: dateController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          const TitleTextFiled(
                              title: "الجنس", icon: Icons.female),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButtonWidget(
                              s: gender,
                              title: "اختر الجنس",
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<GetLocationsBloc, GetLocationsState>(
                        builder: (context, state) {
                          if (state is LoadedGetAllCountryState) {
                            if (kDebugMode) {
                              print(state.country);
                            }
                            return Column(
                              children: [
                                const TitleTextFiled(
                                    title: 'البلد',
                                    icon: Icons.location_on_outlined),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              )),
                                          contentPadding: EdgeInsets.all(10)),
                                      hint: const Text(
                                        'اختر البلد',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      value: selectedCountry,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCountry = value;
                                          selectedCity = null;
                                          selectedRegion = null;
                                        });
                                      },
                                      items: state.country.map((country) {
                                        return DropdownMenuItem(
                                          value: country,
                                          child: Text(
                                            country.name,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            );

                            // DropdownButton<Country>(
                            //   value: selectedCountry,
                            //   hint: const Text('اختر البلد'),
                            //   items: state.country.map((country) {
                            //     return DropdownMenuItem<Country>(
                            //       value: country,
                            //       child: Text(country.name),
                            //     );
                            //   }).toList(),
                            //   onChanged: (value) {
                            //     setState(() {
                            //       selectedCountry = value;
                            //       selectedCity = null;
                            //       selectedRegion = null;
                            //     });
                            //   },
                            // );
                          } else if (state is FailureGetLocationsState) {
                            return Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      state.message,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.blueGrey[50],
                                    child: IconButton(
                                      onPressed: () {
                                        context
                                            .read<GetLocationsBloc>()
                                            .add(const GetAllCountryEvent());
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
                          } else {
                            return const LoadingWidget();
                          }
                        },
                      ),
                      if (selectedCountry != null)
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const TitleTextFiled(
                                title: 'المدينة',
                                icon: Icons.location_on_outlined),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          )),
                                      contentPadding: EdgeInsets.all(10)),
                                  hint: const Text(
                                    'اختر المدينة',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: selectedCity,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCity = value;
                                      selectedRegion = null;
                                    });
                                  },
                                  items: selectedCountry!.cities.map((city) {
                                    return DropdownMenuItem(
                                      value: city,
                                      child: Text(
                                        city.name,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      // DropdownButton<City>(
                      //   value: selectedCity,
                      //   hint: const Text('اختر المدينة'),
                      //   items: selectedCountry!.cities.map((city) {
                      //     return DropdownMenuItem<City>(
                      //       value: city,
                      //       child: Text(city.name),
                      //     );
                      //   }).toList(),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       selectedCity = value;
                      //       selectedRegion = null;
                      //     });
                      //   },
                      // ),
                      if (selectedCity != null)
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const TitleTextFiled(
                                title: 'المنطقة',
                                icon: Icons.location_on_outlined),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          )),
                                      contentPadding: EdgeInsets.all(10)),
                                  hint: const Text(
                                    'اختر المنطقة',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: selectedRegion,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRegion = value;
                                    });
                                  },
                                  items: selectedCity!.regions.map((region) {
                                    return DropdownMenuItem(
                                      value: region,
                                      child: Text(
                                        region.name,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      // DropdownButton<Region>(
                      //   value: selectedRegion,
                      //   hint: const Text('اختر المنطقة'),
                      //   items: selectedCity!.regions.map((region) {
                      //     return DropdownMenuItem<Region>(
                      //       value: region,
                      //       child: Text(region.name),
                      //     );
                      //   }).toList(),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       selectedRegion = value;
                      //     });
                      //   },
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        title1: "انشاء الحساب",
                        title2: " ",
                        onPressButton: () {
                          final isValidForm = formfey.currentState!.validate();
                          if (isValidForm) {
                            BlocProvider.of<AuthBloc>(context)
                                .add(SignupEvent(Signup(
                              email: emailController.text,
                              password: passwordController.text,
                              fName: firstNameController.text,
                              lName: lastNameController.text,
                              gender: selectedGender,
                              dateOfBirth: dateController.text,
                              country: selectedCountry!.id,
                              city: selectedCity!.id,
                              region: selectedRegion!.id,
                              mobilePhoneNumber: "+963${phoneController.text}",
                            )));
                          }
                        },
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// // ignore: unused_element
// Widget _buildDropdownButton(List<Country> countryList) {
//   return PopupMenuButton<String>(
//     elevation: 0,
//     position: PopupMenuPosition.under,
//     itemBuilder: (BuildContext context) {
//       return countryList.map((country) {
//         return PopupMenuItem(
//           value: country.name,
//           child: Text(country.name),
//         );
//       }).toList();
//     },
//     onSelected: (value) {},
//     child: CircleAvatar(
//       radius: 20,
//       backgroundColor: Colors.white,
//       child: Image.asset(
//         AssetClass.Location,
//         width: 21.82,
//         height: 29.09,
//       ),
//     ),
//   );
// }
