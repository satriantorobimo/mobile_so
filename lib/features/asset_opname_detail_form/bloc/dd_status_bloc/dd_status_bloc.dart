import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/asset_opname_detail_form/domain/repo/opname_submit_repo.dart';
import 'bloc.dart';

class DDStatusBloc extends Bloc<DDStatusEvent, DDStatusState> {
  DDStatusState get initialState => DDStatusInitial();
  OpnameSubmitRepo opnameSubmitRepo = OpnameSubmitRepo();
  DDStatusBloc({required this.opnameSubmitRepo}) : super(DDStatusInitial()) {
    on<DDStatusEvent>((event, emit) async {
      if (event is DDStatusAttempt) {
        try {
          emit(DDStatusLoading());
          final ddlStatusResponseModel =
              await opnameSubmitRepo.attemptDdlStatus();
          if (ddlStatusResponseModel!.result == 1) {
            emit(DDStatusLoaded(ddlStatusResponseModel: ddlStatusResponseModel));
          } else if (ddlStatusResponseModel.result == 0) {
            emit(DDStatusError(ddlStatusResponseModel.message));
          } else {
            emit(const DDStatusException('error'));
          }
        } catch (e) {
          emit(DDStatusException(e.toString()));
        }
      }
    });
  }
}
