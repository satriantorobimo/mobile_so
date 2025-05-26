import 'package:mobile_so/features/asset_opname_list/data/asset_opname_list_detail_response_model.dart';
import 'package:mobile_so/features/asset_opname_list/data/asset_opname_list_response_model.dart';
import 'package:mobile_so/features/asset_opname_list/data/asset_opname_schedule_response_model.dart';
import 'package:mobile_so/features/asset_opname_list/domain/api/asset_opname_list_api.dart';

class AssetOpnameListRepo {
  final AssetOpnameListApi assetOpnameListApi = AssetOpnameListApi();

  Future<AssetOpnameListResponseModel?> attemptAssetOpnameList() =>
      assetOpnameListApi.attemptAssetOpnameList();

  Future<AssetOpnameListDetailResponseModel?> attemptAssetOpnameListDetail(
          String code) =>
      assetOpnameListApi.attemptAssetOpnameListDetail(code);

  Future<AssetOpnameListDetailResponseModel?> attemptCalendarOpnameResult(
          String code, String date) =>
      assetOpnameListApi.attemptCalendarOpnameResult(code, date);

  Future<AssetOpnameScheduleResponseModel?> attemptAssetOpnameSchedule(
          String code) =>
      assetOpnameListApi.attemptAssetOpnameSchedule(code);
}
