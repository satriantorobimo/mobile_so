import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _goToLogin();

    super.initState();
  }

  void _goToLogin() {
    SharedPrefUtil.getSharedString('token').then((value) {
      if (value == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, StringRouterUtil.loginScreenRoute, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, StringRouterUtil.navbarScreenRoute, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('StockOpname .',
                    style: TextStyle(
                        fontFamily: GoogleFonts.leagueSpartan().fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 37,
                        color: Colors.white)),
                const SizedBox(height: 16),
                Text(
                  'M o b i l e',
                  style: TextStyle(
                      fontFamily: GoogleFonts.quicksand().fontFamily,
                      fontSize: 13,
                      color: Colors.white),
                )
              ],
            ),
            const CircularProgressIndicator(),
            Column(
              children: [
                Text(
                  'P o w e r e d  b y ',
                  style: TextStyle(
                      fontFamily: GoogleFonts.quicksand().fontFamily,
                      fontSize: 11,
                      color: Colors.white),
                ),
                Image.asset(
                  'assets/imgs/logo.png',
                  width: 250,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
