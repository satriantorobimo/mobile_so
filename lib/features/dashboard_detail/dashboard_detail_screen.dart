import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/asset_opname_detail/data/asset_grow_request_model.dart';
import 'package:mobile_so/features/asset_opname_detail/domain/repo/asset_grow_repo.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/arguments_view_model.dart';
import 'package:mobile_so/features/asset_opname_list/domain/repo/asset_opname_list_repo.dart';
import 'package:mobile_so/features/dashboard_detail/card_widget.dart';
import 'package:mobile_so/features/dashboard_detail/data/argument_dashboard_detail_model.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:provider/provider.dart';
import 'package:mobile_so/features/asset_opname_list/data/asset_opname_list_detail_response_model.dart';
import 'package:table_calendar/table_calendar.dart';
import '../asset_opname_detail/bloc/asset_grow_bloc/bloc.dart';
import '../asset_opname_list/bloc/asset_opname_list_bloc/bloc.dart';

class DashboardDetailScreen extends StatefulWidget {
  const DashboardDetailScreen(
      {super.key, required this.argumentDashboardDetailModel});
  final ArgumentDashboardDetailModel argumentDashboardDetailModel;

  @override
  State<DashboardDetailScreen> createState() => _DashboardDetailScreenState();
}

class _DashboardDetailScreenState extends State<DashboardDetailScreen> {
  String name = '';
  String uid = '';
  String company = '';
  AssetOpnameListBloc assetOpnameListBloc =
      AssetOpnameListBloc(assetOpnameListRepo: AssetOpnameListRepo());
  AssetGrowBloc assetGrowBloc = AssetGrowBloc(assetGrowRepo: AssetGrowRepo());

  @override
  void initState() {
    getUserData();
    assetOpnameListBloc.add(CalendarOpnameResulttAttempt(
        widget.argumentDashboardDetailModel.code,
        widget.argumentDashboardDetailModel.dateStart));
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, StringRouterUtil.assetOpnameScreenRoute);
        },
      ),
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
                Text('Asset Opname',
                    style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: GeneralUtil.fontSize(context) * 0.55,
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
                  height: MediaQuery.of(context).size.width * 0.13,
                  width: MediaQuery.of(context).size.width * 0.13,
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
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                              width: MediaQuery.of(context).size.height * 0.015,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
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
          CardWidget(
              argumentDashboardDetailModel:
                  widget.argumentDashboardDetailModel),
          BlocListener(
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
                    if (state is CalendarOpnameResultLoaded) {
                      final DateTime now = DateTime.now();
                      final List<Data> todayRequests = [];
                      final List<Data> yesterdayRequests = [];

                      for (var item
                          in state.assetOpnameListDetailResponseModel.data!) {
                        final requestDate = DateTime.parse(item.resultDate!);
                        if (isSameDay(requestDate, now)) {
                          todayRequests.add(item);
                        } else {
                          yesterdayRequests.add(item);
                        }
                      }
                      return Expanded(
                        child: ListView(
                          padding: const EdgeInsets.only(
                              left: 24.0, right: 24.0, top: 16),
                          shrinkWrap: true,
                          children: [
                            buildRequestCard("Today", todayRequests),
                            buildRequestCard("Yesterday", yesterdayRequests),
                            SizedBox(
                              height: 80,
                            )
                          ],
                        ),
                      );
                    }
                    return Container();
                  })),
          BlocListener(
              bloc: assetGrowBloc,
              listener: (_, AssetGrowState state) {
                if (state is AssetGrowLoading) {}
                if (state is AssetGrowLoaded) {
                  Navigator.pushNamed(context,
                      StringRouterUtil.assetOpnameDetailFormScreenRoute,
                      arguments: state.assetGrowResponseModel.data![0]);
                }
                if (state is AssetGrowError) {}
                if (state is AssetGrowException) {
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
                  bloc: assetGrowBloc,
                  builder: (_, AssetGrowState state) {
                    return Container();
                  })),
        ],
      ),
    );
  }

  Widget buildRequestCard(String title, List<Data> requests) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.white, width: 2),
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // Removes the divider line
        ),
        child: ExpansionTile(
          initiallyExpanded: true, // Make it expanded by default
          tilePadding:
              EdgeInsets.symmetric(horizontal: 16), // Adjust padding if needed
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: GeneralUtil.fontSize(context) * 0.45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              SizedBox(width: 8),
              Text(requests.length.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: GeneralUtil.fontSize(context) * 0.45,
                  )),
            ],
          ),
          iconColor: Colors.white,
          children: requests.map((request) {
            return GestureDetector(
              onTap: () {
                if (request.status == 'DONE') {
                  Navigator.pushNamed(context,
                      StringRouterUtil.assetOpnameDetailFormViewScreenRoute,
                      arguments: ArgumentsViewModel(
                          opnameCode: request.opnameCode!,
                          assetCode: request.assetCode!));
                } else {
                  assetGrowBloc.add(AssetGrowAttempt(
                      assetGrowRequestModel: AssetGrowRequestModel(
                          request.assetCode!, 'ASSET_CODE')));
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  children: [
                    request.status == 'DONE'
                        ? Image.asset(
                            'assets/icons/done.png',
                            width: 40,
                          )
                        : Image.asset(
                            'assets/icons/reserved.png',
                            width: 40,
                          ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${request.assetCode} - ${request.assetName}",
                              style: TextStyle(
                                  fontSize:
                                      GeneralUtil.fontSize(context) * 0.45,
                                  color: Colors.white)),
                          Text("Description: ${request.assetDescription}",
                              style: TextStyle(
                                  fontSize:
                                      GeneralUtil.fontSize(context) * 0.35,
                                  color: Colors.grey)),
                          Text("Location: ${request.assetLocation}",
                              style: TextStyle(
                                  fontSize:
                                      GeneralUtil.fontSize(context) * 0.35,
                                  color: Colors.grey)),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFF3B3B3B),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
