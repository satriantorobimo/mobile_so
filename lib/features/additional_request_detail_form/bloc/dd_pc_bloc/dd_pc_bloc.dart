import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/repo/dd_repo.dart';

import 'bloc.dart';

class DDpcBloc extends Bloc<DDpcEvent, DDpcState> {
  DDpcState get initialState => DDpcInitial();
  DropDownRepo dropDownRepo = DropDownRepo();
  DDpcBloc({required this.dropDownRepo}) : super(DDpcInitial()) {
    on<DDpcEvent>((event, emit) async {
      if (event is DDpcAttempt) {
        try {
          emit(DDpcLoading());
          final dropDownModel =
              await dropDownRepo.attemptDDPurchaseCondition(event.action);
          if (dropDownModel!.result == 1) {
            emit(DDpcLoaded(dropDownModel: dropDownModel));
          } else if (dropDownModel.result == 0) {
            emit(DDpcError(dropDownModel.message));
          } else {
            emit(const DDpcException('error'));
          }
        } catch (e) {
          emit(DDpcException(e.toString()));
        }
      }
    });
  }
}
