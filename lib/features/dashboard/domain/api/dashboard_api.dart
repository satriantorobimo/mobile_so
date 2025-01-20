import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_so/features/dashboard/data/calendar_list_response_model.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/url_util.dart';

class DashboardApi {
  CalendarListResponseModel calendarListResponseModel =
      CalendarListResponseModel();

  UrlUtil urlUtil = UrlUtil();

  Future<CalendarListResponseModel> attemptCalendarList(
      int month, int year) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_month'] = month;
    mapData['p_year'] = year;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlDataCalendar()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        calendarListResponseModel =
            CalendarListResponseModel.fromJson(jsonDecode(res.body));
        return calendarListResponseModel;
      } else {
        calendarListResponseModel =
            CalendarListResponseModel.fromJson(jsonDecode(res.body));
        throw calendarListResponseModel.message!;
      }
    } catch (ex) {
      throw ex.toString();
    }
  }
}
