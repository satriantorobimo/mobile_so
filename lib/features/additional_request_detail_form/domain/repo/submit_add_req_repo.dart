import 'package:mobile_so/features/additional_request_detail_form/data/submit_request_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/upload_doc_request_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/api/submit_add_req_api.dart';
import 'package:mobile_so/features/login/data/general_response_model.dart';

class SubmitAddReqRepo {
  final SubmitAddReqApi submitAddReqApi = SubmitAddReqApi();

  Future<GeneralResponseModel?> attemptSubmit(
          SubmitRequestModel submitRequestModel) =>
      submitAddReqApi.attemptSubmit(submitRequestModel);
  Future<GeneralResponseModel?> attemptSubmitAdditional(
          SubmitRequestModel submitRequestModel) =>
      submitAddReqApi.attemptSubmitAdditional(submitRequestModel);
  Future<GeneralResponseModel?> attemptSubmitAdditionalSell(
          SubmitRequestModel submitRequestModel) =>
      submitAddReqApi.attemptSubmitAdditionalSell(submitRequestModel);
  Future<GeneralResponseModel?> attemptSubmitAdditionalMaintenance(
          SubmitRequestModel submitRequestModel) =>
      submitAddReqApi.attemptSubmitAdditionalMaintenance(submitRequestModel);

  Future<GeneralResponseModel?> attemptSubmitAdditionalMutation(
          SubmitRequestModel submitRequestModel) =>
      submitAddReqApi.attemptSubmitAdditionalMutation(submitRequestModel);
  Future<GeneralResponseModel?> attemptUpload(
          UploadDocRequestModel uploadDocRequestModel) =>
      submitAddReqApi.attemptUpload(uploadDocRequestModel);
  Future<GeneralResponseModel?> attemptUploadDisposal(
          UploadDocRequestModel uploadDocRequestModel, String opnameCode) =>
      submitAddReqApi.attemptUploadDisposal(uploadDocRequestModel, opnameCode);
  Future<GeneralResponseModel?> attemptUploadMaintenance(
          UploadDocRequestModel uploadDocRequestModel, String opnameCode) =>
      submitAddReqApi.attemptUploadMaintenance(
          uploadDocRequestModel, opnameCode);
  Future<GeneralResponseModel?> attemptUploadMutation(
          UploadDocRequestModel uploadDocRequestModel, String opnameCode) =>
      submitAddReqApi.attemptUploadMutation(uploadDocRequestModel, opnameCode);
  Future<GeneralResponseModel?> attemptUploadSell(
          UploadDocRequestModel uploadDocRequestModel, String opnameCode) =>
      submitAddReqApi.attemptUploadSell(uploadDocRequestModel, opnameCode);
}
