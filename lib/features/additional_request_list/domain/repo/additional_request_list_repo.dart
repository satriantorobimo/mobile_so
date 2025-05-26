import 'package:mobile_so/features/additional_request_list/data/additional_request_list_response_model.dart';
import 'package:mobile_so/features/additional_request_list/domain/api/additional_request_list_api.dart';

class AdditionalRequestListRepo {
  final AdditionalRequestListApi additionalRequestListApi =
      AdditionalRequestListApi();

  Future<AdditionalRequestListResponseModel?> attemptAdditionalRegister() =>
      additionalRequestListApi.attemptAdditionalRegister();

  Future<AdditionalRequestListResponseModel?> attemptAdditionalSell() =>
      additionalRequestListApi.attemptAdditionalSell();

  Future<AdditionalRequestListResponseModel?> attemptAdditionalDisposal() =>
      additionalRequestListApi.attemptAdditionalDisposal();

  Future<AdditionalRequestListResponseModel?> attemptAdditionalMaintenance() =>
      additionalRequestListApi.attemptAdditionalMaintenance();
  Future<AdditionalRequestListResponseModel?> attemptAdditionalMutation() =>
      additionalRequestListApi.attemptAdditionalMutation();
}
