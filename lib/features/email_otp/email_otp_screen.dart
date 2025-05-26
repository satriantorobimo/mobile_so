import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/email_otp/bloc/req_change_password_bloc/bloc.dart';
import 'package:mobile_so/features/email_otp/domain/repo/change_password_repo.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';

class EmailOtpScreen extends StatefulWidget {
  const EmailOtpScreen({super.key});

  @override
  State<EmailOtpScreen> createState() => _EmailOtpScreenState();
}

class _EmailOtpScreenState extends State<EmailOtpScreen> {
  final TextEditingController _usernameCtrl = TextEditingController();
  ReqChangePasswordBloc changePasswordBloc =
      ReqChangePasswordBloc(changePasswordRepo: ChangePasswordRepo());
  bool enable = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Column(
                  children: [
                    Text('StockOpname.',
                        style: TextStyle(
                            fontFamily: GoogleFonts.leagueSpartan().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: GeneralUtil.fontSize(context) * 1.2,
                            color: Colors.white)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      'M o b i l e',
                      style: TextStyle(
                          fontFamily: GoogleFonts.quicksand().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.4,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'USERNAME',
                        style: TextStyle(
                            fontSize: GeneralUtil.fontSize(context) * 0.4,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    Material(
                      elevation: 6,
                      shadowColor: Colors.grey.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                              width: 1.0, color: Color(0xFFB1ADBC))),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        controller: _usernameCtrl,
                        onChanged: (data) {
                          if (_usernameCtrl.text.isEmpty) {
                            enable = false;
                          } else {
                            enable = true;
                          }
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.035),
                            filled: true,
                            fillColor: const Color(0xFFB1ADBC),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    BlocListener(
                        bloc: changePasswordBloc,
                        listener: (_, ReqChangePasswordState state) {
                          if (state is ReqChangePasswordLoading) {
                            setState(() {
                              isLoading = true;
                            });
                          }
                          if (state is ReqChangePasswordLoaded) {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pushNamed(
                                context, StringRouterUtil.otpScreenRoute,
                                arguments: _usernameCtrl.text);
                          }
                          if (state is ReqChangePasswordError) {
                            GeneralUtil()
                                .showSnackBarError(context, state.error!);
                            setState(() {
                              isLoading = false;
                            });
                            if (state.error!
                                .toLowerCase()
                                .contains('please try again in')) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  StringRouterUtil.loginScreenRoute,
                                  (route) => false);
                            }
                          }
                          if (state is ReqChangePasswordException) {
                            GeneralUtil()
                                .showSnackBarError(context, state.error);
                            setState(() {
                              isLoading = false;
                            });
                            if (state.error
                                .toLowerCase()
                                .contains('please try again in')) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  StringRouterUtil.loginScreenRoute,
                                  (route) => false);
                            }
                          }
                        },
                        child: BlocBuilder(
                            bloc: changePasswordBloc,
                            builder: (_, ReqChangePasswordState state) {
                              return isLoading
                                  ? const Center(
                                      child: SizedBox(
                                        width: 45,
                                        height: 45,
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: enable
                                          ? () {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();

                                              changePasswordBloc.add(
                                                  ReqChangePasswordAttempt(
                                                      userName:
                                                          _usernameCtrl.text));
                                            }
                                          : null,
                                      child: Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.09,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                                color: enable
                                                    ? Colors.white
                                                    : Colors.grey,
                                                width: 2)),
                                        child: Center(
                                            child: Text('SEND OTP',
                                                style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.poppins()
                                                            .fontFamily,
                                                    fontSize:
                                                        GeneralUtil.fontSize(
                                                                context) *
                                                            0.5,
                                                    color: enable
                                                        ? Colors.white
                                                        : Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                    );
                            })),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    'P o w e r e d  b y ',
                    style: TextStyle(
                        fontFamily: GoogleFonts.quicksand().fontFamily,
                        fontSize: GeneralUtil.fontSize(context) * 0.35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    'assets/imgs/logo.png',
                    width: MediaQuery.of(context).size.width * 0.6,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
