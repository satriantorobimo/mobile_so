import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/dashboard/bloc/news_bloc/bloc.dart';
import 'package:mobile_so/features/dashboard/domain/repo/dashboard_repo.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:provider/provider.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  NewsBloc newsBloc = NewsBloc(dashboardRepo: DashboardRepo());

  @override
  void initState() {
    newsBloc.add(NewsListAttempt());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('News',
                style: TextStyle(
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: GeneralUtil.fontSize(context) * 1,
                    color: Colors.white)),
          ),
          BlocListener(
              bloc: newsBloc,
              listener: (_, NewsState state) {
                if (state is NewsLoading) {}
                if (state is NewsLoaded) {}
                if (state is NewsError) {
                  GeneralUtil().showSnackBarError(context, state.error!);
                }
                if (state is NewsException) {
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
                  bloc: newsBloc,
                  builder: (context, state) {
                    if (state is NewsLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is NewsLoaded) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return buildRequestCard(
                                state.newsResponseModel.data![index].name!,
                                state.newsResponseModel.data![index]
                                    .description!);
                          },
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                            );
                          },
                          itemCount: state.newsResponseModel.data!.length,
                          padding: EdgeInsets.only(bottom: 200, top: 24),
                          shrinkWrap: true,
                        ),
                      );
                    }

                    return Container();
                  })),
        ],
      ),
    );
  }

  Widget buildRequestCard(String title, String content) {
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
            initiallyExpanded: false, // Make it expanded by default
            tilePadding: EdgeInsets.symmetric(
                horizontal: 16), // Adjust padding if needed
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            title: Text(title,
                style: TextStyle(
                    fontSize: GeneralUtil.fontSize(context) * 0.45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            iconColor: Colors.white,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Text(content,
                    style: TextStyle(
                        fontSize: GeneralUtil.fontSize(context) * 0.35,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ),
            ]),
      ),
    );
  }
}
