import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/otp_login/domain/repo/otp_repo.dart';

import 'bloc.dart';

class ValidateOtpBloc extends Bloc<ValidateOtpEvent, ValidateOtpState> {
  ValidateOtpState get initialState => ValidateOtpInitial();
  OtpRepo otpRepo = OtpRepo();
  ValidateOtpBloc({required this.otpRepo}) : super(ValidateOtpInitial()) {
    on<ValidateOtpEvent>((event, emit) async {
      if (event is ValidateOtpAttempt) {
        try {
          emit(ValidateOtpLoading());
          final loginResponseModel =
              await otpRepo.attemptValidateOtp(event.otpValidateRequestModel);
          if (loginResponseModel!.status == 1) {
            emit(ValidateOtpLoaded(loginResponseModel: loginResponseModel));
          } else if (loginResponseModel.status == 0) {
            emit(ValidateOtpError(loginResponseModel.message));
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
