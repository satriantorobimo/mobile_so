import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/email_otp/domain/repo/change_password_repo.dart';

import 'bloc.dart';

class ReqChangePasswordBloc
    extends Bloc<ReqChangePasswordEvent, ReqChangePasswordState> {
  ReqChangePasswordState get initialState => ReqChangePasswordInitial();
  ChangePasswordRepo changePasswordRepo = ChangePasswordRepo();
  ReqChangePasswordBloc({required this.changePasswordRepo})
      : super(ReqChangePasswordInitial()) {
    on<ReqChangePasswordEvent>((event, emit) async {
      if (event is ReqChangePasswordAttempt) {
        try {
          emit(ReqChangePasswordLoading());
          final changePasswordResponseModel =
              await changePasswordRepo.attemptReqChangePassword(event.userName);
          if (changePasswordResponseModel!.result == 1) {
            emit(ReqChangePasswordLoaded(
                changePasswordResponseModel: changePasswordResponseModel));
          } else if (changePasswordResponseModel.result == 0) {
            emit(ReqChangePasswordError(changePasswordResponseModel.message));
          } else {
            emit(const ReqChangePasswordException('error'));
          }
        } catch (e) {
          emit(ReqChangePasswordException(e.toString()));
        }
      }
    });
  }
}
