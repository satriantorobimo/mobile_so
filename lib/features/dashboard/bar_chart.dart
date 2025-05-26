import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/dashboard/bloc/bar_bloc/bloc.dart';
import 'package:mobile_so/features/dashboard/domain/repo/dashboard_repo.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:provider/provider.dart';

class BarsChart extends StatefulWidget {
  const BarsChart({super.key});

  @override
  State<BarsChart> createState() => _BarsChartState();
}

class _BarsChartState extends State<BarsChart> {
  BarBloc barBloc = BarBloc(dashboardRepo: DashboardRepo());
  @override
  void initState() {
    barBloc.add(BarListAttempt());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: barBloc,
        listener: (_, BarState state) {
          if (state is BarLoading) {}
          if (state is BarLoaded) {}
          if (state is BarError) {
            GeneralUtil().showSnackBarError(context, state.error!);
          }
          if (state is BarException) {
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
            bloc: barBloc,
            builder: (context, state) {
              if (state is BarLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is BarLoaded) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // number of items in each row
                    crossAxisSpacing: 8, // Spacing between columns
                    mainAxisSpacing: 8, // Spacing between rows
                    childAspectRatio: 1.5, // Aspect ratio (width/height)
                  ),
                  padding: const EdgeInsets.all(8.0), // padding around the grid
                  itemCount: state.barChartResponseModel.data!
                      .length, // total number of items
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFE6E7E8),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 3,
                              offset: const Offset(-6, 4), // Shadow position
                            ),
                          ],
                          border: Border.all(
                              color: const Color(0xFFC2C2C2).withOpacity(0.2))),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: Text(
                                  state
                                      .barChartResponseModel.data![index].total!
                                      .toString(),
                                  style: TextStyle(
                                      fontSize:
                                          GeneralUtil.fontSize(context) * 0.5,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                  color: const Color(0xFF130139),
                                ),
                                child: Center(
                                  child: Text(
                                      state.barChartResponseModel.data![index]
                                          .description!,
                                      style: TextStyle(
                                          fontSize:
                                              GeneralUtil.fontSize(context) *
                                                  0.21,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ))
                        ],
                      ),
                    );
                  },
                );
              }

              return Container();
            }));
  }
}
