import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/otp/domain/repo/otp_repo.dart';

import 'bloc.dart';

class ResendOtpBloc extends Bloc<ResendOtpEvent, ResendOtpState> {
  ResendOtpState get initialState => ResendOtpInitial();
  OtpRepo otpRepo = OtpRepo();
  ResendOtpBloc({required this.otpRepo}) : super(ResendOtpInitial()) {
    on<ResendOtpEvent>((event, emit) async {
      if (event is ResendOtpAttempt) {
        try {
          emit(ResendOtpLoading());
          final changePasswordResponseModel =
              await otpRepo.attemptResendOtp(event.userName);
          if (changePasswordResponseModel!.result == 1) {
            emit(ResendOtpLoaded(
                changePasswordResponseModel: changePasswordResponseModel));
          } else if (changePasswordResponseModel.result == 0) {
            emit(ResendOtpError(changePasswordResponseModel.message));
          } else {
            emit(const ResendOtpException('error'));
          }
        } catch (e) {
          emit(ResendOtpException(e.toString()));
        }
      }
    });
  }
}
