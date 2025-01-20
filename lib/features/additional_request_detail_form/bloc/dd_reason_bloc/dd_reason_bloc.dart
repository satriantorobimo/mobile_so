import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/repo/dd_repo.dart';

import 'bloc.dart';

class DDReasonBloc extends Bloc<DDReasonEvent, DDReasonState> {
  DDReasonState get initialState => DDReasonInitial();
  DropDownRepo dropDownRepo = DropDownRepo();
  DDReasonBloc({required this.dropDownRepo}) : super(DDReasonInitial()) {
    on<DDReasonEvent>((event, emit) async {
      if (event is DDReasonAttempt) {
        try {
          emit(DDReasonLoading());
          final downItemModel = await dropDownRepo.attemptDDReason(event.action);
          if (downItemModel!.result == 1) {
            emit(DDReasonLoaded(downItemModel: downItemModel));
          } else if (downItemModel.result == 0) {
            emit(DDReasonError(downItemModel.message));
          } else {
            emit(const DDReasonException('error'));
          }
        } catch (e) {
          emit(DDReasonException(e.toString()));
        }
      }
    });
  }
}
