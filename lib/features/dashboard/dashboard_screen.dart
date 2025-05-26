import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/dashboard/bar_chart.dart';
import 'package:mobile_so/features/dashboard/class_status.dart';
import 'package:mobile_so/features/dashboard/custom_calendar.dart';
import 'package:mobile_so/features/dashboard/line_chart.dart';
import 'package:mobile_so/features/dashboard/news_widget.dart';
import 'package:mobile_so/features/dashboard/speed_widget.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool myDay = true;
  bool calendar = false;
  bool news = false;
  String name = '';
  String uid = '';
  String company = '';

  @override
  void initState() {
    getUserData();

    super.initState();
  }

  void getUserData() async {
    await SharedPrefUtil.getSharedString('name').then((value) => name = value!);
    await SharedPrefUtil.getSharedString('uid').then((value) => uid = value!);
    await SharedPrefUtil.getSharedString('company')
        .then((value) => company = value!);
    setState(() {});
  }

  // final EventList<Event> _markedDateMap = EventList<Event>(
  //   events: {
  //     DateTime(2024, 5, 10): [
  //       Event(
  //         date: DateTime(2024, 5, 10),
  //         title: 'Event 1',
  //         icon: const Icon(Icons.circle),
  //         dot: Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 1.0),
  //           color: Colors.red,
  //           height: 4.0,
  //           width: 4.0,
  //         ),
  //       ),
  //       Event(
  //         date: DateTime(2024, 5, 10),
  //         title: 'Event 2',
  //         icon: const Icon(Icons.circle),
  //         dot: Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 1.0),
  //           color: Colors.green,
  //           height: 4.0,
  //           width: 4.0,
  //         ),
  //       ),
  //       Event(
  //         date: DateTime(2024, 5, 10),
  //         title: 'Event 3',
  //         icon: const Icon(Icons.circle),
  //         dot: Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 1.0),
  //           color: Colors.red,
  //           height: 4.0,
  //           width: 4.0,
  //         ),
  //       ),
  //     ],
  //     DateTime(2024, 5, 9): [
  //       Event(
  //         date: DateTime(2024, 5, 9),
  //         title: 'Event 1',
  //         icon: const Icon(Icons.circle),
  //         dot: Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 1.0),
  //           color: Colors.green,
  //           height: 4.0,
  //           width: 4.0,
  //         ),
  //       ),
  //       Event(
  //         date: DateTime(2024, 5, 9),
  //         title: 'Event 2',
  //         icon: const Icon(Icons.circle),
  //         dot: Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 1.0),
  //           color: Colors.red,
  //           height: 4.0,
  //           width: 4.0,
  //         ),
  //       ),
  //       Event(
  //         date: DateTime(2024, 5, 9),
  //         title: 'Event 3',
  //         icon: const Icon(Icons.circle),
  //         dot: Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 1.0),
  //           color: Colors.green,
  //           height: 4.0,
  //           width: 4.0,
  //         ),
  //       ),
  //     ],
  //     DateTime(2024, 5, 8): [
  //       Event(
  //         date: DateTime(2024, 5, 8),
  //         title: 'Event 1',
  //         icon: const Icon(Icons.circle),
  //         dot: Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 1.0),
  //           color: Colors.red,
  //           height: 4.0,
  //           width: 4.0,
  //         ),
  //       ),
  //       Event(
  //         date: DateTime(2024, 5, 8),
  //         title: 'Event 2',
  //         icon: const Icon(Icons.circle),
  //         dot: Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 1.0),
  //           color: Colors.red,
  //           height: 4.0,
  //           width: 4.0,
  //         ),
  //       ),
  //       Event(
  //         date: DateTime(2024, 5, 8),
  //         title: 'Event 3',
  //         icon: const Icon(Icons.circle),
  //         dot: Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 1.0),
  //           color: Colors.green,
  //           height: 4.0,
  //           width: 4.0,
  //         ),
  //       ),
  //     ],
  //   },
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF130139),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.06,
                left: 24.0,
                right: 24.0,
              ),
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
                                width:
                                    MediaQuery.of(context).size.height * 0.015,
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
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 24.0, right: 24.0, bottom: 8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        myDay = true;
                        calendar = false;
                        news = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: myDay
                              ? const Color(0xFF2C5A71)
                              : Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Text('My Day',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: GeneralUtil.fontSize(context) * 0.35,
                              color: const Color(0xFFC0EDE8))),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        myDay = false;
                        calendar = true;
                        news = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: calendar
                              ? const Color(0xFF2C5A71)
                              : Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Text('Calendar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: GeneralUtil.fontSize(context) * 0.35,
                              color: const Color(0xFFC0EDE8))),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        myDay = false;
                        calendar = false;
                        news = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: news
                              ? const Color(0xFF2C5A71)
                              : Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Text('News',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: GeneralUtil.fontSize(context) * 0.35,
                              color: const Color(0xFFC0EDE8))),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: myDay,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 24, left: 24),
                    child: Text('Daily\nSummary',
                        style: TextStyle(
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: GeneralUtil.fontSize(context) * 1,
                            color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: SizedBox(width: double.infinity, child: BarsChart()),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: const LinesChart(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
              ),
            ),
            Visibility(visible: myDay, child: SpeedWidget()),
            // Visibility(
            //   visible: calendar,
            //   child: Padding(
            //       padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            //       child: Container(
            //         color: Colors.white,
            //         child: CalendarCarousel<Event>(
            //           onDayPressed: (DateTime date, List<Event> events) {},
            //           weekendTextStyle: const TextStyle(
            //             color: Colors.red,
            //           ),
            //           thisMonthDayBorderColor: Colors.white,
            //           showHeader: true,
            //           isScrollable: false,
            //           selectedDayBorderColor: const Color(0xFFE45A04),
            //           todayBorderColor: const Color(0xFFE45A04),
            //           todayTextStyle: const TextStyle(color: Colors.white),
            //           customDayBuilder: (
            //             bool isSelectable,
            //             int index,
            //             bool isSelectedDay,
            //             bool isToday,
            //             bool isPrevMonthDay,
            //             TextStyle textStyle,
            //             bool isNextMonthDay,
            //             bool isThisMonthDay,
            //             DateTime day,
            //           ) {
            //             if (day.day == 15) {
            //               return null;
            //             } else {
            //               return null;
            //             }
            //           },
            //           weekFormat: false,
            //           markedDatesMap: _markedDateMap,
            //           markedDateCustomShapeBorder: RoundedRectangleBorder(
            //             side: BorderSide(
            //               color: Colors.blue,
            //             ),
            //           ),

            //           height: MediaQuery.of(context).size.height * 0.415,
            //           selectedDateTime: DateTime.now(),
            //           daysHaveCircularBorder: false,

            //           /// null for not rendering any border, true for circular border, false for rectangular border
            //         ),
            //       )),
            // ),

            Visibility(visible: calendar, child: CustomCalendar()),
            Visibility(visible: news, child: NewsWidget()),
          ],
        ),
      ),
    );
  }
}
