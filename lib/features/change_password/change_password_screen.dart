import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/email_otp/bloc/change_password_bloc/bloc.dart';
import 'package:mobile_so/features/email_otp/data/change_password_request_model.dart';
import 'package:mobile_so/features/email_otp/domain/repo/change_password_repo.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String email;
  const ChangePasswordScreen({super.key, required this.email});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _showPwd1 = true;
  bool _showPwd2 = true;
  final TextEditingController _pwd1Ctrl = TextEditingController();
  final TextEditingController _pwd2Ctrl = TextEditingController();
  bool isCorrect = false;
  bool isSame = false;
  bool isLoading = false;
  ChangePasswordBloc changePasswordBloc =
      ChangePasswordBloc(changePasswordRepo: ChangePasswordRepo());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text('StockOpname .',
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 29,
                              color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      child: Text('Change\nPassword',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'PASSWORD : ',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Stack(
                        children: [
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
                              obscureText: _showPwd1,
                              controller: _pwd1Ctrl,
                              onChanged: ((value) {
                                String pattern =
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                RegExp regExp = RegExp(pattern);
                                if (regExp.hasMatch(value)) {
                                  setState(() {
                                    isCorrect = true;
                                  });
                                } else {
                                  setState(() {
                                    isCorrect = false;
                                  });
                                }
                              }),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(24),
                                  filled: true,
                                  fillColor: const Color(0xFFB1ADBC),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: _pwd1Ctrl.text.isEmpty ||
                                                _pwd1Ctrl.text == ''
                                            ? Colors.grey
                                            : !isCorrect
                                                ? Colors.red
                                                : Colors.grey,
                                        width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: _pwd1Ctrl.text.isEmpty ||
                                                _pwd1Ctrl.text == ''
                                            ? Colors.grey
                                            : !isCorrect
                                                ? Colors.red
                                                : Colors.grey,
                                        width: 2),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  )),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            top: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPwd1 = !_showPwd1;
                                });
                              },
                              child: Icon(
                                _showPwd1
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.black38,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'CONFIRM PASSWORD :',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Stack(
                        children: [
                          Material(
                            elevation: 6,
                            shadowColor: Colors.grey.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: const BorderSide(
                                    width: 1.0, color: Color(0xFFB1ADBC))),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              obscureText: _showPwd2,
                              controller: _pwd2Ctrl,
                              style: const TextStyle(color: Colors.black),
                              onChanged: ((value) {
                                if (value == _pwd1Ctrl.text) {
                                  setState(() {
                                    isSame = true;
                                  });
                                } else {
                                  setState(() {
                                    isSame = false;
                                  });
                                }
                              }),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(24),
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(0.5)),
                                  filled: true,
                                  fillColor: const Color(0xFFB1ADBC),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: _pwd2Ctrl.text.isEmpty ||
                                                _pwd2Ctrl.text == ''
                                            ? Colors.grey
                                            : !isSame
                                                ? Colors.red
                                                : Colors.grey,
                                        width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: _pwd2Ctrl.text.isEmpty ||
                                                _pwd2Ctrl.text == ''
                                            ? Colors.grey
                                            : !isSame
                                                ? Colors.red
                                                : Colors.grey,
                                        width: 2),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  )),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            top: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPwd2 = !_showPwd2;
                                });
                              },
                              child: Icon(
                                _showPwd2
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.black38,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Your password must :',
                            style: TextStyle(
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ),
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('  1. Be at least 8 characters',
                            style: TextStyle(
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      ),
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            '  2. Include at least one uppercase letter',
                            style: TextStyle(
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      ),
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('  3. Include at least one number',
                            style: TextStyle(
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      ),
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('  4. Include at least one symbol',
                            style: TextStyle(
                                fontFamily: GoogleFonts.raleway().fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                BlocListener(
                    bloc: changePasswordBloc,
                    listener: (_, ChangePasswordState state) {
                      if (state is ChangePasswordLoading) {
                        setState(() {
                          isLoading = true;
                        });
                      }
                      if (state is ChangePasswordLoaded) {
                        GeneralUtil().showSnackBarSuccess(
                            context, 'Change Password Successfully');
                        Future.delayed(const Duration(milliseconds: 500), () {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              StringRouterUtil.loginScreenRoute,
                              (route) => false);
                        });
                      }
                      if (state is ChangePasswordError) {
                        GeneralUtil().showSnackBarError(context, state.error!);
                        setState(() {
                          isLoading = false;
                        });
                      }
                      if (state is ChangePasswordException) {
                        GeneralUtil().showSnackBarError(context, state.error);
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: BlocBuilder(
                        bloc: changePasswordBloc,
                        builder: (_, ChangePasswordState state) {
                          return isLoading
                              ? const Center(
                                  child: SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : InkWell(
                                  onTap: isCorrect && isSame
                                      ? () {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();

                                          changePasswordBloc.add(
                                              ChangePasswordAttempt(
                                                  changePasswordRequestModel:
                                                      ChangePasswordRequestModel(
                                                          confirmPassword:
                                                              _pwd2Ctrl.text,
                                                          password:
                                                              _pwd1Ctrl.text,
                                                          username:
                                                              widget.email)));
                                        }
                                      : null,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height: 66,
                                    decoration: BoxDecoration(
                                      color: isCorrect && isSame
                                          ? const Color(0xFFE45A04)
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text('Confirm',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// 
