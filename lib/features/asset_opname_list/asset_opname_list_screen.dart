import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/asset_opname_list/bloc/asset_opname_list_bloc/bloc.dart';
import 'package:mobile_so/features/asset_opname_list/domain/repo/asset_opname_list_repo.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:provider/provider.dart';

class AssetOpnameListScreen extends StatefulWidget {
  const AssetOpnameListScreen({super.key});

  @override
  State<AssetOpnameListScreen> createState() => _AssetOpnameListScreenState();
}

class _AssetOpnameListScreenState extends State<AssetOpnameListScreen> {
  String name = '';
  String uid = '';
  String company = '';
  AssetOpnameListBloc assetOpnameListBloc =
      AssetOpnameListBloc(assetOpnameListRepo: AssetOpnameListRepo());

  @override
  void initState() {
    getUserData();
    assetOpnameListBloc.add(const AssetOpnameListAttempt());
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
      backgroundColor: Color(0xFF130139),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.06,
                left: 16.0,
                right: 16.0),
            child: AutoSizeText('Asset Opname List',
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 20,
                    color: Colors.white)),
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
                    if (state is AssetOpnameListLoaded) {
                      return state.assetOpnameListResponseModel.data!.isNotEmpty
                          ? ListView.separated(
                              itemBuilder: (context, index) {
                                return Theme(
                                  data: ThemeData(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          StringRouterUtil
                                              .assetOpnameListDetailScreenRoute,
                                          arguments: state
                                              .assetOpnameListResponseModel
                                              .data![index]
                                              .code);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: state
                                                            .assetOpnameListResponseModel
                                                            .data![index]
                                                            .percentageOpname <=
                                                        50.0
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                              alignment: Alignment.center,
                                              child: AutoSizeText(
                                                  '${state.assetOpnameListResponseModel.data![index].percentageOpname}%',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.poppins()
                                                              .fontFamily,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors.white)),
                                            ),
                                            SizedBox(width: 16),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                      child: AutoSizeText(
                                                          'Opname No',
                                                          style: TextStyle(
                                                              fontFamily: GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                    AutoSizeText(
                                                        ': ${state.assetOpnameListResponseModel.data![index].code}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .poppins()
                                                                    .fontFamily,
                                                            fontSize: 11,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                      child: AutoSizeText(
                                                          'Periode Opname ',
                                                          style: TextStyle(
                                                              fontFamily: GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily,
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AutoSizeText(
                                                            ': ${GeneralUtil.dateConvertList(state.assetOpnameListResponseModel.data![index].opnameStartDate!)} to',
                                                            style: TextStyle(
                                                                fontFamily: GoogleFonts
                                                                        .poppins()
                                                                    .fontFamily,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white)),
                                                        AutoSizeText(
                                                            '  ${GeneralUtil.dateConvertList(state.assetOpnameListResponseModel.data![index].opnameEndDate!)}',
                                                            style: TextStyle(
                                                                fontFamily: GoogleFonts
                                                                        .poppins()
                                                                    .fontFamily,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                      child: AutoSizeText(
                                                          'Total Asset Opname',
                                                          style: TextStyle(
                                                              fontFamily: GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily,
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                    AutoSizeText(
                                                        ': ${state.assetOpnameListResponseModel.data![index].totalAsset!}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .poppins()
                                                                    .fontFamily,
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: Color(0xFF3B3B3B),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
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
                              },
                              separatorBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 40, bottom: 40),
                                  child: Container(
                                    width: double.infinity,
                                    height: 1.5,
                                    color: Color(0xFFFF7122),
                                  ),
                                );
                              },
                              itemCount: state
                                  .assetOpnameListResponseModel.data!.length,
                              padding: const EdgeInsets.only(
                                  top: 60.0, left: 24.0, right: 24.0),
                              shrinkWrap: true)
                          : Container();
                    }
                    return Container();
                  })),
        ],
      ),
    );
  }
}
