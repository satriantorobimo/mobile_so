import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/email_otp/domain/repo/change_password_repo.dart';

import 'bloc.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordState get initialState => ChangePasswordInitial();
  ChangePasswordRepo changePasswordRepo = ChangePasswordRepo();
  ChangePasswordBloc({required this.changePasswordRepo})
      : super(ChangePasswordInitial()) {
    on<ChangePasswordEvent>((event, emit) async {
      if (event is ChangePasswordAttempt) {
        try {
          emit(ChangePasswordLoading());
          final changePasswordResponseModel = await changePasswordRepo
              .attemptChangePassword(event.changePasswordRequestModel);
          if (changePasswordResponseModel!.result == 1) {
            emit(ChangePasswordLoaded(
                changePasswordResponseModel: changePasswordResponseModel));
          } else if (changePasswordResponseModel.result == 0) {
            emit(ChangePasswordError(changePasswordResponseModel.message));
          } else {
            emit(const ChangePasswordException('error'));
          }
        } catch (e) {
          emit(ChangePasswordException(e.toString()));
        }
      }
    });
  }
}
