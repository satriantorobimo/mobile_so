import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/dashboard/bar_chart.dart';
import 'package:mobile_so/features/dashboard/class_status.dart';
import 'package:mobile_so/features/dashboard/line_chart.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
// import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class DailyDetailScreen extends StatefulWidget {
  const DailyDetailScreen({super.key});

  @override
  State<DailyDetailScreen> createState() => _DailyDetailScreenState();
}

class _DailyDetailScreenState extends State<DailyDetailScreen> {
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
      Status('Electronic', 50),
      Status('Furniture', 300),
      Status('Machine', 10),
      Status('Others', 5),
    ];
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
            padding: const EdgeInsets.only(top: 32.0, left: 24.0, right: 24.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xFF122E69),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dashboard - 02 May 2024',
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 115,
                            child: Text('Opname No',
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white)),
                          ),
                          Text(': 012.05.2024',
                              style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
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
                                        GoogleFonts.poppins().fontFamily,
                                    fontSize: 12,
                                    color: Colors.white)),
                          ),
                          Text(': PT ABC',
                              style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 12,
                                  color: Colors.white)),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 115,
                            child: Text('Asset Condition',
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontSize: 12,
                                    color: Colors.white)),
                          ),
                          Text(': Good',
                              style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
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
                                        GoogleFonts.poppins().fontFamily,
                                    fontSize: 12,
                                    color: Colors.white)),
                          ),
                          Text(': 300',
                              style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 12,
                                  color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BarsChart(data: data),
                const SizedBox(height: 24),
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
                        Text('Electronic',
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
                        Text('Furniture',
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
                        Text('Machine',
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
                const SizedBox(height: 16),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: const LinesChart(isShowingMainData: true),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
