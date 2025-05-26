import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/otp/data/otp_validate_request_model.dart';
import 'package:mobile_so/features/otp_login/bloc/resend_bloc/bloc.dart';
import 'package:mobile_so/features/otp_login/bloc/validate_bloc/bloc.dart';
import 'package:mobile_so/features/otp_login/domain/repo/otp_repo.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:pinput/pinput.dart';

class OtpLoginScreen extends StatefulWidget {
  final String email;
  const OtpLoginScreen({super.key, required this.email});

  @override
  State<OtpLoginScreen> createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpLoginScreen> {
  final _pinPutController = TextEditingController();
  ValidateOtpBloc validateOtpBloc = ValidateOtpBloc(otpRepo: OtpRepo());
  ResendOtpBloc resendOtpBloc = ResendOtpBloc(otpRepo: OtpRepo());
  bool enable = false;
  bool isLoading = false;

  final defaultPinTheme = PinTheme(
    width: 78,
    height: 78,
    textStyle: const TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.white),
  );
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
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.07),
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
                              fontSize: GeneralUtil.fontSize(context) * 0.6,
                              color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                const Icon(
                  Icons.email_rounded,
                  color: Colors.white,
                  size: 48,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text('We Have Send Code Number To Your Email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GoogleFonts.raleway().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.7,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(widget.email,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.45,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'ENTER YOUR OTP',
                    style: TextStyle(
                      fontSize: GeneralUtil.fontSize(context) * 0.5,
                      color: Colors.white,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    defaultPinTheme: defaultPinTheme,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: _pinPutController,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (String verificationCode) {},
                    onChanged: (code) {
                      if (code.length == 4) {
                        setState(() {
                          enable = true;
                        });
                      } else {
                        setState(() {
                          enable = false;
                        });
                      }
                    },
                    separatorBuilder: (index) => const SizedBox(width: 8),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Haven`t receive email?',
                        style: TextStyle(
                          fontSize: GeneralUtil.fontSize(context) * 0.32,
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      BlocListener(
                          bloc: resendOtpBloc,
                          listener: (_, ResendOtpState state) {
                            if (state is ResendOtpLoading) {}
                            if (state is ResendOtpLoaded) {
                              GeneralUtil().showSnackBarSuccess(
                                  context, 'OTP Sent Successfully');
                            }
                            if (state is ResendOtpError) {
                              GeneralUtil()
                                  .showSnackBarError(context, state.error!);
                              if (state.error!.toLowerCase().contains(
                                  'please contact your it department for unlock')) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    StringRouterUtil.loginScreenRoute,
                                    (route) => false);
                              }
                            }
                            if (state is ResendOtpException) {
                              GeneralUtil()
                                  .showSnackBarError(context, state.error);
                              if (state.error.toLowerCase().contains(
                                  'please contact your it department for unlock')) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    StringRouterUtil.loginScreenRoute,
                                    (route) => false);
                              }
                            }
                          },
                          child: BlocBuilder(
                              bloc: resendOtpBloc,
                              builder: (_, ResendOtpState state) {
                                return InkWell(
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    resendOtpBloc.add(ResendOtpAttempt(
                                        userName: widget.email));
                                  },
                                  child: Text(
                                    'Send Email Again',
                                    style: TextStyle(
                                      fontSize:
                                          GeneralUtil.fontSize(context) * 0.32,
                                      color: Colors.white,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                  ),
                                );
                              })),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                BlocListener(
                    bloc: validateOtpBloc,
                    listener: (_, ValidateOtpState state) {
                      if (state is ValidateOtpLoading) {
                        setState(() {
                          isLoading = true;
                        });
                      }
                      if (state is ValidateOtpLoaded) {
                        SharedPrefUtil.saveSharedString(
                            'token', state.loginResponseModel.token!);
                        SharedPrefUtil.saveSharedString('name',
                            state.loginResponseModel.datalist![0].name!);
                        SharedPrefUtil.saveSharedString(
                            'uid', state.loginResponseModel.datalist![0].uid!);
                        SharedPrefUtil.saveSharedString('company',
                            state.loginResponseModel.datalist![0].companyCode!);
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            StringRouterUtil.navbarScreenRoute,
                            (route) => false);
                      }
                      if (state is ValidateOtpError) {
                        GeneralUtil().showSnackBarError(context, state.error!);
                        setState(() {
                          isLoading = false;
                        });
                        if (state.error!.toLowerCase().contains(
                                'please contact your it department for unlock') ||
                            state.error!
                                .toLowerCase()
                                .contains('tried maximum attempt')) {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              StringRouterUtil.loginScreenRoute,
                              (route) => false);
                        }
                      }
                      if (state is ValidateOtpException) {
                        GeneralUtil().showSnackBarError(context, state.error);
                        setState(() {
                          isLoading = false;
                        });
                        if (state.error.toLowerCase().contains(
                                'please contact your it department for unlock') ||
                            state.error
                                .toLowerCase()
                                .contains('tried maximum attempt')) {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              StringRouterUtil.loginScreenRoute,
                              (route) => false);
                        }
                      }
                    },
                    child: BlocBuilder(
                        bloc: validateOtpBloc,
                        builder: (_, ValidateOtpState state) {
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
                                          validateOtpBloc
                                              .add(ValidateOtpAttempt(
                                            otpValidateRequestModel:
                                                OtpValidateRequestModel(
                                                    username: widget.email,
                                                    otp:
                                                        _pinPutController.text),
                                          ));
                                        }
                                      : null,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height: MediaQuery.of(context).size.height *
                                        0.09,
                                    decoration: BoxDecoration(
                                      color: enable
                                          ? const Color(0xFFE45A04)
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    child: Center(
                                        child: Text('Submit',
                                            style: TextStyle(
                                                fontSize: GeneralUtil.fontSize(
                                                        context) *
                                                    0.5,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600))),
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
