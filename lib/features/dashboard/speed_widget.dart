import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/dashboard/bloc/speed_bloc/bloc.dart';
import 'package:mobile_so/features/dashboard/domain/repo/dashboard_repo.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:provider/provider.dart';

class SpeedWidget extends StatefulWidget {
  const SpeedWidget({super.key});

  @override
  State<SpeedWidget> createState() => _SpeedWidgetState();
}

class _SpeedWidgetState extends State<SpeedWidget> {
  SpeedBloc speedBloc = SpeedBloc(dashboardRepo: DashboardRepo());

  @override
  void initState() {
    speedBloc.add(SpeedListAttempt());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: speedBloc,
        listener: (_, SpeedState state) {
          if (state is SpeedLoading) {}
          if (state is SpeedLoaded) {}
          if (state is SpeedError) {
            GeneralUtil().showSnackBarError(context, state.error!);
          }
          if (state is SpeedException) {
            if (state.error.toLowerCase() == 'unauthorized access') {
              GeneralUtil().showSnackBarError(context, 'Session Expired');
              var bottomBarProvider =
                  Provider.of<NavbarProvider>(context, listen: false);
              bottomBarProvider.setPage(0);
              bottomBarProvider.setTab(0);
              SharedPrefUtil.clearSharedPref();
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushNamedAndRemoveUntil(context,
                    StringRouterUtil.loginScreenRoute, (route) => false);
              });
            } else {
              GeneralUtil().showSnackBarError(context, state.error);
            }
          }
        },
        child: BlocBuilder(
            bloc: speedBloc,
            builder: (context, state) {
              if (state is SpeedLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is SpeedLoaded) {
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16.0, left: 24.0, right: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Opname\nSpeed',
                              style: TextStyle(
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: GeneralUtil.fontSize(context) * 1,
                                  color: const Color(0xFFFF9561))),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                  state.speedResponseModel.data![0]
                                      .jumlahAssetPerHari!
                                      .toString(),
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          GeneralUtil.fontSize(context) * 0.5,
                                      color: const Color(0xFFFF9561))),
                              const SizedBox(width: 16),
                              Text('ASSET / DAY',
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          GeneralUtil.fontSize(context) * 0.5,
                                      color: const Color(0xFFFF9561))),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                              state.speedResponseModel.data![0]
                                  .opnameSpeedTypeName!,
                              style: TextStyle(
                                  fontFamily:
                                      GoogleFonts.squadaOne().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: GeneralUtil.fontSize(context) * 0.7,
                                  color: const Color(0xFFBFBFBF))),
                          imageContent(
                              state.speedResponseModel.data![0].base64!)
                        ],
                      )
                    ],
                  ),
                );
              }

              return Container();
            }));
  }

  Widget imageContent(String value) {
    try {
      Uint8List bytes = base64Decode(value);
      return Center(
          child: Image.memory(
        bytes,
        width: 85,
      ));
    } catch (e) {
      return const Text("Failed to load image");
    }
  }
}
