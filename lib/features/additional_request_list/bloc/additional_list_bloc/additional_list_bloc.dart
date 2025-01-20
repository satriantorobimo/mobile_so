import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/additional_request_list/domain/repo/additional_request_list_repo.dart';
import 'bloc.dart';

class AdditionalListBloc
    extends Bloc<AdditionalListEvent, AdditionalListState> {
  AdditionalListState get initialState => AdditionalListInitial();
  AdditionalRequestListRepo additionalRequestListRepo =
      AdditionalRequestListRepo();
  AdditionalListBloc({required this.additionalRequestListRepo})
      : super(AdditionalListInitial()) {
    on<AdditionalListEvent>((event, emit) async {
      if (event is RegisterAttempt) {
        try {
          emit(AdditionalListLoading());
          final additionalRequestListResponseModel =
              await additionalRequestListRepo.attemptAdditionalRegister();
          if (additionalRequestListResponseModel!.result == 1) {
            emit(AdditionalListLoaded(
                additionalRequestListResponseModel:
                    additionalRequestListResponseModel));
          } else if (additionalRequestListResponseModel.result == 0) {
            emit(AdditionalListError(
                additionalRequestListResponseModel.message));
          } else {
            emit(const AdditionalListException('error'));
          }
        } catch (e) {
          emit(AdditionalListException(e.toString()));
        }
      }
      if (event is SellAttempt) {
        try {
          emit(AdditionalListLoading());
          final additionalRequestListResponseModel =
              await additionalRequestListRepo.attemptAdditionalSell();
          if (additionalRequestListResponseModel!.result == 1) {
            emit(AdditionalListLoaded(
                additionalRequestListResponseModel:
                    additionalRequestListResponseModel));
          } else if (additionalRequestListResponseModel.result == 0) {
            emit(AdditionalListError(
                additionalRequestListResponseModel.message));
          } else {
            emit(const AdditionalListException('error'));
          }
        } catch (e) {
          emit(AdditionalListException(e.toString()));
        }
      }
      if (event is DisposalAttempt) {
        try {
          emit(AdditionalListLoading());
          final additionalRequestListResponseModel =
              await additionalRequestListRepo.attemptAdditionalDisposal();
          if (additionalRequestListResponseModel!.result == 1) {
            emit(AdditionalListLoaded(
                additionalRequestListResponseModel:
                    additionalRequestListResponseModel));
          } else if (additionalRequestListResponseModel.result == 0) {
            emit(AdditionalListError(
                additionalRequestListResponseModel.message));
          } else {
            emit(const AdditionalListException('error'));
          }
        } catch (e) {
          emit(AdditionalListException(e.toString()));
        }
      }
      if (event is MaintenanceAttempt) {
        try {
          emit(AdditionalListLoading());
          final additionalRequestListResponseModel =
              await additionalRequestListRepo.attemptAdditionalMaintenance();
          if (additionalRequestListResponseModel!.result == 1) {
            emit(AdditionalListLoaded(
                additionalRequestListResponseModel:
                    additionalRequestListResponseModel));
          } else if (additionalRequestListResponseModel.result == 0) {
            emit(AdditionalListError(
                additionalRequestListResponseModel.message));
          } else {
            emit(const AdditionalListException('error'));
          }
        } catch (e) {
          emit(AdditionalListException(e.toString()));
        }
      }
    });
  }
}
