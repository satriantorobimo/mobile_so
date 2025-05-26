import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/repo/dd_repo.dart';
import 'bloc.dart';

class DDPicMutationBloc extends Bloc<DDPicMutationEvent, DDPicMutationState> {
  DDPicMutationState get initialState => DDPicMutationInitial();
  DropDownRepo dropDownRepo = DropDownRepo();
  DDPicMutationBloc({required this.dropDownRepo})
      : super(DDPicMutationInitial()) {
    on<DDPicMutationEvent>((event, emit) async {
      if (event is DDPicMutationAttempt) {
        try {
          emit(DDPicMutationLoading());
          final dropDownPicMutation =
              await dropDownRepo.attemptDDPicMutation(event.action);
          if (dropDownPicMutation!.result == 1) {
            emit(DDPicMutationLoaded(dropDownPicMutation: dropDownPicMutation));
          } else if (dropDownPicMutation.result == 0) {
            emit(DDPicMutationError(dropDownPicMutation.message));
          } else {
            emit(const DDPicMutationException('error'));
          }
        } catch (e) {
          emit(DDPicMutationException(e.toString()));
        }
      }
    });
  }
}
