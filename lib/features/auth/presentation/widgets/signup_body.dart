import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/features/locations/presentation/bloc/getLocations/get_locations_event.dart';
import '../../../locations/domain/entities/city.dart';
import '../../../locations/domain/entities/country.dart';
import '../../../locations/domain/entities/region.dart';
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
import '../../../../../injection_countainer.dart' as di;

class SignupBody extends StatefulWidget {
  const SignupBody({Key? key}) : super(key: key);

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  late String selectedGender;
  int? selectedCountryId = 0;
  int? selectedCityId = 0;
  int? selectedRegionId = 0;
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
    return BlocProvider(
      create: (_) => di.sl<GetLocationsBloc>()..add(const GetAllCountryEvent()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SuccessAuthState) {
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
                  title: 'قم  بإنشاء  حساب جديد الآن  ',
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
                                final selectedCountry =
                                    state.country.firstWhere(
                                  (country) => country.id == selectedCountryId,
                                 orElse: () => Country(id: 1,cities: List.empty(),name: '1'),
                                );

                                final selectedCity =
                                    selectedCountry.cities.firstWhere(
                                  (city) => city.id == selectedCityId,
                                  orElse: () => City(countryId: 1,id: 1,name: '1',regions: List.empty()),
                                );

                                final selectedRegion =
                                    selectedCity.regions.firstWhere(
                                  (region) => region.id == selectedRegionId,
                                  orElse: () => const Region(cityId: 1,countryId: 1,id: 1,name: '1'),
                                );

                                return Column(
                                  children: [
                                    PopupMenuButton<int>(
                                      elevation: 0,
                                      position: PopupMenuPosition.under,
                                      itemBuilder: (BuildContext context) {
                                        return state.country.map((country) {
                                          return PopupMenuItem(
                                            value: country.id,
                                            child: Text(country.name),
                                          );
                                        }).toList();
                                      },
                                      onSelected: (value) {
                                        setState(() {
                                          selectedCountryId = value;
                                          selectedCityId = null;
                                          selectedRegionId = null;
                                        });
                                      },
                                      child: CustomTextFiled(
                                        title: 'البلد',
                                        hintT: selectedCountry.name,
                                        icon: Icons.location_on_outlined,
                                      ),
                                    ),
                                    if (selectedCountry.cities.isNotEmpty)
                                      PopupMenuButton<int>(
                                        elevation: 0,
                                        position: PopupMenuPosition.under,
                                        itemBuilder: (BuildContext context) {
                                          return selectedCountry.cities
                                              .map((city) {
                                            return PopupMenuItem(
                                              value: city.id,
                                              child: Text(city.name),
                                            );
                                          }).toList();
                                        },
                                        onSelected: (value) {
                                          setState(() {
                                            selectedCityId = value;
                                            selectedRegionId = null;
                                          });
                                        },
                                        child: CustomTextFiled(
                                          title: 'المدينة',
                                          hintT: selectedCity.name,
                                          icon: Icons.location_on_outlined,
                                        ),
                                      ),
                                    if (selectedCity.regions.isNotEmpty)
                                      PopupMenuButton<int>(
                                        elevation: 0,
                                        position: PopupMenuPosition.under,
                                        itemBuilder: (BuildContext context) {
                                          return selectedCity.regions
                                              .map((region) {
                                            return PopupMenuItem(
                                              value: region.id,
                                              child: Text(region.name),
                                            );
                                          }).toList();
                                        },
                                        onSelected: (value) {
                                          setState(() {
                                            selectedRegionId = value;
                                          });
                                        },
                                        child: CustomTextFiled(
                                          title: 'المنطقة',
                                          hintT: selectedRegion.name,
                                          icon: Icons.location_on_outlined,
                                        ),
                                      ),
                                  ],
                                );
                              } else if (state is FailureGetLocationsState) {
                                return Text(state.message);
                              } else {
                                return const LoadingWidget();
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                                  country: selectedCountryId!,
                                  city: selectedCityId!,
                                  region: selectedRegionId!,
                                  mobilePhoneNumber:
                                      "+963${phoneController.text}",
                                )));
                              }
                            },
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          );
        },
      ),
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
