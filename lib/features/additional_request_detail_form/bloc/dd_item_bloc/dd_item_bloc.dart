import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/repo/dd_repo.dart';

import 'bloc.dart';

class DDItemBloc extends Bloc<DDItemEvent, DDItemState> {
  DDItemState get initialState => DDItemInitial();
  DropDownRepo dropDownRepo = DropDownRepo();
  DDItemBloc({required this.dropDownRepo}) : super(DDItemInitial()) {
    on<DDItemEvent>((event, emit) async {
      if (event is DDItemAttempt) {
        try {
          emit(DDItemLoading());
          final downItemModel = await dropDownRepo.attemptDDItem(event.action);
          if (downItemModel!.result == 1) {
            emit(DDItemLoaded(downItemModel: downItemModel));
          } else if (downItemModel.result == 0) {
            emit(DDItemError(downItemModel.message));
          } else {
            emit(const DDItemException('error'));
          }
        } catch (e) {
          emit(DDItemException(e.toString()));
        }
      }
    });
  }
}
