import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/asset_opname_detail_form/domain/repo/opname_submit_repo.dart';

import 'bloc.dart';

class SubmitOpnameBloc extends Bloc<SubmitOpnameEvent, SubmitOpnameState> {
  SubmitOpnameState get initialState => SubmitOpnameInitial();
  OpnameSubmitRepo opnameSubmitRepo = OpnameSubmitRepo();
  SubmitOpnameBloc({required this.opnameSubmitRepo})
      : super(SubmitOpnameInitial()) {
    on<SubmitOpnameEvent>((event, emit) async {
      if (event is SubmitOpnameAttempt) {
        try {
          emit(SubmitOpnameLoading());
          final generalResponseModel =
              await opnameSubmitRepo.attemptSubmit(event.submitOpnameRequestModel);
          if (generalResponseModel!.result == 1) {
            emit(
                SubmitOpnameLoaded(generalResponseModel: generalResponseModel));
          } else if (generalResponseModel.result == 0) {
            emit(SubmitOpnameError(generalResponseModel.message));
          } else {
            emit(const SubmitOpnameException('error'));
          }
        } catch (e) {
          emit(SubmitOpnameException(e.toString()));
        }
      }
    });
  }
}
