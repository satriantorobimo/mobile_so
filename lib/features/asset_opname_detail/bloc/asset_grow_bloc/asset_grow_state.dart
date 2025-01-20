import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/asset_opname_detail/data/asset_grow_response_model.dart';

abstract class AssetGrowState extends Equatable {
  const AssetGrowState();

  @override
  List<Object> get props => [];
}

class AssetGrowInitial extends AssetGrowState {}

class AssetGrowLoading extends AssetGrowState {}

class AssetGrowLoaded extends AssetGrowState {
  const AssetGrowLoaded({required this.assetGrowResponseModel});
  final AssetGrowResponseModel assetGrowResponseModel;

  @override
  List<Object> get props => [assetGrowResponseModel];
}

class AssetGrowError extends AssetGrowState {
  const AssetGrowError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class AssetGrowException extends AssetGrowState {
  const AssetGrowException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
