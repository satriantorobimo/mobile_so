import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/asset_opname_detail/domain/repo/asset_grow_repo.dart';

import 'bloc.dart';

class AssetGrowBloc extends Bloc<AssetGrowEvent, AssetGrowState> {
  AssetGrowState get initialState => AssetGrowInitial();
  AssetGrowRepo assetGrowRepo = AssetGrowRepo();
  AssetGrowBloc({required this.assetGrowRepo}) : super(AssetGrowInitial()) {
    on<AssetGrowEvent>((event, emit) async {
      if (event is AssetGrowAttempt) {
        try {
          emit(AssetGrowLoading());
          final assetGrowResponseModel =
              await assetGrowRepo.attemptAssetGrow(event.assetGrowRequestModel);
          if (assetGrowResponseModel!.result == 1) {
            emit(AssetGrowLoaded(
                assetGrowResponseModel: assetGrowResponseModel));
          } else if (assetGrowResponseModel.result == 0) {
            emit(AssetGrowError(assetGrowResponseModel.message));
          } else {
            emit(const AssetGrowException('error'));
          }
        } catch (e) {
          emit(AssetGrowException(e.toString()));
        }
      }
      if (event is AssetGrowAdditionalAttempt) {
        try {
          emit(AssetGrowLoading());
          final assetGrowResponseModel =
          await assetGrowRepo.attemptAssetGrowAdditional(event.assetGrowRequestModel);
          if (assetGrowResponseModel!.result == 1) {
            emit(AssetGrowLoaded(
                assetGrowResponseModel: assetGrowResponseModel));
          } else if (assetGrowResponseModel.result == 0) {
            emit(AssetGrowError(assetGrowResponseModel.message));
          } else {
            emit(const AssetGrowException('error'));
          }
        } catch (e) {
          emit(AssetGrowException(e.toString()));
        }
      }
    });
  }
}
