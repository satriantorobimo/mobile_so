import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/repo/dd_repo.dart';

import 'bloc.dart';

class DDTosBloc extends Bloc<DDTosEvent, DDTosState> {
  DDTosState get initialState => DDTosInitial();
  DropDownRepo dropDownRepo = DropDownRepo();
  DDTosBloc({required this.dropDownRepo}) : super(DDTosInitial()) {
    on<DDTosEvent>((event, emit) async {
      if (event is DDTosAttempt) {
        try {
          emit(DDTosLoading());
          final dropDownTosModel =
              await dropDownRepo.attemptDDTos(event.assetCode);
          if (dropDownTosModel!.result == 1) {
            emit(DDTosLoaded(dropDownTosModel: dropDownTosModel));
          } else if (dropDownTosModel.result == 0) {
            emit(DDTosError(dropDownTosModel.message));
          } else {
            emit(const DDTosException('error'));
          }
        } catch (e) {
          emit(DDTosException(e.toString()));
        }
      }
    });
  }
}
