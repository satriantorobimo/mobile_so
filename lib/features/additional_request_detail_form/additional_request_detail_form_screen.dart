import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_so/features/additional_request_detail_form/asset_not_found_widget.dart';
import 'package:mobile_so/features/additional_request_detail_form/bloc/submit_add_req_bloc/bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/bloc/upload_doc_req_bloc/bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/argument_add_request.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/attachment_list.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/submit_request_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/upload_doc_request_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/domain/repo/submit_add_req_repo.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/ddl_request_screen.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/map_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

class AdditionalRequestDetailFormScreen extends StatefulWidget {
  const AdditionalRequestDetailFormScreen(
      {super.key, required this.argumentAddReq});

  final ArgumentAddReq argumentAddReq;

  @override
  State<AdditionalRequestDetailFormScreen> createState() =>
      _AdditionalRequestDetailFormScreenState();
}

enum Answer { internal, external }

class _AdditionalRequestDetailFormScreenState
    extends State<AdditionalRequestDetailFormScreen> {
  final TextEditingController _picCtrl = TextEditingController();
  final TextEditingController _assetNameCtrl = TextEditingController();
  final TextEditingController _serialNoCtrl = TextEditingController();
  final TextEditingController _warrantyCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _totalCtrl = TextEditingController();
  final TextEditingController _netCtrl = TextEditingController();
  final TextEditingController _requestorCtrl = TextEditingController();
  final TextEditingController _remarksCtrl = TextEditingController();
  final NumberFormat _currencyFormat = NumberFormat("#,###", "id_ID");

  int? _tempValue;
  bool _isFormatting = false;
  double cardRadius = 40.0;
  String selectedLocation = '';
  String selectedLocationCode = '';
  String selectedMutation = '';
  String selectedMutationCode = '';
  String selectedPurchaseCondition = '';
  String selectedStatus = '';
  String selectedReason = '';
  String selectedReasonCode = '';
  String selectedType = '';
  String selectedTypeCode = '';
  String selectRequest = '';
  String itemCode = '';
  String picCode = '';
  String picName = '';
  String name = '';
  String uid = '';
  String assetName = '';
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

  Future<void> _showBottomAttachment(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 24.0, left: 16, right: 16),
                  child: Text(
                    'Select Options',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: GeneralUtil.fontSize(context) * 0.55,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: InkWell(
                      onTap: () {
                        pickImage().then((value) {
                          if (value == 'big') {
                            GeneralUtil()
                                .showSnackBarError(context, 'Size Maximal 2MB');
                          }
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        'Gallery',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: GeneralUtil.fontSize(context) * 0.55,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: InkWell(
                      onTap: () {
                        pickFile().then((value) {
                          if (value == 'big') {
                            GeneralUtil()
                                .showSnackBarError(context, 'Size Maximal 2MB');
                          }
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        'File Explorer',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: GeneralUtil.fontSize(context) * 0.55,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
                const SizedBox(height: 24),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _priceCtrl.addListener(_formatSellTextField);
    log('${widget.argumentAddReq}');
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
    if (widget.argumentAddReq.register) {
      setState(() {
        selectRequest = 'Register';
      });
    } else if (widget.argumentAddReq.sell) {
      setState(() {
        selectRequest = 'Sell';
      });
    } else if (widget.argumentAddReq.disposal) {
      setState(() {
        selectRequest = 'Disposal';
      });
    } else if (widget.argumentAddReq.maintenance) {
      setState(() {
        selectRequest = 'Maintenance';
      });
    } else if (widget.argumentAddReq.mutation) {
      setState(() {
        selectRequest = 'Mutation';
      });
    } else {
      setState(() {
        selectRequest = 'Other';
      });
    }
    setState(() {});
  }

  void _formatSellTextField() {
    if (_isFormatting) return;

    _isFormatting = true;
    final String rawInput =
        _priceCtrl.text.replaceAll('.', ''); // Remove existing dots
    final int? value = int.tryParse(rawInput);

    if (value != null) {
      setState(() {
        _tempValue = value; // Save raw value
      });

      // Format the value for display
      final String formattedText = _currencyFormat.format(value);
      _priceCtrl.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    } else {
      setState(() {
        _tempValue = null; // Reset if invalid input
      });
    }

    _isFormatting = false;
  }

  Future<String> pickFile() async {
    var maxFileSizeInBytes = 2 * 1048576;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png', 'doc', 'docx'],
    );

    if (result != null) {
      var fileSize = result.files.first.size;
      if (fileSize <= maxFileSizeInBytes) {
        String filePath = result.files.single.path!;
        String basename = path.basename(filePath);
        final ext = path.extension(basename);
        setState(() {
          attachmentList.add(AttachmentList(filePath, basename, ext));
        });
      } else {
        return 'big';
      }
      return 'yes';
    } else {
      return 'notselect';
    }
  }

  Future<String> pickImage() async {
    try {
      var maxFileSizeInBytes = 2 * 1048576;
      ImagePicker imagePicker = ImagePicker();
      XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );
      if (pickedImage == null) return 'notselect';

      var imagePath = await pickedImage.readAsBytes();
      var fileSize = imagePath.length; // Get the file size in bytes
      if (fileSize <= maxFileSizeInBytes) {
        String basename = path.basename(pickedImage.path);
        final ext = path.extension(basename);
        setState(() {
          attachmentList.add(AttachmentList(pickedImage.path, basename, ext));
        });
      } else {
        return 'big';
      }

      return 'yes';
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
      return 'notselect';
    }
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
                      fontSize: GeneralUtil.fontSize(context) * 0.6,
                      color: Colors.white)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shrinkWrap: true,
            children: [
              widget.argumentAddReq.register
                  ? const Center(
                      child: AssetNotFoundContainer(),
                    )
                  : Stack(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.23,
                              height: MediaQuery.of(context).size.width * 0.23,
                              child: PrettyQrView.data(
                                  data: widget.argumentAddReq
                                      .assetGrowResponseModel.data![0].barcode!,
                                  decoration: const PrettyQrDecoration(
                                    shape: PrettyQrSmoothSymbol(
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    widget.argumentAddReq.assetGrowResponseModel
                                        .data![0].itemName!,
                                    style: TextStyle(
                                        fontSize:
                                            GeneralUtil.fontSize(context) * 0.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  widget.argumentAddReq.assetGrowResponseModel
                                      .data![0].code!,
                                  style: TextStyle(
                                      fontSize:
                                          GeneralUtil.fontSize(context) * 0.45,
                                      color: Colors.white),
                                ),
                                Text(
                                  '${widget.argumentAddReq.assetGrowResponseModel.data![0].status!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].condition!}',
                                  style: TextStyle(
                                      fontSize:
                                          GeneralUtil.fontSize(context) * 0.45,
                                      color: Colors.white),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.165,
                                      child: Text(
                                        'Location : ',
                                        style: TextStyle(
                                            fontSize:
                                                GeneralUtil.fontSize(context) *
                                                    0.45,
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Text(
                                        '${widget.argumentAddReq.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].locationName!}',
                                        style: TextStyle(
                                            fontSize:
                                                GeneralUtil.fontSize(context) *
                                                    0.45,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.08,
                                      child: Text(
                                        'PIC : ',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Text(
                                        widget
                                            .argumentAddReq
                                            .assetGrowResponseModel
                                            .data![0]
                                            .picName!,
                                        style: TextStyle(
                                            fontSize:
                                                GeneralUtil.fontSize(context) *
                                                    0.45,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                          right: 8,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {
                              MapUtil.openMap(
                                  double.parse(widget
                                      .argumentAddReq
                                      .assetGrowResponseModel
                                      .data![0]
                                      .latitude!),
                                  double.parse(widget
                                      .argumentAddReq
                                      .assetGrowResponseModel
                                      .data![0]
                                      .longitude!),
                                  widget.argumentAddReq.assetGrowResponseModel
                                      .data![0].locationName!);
                            },
                            child: Image.asset(
                              'assets/imgs/map.png',
                              width: 40,
                            ),
                          ),
                        )
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
                height: 45,
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
                    fontSize: GeneralUtil.fontSize(context) * 0.5,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              selectRequest == 'Sell'
                  ? formSell()
                  : selectRequest == 'Register'
                      ? formRegister()
                      : selectRequest == 'Disposal'
                          ? formDisposal()
                          : selectRequest == 'Maintenance'
                              ? formMaintenance()
                              : selectRequest == 'Mutation'
                                  ? formMutation()
                                  : Container(),
              GestureDetector(
                onTap: () {
                  _showBottomAttachment(context);
                },
                child: DottedBorder(
                  color: const Color(0xFFE6E7E8).withOpacity(0.5),
                  strokeWidth: 2,
                  radius: Radius.circular(cardRadius),
                  dashPattern: const [10, 5],
                  customPath: (size) {
                    return Path()
                      ..moveTo(cardRadius, 0)
                      ..lineTo(size.width - cardRadius, 0)
                      ..arcToPoint(Offset(size.width, cardRadius),
                          radius: Radius.circular(cardRadius))
                      ..lineTo(size.width, size.height - cardRadius)
                      ..arcToPoint(Offset(size.width - cardRadius, size.height),
                          radius: Radius.circular(cardRadius))
                      ..lineTo(cardRadius, size.height)
                      ..arcToPoint(Offset(0, size.height - cardRadius),
                          radius: Radius.circular(cardRadius))
                      ..lineTo(0, cardRadius)
                      ..arcToPoint(Offset(cardRadius, 0),
                          radius: Radius.circular(cardRadius));
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.cloud_upload_rounded,
                          size: 60,
                          color: Color(0xFF7FE8EB),
                        ),
                        Text('Attach you file here!',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ),
              attachmentList.isNotEmpty
                  ? const SizedBox(
                      height: 8,
                    )
                  : Container(),
              attachmentList.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(color: Colors.white)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Text(attachmentList[index].fileName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            GeneralUtil.fontSize(context) *
                                                0.45,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Row(
                                children: [
                                  attachmentList[index].fileType == '.pdf' ||
                                          attachmentList[index].fileType ==
                                              '.jpg' ||
                                          attachmentList[index].fileType ==
                                              '.png' ||
                                          attachmentList[index].fileType ==
                                              '.jpeg'
                                      ? InkWell(
                                          onTap: () async {
                                            if (attachmentList[index]
                                                    .fileType ==
                                                '.pdf') {
                                              await OpenFile.open(
                                                  attachmentList[index]
                                                      .filePath);
                                            } else if (attachmentList[index]
                                                        .fileType ==
                                                    '.jpg' ||
                                                attachmentList[index]
                                                        .fileType ==
                                                    '.png' ||
                                                attachmentList[index]
                                                        .fileType ==
                                                    '.jpeg') {
                                              Navigator.pushNamed(
                                                  context,
                                                  StringRouterUtil
                                                      .docPreviewScreenRoute,
                                                  arguments:
                                                      attachmentList[index]
                                                          .filePath);
                                            } else {}
                                          },
                                          child: const Icon(
                                            Icons.preview_rounded,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Container(),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        attachmentList.removeAt(index);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.close_rounded,
                                      color: Colors.red,
                                    ),
                                  )
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: isSubmit
                        ? null
                        : () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            Navigator.pop(context);
                          },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              isSubmit ? Colors.grey : const Color(0xff5ff3131),
                              isSubmit ? Colors.grey : const Color(0xFFFF914D)
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: const [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Center(
                        child: Text('Cancel',
                            style: TextStyle(
                                fontSize: GeneralUtil.fontSize(context) * 0.55,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  MultiBlocListener(
                    listeners: [
                      BlocListener(
                        bloc: submitAddReqBloc,
                        listener: (_, SubmitAddReqState state) {
                          if (state is SubmitAddReqLoading) {
                            setState(() {
                              isLoading = true;
                            });
                          }
                          if (state is SubmitAddReqLoaded) {
                            setState(() {
                              assetCode = state.generalResponseModel.code!;
                            });
                            if (widget.argumentAddReq.register) {
                              uploadDocReqBloc.add(UploadDocReqAttempt(
                                  uploadDocRequestModel: UploadDocRequestModel(
                                      pAssetRegisterCode: assetCode,
                                      filePath:
                                          attachmentList[counter].filePath,
                                      pFileName:
                                          attachmentList[counter].fileName)));
                            } else {
                              if (selectRequest == 'Mutation') {
                                uploadDocReqBloc.add(UploadDocMutaionAttempt(
                                    opnameCode: assetCode,
                                    uploadDocRequestModel:
                                        UploadDocRequestModel(
                                            pAssetRegisterCode: widget
                                                .argumentAddReq
                                                .assetGrowResponseModel
                                                .data![0]
                                                .code,
                                            filePath: attachmentList[counter]
                                                .filePath,
                                            pFileName: attachmentList[counter]
                                                .fileName)));
                              } else if (selectRequest == 'Sell') {
                                uploadDocReqBloc.add(UploadDocSellAttempt(
                                    opnameCode: assetCode,
                                    uploadDocRequestModel:
                                        UploadDocRequestModel(
                                            pAssetRegisterCode: widget
                                                .argumentAddReq
                                                .assetGrowResponseModel
                                                .data![0]
                                                .code,
                                            filePath: attachmentList[counter]
                                                .filePath,
                                            pFileName: attachmentList[counter]
                                                .fileName)));
                              } else if (selectRequest == 'Maintenance') {
                                uploadDocReqBloc.add(
                                    UploadDocMaintenanceAttempt(
                                        opnameCode: assetCode,
                                        uploadDocRequestModel:
                                            UploadDocRequestModel(
                                                pAssetRegisterCode: widget
                                                    .argumentAddReq
                                                    .assetGrowResponseModel
                                                    .data![0]
                                                    .code,
                                                filePath:
                                                    attachmentList[counter]
                                                        .filePath,
                                                pFileName:
                                                    attachmentList[counter]
                                                        .fileName)));
                              } else {
                                uploadDocReqBloc.add(UploadDocDisposalAttempt(
                                    opnameCode: assetCode,
                                    uploadDocRequestModel:
                                        UploadDocRequestModel(
                                            pAssetRegisterCode: widget
                                                .argumentAddReq
                                                .assetGrowResponseModel
                                                .data![0]
                                                .code,
                                            filePath: attachmentList[counter]
                                                .filePath,
                                            pFileName: attachmentList[counter]
                                                .fileName)));
                              }
                            }
                          }
                          if (state is SubmitAddReqError) {
                            GeneralUtil()
                                .showSnackBarError(context, state.error!);
                            setState(() {
                              isLoading = false;
                            });
                          }
                          if (state is SubmitAddReqException) {
                            if (state.error.toLowerCase() ==
                                'unauthorized access') {
                              GeneralUtil().showSnackBarError(
                                  context, 'Session Expired');
                              var bottomBarProvider =
                                  Provider.of<NavbarProvider>(context,
                                      listen: false);
                              bottomBarProvider.setPage(2);
                              bottomBarProvider.setTab(2);
                              SharedPrefUtil.clearSharedPref();
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    StringRouterUtil.loginScreenRoute,
                                    (route) => false);
                              });
                            } else {
                              GeneralUtil()
                                  .showSnackBarError(context, state.error);
                            }
                          }
                        },
                      ),
                      BlocListener(
                        bloc: uploadDocReqBloc,
                        listener: (_, UploadDocReqState state) {
                          if (state is UploadDocReqLoading) {
                            setState(() {
                              isLoading = true;
                            });
                          }
                          if (state is UploadDocReqLoaded) {
                            counter++;
                            if (counter < attachmentList.length) {
                              if (widget.argumentAddReq.register) {
                                uploadDocReqBloc.add(UploadDocReqAttempt(
                                    uploadDocRequestModel:
                                        UploadDocRequestModel(
                                            pAssetRegisterCode: assetCode,
                                            filePath: attachmentList[counter]
                                                .filePath,
                                            pFileName: attachmentList[counter]
                                                .fileName)));
                              } else {
                                if (selectRequest == 'Mutation') {
                                  uploadDocReqBloc.add(UploadDocMutaionAttempt(
                                      opnameCode: assetCode,
                                      uploadDocRequestModel:
                                          UploadDocRequestModel(
                                              pAssetRegisterCode: widget
                                                  .argumentAddReq
                                                  .assetGrowResponseModel
                                                  .data![0]
                                                  .code,
                                              filePath: attachmentList[counter]
                                                  .filePath,
                                              pFileName: attachmentList[counter]
                                                  .fileName)));
                                } else if (selectRequest == 'Sell') {
                                  uploadDocReqBloc.add(UploadDocSellAttempt(
                                      opnameCode: assetCode,
                                      uploadDocRequestModel:
                                          UploadDocRequestModel(
                                              pAssetRegisterCode: widget
                                                  .argumentAddReq
                                                  .assetGrowResponseModel
                                                  .data![0]
                                                  .code,
                                              filePath: attachmentList[counter]
                                                  .filePath,
                                              pFileName: attachmentList[counter]
                                                  .fileName)));
                                } else if (selectRequest == 'Maintenance') {
                                  uploadDocReqBloc.add(
                                      UploadDocMaintenanceAttempt(
                                          opnameCode: assetCode,
                                          uploadDocRequestModel:
                                              UploadDocRequestModel(
                                                  pAssetRegisterCode: widget
                                                      .argumentAddReq
                                                      .assetGrowResponseModel
                                                      .data![0]
                                                      .code,
                                                  filePath:
                                                      attachmentList[counter]
                                                          .filePath,
                                                  pFileName:
                                                      attachmentList[counter]
                                                          .fileName)));
                                } else {
                                  uploadDocReqBloc.add(UploadDocDisposalAttempt(
                                      opnameCode: assetCode,
                                      uploadDocRequestModel:
                                          UploadDocRequestModel(
                                              pAssetRegisterCode: widget
                                                  .argumentAddReq
                                                  .assetGrowResponseModel
                                                  .data![0]
                                                  .code,
                                              filePath: attachmentList[counter]
                                                  .filePath,
                                              pFileName: attachmentList[counter]
                                                  .fileName)));
                                }
                              }
                            } else {
                              setState(() {
                                isLoading = false;
                                isSubmit = true;
                              });
                              var bottomBarProvider =
                                  Provider.of<NavbarProvider>(context,
                                      listen: false);
                              bottomBarProvider.setPage(2);
                              bottomBarProvider.setTab(2);
                              GeneralUtil().showSnackBarSuccess(
                                  context, 'Input Data Successfully');
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    StringRouterUtil.navbarScreenRoute,
                                    (route) => false);
                              });
                            }
                          }
                          if (state is UploadDocReqError) {
                            GeneralUtil()
                                .showSnackBarError(context, state.error!);
                            setState(() {
                              isLoading = false;
                            });
                          }
                          if (state is UploadDocReqException) {
                            if (state.error.toLowerCase() ==
                                'unauthorized access') {
                              GeneralUtil().showSnackBarError(
                                  context, 'Session Expired');
                              var bottomBarProvider =
                                  Provider.of<NavbarProvider>(context,
                                      listen: false);
                              bottomBarProvider.setPage(2);
                              bottomBarProvider.setTab(2);
                              SharedPrefUtil.clearSharedPref();
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    StringRouterUtil.loginScreenRoute,
                                    (route) => false);
                              });
                            } else {
                              GeneralUtil()
                                  .showSnackBarError(context, state.error);
                            }
                          }
                        },
                      ),
                    ],
                    child: isLoading
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: 55,
                            child: const Center(
                                child: CircularProgressIndicator()),
                          )
                        : InkWell(
                            onTap: isSubmit
                                ? null
                                : () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    if (selectRequest == 'Register') {
                                      if (attachmentList.isEmpty ||
                                          _assetNameCtrl.text == '' ||
                                          _assetNameCtrl.text.isEmpty ||
                                          selectedPurchaseCondition == '' ||
                                          _remarksCtrl.text == '' ||
                                          _remarksCtrl.text.isEmpty) {
                                        GeneralUtil().showSnackBarError(context,
                                            'Required field cannot be empty');
                                      } else {
                                        submitAddReqBloc.add(SubmitAddReqAttempt(
                                            submitRequestModel:
                                                SubmitRequestModel(
                                                    pItemCode: itemCode,
                                                    pPicCode: picCode,
                                                    pPurchaseCondition:
                                                        selectedPurchaseCondition,
                                                    pRemarksMobile:
                                                        _remarksCtrl.text)));
                                      }
                                    } else if (selectRequest == 'Sell') {
                                      if (selectRequest == '' ||
                                          selectedReasonCode == '' ||
                                          _priceCtrl.text == '' ||
                                          _priceCtrl.text.isEmpty ||
                                          _remarksCtrl.text == '' ||
                                          _remarksCtrl.text.isEmpty ||
                                          attachmentList.isEmpty) {
                                        GeneralUtil().showSnackBarError(context,
                                            'Required field cannot be empty');
                                      } else {
                                        submitAddReqBloc
                                            .add(SubmitAdditionalSellAttempt(
                                                submitRequestModel:
                                                    SubmitRequestModel(
                                                        pAssetCode: widget
                                                            .argumentAddReq
                                                            .assetGrowResponseModel
                                                            .data![0]
                                                            .code,
                                                        pRequestProcessToCode:
                                                            selectRequest
                                                                .toUpperCase(),
                                                        pSellingPrice:
                                                            _tempValue,
                                                        pReasonCode:
                                                            selectedReasonCode,
                                                        pRemarksMobile:
                                                            _remarksCtrl
                                                                .text)));
                                      }
                                    } else if (selectRequest == 'Maintenance') {
                                      if (selectRequest == '' ||
                                          selectedLocationCode == '' ||
                                          selectedTypeCode == '' ||
                                          answerVal.isEmpty ||
                                          _remarksCtrl.text == '' ||
                                          _remarksCtrl.text.isEmpty ||
                                          attachmentList.isEmpty) {
                                        GeneralUtil().showSnackBarError(context,
                                            'Required field cannot be empty');
                                      } else {
                                        submitAddReqBloc.add(
                                            SubmitAdditionalMaintenanceAttempt(
                                                submitRequestModel: SubmitRequestModel(
                                                    pAssetCode: widget
                                                        .argumentAddReq
                                                        .assetGrowResponseModel
                                                        .data![0]
                                                        .code,
                                                    pRequestProcessToCode:
                                                        selectRequest
                                                            .toUpperCase(),
                                                    pMaintenanceBy:
                                                        answerVal[0]!
                                                            .name
                                                            .toUpperCase(),
                                                    pServiceCode:
                                                        selectedTypeCode,
                                                    pRemarksMobile:
                                                        _remarksCtrl.text)));
                                      }
                                    } else if (selectRequest == 'Mutation') {
                                      if (selectRequest == '' ||
                                          selectedMutation == '' ||
                                          selectedMutationCode == '' ||
                                          _remarksCtrl.text == '' ||
                                          _remarksCtrl.text.isEmpty ||
                                          attachmentList.isEmpty) {
                                        GeneralUtil().showSnackBarError(context,
                                            'Required field cannot be empty');
                                      } else {
                                        submitAddReqBloc.add(
                                            SubmitAdditionalMutationAttempt(
                                                submitRequestModel:
                                                    SubmitRequestModel(
                                                        pAssetCode: widget
                                                            .argumentAddReq
                                                            .assetGrowResponseModel
                                                            .data![0]
                                                            .code,
                                                        pRequestProcessToCode:
                                                            selectRequest
                                                                .toUpperCase(),
                                                        pPicCode:
                                                            selectedMutationCode,
                                                        pRemarksMobile:
                                                            _remarksCtrl
                                                                .text)));
                                      }
                                    } else {
                                      if (selectRequest == '' ||
                                          selectedReasonCode == '' ||
                                          _remarksCtrl.text == '' ||
                                          _remarksCtrl.text.isEmpty ||
                                          attachmentList.isEmpty) {
                                        GeneralUtil().showSnackBarError(context,
                                            'Required field cannot be empty');
                                      } else {
                                        submitAddReqBloc.add(SubmitAdditionalAttempt(
                                            submitRequestModel:
                                                SubmitRequestModel(
                                                    pAssetCode: widget
                                                        .argumentAddReq
                                                        .assetGrowResponseModel
                                                        .data![0]
                                                        .code,
                                                    pRequestProcessToCode:
                                                        selectRequest
                                                            .toUpperCase(),
                                                    pReasonCode:
                                                        selectedReasonCode,
                                                    pRemarksMobile:
                                                        _remarksCtrl.text)));
                                      }
                                    }
                                  },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 55,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      isSubmit
                                          ? Colors.grey
                                          : const Color(0xFF5DE0E6),
                                      isSubmit
                                          ? Colors.grey
                                          : const Color(0xFF004AAD)
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 0.0),
                                    stops: const [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: Center(
                                child: Text('Submit',
                                    style: TextStyle(
                                        fontSize:
                                            GeneralUtil.fontSize(context) *
                                                0.55,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget formSell() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Reason *',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: widget.argumentAddReq.register
              ? null
              : () async {
                  final result = await Navigator.pushNamed(
                      context, StringRouterUtil.dropDownScreenRoute,
                      arguments: DdlRequestScreen(
                          title: 'reason', source: selectRequest));

                  if (result != null && result is Map<String, dynamic>) {
                    setState(() {
                      selectedReason = result['value']!;
                      selectedReasonCode = result['code']!;
                    });
                  }
                },
          child: Container(
            width: double.infinity,
            height: 45,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedReason == ''
                    ? Text(
                        'Select Reason',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.45,
                        ),
                      )
                    : Text(
                        selectedReason,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.45,
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                  ),
                ),
              ],
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
          height: 35,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            GeneralUtil.convertToIdr(
                widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .netBookValueComm,
                2),
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
            'Selling Price *',
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
          controller: _priceCtrl,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(18),
          ],
          style: const TextStyle(color: Colors.white),
          onChanged: (val) {
            log(_tempValue.toString());
            setState(() {
              if (_tempValue != null) {
                gainloss = _tempValue! -
                    widget.argumentAddReq.assetGrowResponseModel.data![0]
                        .netBookValueComm!;
              } else {
                gainloss = 0;
              }
            });
          },
          decoration: const InputDecoration(
            counterStyle: TextStyle(color: Color(0xFFE6E7E8)),
            isDense: true,
            prefix: Text(
              "Rp ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            hintText: "0,00",
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
          height: 35,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            GeneralUtil.convertToIdr(gainloss, 2),
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

  Widget formRegister() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Item *',
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
          height: 45,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  assetName,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: GeneralUtil.fontSize(context) * 0.45,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                        context, StringRouterUtil.dropDownScreenRoute,
                        arguments: DdlRequestScreen(
                            title: 'item',
                            source: selectRequest,
                            assetCode: ''));

                    if (result != null && result is Map<String, dynamic>) {
                      setState(() {
                        _assetNameCtrl.text = result['value']!;
                        assetName = result['value']!;
                        itemCode = result['code']!;
                      });
                    }
                  },
                  child: const Icon(
                    Icons.search,
                    size: 32,
                    color: Color(0xFFE6E7E8),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Purchase Condition *',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: () async {
            final result = await Navigator.pushNamed(
                context, StringRouterUtil.dropDownScreenRoute,
                arguments: DdlRequestScreen(
                    title: 'pc', source: selectRequest, assetCode: ''));
            log(result.toString());
            if (result != null && result is Map<String, dynamic>) {
              setState(() {
                selectedPurchaseCondition = result['value']!;
              });
            }
          },
          child: Container(
            width: double.infinity,
            height: 45,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedPurchaseCondition == ''
                    ? Text(
                        'Select Purchase Condition',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.45,
                        ),
                      )
                    : Text(
                        selectedPurchaseCondition,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.45,
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
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
          height: 45,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  picName,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: GeneralUtil.fontSize(context) * 0.45,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                        context, StringRouterUtil.dropDownScreenRoute,
                        arguments: DdlRequestScreen(
                            title: 'employee',
                            source: selectRequest,
                            assetCode: ''));

                    if (result != null && result is Map<String, dynamic>) {
                      setState(() {
                        _picCtrl.text = result['value']!;
                        picName = result['value']!;
                        picCode = result['code']!;
                      });
                    }
                  },
                  child: const Icon(
                    Icons.search,
                    size: 32,
                    color: Color(0xFFE6E7E8),
                  ),
                ),
              )
            ],
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

  Widget formDisposal() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Reason *',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: widget.argumentAddReq.register
              ? null
              : () async {
                  final result = await Navigator.pushNamed(
                      context, StringRouterUtil.dropDownScreenRoute,
                      arguments: DdlRequestScreen(
                          title: 'reason',
                          source: selectRequest,
                          assetCode: widget.argumentAddReq
                              .assetGrowResponseModel.data![0].code));

                  if (result != null && result is Map<String, dynamic>) {
                    setState(() {
                      selectedReason = result['value']!;
                      selectedReasonCode = result['code']!;
                    });
                  }
                },
          child: Container(
            width: double.infinity,
            height: 45,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedReason == ''
                    ? Text(
                        'Select Reason',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.45,
                        ),
                      )
                    : Text(
                        selectedReason,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.45,
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                  ),
                ),
              ],
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
          height: 35,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            GeneralUtil.convertToIdr(
                widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .purchasePrice,
                2),
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
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          height: 35,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            GeneralUtil.convertToIdr(
                widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .totalDepreComm,
                2),
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
          height: 35,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            GeneralUtil.convertToIdr(
                widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .netBookValueComm,
                2),
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
            '$name - $uid',
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

  Widget formMaintenance() {
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
            widget.argumentAddReq.assetGrowResponseModel.data![0].itemName!,
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
          height: 35,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Text(
            widget.argumentAddReq.assetGrowResponseModel.data![0].code!,
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
        GestureDetector(
          onTap: () async {
            final result = await Navigator.pushNamed(
                context, StringRouterUtil.dropDownScreenRoute,
                arguments: DdlRequestScreen(
                    title: 'location',
                    source: selectRequest,
                    assetCode: widget
                        .argumentAddReq.assetGrowResponseModel.data![0].code));
            if (result != null && result is Map<String, dynamic>) {
              setState(() {
                selectedLocation = result['value']!;
                selectedLocationCode = result['code']!;
              });
            }
          },
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedLocation == ''
                    ? Text(
                        'Select Location',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.45,
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          selectedLocation,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: GeneralUtil.fontSize(context) * 0.45,
                          ),
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Maintenance By *',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Theme(
          data: Theme.of(context).copyWith(
              unselectedWidgetColor: Colors.white, disabledColor: Colors.white),
          child: Row(
            children: [
              Expanded(
                child: RadioListTile<Answer>(
                  title: const Text(
                    'Internal',
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                  value: Answer.internal,
                  groupValue: answerVal[0],
                  activeColor: Colors.white,
                  onChanged: (Answer? value) {
                    setState(() {
                      answerVal[0] = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<Answer>(
                  title: const Text(
                    'External',
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                  value: Answer.external,
                  activeColor: Colors.white,
                  groupValue: answerVal[0],
                  onChanged: (Answer? value) {
                    setState(() {
                      answerVal[0] = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Type of Service *',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: () async {
            final result = await Navigator.pushNamed(
                context, StringRouterUtil.dropDownScreenRoute,
                arguments: DdlRequestScreen(
                    title: 'tos',
                    source: selectRequest,
                    assetCode: widget
                        .argumentAddReq.assetGrowResponseModel.data![0].code));

            if (result != null && result is Map<String, dynamic>) {
              setState(() {
                selectedType = result['value']!;
                selectedTypeCode = result['code']!;
              });
            }
          },
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedType == ''
                    ? Text(
                        'Select Type of Service',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.45,
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          selectedType,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: GeneralUtil.fontSize(context) * 0.45,
                          ),
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                  ),
                ),
              ],
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
            '$name - $uid',
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

  Widget formMutation() {
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
            widget.argumentAddReq.assetGrowResponseModel.data![0].itemName!,
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
            'FA Type & Category',
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
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].categoryName!}',
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
            'Mutation Type',
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
            'To PIC',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: GeneralUtil.fontSize(context) * 0.45,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Mutation To *',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: () async {
            final result = await Navigator.pushNamed(
                context, StringRouterUtil.dropDownScreenRoute,
                arguments: DdlRequestScreen(
                    title: 'mutation to',
                    source: selectRequest,
                    assetCode: widget
                        .argumentAddReq.assetGrowResponseModel.data![0].code));
            if (result != null && result is Map<String, dynamic>) {
              setState(() {
                selectedMutation = result['value']!;
                selectedMutationCode = result['code']!;
              });
            }
          },
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedMutation == ''
                    ? Text(
                        'Select Mutation To',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.45,
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          selectedMutation,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: GeneralUtil.fontSize(context) * 0.45,
                          ),
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Icon(
                    Icons.search,
                    size: 32,
                    color: Color(0xFFE6E7E8),
                  ),
                ),
              ],
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

  Widget mainContent() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Condition',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: () async {
            await Navigator.pushNamed(
                    context, StringRouterUtil.dropDownScreenRoute,
                    arguments: DdlRequestScreen(
                        title: 'Condition',
                        source: selectRequest,
                        assetCode: widget.argumentAddReq.assetGrowResponseModel
                            .data![0].code))
                .then((val) {
              if (val != null) {
                setState(() {
                  selectedPurchaseCondition = val.toString();
                });
              }
            });
          },
          child: Container(
            width: double.infinity,
            height: 45,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedPurchaseCondition == ''
                    ? Text(
                        'Select Condition',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.45,
                        ),
                      )
                    : Text(
                        selectedPurchaseCondition,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.45,
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Status',
            style: TextStyle(
                fontSize: GeneralUtil.fontSize(context) * 0.55,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: () async {
            await Navigator.pushNamed(
                    context, StringRouterUtil.dropDownScreenRoute,
                    arguments: DdlRequestScreen(
                        title: 'Status',
                        source: selectRequest,
                        assetCode: widget.argumentAddReq.assetGrowResponseModel
                            .data![0].code))
                .then((val) {
              if (val != null) {
                setState(() {
                  selectedStatus = val.toString();
                });
              }
            });
          },
          child: Container(
            width: double.infinity,
            height: 45,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedStatus == ''
                    ? Text(
                        'Select Status',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.45,
                        ),
                      )
                    : Text(
                        selectedStatus,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: GeneralUtil.fontSize(context) * 0.45,
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
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
        TextFormField(
          controller: _picCtrl,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
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
          controller: _warrantyCtrl,
          maxLength: 500,
          minLines: 3,
          maxLines: 10,
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
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Opname Location',
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
          padding: const EdgeInsetsDirectional.only(bottom: 16),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Longitude  : ${widget.argumentAddReq.assetGrowResponseModel.data![0].longitude}',
                    style: TextStyle(
                        fontSize: GeneralUtil.fontSize(context) * 0.45,
                        color: Color(0xFFBFBFBF)),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '||',
                    style: TextStyle(
                        fontSize: GeneralUtil.fontSize(context) * 0.45,
                        color: Color(0xFFBFBFBF)),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Latitude     : ${widget.argumentAddReq.assetGrowResponseModel.data![0].latitude}',
                    style: TextStyle(
                        fontSize: GeneralUtil.fontSize(context) * 0.45,
                        color: Color(0xFFBFBFBF)),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  MapUtil.openMap(
                      double.parse(widget.argumentAddReq.assetGrowResponseModel
                          .data![0].latitude!),
                      double.parse(widget.argumentAddReq.assetGrowResponseModel
                          .data![0].longitude!),
                      widget.argumentAddReq.assetGrowResponseModel.data![0]
                          .locationName!);
                },
                child: Image.asset(
                  'assets/imgs/map.png',
                  width: 40,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
