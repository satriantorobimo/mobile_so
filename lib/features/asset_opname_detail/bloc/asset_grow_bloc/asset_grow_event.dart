import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/asset_opname_detail/data/asset_grow_request_model.dart';

abstract class AssetGrowEvent extends Equatable {
  const AssetGrowEvent();
}

class AssetGrowAttempt extends AssetGrowEvent {
  const AssetGrowAttempt({required this.assetGrowRequestModel});
  final AssetGrowRequestModel assetGrowRequestModel;

  @override
  List<Object> get props => [assetGrowRequestModel];
}

class AssetGrowAdditionalAttempt extends AssetGrowEvent {
  const AssetGrowAdditionalAttempt({required this.assetGrowRequestModel});
  final AssetGrowRequestModel assetGrowRequestModel;

  @override
  List<Object> get props => [assetGrowRequestModel];
}
