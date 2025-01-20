import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/asset_opname_detail/domain/repo/asset_grow_repo.dart';

import 'bloc.dart';

class ReservedBloc extends Bloc<ReservedEvent, ReservedState> {
  ReservedState get initialState => ReservedInitial();
  AssetGrowRepo assetGrowRepo = AssetGrowRepo();
  ReservedBloc({required this.assetGrowRepo}) : super(ReservedInitial()) {
    on<ReservedEvent>((event, emit) async {
      if (event is ReservedAttempt) {
        try {
          emit(ReservedLoading());
          final generalResponseModel =
              await assetGrowRepo.attemptReserved(event.assetCode);
          if (generalResponseModel!.result == 1) {
            emit(ReservedLoaded(generalResponseModel: generalResponseModel));
          } else if (generalResponseModel.result == 0) {
            emit(ReservedError(generalResponseModel.message));
          } else {
            emit(const ReservedException('error'));
          }
        } catch (e) {
          emit(ReservedException(e.toString()));
        }
      }
    });
  }
}
