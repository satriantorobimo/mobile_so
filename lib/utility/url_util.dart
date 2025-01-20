import 'dart:convert';

class UrlUtil {
  static String baseUrl = 'http://149.129.243.237/';

  static Map<String, String> headerType() =>
      {'Content-Type': 'application/json', 'Accept': 'application/json'};

  static Map<String, String> headerTypeBasicAuth(
          String username, String password) =>
      {
        "content-type": "application/json",
        "accept": "application/json",
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$username:$password'))}'
      };

  static Map<String, String> headerTypeWithToken(String token, String userId) =>
      {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Userid': userId
      };

  static Map<String, String> headerTypeWithTokenNoUserId(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };

  static Map<String, String> headerTypeForm() => {
        'Content-Type': 'application/x-www-form-urlencoded',
      };

  Map<String, String> getHeaderTypeWithToken(String token, String userId) {
    return headerTypeWithToken(token, userId);
  }

  Map<String, String> getHeaderTypeWithTokenNoUserId(String token) {
    return headerTypeWithTokenNoUserId(token);
  }

  Map<String, String> getHeaderTypeBasicAuth(String username, String password) {
    return headerTypeBasicAuth(username, password);
  }

  Map<String, String> getHeaderTypeForm() {
    return headerTypeForm();
  }

  Map<String, String> getHeaderType() {
    return headerType();
  }

  static String urlLogin() => 'Token_SOMobile/api/Authenticate/requestValidate';

  String getUrlLogin() {
    final String getUrlLogin2 = urlLogin();
    return baseUrl + getUrlLogin2;
  }

  static String urlChangePassword() =>
      'eBase_api/api/SysCompanyUserMainExternal/ExecSpForRequestChangePassword';

  String getUrlChangePassword() {
    final String urlChangePassword2 = urlChangePassword();
    return baseUrl + urlChangePassword2;
  }

  static String urlValidateOtp() =>
      'eBase_api/api/SysCompanyUserMainExternal/ExecSpForValidateOTPChangePassword';

  String getUrlValidateOtp() {
    final String urlValidateOtp2 = urlValidateOtp();
    return baseUrl + urlValidateOtp2;
  }

  static String urlResendOtp() =>
      'eBase_api/api/SysCompanyUserMainExternal/ExecSpForResendOTPChangePassword';

  String getUrlResendOtp() {
    final String urlResendOtp2 = urlResendOtp();
    return baseUrl + urlResendOtp2;
  }

  static String urlConfirmPassword() =>
      'eBase_api/api/SysCompanyUserMainExternal/ExecSpForChangePassword';

  String getUrlConfirmPassword() {
    final String urlConfirmPassword2 = urlConfirmPassword();
    return baseUrl + urlConfirmPassword2;
  }

  static String urlValidateOtpLogin() =>
      'Token_SOMobile/api/Authenticate/requestValidateOTP';

  String getUrlValidateOtpLogin() {
    final String urlValidateOtpLogin2 = urlValidateOtpLogin();
    return baseUrl + urlValidateOtpLogin2;
  }

  static String urlResendOtpLogin() =>
      'Token_SOMobile/api/Authenticate/requestResendOTP';

  String getUrlResendOtpLogin() {
    final String urlResendOtpLogin2 = urlResendOtpLogin();
    return baseUrl + urlResendOtpLogin2;
  }

  static String urlAssetGrow() => 'SOMobile_api/api/Asset/Getrow';

  String getUrlAssetGrow() {
    final String urlAssetGrow2 = urlAssetGrow();
    return baseUrl + urlAssetGrow2;
  }

  static String urlAddResgisterList() =>
      'SOMobile_api/api/AdditionalRequestAssetRegister/Getrows';

  String getUrlAddResgisterList() {
    final String urlAddResgisterList2 = urlAddResgisterList();
    return baseUrl + urlAddResgisterList2;
  }

  static String urlAddSellList() =>
      'SOMobile_api/api/AdditionalRequestSell/Getrows';

  String getUrlAddSellList() {
    final String urlAddSellList2 = urlAddSellList();
    return baseUrl + urlAddSellList2;
  }

  static String urlAddDisposalList() =>
      'SOMobile_api/api/AdditionalRequestDisposal/Getrows';

  String getUrlAddDisposalList() {
    final String urlAddDisposalList2 = urlAddDisposalList();
    return baseUrl + urlAddDisposalList2;
  }

  static String urlAddMaintenanceList() =>
      'SOMobile_api/api/AdditionalRequestMaintenance/Getrows';

  String getUrlAddMaintenanceList() {
    final String urlAddMaintenanceList2 = urlAddMaintenanceList();
    return baseUrl + urlAddMaintenanceList2;
  }

  static String urlDataCalendar() =>
      'SOMobile_api/api/Dashboard/GetCalendarOpnameSchedule';

  String getUrlDataCalendar() {
    final String urlDataCalendar2 = urlDataCalendar();
    return baseUrl + urlDataCalendar2;
  }

  static String urlAssetGrowAdditional() =>
      'SOMobile_api/api/Asset/GetrowForAdditionalRequest';

  String getUrlAssetGrowAdditional() {
    final String urlAssetGrowAdditional2 = urlAssetGrowAdditional();
    return baseUrl + urlAssetGrowAdditional2;
  }

