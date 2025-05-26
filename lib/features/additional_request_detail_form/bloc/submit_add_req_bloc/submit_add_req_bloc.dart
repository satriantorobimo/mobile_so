import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/repo/submit_add_req_repo.dart';

import 'bloc.dart';

class SubmitAddReqBloc extends Bloc<SubmitAddReqEvent, SubmitAddReqState> {
  SubmitAddReqState get initialState => SubmitAddReqInitial();
  SubmitAddReqRepo submitAddReqRepo = SubmitAddReqRepo();
  SubmitAddReqBloc({required this.submitAddReqRepo})
      : super(SubmitAddReqInitial()) {
    on<SubmitAddReqEvent>((event, emit) async {
      if (event is SubmitAddReqAttempt) {
        try {
          emit(SubmitAddReqLoading());
          final generalResponseModel =
              await submitAddReqRepo.attemptSubmit(event.submitRequestModel);
          if (generalResponseModel!.result == 1) {
            emit(
                SubmitAddReqLoaded(generalResponseModel: generalResponseModel));
          } else if (generalResponseModel.result == 0) {
            emit(SubmitAddReqError(generalResponseModel.message));
          } else {
            emit(const SubmitAddReqException('error'));
          }
        } catch (e) {
          emit(SubmitAddReqException(e.toString()));
        }
      }
      if (event is SubmitAdditionalAttempt) {
        try {
          emit(SubmitAddReqLoading());
          final generalResponseModel = await submitAddReqRepo
              .attemptSubmitAdditional(event.submitRequestModel);
          if (generalResponseModel!.result == 1) {
            emit(
                SubmitAddReqLoaded(generalResponseModel: generalResponseModel));
          } else if (generalResponseModel.result == 0) {
            emit(SubmitAddReqError(generalResponseModel.message));
          } else {
            emit(const SubmitAddReqException('error'));
          }
        } catch (e) {
          emit(SubmitAddReqException(e.toString()));
        }
      }
      if (event is SubmitAdditionalSellAttempt) {
        try {
          emit(SubmitAddReqLoading());
          final generalResponseModel = await submitAddReqRepo
              .attemptSubmitAdditionalSell(event.submitRequestModel);
          if (generalResponseModel!.result == 1) {
            emit(
                SubmitAddReqLoaded(generalResponseModel: generalResponseModel));
          } else if (generalResponseModel.result == 0) {
            emit(SubmitAddReqError(generalResponseModel.message));
          } else {
            emit(const SubmitAddReqException('error'));
          }
        } catch (e) {
          emit(SubmitAddReqException(e.toString()));
        }
      }
      if (event is SubmitAdditionalMaintenanceAttempt) {
        try {
          emit(SubmitAddReqLoading());
          final generalResponseModel = await submitAddReqRepo
              .attemptSubmitAdditionalMaintenance(event.submitRequestModel);
          if (generalResponseModel!.result == 1) {
            emit(
                SubmitAddReqLoaded(generalResponseModel: generalResponseModel));
          } else if (generalResponseModel.result == 0) {
            emit(SubmitAddReqError(generalResponseModel.message));
          } else {
            emit(const SubmitAddReqException('error'));
          }
        } catch (e) {
          emit(SubmitAddReqException(e.toString()));
        }
      }
      if (event is SubmitAdditionalMutationAttempt) {
        try {
          emit(SubmitAddReqLoading());
          final generalResponseModel = await submitAddReqRepo
              .attemptSubmitAdditionalMutation(event.submitRequestModel);
          if (generalResponseModel!.result == 1) {
            emit(
                SubmitAddReqLoaded(generalResponseModel: generalResponseModel));
          } else if (generalResponseModel.result == 0) {
            emit(SubmitAddReqError(generalResponseModel.message));
          } else {
            emit(const SubmitAddReqException('error'));
          }
        } catch (e) {
          emit(SubmitAddReqException(e.toString()));
        }
      }
    });
  }
}
