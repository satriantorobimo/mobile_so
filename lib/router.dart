import 'package:flutter/material.dart';
import 'package:mobile_so/features/about_us/about_us_screen.dart';
import 'package:mobile_so/features/additional_request/additional_request_screen.dart';
import 'package:mobile_so/features/additional_request_detail/additional_request_detail_screen.dart';
import 'package:mobile_so/features/additional_request_detail_form/additional_request_detail_form_screen.dart';
import 'package:mobile_so/features/additional_request_detail_form/additional_request_detail_form_view_screen.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/argument_add_request.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/argument_view_add_request.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/doc_preview_request_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/doc_preview.dart';
import 'package:mobile_so/features/additional_request_detail_form/doc_preview_network.dart';
import 'package:mobile_so/features/additional_request_detail_form/doc_preview_pdf_network.dart';
import 'package:mobile_so/features/additional_request_list/additional_request_list_screen.dart';
import 'package:mobile_so/features/asset_opname/asset_opname_screen.dart';
import 'package:mobile_so/features/asset_opname_detail/asset_opname_detail_screen.dart';
import 'package:mobile_so/features/asset_opname_detail/data/arguments_asset_grow.dart';
import 'package:mobile_so/features/asset_opname_detail/data/asset_grow_response_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/asset_opname_detail_form_screen.dart';
import 'package:mobile_so/features/asset_opname_detail_form/asset_opname_detail_form_view_screen.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/arguments_view_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/ddl_request_screen.dart';
import 'package:mobile_so/features/asset_opname_detail_form/drop_down_screen.dart';
import 'package:mobile_so/features/asset_opname_list/asset_opname_list_detail_screen.dart';
import 'package:mobile_so/features/asset_opname_list/asset_opname_list_screen.dart';
import 'package:mobile_so/features/change_password/change_password_screen.dart';
import 'package:mobile_so/features/daily_detail/daily_detail_screen.dart';
import 'package:mobile_so/features/daily_detail/data/argument_daily_detail_model.dart';
import 'package:mobile_so/features/dashboard/dashboard_screen.dart';
import 'package:mobile_so/features/dashboard_detail/dashboard_detail_screen.dart';
import 'package:mobile_so/features/dashboard_detail/data/argument_dashboard_detail_model.dart';
import 'package:mobile_so/features/email_otp/email_otp_screen.dart';
import 'package:mobile_so/features/login/login_screen.dart';
import 'package:mobile_so/features/navbar/navbar_screen.dart';
import 'package:mobile_so/features/notification/notification_screen.dart';
import 'package:mobile_so/features/otp/otp_screen.dart';
import 'package:mobile_so/features/otp_login/otp_login_screen.dart';
import 'package:mobile_so/features/profile/profile_screen.dart';
import 'package:mobile_so/features/scanner/scanner_screen.dart';
import 'package:mobile_so/features/splash/splash_screen.dart';
import 'package:mobile_so/utility/string_router_util.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case StringRouterUtil.splashScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const SplashScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.loginScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const LoginScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.aboutUsScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const AboutUsScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.addRequestScreenRoute:
        final ArgumentAddReq argumentAddReq =
            settings.arguments as ArgumentAddReq;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                AdditionalRequestScreen(argumentAddReq: argumentAddReq),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.addRequestListScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const AdditionalRequestListScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.addRequestDetailScreenRoute:
        final ArgumentAddReq argumentAddReq =
            settings.arguments as ArgumentAddReq;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                AdditionalRequestDetailScreen(argumentAddReq: argumentAddReq),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.assetOpnameScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const AssetOpnameScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.assetOpnameListDetailScreenRoute:
        final String code = settings.arguments as String;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                AssetOpnameListDetailScreen(code: code),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.assetOpnameDetailScreenRoute:
        final ArgumentsAssetGrow argumentsAssetGrow =
            settings.arguments as ArgumentsAssetGrow;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                AssetOpnameDetailScreen(argumentsAssetGrow: argumentsAssetGrow),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.dashboardScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const DashboardScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.dashboardDetailScreenRoute:
        final ArgumentDashboardDetailModel argumentDashboardDetailModel =
            settings.arguments as ArgumentDashboardDetailModel;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => DashboardDetailScreen(
                argumentDashboardDetailModel: argumentDashboardDetailModel),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.navbarScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const NavbarScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.notificationScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const NotificationScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.emailOtpScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const EmailOtpScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.otpScreenRoute:
        final String email = settings.arguments as String;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => OtpScreen(email: email),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.otpLoginScreenRoute:
        final String email = settings.arguments as String;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => OtpLoginScreen(email: email),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.profileScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const ProfileScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.scannerScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const ScannerScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.changePwdScreenRoute:
        final String email = settings.arguments as String;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => ChangePasswordScreen(email: email),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.dailyDetailScreenRoute:
        final ArgumentDailyDetailModel argumentDailyDetailModel =
            settings.arguments as ArgumentDailyDetailModel;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => DailyDetailScreen(
                argumentDailyDetailModel: argumentDailyDetailModel),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.assetOpnameDetailFormScreenRoute:
        final Data data = settings.arguments as Data;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                AssetOpnameDetailFormScreen(data: data),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.assetOpnameDetailFormViewScreenRoute:
        final ArgumentsViewModel data =
            settings.arguments as ArgumentsViewModel;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                AssetOpnameDetailFormViewScreen(argumentsViewModel: data),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.addRequesteDetailFormScreenRoute:
        final ArgumentAddReq argumentAddReq =
            settings.arguments as ArgumentAddReq;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => AdditionalRequestDetailFormScreen(
                argumentAddReq: argumentAddReq),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.addRequesteDetailFormViewScreenRoute:
        final ArgumentViewAddReq argumentViewAddReq =
            settings.arguments as ArgumentViewAddReq;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => AdditionalRequestDetailFormViewScreen(
                argumentViewAddReq: argumentViewAddReq),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.dropDownScreenRoute:
        final DdlRequestScreen ddlRequestScreen =
            settings.arguments as DdlRequestScreen;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                DropDownScreen(ddlRequestScreen: ddlRequestScreen),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.docPreviewScreenRoute:
        final String path = settings.arguments as String;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => DocPreviewAssetScreen(path),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.docPreviewNetworkScreenRoute:
        final DocPreviewRequestModel docPreviewRequestModel =
            settings.arguments as DocPreviewRequestModel;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                DocPreviewNetworkScreen(docPreviewRequestModel),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.docPreviewNetworkPdfScreenRoute:
        final DocPreviewRequestModel docPreviewRequestModel =
            settings.arguments as DocPreviewRequestModel;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                DocPreviewNetworkPdfScreen(docPreviewRequestModel),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      default:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
