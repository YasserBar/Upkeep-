import 'package:flutter/material.dart';
import '../../features/orders/presentation/pages/incoming_requests_screen.dart';
import '../../features/services/presentation/pages/my_service_screen.dart';
import '../pages/provider_service/screen/home_service_provider_screen.dart';
import '../pages/provider_service/screen/service_screen.dart';
import '../theme/colors.dart';

class NavigationProvider extends StatefulWidget {
  const NavigationProvider({super.key});

  @override
  State<NavigationProvider> createState() => _NavigationProviderState();
}

class _NavigationProviderState extends State<NavigationProvider> {
  int index = 0;
  final pages = [
    const HomeServiceProviderScreen(),
    const IncomingRequestScreen(),
    const MyServicesScreen(),
    const ServiceScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          backgroundColor: primaryColor,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.white,
          selectedItemColor: secondryColor,
          currentIndex: index,
          onTap: (int nextIndex) {
            setState(
              () {
                index = nextIndex;
              },
            );
          },
          items: const [
            BottomNavigationBarItem(
                backgroundColor: primaryColor,
                icon: Icon(
                  Icons.home,
                ),
                label: 'الرئيسية'),
            BottomNavigationBarItem(
                backgroundColor: primaryColor,
                icon: Icon(
                  Icons.credit_card,
                ),
                label: 'طلباتي الواردة'),
            BottomNavigationBarItem(
                backgroundColor: primaryColor,
                icon: Icon(
                  Icons.file_copy_outlined,
                ),
                label: 'خدماتي'),
            BottomNavigationBarItem(
              backgroundColor: primaryColor,
              icon: Icon(
                Icons.person,
              ),
              label: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }
}
