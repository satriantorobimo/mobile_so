import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/repo/submit_add_req_repo.dart';
import 'package:mobile_so/features/asset_opname_detail_form/domain/repo/opname_submit_repo.dart';

import 'bloc.dart';

class UploadDocOpnameBloc extends Bloc<UploadDocOpnameEvent, UploadDocOpnameState> {
  UploadDocOpnameState get initialState => UploadDocOpnameInitial();
  OpnameSubmitRepo opnameSubmitRepo = OpnameSubmitRepo();
  UploadDocOpnameBloc({required this.opnameSubmitRepo})
      : super(UploadDocOpnameInitial()) {
    on<UploadDocOpnameEvent>((event, emit) async {
      if (event is UploadDocOpnameAttempt) {
        try {
          emit(UploadDocOpnameLoading());
          final generalResponseModel =
              await opnameSubmitRepo.attemptUpload(event.uploadDocRequestModelModel, event.opnameCode);
          if (generalResponseModel!.result == 1) {
            emit(
                UploadDocOpnameLoaded(generalResponseModel: generalResponseModel));
          } else if (generalResponseModel.result == 0) {
            emit(UploadDocOpnameError(generalResponseModel.message));
          } else {
            emit(const UploadDocOpnameException('error'));
          }
        } catch (e) {
          emit(UploadDocOpnameException(e.toString()));
        }
      }
    });
  }
}
