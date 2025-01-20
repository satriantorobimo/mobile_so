import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/asset_opname_detail_form/domain/repo/opname_submit_repo.dart';

import 'bloc.dart';

class DDConditionBloc extends Bloc<DDConditionEvent, DDConditionState> {
  DDConditionState get initialState => DDConditionInitial();
  OpnameSubmitRepo opnameSubmitRepo = OpnameSubmitRepo();
  DDConditionBloc({required this.opnameSubmitRepo}) : super(DDConditionInitial()) {
    on<DDConditionEvent>((event, emit) async {
      if (event is DDConditionAttempt) {
        try {
          emit(DDConditionLoading());
          final dropDownModel =
              await opnameSubmitRepo.attemptDdlCondition();
          if (dropDownModel!.result == 1) {
            emit(DDConditionLoaded(dropDownModel: dropDownModel));
          } else if (dropDownModel.result == 0) {
            emit(DDConditionError(dropDownModel.message));
          } else {
            emit(const DDConditionException('error'));
          }
        } catch (e) {
          emit(DDConditionException(e.toString()));
        }
      }
    });
  }
}
