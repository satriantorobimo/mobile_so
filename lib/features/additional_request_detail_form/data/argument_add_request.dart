import 'package:mobile_so/features/asset_opname_detail/data/asset_grow_response_model.dart';

class ArgumentAddReq {
  bool register = false;
  bool sell = false;
  bool disposal = false;
  bool maintenance = false;
  bool other = false;
  final AssetGrowResponseModel assetGrowResponseModel;

  ArgumentAddReq(
      {required this.register,
      required this.sell,
      required this.disposal,
      required this.maintenance,
      required this.other,
      required this.assetGrowResponseModel});
}
