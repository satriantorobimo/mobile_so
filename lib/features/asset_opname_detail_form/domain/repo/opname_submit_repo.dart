import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_employee.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/upload_doc_request_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/arguments_view_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/ddl_location_response_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/ddl_status_response_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/opname_result_response_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/submit_opname_request_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/domain/api/opname_submit_api.dart';
import 'package:mobile_so/features/login/data/general_response_model.dart';

class OpnameSubmitRepo {
  final OpnameSubmitApi opnameSubmitApi = OpnameSubmitApi();

  Future<DdlLocationResponseModel?> attemptDdlLocation() =>
      opnameSubmitApi.attemptDdlLocation();

  Future<OpnameResultResponseModel?> attemptOpnameResult(
          ArgumentsViewModel argumentViewModel) =>
      opnameSubmitApi.attemptOpnameResult(argumentViewModel);

  Future<DropDownModel?> attemptDdlCondition() =>
      opnameSubmitApi.attemptDdlCondition();

  Future<DdlStatusResponseModel?> attemptDdlStatus() =>
      opnameSubmitApi.attemptDdlStatus();

  Future<DropDownEmployee?> attemptDdlEmployee(String action) =>
      opnameSubmitApi.attemptDdlEmployee(action);

  Future<GeneralResponseModel?> attemptUpload(
          UploadDocRequestModel uploadDocRequestModel, String opnameCode) =>
      opnameSubmitApi.attemptUpload(uploadDocRequestModel, opnameCode);

  Future<GeneralResponseModel?> attemptSubmit(
          SubmitOpnameRequestModel submitOpnameRequestModel) =>
      opnameSubmitApi.attemptSubmit(submitOpnameRequestModel);
}
