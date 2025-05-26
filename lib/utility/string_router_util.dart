class StringRouterUtil {
  factory StringRouterUtil() => _instance;
  StringRouterUtil.internal();
  static final StringRouterUtil _instance = StringRouterUtil.internal();

  static const String splashScreenRoute = '/';
  static const String loginScreenRoute = '/login-route';
  static const String navbarScreenRoute = '/navbar-route';
  static const String aboutUsScreenRoute = '/about-us-route';
  static const String addRequestScreenRoute = '/add-request-route';
  static const String addRequestListScreenRoute = '/add-request-list-route';
  static const String addRequestDetailScreenRoute = '/add-request-detail-route';
  static const String addRequesteDetailFormScreenRoute =
      '/add-request-detail-form-route';
  static const String addRequesteDetailFormViewScreenRoute =
      '/add-request-detail-form-view-route';
  static const String assetOpnameScreenRoute = '/asset-opname-route';
  static const String assetOpnameDetailScreenRoute =
      '/asset-opname-detail-route';
  static const String assetOpnameDetailFormScreenRoute =
      '/asset-opname-detail-form-route';
  static const String assetOpnameDetailFormViewScreenRoute =
      '/asset-opname-detail-form-view-route';
  static const String assetOpnameListDetailScreenRoute =
      '/asset-opname-list-detail-route';
  static const String dashboardScreenRoute = '/dashboard-route';
  static const String dashboardDetailScreenRoute = '/dashboard-detail-route';
  static const String notificationScreenRoute = '/notification-route';
  static const String emailOtpScreenRoute = '/email-otp-route';
  static const String otpScreenRoute = '/otp-route';
  static const String otpLoginScreenRoute = '/otp-login-route';
  static const String profileScreenRoute = '/profile-route';
  static const String scannerScreenRoute = '/scanner-route';
  static const String changePwdScreenRoute = '/change-pwd-route';
  static const String dailyDetailScreenRoute = '/daily-detail-route';
  static const String dropDownScreenRoute = '/drop-down-route';
  static const String docPreviewScreenRoute = '/doc-preview-route';
  static const String docPreviewNetworkScreenRoute =
      '/doc-preview-network-route';

  static const String docPreviewNetworkPdfScreenRoute =
      '/doc-preview-network-pdf-route';
}
