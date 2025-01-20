import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/otp_login/domain/repo/otp_repo.dart';

import 'bloc.dart';

class ResendOtpBloc extends Bloc<ResendOtpEvent, ResendOtpState> {
  ResendOtpState get initialState => ResendOtpInitial();
  OtpRepo otpRepo = OtpRepo();
  ResendOtpBloc({required this.otpRepo}) : super(ResendOtpInitial()) {
    on<ResendOtpEvent>((event, emit) async {
      if (event is ResendOtpAttempt) {
        try {
          emit(ResendOtpLoading());
          final generalResponseModel =
              await otpRepo.attemptResendOtp(event.userName);
          if (generalResponseModel!.status == 1) {
            emit(ResendOtpLoaded(generalResponseModel: generalResponseModel));
          } else if (generalResponseModel.status == 0) {
            emit(ResendOtpError(generalResponseModel.message));
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
