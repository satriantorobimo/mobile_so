import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/repo/additional_request_detail_repo.dart';

import 'bloc.dart';

class DetailViewBloc extends Bloc<DetailViewEvent, DetailViewState> {
  DetailViewState get initialState => DetailViewInitial();
  AdditionalRequestDetailRepo additionalRequestDetailRepo =
      AdditionalRequestDetailRepo();
  DetailViewBloc({required this.additionalRequestDetailRepo})
      : super(DetailViewInitial()) {
    on<DetailViewEvent>((event, emit) async {
      if (event is DetailViewRegisterAttempt) {
        try {
          emit(DetailViewLoading());
          final additionalRequestDetailRegisterResponseModel =
              await additionalRequestDetailRepo
                  .attemptRegisterDetail(event.pCode);
          if (additionalRequestDetailRegisterResponseModel!.result == 1) {
            emit(DetailViewRegisterLoaded(
                additionalRequestDetailRegisterResponseModel:
                    additionalRequestDetailRegisterResponseModel));
          } else if (additionalRequestDetailRegisterResponseModel.result == 0) {
            emit(DetailViewError(
                additionalRequestDetailRegisterResponseModel.message));
          } else {
            emit(const DetailViewException('error'));
          }
        } catch (e) {
          emit(DetailViewException(e.toString()));
        }
      }

      if (event is DetailViewSellAttempt) {
        try {
          emit(DetailViewLoading());
          final additionalRequestDetailSellResponseModel =
              await additionalRequestDetailRepo.attemptSellDetail(event.pCode);
          if (additionalRequestDetailSellResponseModel!.result == 1) {
            emit(DetailViewSellLoaded(
                additionalRequestDetailSellResponseModel:
                    additionalRequestDetailSellResponseModel));
          } else if (additionalRequestDetailSellResponseModel.result == 0) {
            emit(DetailViewError(
                additionalRequestDetailSellResponseModel.message));
          } else {
            emit(const DetailViewException('error'));
          }
        } catch (e) {
          emit(DetailViewException(e.toString()));
        }
      }

      if (event is DetailViewDisposalAttempt) {
        try {
          emit(DetailViewLoading());
          final additionalRequestDetailDisposalResponseModel =
              await additionalRequestDetailRepo
                  .attemptDisposalDetail(event.pCode);
          if (additionalRequestDetailDisposalResponseModel!.result == 1) {
            emit(DetailViewDisposalLoaded(
                additionalRequestDetailDisposalResponseModel:
                    additionalRequestDetailDisposalResponseModel));
          } else if (additionalRequestDetailDisposalResponseModel.result == 0) {
            emit(DetailViewError(
                additionalRequestDetailDisposalResponseModel.message));
          } else {
            emit(const DetailViewException('error'));
          }
        } catch (e) {
          emit(DetailViewException(e.toString()));
        }
      }

      if (event is DetailViewMaintenanceAttempt) {
        try {
          emit(DetailViewLoading());
          final additionalRequestDetailMaintenanceResponseModel =
              await additionalRequestDetailRepo
                  .attemptMaintenanceDetail(event.pCode);
          if (additionalRequestDetailMaintenanceResponseModel!.result == 1) {
            emit(DetailViewMaintenanceLoaded(
                additionalRequestDetailMaintenanceResponseModel:
                    additionalRequestDetailMaintenanceResponseModel));
          } else if (additionalRequestDetailMaintenanceResponseModel.result ==
              0) {
            emit(DetailViewError(
                additionalRequestDetailMaintenanceResponseModel.message));
          } else {
            emit(const DetailViewException('error'));
          }
        } catch (e) {
          emit(DetailViewException(e.toString()));
        }
      }

      if (event is DetailViewMutationAttempt) {
        try {
          emit(DetailViewLoading());
          final additionalRequestDetailMutationResponseModel =
              await additionalRequestDetailRepo
                  .attemptMutationDetail(event.pCode);
          if (additionalRequestDetailMutationResponseModel!.result == 1) {
            emit(DetailViewMutationLoaded(
                additionalRequestDetailMutationResponseModel:
                    additionalRequestDetailMutationResponseModel));
          } else if (additionalRequestDetailMutationResponseModel.result == 0) {
            emit(DetailViewError(
                additionalRequestDetailMutationResponseModel.message));
          } else {
            emit(const DetailViewException('error'));
          }
        } catch (e) {
          emit(DetailViewException(e.toString()));
        }
      }

      if (event is DocPreviewAttempt) {
        try {
          emit(DetailViewLoading());
          final docPreviewResponseModel = await additionalRequestDetailRepo
              .attemptDocPreview(event.pFileName, event.pFilePaths);
          if (docPreviewResponseModel!.statusCode == 200) {
            emit(DocPreviewLoaded(
                docPreviewResponseModel: docPreviewResponseModel));
          } else if (docPreviewResponseModel.statusCode != 200) {
            emit(DetailViewError(docPreviewResponseModel.message));
          } else {
            emit(const DetailViewException('error'));
          }
        } catch (e) {
          emit(DetailViewException(e.toString()));
        }
      }
    });
  }
}
