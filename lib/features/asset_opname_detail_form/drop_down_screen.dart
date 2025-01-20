import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/additional_request_detail_form/bloc/dd_employee_bloc/bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/bloc/dd_item_bloc/bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/bloc/dd_pc_bloc/bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/bloc/dd_reason_bloc/bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/bloc/dd_reason_bloc/dd_reason_bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/bloc/dd_tos_bloc/bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_employee.dart'
    as employee;
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_item_model.dart'
    as item;

import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_model.dart'
    as pc;
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_tos_mdel.dart'
    as tos;
import 'package:mobile_so/features/additional_request_detail_form/domain/repo/dd_repo.dart';
import 'package:mobile_so/features/asset_opname_detail_form/bloc/dd_condition_bloc/bloc.dart';
import 'package:mobile_so/features/asset_opname_detail_form/bloc/dd_location_bloc/bloc.dart';
import 'package:mobile_so/features/asset_opname_detail_form/bloc/dd_pic_bloc/bloc.dart';
import 'package:mobile_so/features/asset_opname_detail_form/bloc/dd_status_bloc/bloc.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/ddl_location_response_model.dart'
    as loc;
import 'package:mobile_so/features/asset_opname_detail_form/data/ddl_request_screen.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/ddl_status_response_model.dart'
    as stat;
import 'package:mobile_so/features/asset_opname_detail_form/domain/repo/opname_submit_repo.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class DropDownScreen extends StatefulWidget {
  const DropDownScreen({super.key, required this.ddlRequestScreen});

  final DdlRequestScreen ddlRequestScreen;

  @override
  State<DropDownScreen> createState() => _DropDownScreenState();
}

class _DropDownScreenState extends State<DropDownScreen> {
  bool isLoading = true;

  List<String> request = ['Sell', 'Register', 'Disposal', 'Maintenance'];
  List<String> reason = ['Broken'];
  List<String> type = ['Maintenance 5000km'];

  List<String> status = ['Available - Used'];

  DDItemBloc ddItemBloc = DDItemBloc(dropDownRepo: DropDownRepo());
  DDpcBloc dDpcBloc = DDpcBloc(dropDownRepo: DropDownRepo());
  DDemployeeBloc dDemployeeBloc = DDemployeeBloc(dropDownRepo: DropDownRepo());
  DDLocationBloc ddLocationBloc =
      DDLocationBloc(opnameSubmitRepo: OpnameSubmitRepo());
  DDConditionBloc ddConditionBloc =
      DDConditionBloc(opnameSubmitRepo: OpnameSubmitRepo());
  DDStatusBloc ddStatusBloc =
      DDStatusBloc(opnameSubmitRepo: OpnameSubmitRepo());
  DDPicBloc ddPicBloc = DDPicBloc(opnameSubmitRepo: OpnameSubmitRepo());
  DDReasonBloc ddReasonBloc = DDReasonBloc(dropDownRepo: DropDownRepo());
  DDTosBloc ddTosBloc = DDTosBloc(dropDownRepo: DropDownRepo());

  List<item.Data> dropDownItemModel = [];
  List<pc.Data> dropDownModel = [];
  List<employee.Data> dropDownEmployeeModel = [];
  List<item.Data> dropDownItemModelTemp = [];
  List<pc.Data> dropDownModelTemp = [];
  List<employee.Data> dropDownEmployeeModelTemp = [];
  List<loc.Data> dropDownLocationModelTemp = [];
  List<stat.Data> dropDownStatusModelTemp = [];
  List<employee.Data> dropDownPicModel = [];
  List<pc.Data> dropDownConditionModelTemp = [];
  List<loc.Data> dropDownLocationModel = [];
  List<stat.Data> dropDownStatusModel = [];
  List<employee.Data> dropDownPicModelTemp = [];
  List<pc.Data> dropDownConditionModel = [];
  List<pc.Data> dropDownReasonModel = [];
  List<pc.Data> dropDownReasonModelTemp = [];
  List<tos.Data> dropDownTosModel = [];
  List<tos.Data> dropDownTosModelTemp = [];

