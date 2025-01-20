import 'package:mobile_so/features/asset_opname_detail/data/asset_grow_request_model.dart';
import 'package:mobile_so/features/asset_opname_detail/data/asset_grow_response_model.dart';
import 'package:mobile_so/features/asset_opname_detail/domain/api/asset_grow_api.dart';
import 'package:mobile_so/features/login/data/general_response_model.dart';

class AssetGrowRepo {
  final AssetGrowApi assetGrowApi = AssetGrowApi();

  Future<AssetGrowResponseModel?> attemptAssetGrow(
          AssetGrowRequestModel assetGrowRequestModel) =>
      assetGrowApi.attemptAssetGrow(assetGrowRequestModel);

  Future<AssetGrowResponseModel?> attemptAssetGrowAdditional(
      AssetGrowRequestModel assetGrowRequestModel) =>
      assetGrowApi.attemptAssetGrowAdditional(assetGrowRequestModel);

  Future<GeneralResponseModel?> attemptReserved(String assetCode) =>
      assetGrowApi.attemptReserved(assetCode);
}
