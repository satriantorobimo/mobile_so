import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/login/bloc/login_bloc/bloc.dart';
import 'package:mobile_so/features/login/data/login_request_model.dart';
import 'package:mobile_so/features/login/domain/repo/login_repo.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  LoginBloc loginBloc = LoginBloc(loginRepo: LoginRepo());
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
                        controller: _usernameController,
                        onChanged: (data) {
                          if (_usernameController.text.isEmpty ||
                              _passController.text.isEmpty) {
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
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'PASSWORD',
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
                        controller: _passController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        onChanged: (data) {
                          if (_usernameController.text.isEmpty ||
                              _passController.text.isEmpty) {
                            enable = false;
                          } else {
                            enable = true;
                          }
                          setState(() {});
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.035),
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.5)),
                            filled: true,
                            fillColor: const Color(0xFFB1ADBC),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    BlocListener(
                        bloc: loginBloc,
                        listener: (_, LoginState state) {
                          if (state is LoginLoading) {
                            setState(() {
                              isLoading = true;
                            });
                          }
                          if (state is LoginLoaded) {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pushNamed(
                                context, StringRouterUtil.otpLoginScreenRoute,
                                arguments: _usernameController.text);
                          }
                          if (state is LoginError) {
                            GeneralUtil()
                                .showSnackBarError(context, state.error!);
                            setState(() {
                              isLoading = false;
                            });
                          }
                          if (state is LoginException) {
                            GeneralUtil()
                                .showSnackBarError(context, state.error);
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        child: BlocBuilder(
                            bloc: loginBloc,
                            builder: (_, LoginState state) {
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

                                              loginBloc.add(LoginAttempt(
                                                  loginRequestModel:
                                                      LoginRequestModel(
                                                          username:
                                                              _usernameController
                                                                  .text,
                                                          password:
                                                              _passController
                                                                  .text)));
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
                                            child: Text('Login',
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
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, StringRouterUtil.emailOtpScreenRoute);
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontSize: GeneralUtil.fontSize(context) * 0.4,
                              color: Colors.white),
                        ),
                      ),
                    ),
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
