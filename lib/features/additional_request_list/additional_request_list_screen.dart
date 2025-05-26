import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/argument_add_request.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/argument_view_add_request.dart';
import 'package:mobile_so/features/additional_request_list/bloc/additional_list_bloc/bloc.dart';
import 'package:mobile_so/features/additional_request_list/data/additional_request_list_response_model.dart'
    as add;
import 'package:mobile_so/features/additional_request_list/domain/repo/additional_request_list_repo.dart';
import 'package:mobile_so/features/asset_opname_detail/data/asset_grow_response_model.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:provider/provider.dart';

class AdditionalRequestListScreen extends StatefulWidget {
  const AdditionalRequestListScreen({super.key});

  @override
  State<AdditionalRequestListScreen> createState() =>
      _AdditionalRequestListScreenState();
}

class _AdditionalRequestListScreenState
    extends State<AdditionalRequestListScreen> {
  bool register = true;
  bool sell = false;
  bool disposal = false;
  bool maintanance = false;
  bool mutation = false;
  String name = '';
  String uid = '';
  String company = '';
  AdditionalListBloc additionalListBloc = AdditionalListBloc(
      additionalRequestListRepo: AdditionalRequestListRepo());

  @override
  void initState() {
    getUserData();
    additionalListBloc.add(const RegisterAttempt());
    super.initState();
  }

  void getUserData() async {
    await SharedPrefUtil.getSharedString('name').then((value) => name = value!);
    await SharedPrefUtil.getSharedString('uid').then((value) => uid = value!);
    await SharedPrefUtil.getSharedString('company')
        .then((value) => company = value!);
    setState(() {});
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, StringRouterUtil.addRequestScreenRoute,
              arguments: ArgumentAddReq(
                  disposal: disposal,
                  maintenance: maintanance,
                  other: false,
                  register: register,
                  sell: sell,
                  mutation: mutation,
                  assetGrowResponseModel: AssetGrowResponseModel()));
        },
      ),
      backgroundColor: Color(0xFF130139),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.06,
                left: 16.0,
                right: 16.0),
            child: Text('Additional Request List',
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
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                  top: 16.0, left: 24.0, right: 24.0, bottom: 8.0),
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      register = true;
                      sell = false;
                      disposal = false;
                      maintanance = false;
                      mutation = false;
                    });
                    additionalListBloc.add(const RegisterAttempt());
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: register
                            ? const Color(0xFF2C5A71)
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Text('Register',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: const Color(0xFFC0EDE8))),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      register = false;
                      sell = true;
                      disposal = false;
                      maintanance = false;
                      mutation = false;
                    });
                    additionalListBloc.add(const SellAttempt());
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color:
                            sell ? const Color(0xFF2C5A71) : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Text('Sell',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: const Color(0xFFC0EDE8))),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      register = false;
                      sell = false;
                      disposal = true;
                      maintanance = false;
                      mutation = false;
                    });
                    additionalListBloc.add(const DisposalAttempt());
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: disposal
                            ? const Color(0xFF2C5A71)
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Text('Disposal',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: const Color(0xFFC0EDE8))),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      register = false;
                      sell = false;
                      disposal = false;
                      maintanance = true;
                      mutation = false;
                    });
                    additionalListBloc.add(const MaintenanceAttempt());
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: maintanance
                            ? const Color(0xFF2C5A71)
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Text('Maintenance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: const Color(0xFFC0EDE8))),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      register = false;
                      sell = false;
                      disposal = false;
                      maintanance = false;
                      mutation = true;
                    });
                    additionalListBloc.add(const MutationAttempt());
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: mutation
                            ? const Color(0xFF2C5A71)
                            : Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Text('Mutation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: const Color(0xFFC0EDE8))),
                  ),
                ),
              ],
            ),
          ),
          BlocListener(
              bloc: additionalListBloc,
              listener: (_, AdditionalListState state) {
                if (state is AdditionalListLoading) {}
                if (state is AdditionalListLoaded) {}
                if (state is AdditionalListError) {
                  GeneralUtil().showSnackBarError(context, state.error!);
                }
                if (state is AdditionalListException) {
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
                  bloc: additionalListBloc,
                  builder: (_, AdditionalListState state) {
                    if (state is AdditionalListLoading) {
                      return const Center(
                        child: SizedBox(
                          width: 45,
                          height: 45,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is AdditionalListLoaded) {
                      // Parse and group data into "Today" and "Yesterday"
                      final DateTime now = DateTime.now();
                      final List<add.Data> todayRequests = [];
                      final List<add.Data> yesterdayRequests = [];

                      for (var item
                          in state.additionalRequestListResponseModel.data!) {
                        final requestDate = DateTime.parse(item.requestDate!);
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
                    if (state is AdditionalListError) {
                      return Container();
                    }
                    if (state is AdditionalListException) {
                      return Container();
                    }
                    return Container();
                  })),
        ],
      ),
    );
  }

  Widget buildRequestCard(String title, List<add.Data> requests) {
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
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          iconColor: Colors.white,
          children: requests.map((request) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context,
                    StringRouterUtil.addRequesteDetailFormViewScreenRoute,
                    arguments: ArgumentViewAddReq(
                        register: register,
                        sell: sell,
                        disposal: disposal,
                        maintenance: maintanance,
                        other: false,
                        data: request));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    Icon(Icons.description, size: 30, color: Colors.green),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Request No :  ${request.requestCode}",
                              style: TextStyle(
                                  fontSize: GeneralUtil.fontSize(context) * 0.4,
                                  color: Colors.white)),
                          Text(
                              "Item Name: ${request.requestType!.toLowerCase() == 'register' ? request.itemName : request.assetName}",
                              style: TextStyle(
                                  fontSize:
                                      GeneralUtil.fontSize(context) * 0.35,
                                  color: Colors.grey)),
                          Text("Request Type: ${request.requestType}",
                              style: TextStyle(
                                  fontSize:
                                      GeneralUtil.fontSize(context) * 0.35,
                                  color: Colors.grey)),
                          Text("Request Status: ${request.status}",
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
