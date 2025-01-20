import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/repo/dd_repo.dart';
import 'package:mobile_so/features/asset_opname_detail_form/domain/repo/opname_submit_repo.dart';

import 'bloc.dart';

class DDPicBloc extends Bloc<DDPicEvent, DDPicState> {
  DDPicState get initialState => DDPicInitial();
  OpnameSubmitRepo opnameSubmitRepo = OpnameSubmitRepo();
  DDPicBloc({required this.opnameSubmitRepo}) : super(DDPicInitial()) {
    on<DDPicEvent>((event, emit) async {
      if (event is DDPicAttempt) {
        try {
          emit(DDPicLoading());
          final dropDownEmployee =
              await opnameSubmitRepo.attemptDdlEmployee(event.action);
          if (dropDownEmployee!.result == 1) {
            emit(DDPicLoaded(dropDownEmployee: dropDownEmployee));
          } else if (dropDownEmployee.result == 0) {
            emit(DDPicError(dropDownEmployee.message));
          } else {
            emit(const DDPicException('error'));
          }
        } catch (e) {
          emit(DDPicException(e.toString()));
        }
      }
    });
  }
}
