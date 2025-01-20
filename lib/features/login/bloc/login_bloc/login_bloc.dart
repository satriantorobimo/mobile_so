import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/login/domain/repo/login_repo.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginState get initialState => LoginInitial();
  LoginRepo loginRepo = LoginRepo();
  LoginBloc({required this.loginRepo}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginAttempt) {
        try {
          emit(LoginLoading());
          final generalResponseModel =
              await loginRepo.attemptLogin(event.loginRequestModel);
          if (generalResponseModel!.status == 1) {
            emit(LoginLoaded(generalResponseModel: generalResponseModel));
          } else if (generalResponseModel.status == 0) {
            emit(LoginError(generalResponseModel.message));
          } else {
            emit(const LoginException('error'));
          }
        } catch (e) {
          emit(LoginException(e.toString()));
        }
      }
    });
  }
}
