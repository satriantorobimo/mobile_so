import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/dashboard/bar_chart.dart';
import 'package:mobile_so/features/dashboard/class_status.dart';
import 'package:mobile_so/features/dashboard/custom_calendar.dart';
import 'package:mobile_so/features/dashboard/line_chart.dart';
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
    final List<Status> data = [
      Status('On Repair', 50),
      Status('Good', 300),
      Status('Broken', 10),
      Status('Others', 5),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFF130139),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.06,
                  left: 24.0,
                  right: 24.0),
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
                              fontSize: 15,
                              color: Colors.white)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(uid,
                              style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white)),
                          Text(company,
                              style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.check_circle_rounded,
                                color: Colors.green,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text('Active',
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
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
                              fontSize: 15,
                              color: const Color(0xFFC0EDE8))),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        myDay = false;
                        calendar = true;
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
                              fontSize: 15,
                              color: const Color(0xFFC0EDE8))),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: myDay,
              child: Padding(
                padding: const EdgeInsets.only(right: 24, left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Daily\nSummary',
                        style: TextStyle(
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Colors.white)),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity,
                        child: BarsChart(data: data)),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              color: const Color(0xFFFFB300),
                            ),
                            const SizedBox(width: 4),
                            Text('On Repair',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white)),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              color: const Color(0xFF00BF63),
                            ),
                            const SizedBox(width: 4),
                            Text('Good',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white)),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              color: const Color(0xFFD00E00),
                            ),
                            const SizedBox(width: 4),
                            Text('Broken',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white)),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              color: const Color(0xFF2F5F98),
                            ),
                            const SizedBox(width: 4),
                            Text('Others',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: const LinesChart(isShowingMainData: true),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: myDay,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 4.0, left: 24.0, right: 24.0),
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
                                fontSize: 28,
                                color: const Color(0xFFFF9561))),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text('358',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 55,
                                    color: const Color(0xFFFF9561))),
                            const SizedBox(width: 16),
                            Text('ASSET / DAY',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: const Color(0xFFFF9561))),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Jaguar',
                            style: TextStyle(
                                fontFamily: GoogleFonts.squadaOne().fontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: const Color(0xFFBFBFBF))),
                        Image.asset(
                          'assets/imgs/jaguar.png',
                          width: 85,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
