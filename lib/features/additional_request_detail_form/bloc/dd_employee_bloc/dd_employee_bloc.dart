import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/repo/dd_repo.dart';

import 'bloc.dart';

class DDemployeeBloc extends Bloc<DDemployeeEvent, DDemployeeState> {
  DDemployeeState get initialState => DDemployeeInitial();
  DropDownRepo dropDownRepo = DropDownRepo();
  DDemployeeBloc({required this.dropDownRepo}) : super(DDemployeeInitial()) {
    on<DDemployeeEvent>((event, emit) async {
      if (event is DDemployeeAttempt) {
        try {
          emit(DDemployeeLoading());
          final dropDownEmployee =
              await dropDownRepo.attemptDDEmployee(event.action);
          if (dropDownEmployee!.result == 1) {
            emit(DDemployeeLoaded(dropDownEmployee: dropDownEmployee));
          } else if (dropDownEmployee.result == 0) {
            emit(DDemployeeError(dropDownEmployee.message));
          } else {
            emit(const DDemployeeException('error'));
          }
        } catch (e) {
          emit(DDemployeeException(e.toString()));
        }
      }
    });
  }
}
