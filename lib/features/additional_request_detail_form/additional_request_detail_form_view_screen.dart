import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_so/features/additional_request_detail_form/bloc/detail_view_bloc/bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/bloc/submit_add_req_bloc/bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/bloc/upload_doc_req_bloc/bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_disposal_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_maintenance_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_mutation_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_register_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_sell_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/argument_view_add_request.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/attachment_list.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/doc_preview_request_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/repo/additional_request_detail_repo.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/repo/submit_add_req_repo.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:open_file/open_file.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

class AdditionalRequestDetailFormViewScreen extends StatefulWidget {
  const AdditionalRequestDetailFormViewScreen(
      {super.key, required this.argumentViewAddReq});

  final ArgumentViewAddReq argumentViewAddReq;

  @override
  State<AdditionalRequestDetailFormViewScreen> createState() =>
      _AdditionalRequestDetailFormViewScreenState();
}

enum Answer { internal, external }

class _AdditionalRequestDetailFormViewScreenState
    extends State<AdditionalRequestDetailFormViewScreen> {
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _remarksCtrl = TextEditingController();
  final NumberFormat _currencyFormat = NumberFormat("#,###", "id_ID");
  DetailViewBloc detailViewBloc = DetailViewBloc(
      additionalRequestDetailRepo: AdditionalRequestDetailRepo());

  bool _isFormatting = false;
  double cardRadius = 40.0;
  String selectedLocation = '';
  String selectedLocationCode = '';
  String selectedPurchaseCondition = '';
  String selectedStatus = '';
  String selectedReason = '';
  String selectedReasonCode = '';
  String selectedType = '';
  String selectedTypeCode = '';
  String selectRequest = '';
  String itemCode = '';
  String picCode = '';
  String name = '';
  String uid = '';
  bool isLoading = false;
  bool isSubmit = false;
  String assetCode = '';
  int counter = 0;
  double gainloss = 0.0;

  Map<int, Answer?> answerVal = {};

  List<AttachmentList> attachmentList = [];

  SubmitAddReqBloc submitAddReqBloc =
      SubmitAddReqBloc(submitAddReqRepo: SubmitAddReqRepo());

  UploadDocReqBloc uploadDocReqBloc =
      UploadDocReqBloc(submitAddReqRepo: SubmitAddReqRepo());

  @override
  void initState() {
    super.initState();
    _priceCtrl.addListener(_formatSellTextField);

    getUserData();
  }

  @override
  void dispose() {
    _priceCtrl.removeListener(_formatSellTextField);
    _priceCtrl.dispose();
    super.dispose();
  }

  void getUserData() async {
    await SharedPrefUtil.getSharedString('name').then((value) => name = value!);
    await SharedPrefUtil.getSharedString('uid').then((value) => uid = value!);
    if (widget.argumentViewAddReq.register) {
      setState(() {
        selectRequest = 'Register';
      });
      detailViewBloc.add(DetailViewRegisterAttempt(
          pCode: widget.argumentViewAddReq.data.requestCode!));
    } else if (widget.argumentViewAddReq.sell) {
      setState(() {
        selectRequest = 'Sell';
      });
      detailViewBloc.add(DetailViewSellAttempt(
          pCode: widget.argumentViewAddReq.data.requestCode!));
    } else if (widget.argumentViewAddReq.disposal) {
      setState(() {
        selectRequest = 'Disposal';
      });
      detailViewBloc.add(DetailViewDisposalAttempt(
          pCode: widget.argumentViewAddReq.data.requestCode!));
    } else if (widget.argumentViewAddReq.maintenance) {
      setState(() {
        selectRequest = 'Maintenance';
      });
      detailViewBloc.add(DetailViewMaintenanceAttempt(
          pCode: widget.argumentViewAddReq.data.requestCode!));
    } else {
      setState(() {
        selectRequest = 'Other';
      });
      detailViewBloc.add(DetailViewMutationAttempt(
          pCode: widget.argumentViewAddReq.data.requestCode!));
    }
    setState(() {});
  }

  int _calculateNewCursorPosition(
      String oldText, String newText, int oldCursorPosition) {
    // Count dots before cursor in old text
    final String textBeforeCursor =
        oldText.substring(0, oldCursorPosition.clamp(0, oldText.length));
    final int dotsBeforeCursor = textBeforeCursor.split('.').length - 1;

    // Calculate position in raw (unformatted) text
    final int rawPosition = oldCursorPosition - dotsBeforeCursor;

    // Find corresponding position in new formatted text
    int newPosition = 0;
    int rawCount = 0;

    for (int i = 0; i < newText.length && rawCount < rawPosition; i++) {
      if (newText[i] != '.') {
        rawCount++;
      }
      newPosition = i + 1;
    }

    return newPosition.clamp(0, newText.length);
  }

  void _formatSellTextField() {
    if (_isFormatting) return;

    _isFormatting = true;

    // Store current cursor position
    final int cursorPosition = _priceCtrl.selection.baseOffset;
    final String oldText = _priceCtrl.text;

    final String rawInput = oldText.replaceAll('.', ''); // Remove existing dots
    final int? value = int.tryParse(rawInput);

    if (value != null) {
      setState(() {});

      // Format the value for display
      final String formattedText = _currencyFormat.format(value);

      // Calculate new cursor position to preserve user's intended position
      final int newCursorPosition =
          _calculateNewCursorPosition(oldText, formattedText, cursorPosition);

      _priceCtrl.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: newCursorPosition),
      );
    } else {
      setState(() {
        // Reset if invalid input
      });
    }

    _isFormatting = false;
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
              Text('Additional Request',
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: GeneralUtil.fontSize(context) * 0.55,
                      color: Colors.white)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    height: MediaQuery.of(context).size.width * 0.23,
                    child: PrettyQrView.data(
                        data: widget.argumentViewAddReq.data.assetCode!,
                        decoration: const PrettyQrDecoration(
                          shape: PrettyQrSmoothSymbol(
                            color: Colors.white,
                          ),
                        )),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.argumentViewAddReq.register
                              ? widget.argumentViewAddReq.data.itemName!
                              : widget.argumentViewAddReq.data.assetName!,
                          style: TextStyle(
                              fontSize: GeneralUtil.fontSize(context) * 0.45,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.argumentViewAddReq.data.assetCode!,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Text(
                          widget.argumentViewAddReq.data.status!,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(
                                'PIC : ',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                name,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Request Process To',
                  style: TextStyle(
                      fontSize: GeneralUtil.fontSize(context) * 0.55,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 8.0),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
                  ),
                ),
                child: Text(
                  selectRequest,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: GeneralUtil.fontSize(context) * 0.45,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocListener(
                  bloc: detailViewBloc,
                  listener: (_, DetailViewState state) {
                    if (state is DetailViewLoading) {
                      setState(() {
                        isLoading = true;
                      });
                    }
                    if (state is DetailViewRegisterLoaded) {
                      for (var item in state
                          .additionalRequestDetailRegisterResponseModel
                          .data![0]
                          .document!) {
                        String extension = item.path!.split('.').last;
                        setState(() {
                          attachmentList.add(AttachmentList(
                              item.path!, item.fileName!, extension));
                        });
                      }
                    }
                    if (state is DetailViewSellLoaded) {
                      for (var item in state
                          .additionalRequestDetailSellResponseModel
                          .data![0]
                          .document!) {
                        String extension = item.path!.split('.').last;
                        setState(() {
                          attachmentList.add(AttachmentList(
                              item.path!, item.fileName!, extension));
                        });
                      }
                    }
                    if (state is DetailViewDisposalLoaded) {
                      for (var item in state
                          .additionalRequestDetailDisposalResponseModel
                          .data![0]
                          .document!) {
                        String extension = item.path!.split('.').last;
                        setState(() {
                          attachmentList.add(AttachmentList(
                              item.path!, item.fileName!, extension));
                        });
                      }
                    }
                    if (state is DetailViewMaintenanceLoaded) {
                      for (var item in state
                          .additionalRequestDetailMaintenanceResponseModel
                          .data![0]
                          .document!) {
                        String extension = item.path!.split('.').last;
                        setState(() {
                          attachmentList.add(AttachmentList(
                              item.path!, item.fileName!, extension));
                        });
                      }
                    }
                    if (state is DetailViewMutationLoaded) {
                      for (var item in state
                          .additionalRequestDetailMutationResponseModel
                          .data![0]
                          .document!) {
                        String extension = item.path!.split('.').last;
                        setState(() {
                          attachmentList.add(AttachmentList(
                              item.path!, item.fileName!, extension));
                        });
                      }
                    }
                    if (state is DetailViewError) {
                      GeneralUtil().showSnackBarError(context, state.error!);
                      setState(() {
                        isLoading = false;
                      });
                    }
                    if (state is DetailViewException) {
                      setState(() {
                        isLoading = false;
                      });
                      if (state.error.toLowerCase() == 'unauthorized access') {
                        GeneralUtil()
                            .showSnackBarError(context, 'Session Expired');
                        var bottomBarProvider =
                            Provider.of<NavbarProvider>(context, listen: false);
                        bottomBarProvider.setPage(0);
                        bottomBarProvider.setTab(0);
                        SharedPrefUtil.clearSharedPref();
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              StringRouterUtil.loginScreenRoute,
                              (route) => false);
                        });
                      } else {
                        GeneralUtil().showSnackBarError(context, state.error);
                      }
                    }
                  },
                  child: BlocBuilder(
                      bloc: detailViewBloc,
                      builder: (context, DetailViewState state) {
                        if (state is DetailViewLoading) {
                          return const Center(
                            child: SizedBox(
                              width: 45,
                              height: 45,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (state is DetailViewRegisterLoaded) {
                          return formRegister(state
                              .additionalRequestDetailRegisterResponseModel);
                        }
                        if (state is DetailViewSellLoaded) {
                          return formSell(
                              state.additionalRequestDetailSellResponseModel);
                        }
                        if (state is DetailViewDisposalLoaded) {
                          return formDisposal(state
                              .additionalRequestDetailDisposalResponseModel);
                        }
                        if (state is DetailViewMaintenanceLoaded) {
                          return formMaintenance(state
                              .additionalRequestDetailMaintenanceResponseModel);
                        }
                        if (state is DetailViewMutationLoaded) {
                          return formMutation(state
                              .additionalRequestDetailMutationResponseModel);
                        }

                        return const Center(
                          child: SizedBox(
                            width: 45,
                            height: 45,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      })),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'File Uploaded',
                  style: TextStyle(
                      fontSize: GeneralUtil.fontSize(context) * 0.55,
                      color: Colors.white),
                ),
              ),
              attachmentList.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(color: Colors.white)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Text(attachmentList[index].fileName,
                                    style: TextStyle(
                                        fontSize:
                                            GeneralUtil.fontSize(context) *
                                                0.45,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Row(
                                children: [
                                  attachmentList[index]
                                                  .fileType
                                                  .toLowerCase() ==
                                              'pdf' ||
                                          attachmentList[
                                                      index]
                                                  .fileType
                                                  .toLowerCase() ==
                                              'jpg' ||
                                          attachmentList[index]
                                                  .fileType
                                                  .toLowerCase() ==
                                              'png' ||
                                          attachmentList[index]
                                                  .fileType
                                                  .toLowerCase() ==
                                              'jpeg'
                                      ? InkWell(
                                          onTap: () async {
                                            if (attachmentList[index]
                                                    .fileType
                                                    .toLowerCase() ==
                                                'pdf') {
                                              Navigator.pushNamed(
                                                  context,
                                                  StringRouterUtil
                                                      .docPreviewNetworkPdfScreenRoute,
                                                  arguments:
                                                      DocPreviewRequestModel(
                                                          pFileName:
                                                              attachmentList[
                                                                      index]
                                                                  .fileName,
                                                          pFilePaths:
                                                              attachmentList[
                                                                      index]
                                                                  .filePath));
                                            } else if (attachmentList[index]
                                                        .fileType
                                                        .toLowerCase() ==
                                                    'jpg' ||
                                                attachmentList[index]
                                                        .fileType
                                                        .toLowerCase() ==
                                                    'png' ||
                                                attachmentList[index]
                                                        .fileType
                                                        .toLowerCase() ==
                                                    'jpeg') {
                                              Navigator.pushNamed(
                                                  context,
                                                  StringRouterUtil
                                                      .docPreviewNetworkScreenRoute,
                                                  arguments:
                                                      DocPreviewRequestModel(
                                                          pFileName:
                                                              attachmentList[
                                                                      index]
                                                                  .fileName,
                                                          pFilePaths:
                                                              attachmentList[
                                                                      index]
                                                                  .filePath));
                                            } else {}
                                          },
                                          child: const Icon(
                                            Icons.preview_rounded,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Container(),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 12);
                      },
                      itemCount: attachmentList.length)
                  : Container(),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget formSell(AdditionalRequestDetailSellResponseModel data) {
    _remarksCtrl.text = data.data![0].remarks!;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Reason',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            data.data![0].reasonName!,
            style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Net Book Value',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            GeneralUtil.convertToIdr(data.data![0].netBookValueComm, 2),
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Selling Price',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            GeneralUtil.convertToIdr(data.data![0].sellingPrice, 2),
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Gain / Loss',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            GeneralUtil.convertToIdr(
                data.data![0].sellingPrice! - data.data![0].netBookValueComm!,
                2),
            style: TextStyle(
              color: gainloss < 0 ? Colors.red : Colors.green,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Remarks',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: _remarksCtrl,
          maxLength: 500,
          minLines: 3,
          maxLines: 10,
          readOnly: true,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            counterStyle: TextStyle(color: Color(0xFFE6E7E8)),
            isDense: true,
            contentPadding: EdgeInsets.only(bottom: 16),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE6E7E8)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE6E7E8)),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget formRegister(AdditionalRequestDetailRegisterResponseModel data) {
    _remarksCtrl.text = data.data![0].remarks!;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Item',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            data.data![0].itemName!,
            style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Purchase Condition',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            data.data![0].purchaseCondition!,
            style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'PIC',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            data.data![0].picName!,
            style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Remarks',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: _remarksCtrl,
          maxLength: 500,
          minLines: 3,
          maxLines: 10,
          readOnly: true,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            counterStyle: TextStyle(color: Color(0xFFE6E7E8)),
            isDense: true,
            contentPadding: EdgeInsets.only(bottom: 16),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE6E7E8)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE6E7E8)),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }

  Widget formDisposal(AdditionalRequestDetailDisposalResponseModel data) {
    _remarksCtrl.text = data.data![0].remarks!;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Reason',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            data.data![0].reasonTypeName!,
            style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Purchase Price',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            GeneralUtil.convertToIdr(data.data![0].purchasePrice, 2),
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Total Depre. Comm.',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            GeneralUtil.convertToIdr(data.data![0].totalDepreComm, 2),
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Net Book Value',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            GeneralUtil.convertToIdr(data.data![0].netBookValueComm, 2),
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Requestor',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            '${data.data![0].requestorName} - ${data.data![0].requestorCode}',
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Remarks',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: _remarksCtrl,
          maxLength: 500,
          minLines: 3,
          maxLines: 10,
          readOnly: true,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            counterStyle: TextStyle(color: Color(0xFFE6E7E8)),
            isDense: true,
            contentPadding: EdgeInsets.only(bottom: 16),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE6E7E8)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE6E7E8)),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }

  Widget formMaintenance(AdditionalRequestDetailMaintenanceResponseModel data) {
    _remarksCtrl.text = data.data![0].remarks!;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Asset Name',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            data.data![0].assetName!,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Serial No',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            data.data![0].assetCode!,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Location',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            data.data![0].locationName!,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Maintenance By',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            data.data![0].maintenanceBy!,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Type of Service',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            data.data![0].serviceName!,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Requestor',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            '${data.data![0].requestorName} - ${data.data![0].requestorCode}',
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Remarks *',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: _remarksCtrl,
          maxLength: 500,
          minLines: 3,
          maxLines: 10,
          readOnly: true,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            counterStyle: TextStyle(color: Color(0xFFE6E7E8)),
            isDense: true,
            contentPadding: EdgeInsets.only(bottom: 16),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE6E7E8)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE6E7E8)),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }

  Widget formMutation(AdditionalRequestDetailMutationResponseModel data) {
    _remarksCtrl.text = data.data![0].remarks!;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Asset Name',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            data.data![0].assetName!,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        // const Align(
        //   alignment: Alignment.centerLeft,
        //   child: Text(
        //     'FA Type & Category',
        //     style: TextStyle( fontSize:
        // GeneralUtil.fontSize(context) *
        //     0.55, color: Colors.white),
        //   ),
        // ),
        // const SizedBox(
        //   height: 8,
        // ),
        // Container(
        //   width: double.infinity,
        //   padding: EdgeInsets.only(bottom: 8.0),
        //   decoration: const BoxDecoration(
        //     border: Border(
        //       bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
        //     ),
        //   ),
        //   child: Text(
        //     data.data![0].!,
        //     style: TextStyle(
        //       color: Colors.grey,
        //       fontFamily: GoogleFonts.poppins().fontFamily,
        //        fontSize:
        // GeneralUtil.fontSize(context) *
        //     0.45,
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   height: 16,
        // ),
        // const Align(
        //   alignment: Alignment.centerLeft,
        //   child: Text(
        //     'Location',
        //     style: TextStyle( fontSize:
        // GeneralUtil.fontSize(context) *
        //     0.55, color: Colors.white),
        //   ),
        // ),
        // const SizedBox(
        //   height: 8,
        // ),
        // Container(
        //   width: double.infinity,
        //   padding: EdgeInsets.only(bottom: 8.0),
        //   decoration: const BoxDecoration(
        //     border: Border(
        //       bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
        //     ),
        //   ),
        //   child: Text(
        //     data.data![0].locationName!,
        //     style: TextStyle(
        //       color: Colors.grey,
        //       fontFamily: GoogleFonts.poppins().fontFamily,
        //        fontSize:
        // GeneralUtil.fontSize(context) *
        //     0.45,
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   height: 16,
        // ),
        // const Align(
        //   alignment: Alignment.centerLeft,
        //   child: Text(
        //     'Maintenance By',
        //     style: TextStyle( fontSize:
        // GeneralUtil.fontSize(context) *
        //     0.55, color: Colors.white),
        //   ),
        // ),
        // const SizedBox(
        //   height: 8,
        // ),
        // Container(
        //   width: double.infinity,
        //   padding: EdgeInsets.only(bottom: 8.0),
        //   decoration: const BoxDecoration(
        //     border: Border(
        //       bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
        //     ),
        //   ),
        //   child: Text(
        //     data.data![0].maintenanceBy!,
        //     style: TextStyle(
        //       color: Colors.grey,
        //       fontFamily: GoogleFonts.poppins().fontFamily,
        //        fontSize:
        // GeneralUtil.fontSize(context) *
        //     0.45,
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   height: 16,
        // ),
        // const Align(
        //   alignment: Alignment.centerLeft,
        //   child: Text(
        //     'Type of Service',
        //     style: TextStyle( fontSize:
        // GeneralUtil.fontSize(context) *
        //     0.55, color: Colors.white),
        //   ),
        // ),
        // const SizedBox(
        //   height: 8,
        // ),
        // Container(
        //   width: double.infinity,
        //   padding: EdgeInsets.only(bottom: 8.0),
        //   decoration: const BoxDecoration(
        //     border: Border(
        //       bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
        //     ),
        //   ),
        //   child: Text(
        //     data.data![0].serviceName!,
        //     style: TextStyle(
        //       color: Colors.grey,
        //       fontFamily: GoogleFonts.poppins().fontFamily,
        //        fontSize:
        // GeneralUtil.fontSize(context) *
        //     0.45,
        //     ),
        //   ),
        // ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Mutation To',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            '${data.data![0].toPicCode} - ${data.data![0].toPicName}',
            style: TextStyle(
              color: Colors.grey,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Remarks *',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: _remarksCtrl,
          maxLength: 500,
          minLines: 3,
          maxLines: 10,
          readOnly: true,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            counterStyle: TextStyle(color: Color(0xFFE6E7E8)),
            isDense: true,
            contentPadding: EdgeInsets.only(bottom: 16),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE6E7E8)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE6E7E8)),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
