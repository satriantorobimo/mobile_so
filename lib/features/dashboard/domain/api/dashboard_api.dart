import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_so/features/dashboard/data/bar_chart_response_model.dart';
import 'package:mobile_so/features/dashboard/data/calendar_list_response_model.dart';
import 'package:mobile_so/features/dashboard/data/line_chart_response_model.dart';
import 'package:mobile_so/features/dashboard/data/news_response_model.dart';
import 'package:mobile_so/features/dashboard/data/pie_chart_response_model.dart';
import 'package:mobile_so/features/dashboard/data/speed_response_model.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/url_util.dart';

class DashboardApi {
  CalendarListResponseModel calendarListResponseModel =
      CalendarListResponseModel();
  NewsResponseModel newsResponseModel = NewsResponseModel();
  SpeedResponseModel speedResponseModel = SpeedResponseModel();
  BarChartResponseModel barChartResponseModel = BarChartResponseModel();
  LineChartResponseModel lineChartResponseModel = LineChartResponseModel();
  PieChartResponseModel pieChartResponseModel = PieChartResponseModel();

  UrlUtil urlUtil = UrlUtil();

  Future<CalendarListResponseModel> attemptCalendarList(
      String month, String year) async {
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
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<NewsResponseModel> attemptNews() async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['action'] = 'default';
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlNews()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        newsResponseModel = NewsResponseModel.fromJson(jsonDecode(res.body));
        return newsResponseModel;
      } else {
        newsResponseModel = NewsResponseModel.fromJson(jsonDecode(res.body));
        throw newsResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<SpeedResponseModel> attemptSpeed() async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['action'] = 'default';
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlSpped()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        speedResponseModel = SpeedResponseModel.fromJson(jsonDecode(res.body));
        return speedResponseModel;
      } else {
        speedResponseModel = SpeedResponseModel.fromJson(jsonDecode(res.body));
        throw speedResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<BarChartResponseModel> attemptBarChart() async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['action'] = 'default';
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlBar()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        barChartResponseModel =
            BarChartResponseModel.fromJson(jsonDecode(res.body));
        return barChartResponseModel;
      } else {
        barChartResponseModel =
            BarChartResponseModel.fromJson(jsonDecode(res.body));
        throw barChartResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<LineChartResponseModel> attemptLineChart() async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['action'] = 'default';
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlLine()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        lineChartResponseModel =
            LineChartResponseModel.fromJson(jsonDecode(res.body));
        return lineChartResponseModel;
      } else {
        lineChartResponseModel =
            LineChartResponseModel.fromJson(jsonDecode(res.body));
        throw lineChartResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<BarChartResponseModel> attemptBarChartCalendar(
      String code, String date) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_opname_code'] = code;
    mapData['p_date'] = date;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlBarCalendart()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        barChartResponseModel =
            BarChartResponseModel.fromJson(jsonDecode(res.body));
        return barChartResponseModel;
      } else {
        barChartResponseModel =
            BarChartResponseModel.fromJson(jsonDecode(res.body));
        throw barChartResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<PieChartResponseModel> attemptPieChartCalendar(
      String code, String date) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_opname_code'] = code;
    mapData['p_date'] = date;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlPieCalendart()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        pieChartResponseModel =
            PieChartResponseModel.fromJson(jsonDecode(res.body));
        return pieChartResponseModel;
      } else {
        pieChartResponseModel =
            PieChartResponseModel.fromJson(jsonDecode(res.body));
        throw pieChartResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }
}
