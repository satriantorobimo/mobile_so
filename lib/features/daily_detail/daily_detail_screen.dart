import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/asset_opname_list/domain/repo/asset_opname_list_repo.dart';
import 'package:mobile_so/features/daily_detail/data/argument_daily_detail_model.dart';
import 'package:mobile_so/features/dashboard/bar_chart_detail.dart';
import 'package:mobile_so/features/dashboard/pie_chart.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:provider/provider.dart';

import '../asset_opname_list/bloc/asset_opname_list_bloc/bloc.dart';

class DailyDetailScreen extends StatefulWidget {
  const DailyDetailScreen({super.key, required this.argumentDailyDetailModel});
  final ArgumentDailyDetailModel argumentDailyDetailModel;

  @override
  State<DailyDetailScreen> createState() => _DailyDetailScreenState();
}

class _DailyDetailScreenState extends State<DailyDetailScreen> {
  String name = '';
  String uid = '';
  String company = '';
  AssetOpnameListBloc assetOpnameListBloc =
      AssetOpnameListBloc(assetOpnameListRepo: AssetOpnameListRepo());

  @override
  void initState() {
    getUserData();
    assetOpnameListBloc
        .add(AssetOpnameScheduletAttempt(widget.argumentDailyDetailModel.code));
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.06,
                left: 16.0,
                right: 16.0),
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
                Text('Daily Detail',
                    style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 20,
                        color: Colors.white)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 65,
                  width: 65,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: GeneralUtil.fontSize(context) * 0.3,
                            color: Colors.white)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(uid,
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: GeneralUtil.fontSize(context) * 0.3,
                                color: Colors.white)),
                        Text(company,
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: GeneralUtil.fontSize(context) * 0.3,
                                color: Colors.white)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                              size: MediaQuery.of(context).size.height * 0.015,
                            ),
                            const SizedBox(width: 4),
                            Text('Active',
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        GeneralUtil.fontSize(context) * 0.3,
                                    color: Colors.white)),
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: ListView(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.only(top: 32.0, left: 24.0, right: 24.0),
                  children: [
                BlocListener(
                    bloc: assetOpnameListBloc,
                    listener: (_, AssetOpnameListState state) {
                      if (state is AssetOpnameListLoading) {}
                      if (state is AssetOpnameListLoaded) {}
                      if (state is AssetOpnameListError) {
                        GeneralUtil().showSnackBarError(context, state.error!);
                      }
                      if (state is AssetOpnameListException) {
                        if (state.error.toLowerCase() ==
                            'unauthorized access') {
                          GeneralUtil()
                              .showSnackBarError(context, 'Session Expired');
                          var bottomBarProvider = Provider.of<NavbarProvider>(
                              context,
                              listen: false);
                          bottomBarProvider.setPage(0);
                          bottomBarProvider.setTab(0);
                          SharedPrefUtil.clearSharedPref();
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                StringRouterUtil.loginScreenRoute,
                                (route) => false);
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
                            return Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xFF122E69),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 32.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Dashboard - ${GeneralUtil.dateConverDailyDetail(widget.argumentDailyDetailModel.date)}',
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 115,
                                            child: Text('Opname No',
                                                style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.poppins()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.white)),
                                          ),
                                          Text(
                                              ': ${widget.argumentDailyDetailModel.code}',
                                              style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.poppins()
                                                          .fontFamily,
                                                  fontSize: 12,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 115,
                                            child: Text('Opname Location',
                                                style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.poppins()
                                                            .fontFamily,
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                          ),
                                          Text(
                                              ': ${state.assetOpnameScheduleResponseModel.data![0].locationName == '' ? '-' : state.assetOpnameScheduleResponseModel.data![0].locationName}',
                                              style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.poppins()
                                                          .fontFamily,
                                                  fontSize: 12,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 115,
                                            child: Text('Status',
                                                style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.poppins()
                                                            .fontFamily,
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                          ),
                                          Text(
                                              ': ${state.assetOpnameScheduleResponseModel.data![0].status}',
                                              style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.poppins()
                                                          .fontFamily,
                                                  fontSize: 12,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 115,
                                            child: Text('Total',
                                                style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.poppins()
                                                            .fontFamily,
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                          ),
                                          Text(
                                              ': ${state.assetOpnameScheduleResponseModel.data![0].totalAsset}',
                                              style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.poppins()
                                                          .fontFamily,
                                                  fontSize: 12,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container();
                        })),
                const SizedBox(height: 24),
                BarsChartDetail(
                  code: widget.argumentDailyDetailModel.code,
                  date: widget.argumentDailyDetailModel.date,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: PieChart(
                    code: widget.argumentDailyDetailModel.code,
                    date: widget.argumentDailyDetailModel.date,
                  ),
                ),
                const SizedBox(height: 40),
              ]))
        ],
      ),
    );
  }
}
