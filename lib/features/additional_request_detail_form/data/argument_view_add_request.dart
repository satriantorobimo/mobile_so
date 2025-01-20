import 'package:mobile_so/features/additional_request_list/data/additional_request_list_response_model.dart';

class ArgumentViewAddReq {
  bool register = false;
  bool sell = false;
  bool disposal = false;
  bool maintenance = false;
  bool other = false;
  Data data;

  ArgumentViewAddReq(
      {required this.register,
      required this.sell,
      required this.disposal,
      required this.maintenance,
      required this.other,
      required this.data});
}
