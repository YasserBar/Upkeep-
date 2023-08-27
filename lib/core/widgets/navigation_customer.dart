import 'package:flutter/material.dart';
import 'package:upkeep_plus/features/foundations/presentation/pages/customerPage/foundations_in_system.dart';
import '../../features/ads&jobs/presentation/pages/customer/job_page.dart';
import '../../features/orders/presentation/pages/customer/my_order_page.dart';
import '../pages/customer/customer_home_page.dart';
import '../theme/colors.dart';

class NavigationCustomer extends StatefulWidget {
  const NavigationCustomer({super.key});

  @override
  State<NavigationCustomer> createState() => _NavigationCustomerState();
}

class _NavigationCustomerState extends State<NavigationCustomer> {
  int? countryId;
  int? cityId;
  int? regionId;
  int index = 0;
  setCountryId(int countryId) {
    this.countryId = countryId;
  }

  setCityId(int cityId) {
    this.cityId = cityId;
  }

  setRegionId(int regionId) {
    this.regionId = regionId;
  }

  // ignore: prefer_typing_uninitialized_variables
  late final pages;
  @override
  void initState() {
    super.initState();
    pages = [
      CustomerHomePage(
        countryId: countryId,
        cityId: cityId,
        regionId: regionId,
        setCountryId: setCountryId,
        setCityId: setCityId,
        setRegionId: setRegionId,
      ),
      FoundationsInSystem(
        countryId: countryId,
        cityId: cityId,
        regionId: regionId,
        setCountryId: setCountryId,
        setCityId: setCityId,
        setRegionId: setRegionId,
      ),
      const MyOrderPage(),
      const JobPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Theme(
          data: ThemeData(
            canvasColor: primaryColor,
          ),
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            unselectedItemColor: Colors.white,
            selectedItemColor: secondryColor,
            currentIndex: index,
            onTap: (int nextIndex) {
              setState(() {
                index = nextIndex;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'الرئيسية'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.people,
                  ),
                  label: 'مزودي الخدمة'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: 'طلباتي'),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.work,
                ),
                label: 'فرص عمل',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
