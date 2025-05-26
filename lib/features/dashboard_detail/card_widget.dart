import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/asset_opname_list/domain/repo/asset_opname_list_repo.dart';
import 'package:mobile_so/features/dashboard_detail/data/argument_dashboard_detail_model.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:provider/provider.dart';

import '../asset_opname_list/bloc/asset_opname_list_bloc/bloc.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key, required this.argumentDashboardDetailModel});
  final ArgumentDashboardDetailModel argumentDashboardDetailModel;
  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  AssetOpnameListBloc assetOpnameListBloc =
      AssetOpnameListBloc(assetOpnameListRepo: AssetOpnameListRepo());
  @override
  void initState() {
    assetOpnameListBloc.add(
        AssetOpnameScheduletAttempt(widget.argumentDashboardDetailModel.code));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: assetOpnameListBloc,
        listener: (_, AssetOpnameListState state) {
          if (state is AssetOpnameListLoading) {}
          if (state is AssetOpnameListLoaded) {}
          if (state is AssetOpnameListError) {
            GeneralUtil().showSnackBarError(context, state.error!);
          }
          if (state is AssetOpnameListException) {
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
            bloc: assetOpnameListBloc,
            builder: (context, AssetOpnameListState state) {
              if (state is AssetOpnameListLoading) {
                return const Center(
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is AssetOpnameShceduleLoaded) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 32.0, left: 24.0, right: 24.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF122E69),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                            'Dashboard - ${GeneralUtil.dateConverDailyDetail(widget.argumentDashboardDetailModel.date)}',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: GeneralUtil.fontSize(context) * 0.5,
                                color: const Color(0xFF00B7FF))),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          height: 2,
                          color: Color(0xFFEEEEEE).withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 50,
                              color: Colors.green,
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.32,
                                      child: Text('Opname No',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: GeneralUtil.fontSize(
                                                      context) *
                                                  0.35,
                                              color: Colors.white)),
                                    ),
                                    Text(
                                        ': ${widget.argumentDashboardDetailModel.code}',
                                        style: TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            fontSize:
                                                GeneralUtil.fontSize(context) *
                                                    0.35,
                                            color: Colors.white)),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.32,
                                      child: Text('Periode Opname',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              fontSize: GeneralUtil.fontSize(
                                                      context) *
                                                  0.35,
                                              color: Colors.white)),
                                    ),
                                    Text(
                                        ': ${GeneralUtil.dateConvertList(widget.argumentDashboardDetailModel.dateStart)} to\n  ${GeneralUtil.dateConvertList(widget.argumentDashboardDetailModel.dateEnd)}',
                                        style: TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            fontSize:
                                                GeneralUtil.fontSize(context) *
                                                    0.35,
                                            color: Colors.white)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.32,
                                      child: Text('Total Asset Opname',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              fontSize: GeneralUtil.fontSize(
                                                      context) *
                                                  0.35,
                                              color: Colors.white)),
                                    ),
                                    Text(
                                        ': ${state.assetOpnameScheduleResponseModel.data![0].totalAsset}',
                                        style: TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            fontSize:
                                                GeneralUtil.fontSize(context) *
                                                    0.35,
                                            color: Colors.white)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.32,
                                      child: Text('Status',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              fontSize: GeneralUtil.fontSize(
                                                      context) *
                                                  0.35,
                                              color: Colors.white)),
                                    ),
                                    Text(
                                        ': ${state.assetOpnameScheduleResponseModel.data![0].status}',
                                        style: TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            fontSize:
                                                GeneralUtil.fontSize(context) *
                                                    0.35,
                                            color: Colors.white)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            }));
  }
}
