import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/asset_opname_detail_form/domain/repo/opname_submit_repo.dart';

import 'bloc.dart';

class OpnameResultBloc extends Bloc<OpnameResultEvent, OpnameResultState> {
  OpnameResultState get initialState => OpnameResultInitial();
  OpnameSubmitRepo opnameSubmitRepo = OpnameSubmitRepo();
  OpnameResultBloc({required this.opnameSubmitRepo})
      : super(OpnameResultInitial()) {
    on<OpnameResultEvent>((event, emit) async {
      if (event is OpnameResultAttempt) {
        try {
          emit(OpnameResultLoading());
          final opnameResultResponseModel = await opnameSubmitRepo
              .attemptOpnameResult(event.argumentsViewModel);
          if (opnameResultResponseModel!.result == 1) {
            emit(OpnameResultLoaded(
                opnameResultResponseModel: opnameResultResponseModel));
          } else if (opnameResultResponseModel.result == 0) {
            emit(OpnameResultError(opnameResultResponseModel.message));
          } else {
            emit(const OpnameResultException('error'));
          }
        } catch (e) {
          emit(OpnameResultException(e.toString()));
        }
      }
    });
  }
}