  @override
  void initState() {
    if (widget.ddlRequestScreen.title == 'item') {
      ddItemBloc.add(const DDItemAttempt(action: 'default'));
    } else if (widget.ddlRequestScreen.title == 'employee') {
      dDemployeeBloc.add(const DDemployeeAttempt(action: 'default'));
    } else if (widget.ddlRequestScreen.title == 'location') {
      ddLocationBloc.add(DDLocationAttempt());
    } else if (widget.ddlRequestScreen.title == 'condition') {
      ddConditionBloc.add(DDConditionAttempt());
    } else if (widget.ddlRequestScreen.title == 'status') {
      ddStatusBloc.add(DDStatusAttempt());
    } else if (widget.ddlRequestScreen.title == 'pic') {
      ddPicBloc.add(DDPicAttempt(action: 'default'));
    } else if (widget.ddlRequestScreen.title == 'reason') {
      ddReasonBloc.add(DDReasonAttempt(
          action: widget.ddlRequestScreen.source == 'Sell'
              ? 'M0001326'
              : 'M0001318'));
    } else if (widget.ddlRequestScreen.title == 'tos') {
      ddTosBloc
          .add(DDTosAttempt(assetCode: widget.ddlRequestScreen.assetCode!));
    } else {
      dDpcBloc.add(const DDpcAttempt(action: 'SGC.2410.00007'));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF130139),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.06,
                left: 16.0,
                right: 16.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                    widget.ddlRequestScreen.title == 'pc'
                        ? 'Purchase Condition'
                        : widget.ddlRequestScreen.title == 'item'
                            ? toBeginningOfSentenceCase(
                                widget.ddlRequestScreen.title)
                            : widget.ddlRequestScreen.title == 'employee' ||
                                    widget.ddlRequestScreen.title == 'pic'
                                ? 'PIC'
                                : widget.ddlRequestScreen.title == 'tos'
                                    ? 'Type of Service'
                                    : toBeginningOfSentenceCase(
                                        widget.ddlRequestScreen.title),
                    style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 20,
                        color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              elevation: 6,
              shadowColor: Colors.grey.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(width: 1.0, color: Color(0xFFEAEAEA))),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      if (widget.ddlRequestScreen.title == 'item') {
                        dropDownItemModelTemp = dropDownItemModel
                            .where((item) => item.itemName!
                                .toUpperCase()
                                .contains(value.toUpperCase()))
                            .toList();
                      } else if (widget.ddlRequestScreen.title == 'employee') {
                        dropDownEmployeeModelTemp = dropDownEmployeeModel
                            .where((item) => item.employeeName!
                                .toUpperCase()
                                .contains(value.toUpperCase()))
                            .toList();
                      } else if (widget.ddlRequestScreen.title == 'pic') {
                        dropDownPicModelTemp = dropDownPicModel
                            .where((item) => item.employeeName!
                                .toUpperCase()
                                .contains(value.toUpperCase()))
                            .toList();
                      } else if (widget.ddlRequestScreen.title == 'location') {
                        dropDownLocationModelTemp = dropDownLocationModel
                            .where((item) => item.branchName!
                                .toUpperCase()
                                .contains(value.toUpperCase()))
                            .toList();
                      } else if (widget.ddlRequestScreen.title == 'condition') {
                        dropDownConditionModelTemp = dropDownConditionModel
                            .where((item) => item.description!
                                .toUpperCase()
                                .contains(value.toUpperCase()))
                            .toList();
                      } else if (widget.ddlRequestScreen.title == 'status') {
                        dropDownStatusModelTemp = dropDownStatusModel
                            .where((item) => item.status!
                                .toUpperCase()
                                .contains(value.toUpperCase()))
                            .toList();
                      } else if (widget.ddlRequestScreen.title == 'reason') {
                        dropDownReasonModelTemp = dropDownReasonModel
                            .where((item) => item.description!
                                .toUpperCase()
                                .contains(value.toUpperCase()))
                            .toList();
                      } else if (widget.ddlRequestScreen.title == 'tos') {
                        dropDownTosModelTemp = dropDownTosModel
                            .where((item) => item.description!
                                .toUpperCase()
                                .contains(value.toUpperCase()))
                            .toList();
                      } else {
                        dropDownModelTemp = dropDownModel
                            .where((item) => item.description!
                                .toUpperCase()
                                .contains(value.toUpperCase()))
                            .toList();
                      }
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Search',
                      contentPadding: const EdgeInsets.only(top: 32, left: 16),
                      hintStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.grey.withOpacity(0.5)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      )),
                ),
              ),
            ),
          ),
          MultiBlocListener(
            listeners: [
              BlocListener(
                bloc: ddTosBloc,
                listener: (_, DDTosState state) {
                  if (state is DDTosLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  if (state is DDTosLoaded) {
                    setState(() {
                      isLoading = false;
                      dropDownTosModel = state.dropDownTosModel.data!;
                      dropDownTosModelTemp = state.dropDownTosModel.data!;
                    });
                  }
                  if (state is DDTosError) {
                    GeneralUtil().showSnackBarError(context, state.error!);
                    setState(() {
                      isLoading = false;
                    });
                  }
                  if (state is DDTosException) {
                    GeneralUtil().showSnackBarError(context, state.error);
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
              BlocListener(
                bloc: ddReasonBloc,
                listener: (_, DDReasonState state) {
                  if (state is DDReasonLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  if (state is DDReasonLoaded) {
                    setState(() {
                      isLoading = false;
                      dropDownReasonModel = state.downItemModel.data!;
                      dropDownReasonModelTemp = state.downItemModel.data!;
                    });
                  }
                  if (state is DDReasonError) {
                    GeneralUtil().showSnackBarError(context, state.error!);
                    setState(() {
                      isLoading = false;
                    });
                  }
                  if (state is DDReasonException) {
                    GeneralUtil().showSnackBarError(context, state.error);
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
              BlocListener(
                bloc: ddItemBloc,
                listener: (_, DDItemState state) {
                  if (state is DDItemLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  if (state is DDItemLoaded) {
                    setState(() {
                      isLoading = false;
                      dropDownItemModel = state.downItemModel.data!;
                      dropDownItemModelTemp = state.downItemModel.data!;
                    });
                  }
                  if (state is DDItemError) {
                    GeneralUtil().showSnackBarError(context, state.error!);
                    setState(() {
                      isLoading = false;
                    });
                  }
                  if (state is DDItemException) {
                    GeneralUtil().showSnackBarError(context, state.error);
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
              BlocListener(
                bloc: dDpcBloc,
                listener: (_, DDpcState state) {
                  if (state is DDpcLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  if (state is DDpcLoaded) {
                    setState(() {
                      isLoading = false;
                      dropDownModel = state.dropDownModel.data!;
                      dropDownModelTemp = state.dropDownModel.data!;
                    });
                  }
                  if (state is DDpcError) {
                    GeneralUtil().showSnackBarError(context, state.error!);
                    setState(() {
                      isLoading = false;
                    });
                  }
                  if (state is DDpcException) {
                    GeneralUtil().showSnackBarError(context, state.error);
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
              BlocListener(
                bloc: dDemployeeBloc,
                listener: (_, DDemployeeState state) {
                  if (state is DDemployeeLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  if (state is DDemployeeLoaded) {
                    setState(() {
                      isLoading = false;
                      dropDownEmployeeModel = state.dropDownEmployee.data!;
                      dropDownEmployeeModelTemp = state.dropDownEmployee.data!;
                    });
                  }
                  if (state is DDemployeeError) {
                    GeneralUtil().showSnackBarError(context, state.error!);
                    setState(() {
                      isLoading = false;
                    });
                  }
                  if (state is DDemployeeException) {
                    GeneralUtil().showSnackBarError(context, state.error);
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
              BlocListener(
                bloc: ddLocationBloc,
                listener: (_, DDLocationState state) {
                  if (state is DDLocationLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  if (state is DDLocationLoaded) {
                    setState(() {
                      isLoading = false;
                      dropDownLocationModel =
                          state.ddlLocationResponseModel.data!;
                      dropDownLocationModelTemp =
                          state.ddlLocationResponseModel.data!;
                    });
                  }
                  if (state is DDLocationError) {
                    GeneralUtil().showSnackBarError(context, state.error!);
                    setState(() {
                      isLoading = false;
                    });
                  }
                  if (state is DDLocationException) {
                    GeneralUtil().showSnackBarError(context, state.error);
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
              BlocListener(
                bloc: ddConditionBloc,
                listener: (_, DDConditionState state) {
                  if (state is DDConditionLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  if (state is DDConditionLoaded) {
                    setState(() {
                      isLoading = false;
                      dropDownConditionModel = state.dropDownModel.data!;
                      dropDownConditionModelTemp = state.dropDownModel.data!;
                    });
                  }
                  if (state is DDConditionError) {
                    GeneralUtil().showSnackBarError(context, state.error!);
                    setState(() {
                      isLoading = false;
                    });
                  }
                  if (state is DDConditionException) {
                    GeneralUtil().showSnackBarError(context, state.error);
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
              BlocListener(
                bloc: ddStatusBloc,
                listener: (_, DDStatusState state) {
                  if (state is DDStatusLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  if (state is DDStatusLoaded) {
                    setState(() {
                      isLoading = false;
                      dropDownStatusModel = state.ddlStatusResponseModel.data!;
                      dropDownStatusModelTemp =
                          state.ddlStatusResponseModel.data!;
                    });
                  }
                  if (state is DDStatusError) {
                    GeneralUtil().showSnackBarError(context, state.error!);
                    setState(() {
                      isLoading = false;
                    });
                  }
                  if (state is DDStatusException) {
                    GeneralUtil().showSnackBarError(context, state.error);
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
              BlocListener(
                bloc: ddPicBloc,
                listener: (_, DDPicState state) {
                  if (state is DDPicLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  if (state is DDPicLoaded) {
                    setState(() {
                      isLoading = false;
                      dropDownPicModel = state.dropDownEmployee.data!;
                      dropDownPicModelTemp = state.dropDownEmployee.data!;
                    });
                  }
                  if (state is DDPicError) {
                    GeneralUtil().showSnackBarError(context, state.error!);
                    setState(() {
                      isLoading = false;
                    });
                  }
                  if (state is DDPicException) {
                    GeneralUtil().showSnackBarError(context, state.error);
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              )
            ],
            child: isLoading
                ? const Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : dropDownItemModelTemp.isEmpty &&
                        dropDownTosModelTemp.isEmpty &&
                        dropDownModelTemp.isEmpty &&
                        dropDownReasonModelTemp.isEmpty &&
                        dropDownEmployeeModelTemp.isEmpty &&
                        dropDownLocationModelTemp.isEmpty &&
                        dropDownConditionModelTemp.isEmpty &&
                        dropDownStatusModelTemp.isEmpty &&
                        dropDownPicModelTemp.isEmpty &&
                        widget.ddlRequestScreen.title != 'Request' &&
                        widget.ddlRequestScreen.title != 'Reason'
                    ? Container()
                    : Expanded(
                        child: ListView.separated(
                            separatorBuilder: (BuildContext context,
                                int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, bottom: 16),
                                child: Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey.withOpacity(0.6),
                                ),
                              );
                            },
                            itemCount: widget.ddlRequestScreen.title == 'item'
                                ? dropDownItemModelTemp.isNotEmpty
                                    ? dropDownItemModelTemp.length
                                    : dropDownItemModel.length
                                : widget.ddlRequestScreen.title == 'pc'
                                    ? dropDownModelTemp.isNotEmpty
                                        ? dropDownModelTemp.length
                                        : dropDownModel.length
                                    : widget.ddlRequestScreen.title == 'reason'
                                        ? dropDownReasonModelTemp.isNotEmpty
                                            ? dropDownReasonModelTemp.length
                                            : dropDownReasonModel.length
                                        : widget.ddlRequestScreen.title ==
                                                'employee'
                                            ? dropDownEmployeeModelTemp
                                                    .isNotEmpty
                                                ? dropDownEmployeeModelTemp
                                                    .length
                                                : dropDownEmployeeModel.length
                                            : widget.ddlRequestScreen.title ==
                                                    'location'
                                                ? dropDownLocationModelTemp
                                                        .isNotEmpty
                                                    ? dropDownLocationModelTemp
                                                        .length
                                                    : dropDownLocationModel
                                                        .length
                                                : widget.ddlRequestScreen
                                                            .title ==
                                                        'condition'
                                                    ? dropDownConditionModelTemp
                                                            .isNotEmpty
                                                        ? dropDownConditionModelTemp
                                                            .length
                                                        : dropDownConditionModel
                                                            .length
                                                    : widget.ddlRequestScreen
                                                                .title ==
                                                            'status'
                                                        ? dropDownStatusModelTemp
                                                                .isNotEmpty
                                                            ? dropDownStatusModelTemp
                                                                .length
                                                            : dropDownStatusModel
                                                                .length
                                                        : widget.ddlRequestScreen
                                                                    .title ==
                                                                'pic'
                                                            ? dropDownPicModelTemp
                                                                    .isNotEmpty
                                                                ? dropDownPicModelTemp
                                                                    .length
                                                                : dropDownPicModel
                                                                    .length
                                                            : widget.ddlRequestScreen
                                                                        .title ==
                                                                    'Request'
                                                                ? request.length
                                                                : widget.ddlRequestScreen
                                                                            .title ==
                                                                        'Reason'
                                                                    ? reason
                                                                        .length
                                                                    : widget.ddlRequestScreen.title ==
                                                                            'tos'
                                                                        ? dropDownTosModelTemp
                                                                                .isNotEmpty
                                                                            ? dropDownTosModelTemp
                                                                                .length
                                                                            : dropDownTosModel
                                                                                .length
                                                                        : status
                                                                            .length,
                            padding: const EdgeInsets.only(
                                left: 24.0, right: 24.0, bottom: 16, top: 16),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, {
                                    'value': widget.ddlRequestScreen.title ==
                                            'item'
                                        ? dropDownItemModelTemp.isNotEmpty
                                            ? dropDownItemModelTemp[index]
                                                .itemName
                                            : dropDownItemModel[index].itemName
                                        : widget.ddlRequestScreen.title == 'pc'
                                            ? dropDownModelTemp.isNotEmpty
                                                ? dropDownModelTemp[index]
                                                    .description
                                                : dropDownModel[index]
                                                    .description
                                            : widget.ddlRequestScreen.title ==
                                                    'reason'
                                                ? dropDownReasonModelTemp
                                                        .isNotEmpty
                                                    ? dropDownReasonModelTemp[index]
                                                        .description
                                                    : dropDownReasonModel[index]
                                                        .description
                                                : widget.ddlRequestScreen.title ==
                                                        'employee'
                                                    ? dropDownEmployeeModelTemp
                                                            .isNotEmpty
                                                        ? dropDownEmployeeModelTemp[index]
                                                            .employeeName
                                                        : dropDownEmployeeModel[index]
                                                            .employeeName
                                                    : widget.ddlRequestScreen.title ==
                                                            'location'
                                                        ? dropDownLocationModelTemp
                                                                .isNotEmpty
                                                            ? '${dropDownLocationModelTemp[index].branchName}  - ${dropDownLocationModelTemp[index].locationName}'
                                                            : dropDownEmployeeModel[index]
                                                                .employeeName
                                                        : widget.ddlRequestScreen
                                                                    .title ==
                                                                'condition'
                                                            ? dropDownConditionModelTemp
                                                                    .isNotEmpty
                                                                ? dropDownConditionModelTemp[index]
                                                                    .description
                                                                : dropDownConditionModel[index]
                                                                    .description
                                                            : widget.ddlRequestScreen
                                                                        .title ==
                                                                    'status'
                                                                ? dropDownStatusModelTemp
                                                                        .isNotEmpty
                                                                    ? dropDownStatusModelTemp[index]
                                                                        .status
                                                                    : dropDownStatusModel[index].status
                                                                : widget.ddlRequestScreen.title == 'pic'
                                                                    ? dropDownPicModelTemp.isNotEmpty
                                                                        ? dropDownPicModelTemp[index].employeeName
                                                                        : dropDownPicModel[index].employeeName
                                                                    : widget.ddlRequestScreen.title == 'Request'
                                                                        ? request[index]
                                                                        : widget.ddlRequestScreen.title == 'Reason'
                                                                            ? reason[index]
                                                                            : widget.ddlRequestScreen.title == 'tos'
                                                                                ? dropDownTosModelTemp.isNotEmpty
                                                                                    ? dropDownTosModelTemp[index].description
                                                                                    : dropDownTosModel[index].description!
                                                                                : status[index],
                                    'code': widget.ddlRequestScreen.title ==
                                            'item'
                                        ? dropDownItemModelTemp.isNotEmpty
                                            ? dropDownItemModelTemp[index]
                                                .itemCode
                                            : dropDownItemModel[index].itemCode
                                        : widget.ddlRequestScreen.title == 'pc'
                                            ? dropDownModelTemp.isNotEmpty
                                                ? dropDownModelTemp[index].code
                                                : dropDownModel[index].code
                                            : widget.ddlRequestScreen.title ==
                                                    'reason'
                                                ? dropDownReasonModelTemp
                                                        .isNotEmpty
                                                    ? dropDownReasonModelTemp[index]
                                                        .code
                                                    : dropDownReasonModel[index]
                                                        .code
                                                : widget.ddlRequestScreen.title ==
                                                        'location'
                                                    ? dropDownLocationModelTemp
                                                            .isNotEmpty
                                                        ? dropDownLocationModelTemp[index]
                                                            .locationCode
                                                        : dropDownLocationModel[index]
                                                            .locationCode
                                                    : widget.ddlRequestScreen.title ==
                                                            'condition'
                                                        ? dropDownConditionModelTemp
                                                                .isNotEmpty
                                                            ? dropDownConditionModelTemp[index]
                                                                .code
                                                            : dropDownConditionModel[index]
                                                                .code
                                                        : widget.ddlRequestScreen
                                                                    .title ==
                                                                'status'
                                                            ? dropDownStatusModelTemp
                                                                    .isNotEmpty
                                                                ? dropDownStatusModelTemp[index]
                                                                    .code
                                                                : dropDownStatusModel[index]
                                                                    .code
                                                            : widget.ddlRequestScreen
                                                                        .title ==
                                                                    'employee'
                                                                ? dropDownEmployeeModelTemp
                                                                        .isNotEmpty
                                                                    ? dropDownEmployeeModelTemp[index]
                                                                        .employeeCode
                                                                    : dropDownEmployeeModel[index]
                                                                        .employeeCode
                                                                : widget.ddlRequestScreen.title == 'pic'
                                                                    ? dropDownPicModelTemp.isNotEmpty
                                                                        ? dropDownPicModelTemp[index].employeeCode
                                                                        : dropDownPicModel[index].employeeCode
                                                                    : widget.ddlRequestScreen.title == 'tos'
                                                                        ? dropDownTosModelTemp.isNotEmpty
                                                                            ? dropDownTosModelTemp[index].serviceCode
                                                                            : dropDownTosModel[index].serviceCode!
                                                                        : ''
                                  });
                                },
                                child: Text(
                                  widget.ddlRequestScreen.title == 'item'
                                      ? dropDownItemModelTemp.isNotEmpty
                                          ? dropDownItemModelTemp[index]
                                              .itemName!
                                          : dropDownItemModel[index].itemName!
                                      : widget.ddlRequestScreen.title == 'pc'
                                          ? dropDownModelTemp.isNotEmpty
                                              ? dropDownModelTemp[index]
                                                  .description!
                                              : dropDownModel[index]
                                                  .description!
                                          : widget.ddlRequestScreen.title ==
                                                  'reason'
                                              ? dropDownReasonModelTemp
                                                      .isNotEmpty
                                                  ? dropDownReasonModelTemp[index]
                                                      .description!
                                                  : dropDownReasonModel[index]
                                                      .description!
                                              : widget.ddlRequestScreen.title ==
                                                      'employee'
                                                  ? dropDownEmployeeModelTemp
                                                          .isNotEmpty
                                                      ? dropDownEmployeeModelTemp[index]
                                                          .employeeName!
                                                      : dropDownEmployeeModel[index]
                                                          .employeeName!
                                                  : widget.ddlRequestScreen
                                                              .title ==
                                                          'location'
                                                      ? dropDownLocationModelTemp
                                                              .isNotEmpty
                                                          ? '${dropDownLocationModelTemp[index].branchName!} - ${dropDownLocationModelTemp[index].locationName!}'
                                                          : '${dropDownLocationModel[index].branchName!} - ${dropDownLocationModel[index].locationName!}'
                                                      : widget.ddlRequestScreen
                                                                  .title ==
                                                              'condition'
                                                          ? dropDownConditionModelTemp
                                                                  .isNotEmpty
                                                              ? dropDownConditionModelTemp[index]
                                                                  .description!
                                                              : dropDownConditionModel[index]
                                                                  .description!
                                                          : widget.ddlRequestScreen
                                                                      .title ==
                                                                  'status'
                                                              ? dropDownStatusModelTemp
                                                                      .isNotEmpty
                                                                  ? dropDownStatusModelTemp[index]
                                                                      .status!
                                                                  : dropDownStatusModel[
                                                                          index]
                                                                      .status!
                                                              : widget.ddlRequestScreen
                                                                          .title ==
                                                                      'pic'
                                                                  ? dropDownPicModelTemp
                                                                          .isNotEmpty
                                                                      ? dropDownPicModelTemp[index]
                                                                          .employeeName!
                                                                      : dropDownPicModel[index]
                                                                          .employeeName!
                                                                  : widget.ddlRequestScreen.title ==
                                                                          'Request'
                                                                      ? request[index]
                                                                      : widget.ddlRequestScreen.title == 'Reason'
                                                                          ? reason[index]
                                                                          : widget.ddlRequestScreen.title == 'tos'
                                                                              ? dropDownTosModelTemp.isNotEmpty
                                                                                  ? dropDownTosModelTemp[index].description!
                                                                                  : dropDownTosModel[index].description!
                                                                              : status[index],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }),
                      ),
          ),
        ]));
  }
}
