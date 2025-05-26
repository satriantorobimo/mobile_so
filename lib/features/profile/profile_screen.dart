import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/utility/alert_dialog_util.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _uidCtrl = TextEditingController();
  final TextEditingController _companyCtrl = TextEditingController();
  String name = '';
  String uid = '';
  String company = '';
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() async {
    await SharedPrefUtil.getSharedString('name').then((value) => name = value!);
    await SharedPrefUtil.getSharedString('uid').then((value) => uid = value!);
    await SharedPrefUtil.getSharedString('company')
        .then((value) => company = value!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF130139),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imgs/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06,
                  ),
                  child: Text('Profile',
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.7,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.person_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Center(
                        child: Text(name,
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: GeneralUtil.fontSize(context) * 0.55,
                                color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(company,
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: GeneralUtil.fontSize(context) * 0.4,
                            color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(uid,
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: GeneralUtil.fontSize(context) * 0.4,
                            color: Colors.white)),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.015,
                          width: MediaQuery.of(context).size.height * 0.015,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text('Active',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: GeneralUtil.fontSize(context) * 0.3,
                                color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('StockOpname.',
                        style: TextStyle(
                            fontFamily: GoogleFonts.leagueSpartan().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: GeneralUtil.fontSize(context) * 0.7,
                            color: Colors.white)),
                    const SizedBox(height: 24),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: 1.5,
                      color: Color(0xFFE45A04),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Row(
                        children: [
                          Text('About',
                              style: TextStyle(
                                  fontFamily:
                                      GoogleFonts.leagueSpartan().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: GeneralUtil.fontSize(context) * 0.7,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: 1.5,
                      color: Color(0xFFE45A04),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Row(
                        children: [
                          Text('Support',
                              style: TextStyle(
                                  fontFamily:
                                      GoogleFonts.leagueSpartan().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: GeneralUtil.fontSize(context) * 0.7,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: 1.5,
                      color: Color(0xFFE45A04),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              var dialog = CustomAlertDialog(
                                title: "Logout",
                                message: "Are you sure, do you want to logout?",
                                onPostivePressed: () {
                                  SharedPrefUtil.clearSharedPref();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      StringRouterUtil.loginScreenRoute,
                                      (route) => false);
                                },
                                positiveBtnText: 'Yes',
                                negativeBtnText: 'No',
                                onNegativePressed: () {
                                  Navigator.pop(context);
                                },
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => dialog);
                            },
                            child: Text('Logout',
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.leagueSpartan().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        GeneralUtil.fontSize(context) * 0.7,
                                    color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: 1.5,
                      color: Color(0xFFE45A04),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