  static String urlReserved() => 'SOMobile_api/api/Opname/ExecSpForReserved';

  String getUrlReserved() {
    final String urlReserved2 = urlReserved();
    return baseUrl + urlReserved2;
  }

  static String urlDDLLocation() =>
      'ebase_api/api/MasterLocationExternal/GetrowsDDL';

  String getUrlDDLocation() {
    final String urlDDLLocation2 = urlDDLLocation();
    return baseUrl + urlDDLLocation2;
  }

  static String urlDDLCondition() =>
      'ebase_api/api/MasterReasonExternal/GetrowsDDL';

  String getUrlDDCondition() {
    final String urlDDLCondition2 = urlDDLCondition();
    return baseUrl + urlDDLCondition2;
  }

  static String urlDDLStatus() =>
      'ebase_api/api/MasterStatusExternal/GetrowsDDL';

  String getUrlDDStatus() {
    final String urlDDLStatus2 = urlDDLStatus();
    return baseUrl + urlDDLStatus2;
  }

  static String urlDDLItem() =>
      'ebase_api/api/MasterItemExternal/GetRowsDDLForAdditionalRequestAssetRegister';

  String getUrlDDLItem() {
    final String urlDDLItem2 = urlDDLItem();
    return baseUrl + urlDDLItem2;
  }

  static String urlddDetailRegister() =>
      'SOMobile_api/api/AdditionalRequestAssetRegister/Getrow';

  String getUrlAddDetailRegister() {
    final String urlddDetailRegister2 = urlddDetailRegister();
    return baseUrl + urlddDetailRegister2;
  }

  static String urlddDetailSell() =>
      'SOMobile_api/api/AdditionalRequestSell/Getrow';

  String getUrlAddDetailSell() {
    final String urlddDetailSell2 = urlddDetailSell();
    return baseUrl + urlddDetailSell2;
  }

  static String urlddDetailDisposal() =>
      'SOMobile_api/api/AdditionalRequestDisposal/Getrow';

  String getUrlAddDetailDisposal() {
    final String urlddDetailDisposal2 = urlddDetailDisposal();
    return baseUrl + urlddDetailDisposal2;
  }

  static String urlddDetailMaintenance() =>
      'SOMobile_api/api/AdditionalRequestMaintenance/Getrow';

  String getUrlAddDetailMaintenance() {
    final String urlddDetailMaintenance2 = urlddDetailMaintenance();
    return baseUrl + urlddDetailMaintenance2;
  }

  static String urlDDLReason() =>
      'ebase_api/api/MasterReasonExternal/GetrowsDDL';

  String getUrlDDLReason() {
    final String urlDDLReason2 = urlDDLReason();
    return baseUrl + urlDDLReason2;
  }

  static String urlDDLPurchaseCondition() =>
      'ebase_api/api/SysGeneralSubcodeExternal/GetrowsDDL';

  String getUrlDDLPurchaseCondition() {
    final String urlDDLPurchaseCondition2 = urlDDLPurchaseCondition();
    return baseUrl + urlDDLPurchaseCondition2;
  }

  static String urlDDLEmployee() =>
      'ebase_api/api/SysEmployeeMainExternal/GetrowsDDL';

  String getUrlDDLEmployee() {
    final String urlDDLEmployee2 = urlDDLEmployee();
    return baseUrl + urlDDLEmployee2;
  }

  static String urlDDLTos() =>
      'ebase_api/api/MasterModelDetailExternal/GetrowsDDL';

  String getUrlDDLTos() {
    final String urlDDLTos2 = urlDDLTos();
    return baseUrl + urlDDLTos2;
  }

  static String urlSubmitAddReq() => 'SOMobile_api/api/AssetRegister/Insert';

  String getUrlSubmitAddReq() {
    final String urlSubmitAddReq2 = urlSubmitAddReq();
    return baseUrl + urlSubmitAddReq2;
  }

  static String urlSubmitAdditional() =>
      'SOMobile_api/api/AdditionalRequest/Insert';

  String getUrlSubmitAdditional() {
    final String urlSubmitAdditional2 = urlSubmitAdditional();
    return baseUrl + urlSubmitAdditional2;
  }

  static String urlSubmitOpname() =>
      'SOMobile_api/api/Opname/ExecSpForSubmitted';

  String getUrlSubmitOpname() {
    final String urlSubmitOpname2 = urlSubmitOpname();
    return baseUrl + urlSubmitOpname2;
  }

  static String urlUploadDocReq() =>
      'SOMobile_api/api/AssetRegisterDocument/Upload';

  String getUrlUploadDocReq() {
    final String urlUploadDocReq2 = urlUploadDocReq();
    return baseUrl + urlUploadDocReq2;
  }

  static String urlUploadDocDisposalReq() =>
      'SOMobile_api/api/AdditionalRequestDisposalDocument/Upload';

  String getUrlUploadDocDisposalReq() {
    final String urlUploadDocDisposalReq2 = urlUploadDocDisposalReq();
    return baseUrl + urlUploadDocDisposalReq2;
  }

  static String urlUploadDocOpname() =>
      'SOMobile_api/api/OpnameDocument/Upload';

  String getUrlUploadDocOpname() {
    final String urlUploadDocOpname2 = urlUploadDocOpname();
    return baseUrl + urlUploadDocOpname2;
  }
}
