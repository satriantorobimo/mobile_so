import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_disposal_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_maintenance_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_mutation_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_register_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_sell_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/doc_preview_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/api/additional_request_detail_api.dart';

class AdditionalRequestDetailRepo {
  final AdditionalRequestDetailApi additionalRequestDetailApi =
      AdditionalRequestDetailApi();

  Future<AdditionalRequestDetailRegisterResponseModel?> attemptRegisterDetail(
          String pCode) =>
      additionalRequestDetailApi.attemptRegisterDetail(pCode);

  Future<AdditionalRequestDetailSellResponseModel?> attemptSellDetail(
          String pCode) =>
      additionalRequestDetailApi.attemptSellDetail(pCode);

  Future<AdditionalRequestDetailDisposalResponseModel?> attemptDisposalDetail(
          String pCode) =>
      additionalRequestDetailApi.attemptDisposalDetail(pCode);

  Future<AdditionalRequestDetailMaintenanceResponseModel?>
      attemptMaintenanceDetail(String pCode) =>
          additionalRequestDetailApi.attemptMaintenanceDetail(pCode);

  Future<AdditionalRequestDetailMutationResponseModel?> attemptMutationDetail(
          String pCode) =>
      additionalRequestDetailApi.attemptMutationDetail(pCode);

  Future<DocPreviewResponseModel?> attemptDocPreview(
          String pFileName, String pFilePaths) =>
      additionalRequestDetailApi.attemptDocPreview(pFileName, pFilePaths);
}
