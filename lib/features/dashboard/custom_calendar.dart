import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/dashboard/bloc/calendar_bloc/bloc.dart';
import 'package:mobile_so/features/dashboard/data/calendar_list_response_model.dart';
import 'package:mobile_so/features/dashboard/domain/repo/dashboard_repo.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarBloc calendarBloc = CalendarBloc(dashboardRepo: DashboardRepo());
  List<Results> results = [];
  List<Results> resultsTemp = [];
  bool firstCome = true;

  @override
  void initState() {
    calendarBloc.add(CalendarListAttempt(month: 1, year: 2025));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocListener(
            bloc: calendarBloc,
            listener: (_, CalendarState state) {
              if (state is CalendarLoading) {}
              if (state is CalendarLoaded) {
                String timeNow = firstCome
                    ? GeneralUtil.dateConvertNow(DateTime.now().toString())
                    : GeneralUtil.dateConvertCalendar(_focusedDay.toString());
                setState(() {
                  resultsTemp.addAll(state.calendarListResponseModel.results!);
                  results = resultsTemp
                      .where((item) =>
                          GeneralUtil.dateConvert(item.date!).contains(timeNow))
                      .toList();
                });
              }
              if (state is CalendarError) {
                GeneralUtil().showSnackBarError(context, state.error!);
              }
              if (state is CalendarException) {
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
                bloc: calendarBloc,
                builder: (context, state) {
                  if (state is CalendarLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is CalendarLoaded) {
                    final events = parseEvents(state.calendarListResponseModel);

                    return Container(
                      color: Colors.white,
                      child: TableCalendar(
                        firstDay: DateTime.utc(2024, 1, 1),
                        lastDay: DateTime.utc(2025, 12, 31),
                        rowHeight:
                            (MediaQuery.of(context).size.height - 100) / 14,
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        eventLoader: (day) {
                          // Normalize the date by removing time components
                          final normalizedDay =
                              DateTime(day.year, day.month, day.day);
                          return events[normalizedDay] ?? [];
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;

                            setState(() {
                              results = resultsTemp
                                  .where((item) =>
                                      GeneralUtil.dateConvert(item.date!)
                                          .contains(
                                              GeneralUtil.dateConvertCalendar(
                                                  _selectedDay.toString())))
                                  .toList();
                            }); // update focusedDay to maintain the view
                          });
                        },
                        onPageChanged: (focusedDay) {
                          setState(() {
                            results = [];
                            resultsTemp = [];
                            _focusedDay =
                                focusedDay; // Update the focused month
                            firstCome = false;
                          });

                          calendarBloc.add(CalendarListAttempt(
                              month: focusedDay.month, year: focusedDay.year));
                        },
                        calendarStyle: CalendarStyle(
                          cellMargin: EdgeInsets.zero,
                          cellPadding: EdgeInsets.zero,
                          defaultTextStyle: TextStyle(color: Colors.black),
                          weekendTextStyle: TextStyle(color: Colors.red),
                          todayDecoration: BoxDecoration(
                            color: Colors.orange,
                          ),
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible:
                              false, // Hides "2 weeks" or format toggle button
                          titleCentered: true, // Centers the title
                          decoration: BoxDecoration(
                            color: Colors.orange, // Header background color
                          ),
                          titleTextStyle: TextStyle(
                            color: Colors.white, // Title text color
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                          leftChevronIcon: Icon(
                            Icons.chevron_left,
                            color: Colors.white, // Chevron color
                          ),
                          rightChevronIcon: Icon(
                            Icons.chevron_right,
                            color: Colors.white, // Chevron color
                          ),
                        ),
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, day, events) {
                            // Override default markers and prevent rendering them
                            return SizedBox.shrink();
                          },
                          defaultBuilder: (context, day, focusedDay) {
                            final normalizedDay =
                                DateTime(day.year, day.month, day.day);
                            final dayEvents = events[normalizedDay] ?? [];
                            final hasEvents = dayEvents.isNotEmpty;

                            return Container(
                                margin: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  color: hasEvents
                                      ? Colors.orange[100]
                                      : Colors.transparent,
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (hasEvents)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                          dayEvents.length > 4
                                              ? 4
                                              : dayEvents.length, // Max 4 dots
                                          (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 1.0),
                                            child: Icon(
                                              Icons.circle,
                                              size: 6.0,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                    const SizedBox(
                                        height:
                                            1.0), // Space between dot and number
                                    Text(
                                      '${day.day}', // Day number
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ));
                          },
                          todayBuilder: (context, day, focusedDay) {
                            final normalizedDay =
                                DateTime(day.year, day.month, day.day);
                            final dayEvents = events[normalizedDay] ?? [];
                            final hasEvents = dayEvents.isNotEmpty;
                            return Container(
                                margin: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (hasEvents)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                          dayEvents.length > 4
                                              ? 4
                                              : dayEvents.length, // Max 4 dots
                                          (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 1.0),
                                            child: Icon(
                                              Icons.circle,
                                              size: 6.0,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                    const SizedBox(height: 1.0),
                                    Text(
                                      '${day.day}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ));
                          },
                          selectedBuilder: (context, day, focusedDay) {
                            final normalizedDay =
                                DateTime(day.year, day.month, day.day);
                            final dayEvents = events[normalizedDay] ?? [];
                            final hasEvents = dayEvents.isNotEmpty;
                            return Container(
                                margin: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (hasEvents)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                          dayEvents.length > 4
                                              ? 4
                                              : dayEvents.length, // Max 4 dots
                                          (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 1.0),
                                            child: Icon(
                                              Icons.circle,
                                              size: 6.0,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                    const SizedBox(height: 1.0),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Text(
                                        '${day.day}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          },
                        ),
                      ),
                    );
                  }

                  return Container();
                })),
        results.isEmpty
            ? Container()
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFF122E69),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 45,
                                color: results[0].data![index].status == 'CLOSE'
                                    ? Colors.red
                                    : results[0].data![index].status == 'CANCEL'
                                        ? Colors.orange
                                        : Colors.green,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.27,
                                        child: AutoSizeText('Opname No',
                                            style: TextStyle(
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.white)),
                                      ),
                                      Text(': ${results[0].data![index].code}',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.27,
                                        child: Text('Periode Opname',
                                            style: TextStyle(
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily,
                                                fontSize: 12,
                                                color: Colors.white)),
                                      ),
                                      Text(': 12 to 26 May 2024',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.27,
                                        child: Text('Total Asset Opname',
                                            style: TextStyle(
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily,
                                                fontSize: 12,
                                                color: Colors.white)),
                                      ),
                                      Text(
                                          ': ${results[0].data![index].totalAsset}',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context,
                                      StringRouterUtil
                                          .dashboardDetailScreenRoute);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFE45A04),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  padding: EdgeInsets.all(5),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 6),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      StringRouterUtil.dailyDetailScreenRoute);
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/dashboard.svg',
                                  color: Colors.white,
                                  height: 28,
                                  width: 28,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16);
                  },
                  itemCount: results[0].data!.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      left: 24.0, right: 24.0, top: 24, bottom: 150.0),
                ),
              )
      ],
    );
  }

  Map<DateTime, List<Data>> parseEvents(CalendarListResponseModel response) {
    return {
      for (var result in response.results!)
        if (result.date != null)
          DateTime.parse(result.date!).toLocal().copyWith(
                hour: 0,
                minute: 0,
                second: 0,
                millisecond: 0,
                microsecond: 0,
              ): result.data!,
    };
  }
}
