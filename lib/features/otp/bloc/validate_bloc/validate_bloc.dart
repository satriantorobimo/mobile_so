import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/otp/domain/repo/otp_repo.dart';

import 'bloc.dart';

class ValidateOtpBloc extends Bloc<ValidateOtpEvent, ValidateOtpState> {
  ValidateOtpState get initialState => ValidateOtpInitial();
  OtpRepo otpRepo = OtpRepo();
  ValidateOtpBloc({required this.otpRepo}) : super(ValidateOtpInitial()) {
    on<ValidateOtpEvent>((event, emit) async {
      if (event is ValidateOtpAttempt) {
        try {
          emit(ValidateOtpLoading());
          final changePasswordResponseModel =
              await otpRepo.attemptValidateOtp(event.otpValidateRequestModel);
          if (changePasswordResponseModel!.result == 1) {
            emit(ValidateOtpLoaded(
                changePasswordResponseModel: changePasswordResponseModel));
          } else if (changePasswordResponseModel.result == 0) {
            emit(ValidateOtpError(changePasswordResponseModel.message));
          } else {
            emit(const ValidateOtpException('error'));
          }
        } catch (e) {
          emit(ValidateOtpException(e.toString()));
        }
      }
    });
  }
}
