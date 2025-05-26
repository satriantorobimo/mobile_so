import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/asset_opname_detail/domain/repo/asset_grow_repo.dart';

import 'bloc.dart';

class PrintBloc extends Bloc<PrintEvent, PrintState> {
  PrintState get initialState => PrintInitial();
  AssetGrowRepo assetGrowRepo = AssetGrowRepo();
  PrintBloc({required this.assetGrowRepo}) : super(PrintInitial()) {
    on<PrintEvent>((event, emit) async {
      if (event is PrintAttempt) {
        try {
          emit(PrintLoading());
          final generalResponseModel =
              await assetGrowRepo.attemptPrint(event.assetCode);
          if (generalResponseModel!.result == 1) {
            emit(PrintLoaded(generalResponseModel: generalResponseModel));
          } else if (generalResponseModel.result == 0) {
            emit(PrintError(generalResponseModel.message));
          } else {
            emit(const PrintException('error'));
          }
        } catch (e) {
          emit(PrintException(e.toString()));
        }
      }
    });
  }
}
