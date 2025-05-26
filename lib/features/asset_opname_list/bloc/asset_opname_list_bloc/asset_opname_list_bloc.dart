import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/asset_opname_list/domain/repo/asset_opname_list_repo.dart';

import 'bloc.dart';

class AssetOpnameListBloc
    extends Bloc<AssetOpnameListEvent, AssetOpnameListState> {
  AssetOpnameListState get initialState => AssetOpnameListInitial();
  AssetOpnameListRepo assetOpnameListRepo = AssetOpnameListRepo();
  AssetOpnameListBloc({required this.assetOpnameListRepo})
      : super(AssetOpnameListInitial()) {
    on<AssetOpnameListEvent>((event, emit) async {
      if (event is AssetOpnameListAttempt) {
        try {
          emit(AssetOpnameListLoading());
          final assetOpnameListResponseModel =
              await assetOpnameListRepo.attemptAssetOpnameList();
          if (assetOpnameListResponseModel!.result == 1) {
            emit(AssetOpnameListLoaded(
                assetOpnameListResponseModel: assetOpnameListResponseModel));
          } else if (assetOpnameListResponseModel.result == 0) {
            emit(AssetOpnameListError(assetOpnameListResponseModel.message));
          } else {
            emit(const AssetOpnameListException('error'));
          }
        } catch (e) {
          emit(AssetOpnameListException(e.toString()));
        }
      }
      if (event is AssetOpnameLisDetailtAttempt) {
        try {
          emit(AssetOpnameListLoading());
          final assetOpnameListDetailResponseModel = await assetOpnameListRepo
              .attemptAssetOpnameListDetail(event.code);
          if (assetOpnameListDetailResponseModel!.result == 1) {
            emit(AssetOpnameListDetailLoaded(
                assetOpnameListDetailResponseModel:
                    assetOpnameListDetailResponseModel));
          } else if (assetOpnameListDetailResponseModel.result == 0) {
            emit(AssetOpnameListError(
                assetOpnameListDetailResponseModel.message));
          } else {
            emit(const AssetOpnameListException('error'));
          }
        } catch (e) {
          emit(AssetOpnameListException(e.toString()));
        }
      }
      if (event is AssetOpnameScheduletAttempt) {
        try {
          emit(AssetOpnameListLoading());
          final assetOpnameScheduleResponseModel =
              await assetOpnameListRepo.attemptAssetOpnameSchedule(event.code);
          if (assetOpnameScheduleResponseModel!.result == 1) {
            emit(AssetOpnameShceduleLoaded(
                assetOpnameScheduleResponseModel:
                    assetOpnameScheduleResponseModel));
          } else if (assetOpnameScheduleResponseModel.result == 0) {
            emit(
                AssetOpnameListError(assetOpnameScheduleResponseModel.message));
          } else {
            emit(const AssetOpnameListException('error'));
          }
        } catch (e) {
          emit(AssetOpnameListException(e.toString()));
        }
      }

      if (event is CalendarOpnameResulttAttempt) {
        try {
          emit(AssetOpnameListLoading());
          final assetOpnameListDetailResponseModel = await assetOpnameListRepo
              .attemptCalendarOpnameResult(event.code, event.date);
          if (assetOpnameListDetailResponseModel!.result == 1) {
            emit(CalendarOpnameResultLoaded(
                assetOpnameListDetailResponseModel:
                    assetOpnameListDetailResponseModel));
          } else if (assetOpnameListDetailResponseModel.result == 0) {
            emit(AssetOpnameListError(
                assetOpnameListDetailResponseModel.message));
          } else {
            emit(const AssetOpnameListException('error'));
          }
        } catch (e) {
          emit(AssetOpnameListException(e.toString()));
        }
      }
    });
  }
}
