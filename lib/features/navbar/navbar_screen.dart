import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_so/features/additional_request_list/additional_request_list_screen.dart';
import 'package:mobile_so/features/asset_opname_list/asset_opname_list_screen.dart';
import 'package:mobile_so/features/dashboard/dashboard_screen.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';

import 'package:mobile_so/features/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  Widget _getPage(int index) {
    if (index == 0) {
      return const DashboardScreen();
    }
    if (index == 1) {
      return const AssetOpnameListScreen();
    }
    if (index == 2) {
      return const AdditionalRequestListScreen();
    }
    if (index == 3) {
      return const ProfileScreen();
    }

    return const DashboardScreen();
  }

  @override
  Widget build(BuildContext context) {
    var bottomBarProvider = Provider.of<NavbarProvider>(context);
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomBarProvider.page,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFE45A04),
          onTap: (index) {
            bottomBarProvider.setPage(index);
            bottomBarProvider.setTab(0);
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 18,
          selectedFontSize: 13,
          unselectedFontSize: 13,
          selectedLabelStyle: const TextStyle(
              fontSize: 13,
              color: Colors.white,
              height: 1.5,
              fontWeight: FontWeight.w600),
          elevation: 0,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xFF575551),
          unselectedLabelStyle: const TextStyle(
              color: Color(0xFF575551),
              height: 1.5,
              fontWeight: FontWeight.w600),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/dashboard.svg',
                  color: Colors.white30,
                  height: 40,
                  width: 40,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/dashboard.svg',
                  color: Colors.white,
                  height: 40,
                  width: 40,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/plus.svg',
                  color: Colors.white30,
                  height: 40,
                  width: 40,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/plus.svg',
                  color: Colors.white,
                  height: 40,
                  width: 40,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/info.svg',
                  color: Colors.white30,
                  height: 40,
                  width: 40,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/info.svg',
                  color: Colors.white,
                  height: 40,
                  width: 40,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/profile.svg',
                  color: Colors.white30,
                  height: 40,
                  width: 40,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/profile.svg',
                  color: Colors.white,
                  height: 40,
                  width: 40,
                ),
                label: ''),
          ],
        ),
        body: _getPage(bottomBarProvider.page));
  }
}
