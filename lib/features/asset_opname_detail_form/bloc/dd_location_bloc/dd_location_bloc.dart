import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/asset_opname_detail_form/domain/repo/opname_submit_repo.dart';

import 'bloc.dart';

class DDLocationBloc extends Bloc<DDLocationEvent, DDLocationState> {
  DDLocationState get initialState => DDLocationInitial();
  OpnameSubmitRepo opnameSubmitRepo = OpnameSubmitRepo();
  DDLocationBloc({required this.opnameSubmitRepo}) : super(DDLocationInitial()) {
    on<DDLocationEvent>((event, emit) async {
      if (event is DDLocationAttempt) {
        try {
          emit(DDLocationLoading());
          final ddlLocationResponseModel =
              await opnameSubmitRepo.attemptDdlLocation();
          if (ddlLocationResponseModel!.result == 1) {
            emit(DDLocationLoaded(ddlLocationResponseModel: ddlLocationResponseModel));
          } else if (ddlLocationResponseModel.result == 0) {
            emit(DDLocationError(ddlLocationResponseModel.message));
          } else {
            emit(const DDLocationException('error'));
          }
        } catch (e) {
          emit(DDLocationException(e.toString()));
        }
      }
    });
  }
}
