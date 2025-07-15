import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/attachment_list.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/upload_doc_request_model.dart';
import 'package:mobile_so/features/asset_opname_detail/data/asset_grow_response_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/bloc/submit_opname_bloc/bloc.dart';
import 'package:mobile_so/features/asset_opname_detail_form/bloc/upload_doc_opname_bloc/bloc.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/ddl_request_screen.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/submit_opname_request_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/domain/repo/opname_submit_repo.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/drop_down_util.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/map_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

class AssetOpnameDetailFormScreen extends StatefulWidget {
  const AssetOpnameDetailFormScreen({super.key, required this.data});
  final Data data;

  @override
  State<AssetOpnameDetailFormScreen> createState() =>
      _AssetOpnameDetailFormScreenState();
}

class _AssetOpnameDetailFormScreenState
    extends State<AssetOpnameDetailFormScreen> {
  final TextEditingController _warrantyCtrl = TextEditingController();
  double cardRadius = 40.0;
  String selectedLocation = '';
  String selectedLocationCode = '';
  String selectedCondition = '';
  String selectedConditionCode = '';
  String selectedStatus = '';
  String selectedStatusCode = '';
  String selectedPic = '';
  String selectedPicCode = '';
  bool isLoading = false;
  bool isSubmit = false;
  int counter = 0;
  List<AttachmentList> attachmentList = [];
  SubmitOpnameBloc submitOpnameBloc =
      SubmitOpnameBloc(opnameSubmitRepo: OpnameSubmitRepo());
  UploadDocOpnameBloc uploadDocOpnameBloc =
      UploadDocOpnameBloc(opnameSubmitRepo: OpnameSubmitRepo());

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
                const Padding(
                  padding: EdgeInsets.only(top: 24.0, left: 16, right: 16),
                  child: Text(
                    'Select Options',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
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
                      child: const Text(
                        'Gallery',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
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
                      child: const Text(
                        'File Explorer',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
                const SizedBox(height: 24),
              ],
            ),
          );
        });
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
              Text('Asset Opname',
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 20,
                      color: Colors.white)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shrinkWrap: true,
            children: [
              Stack(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: PrettyQrView.data(
                            data: widget.data.barcode!,
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
                              widget.data.itemName!,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.data.code!,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Text(
                              '${widget.data.status!} - ${widget.data.condition!}',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Location : ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Text(
                                  '${widget.data.branchName!} - ${widget.data.locationName!}',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PIC : ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Text(
                                  widget.data.picName!,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 8,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        MapUtil.openMap(
                            double.parse(widget.data.latitude!),
                            double.parse(widget.data.longitude!),
                            widget.data.locationName!);
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Opname Result',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Location *',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.pushNamed(
                      context, StringRouterUtil.dropDownScreenRoute,
                      arguments:
                          DdlRequestScreen(title: 'location', source: ''));
                  if (result != null && result is Map<String, dynamic>) {
                    setState(() {
                      selectedLocation = result['value']!;
                      selectedLocationCode = result['code']!;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 8.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: selectedLocation == ''
                            ? Text(
                                'Select Location',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 16,
                                ),
                              )
                            : Text(
                                selectedLocation,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Condition *',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.pushNamed(
                      context, StringRouterUtil.dropDownScreenRoute,
                      arguments:
                          DdlRequestScreen(title: 'condition', source: ''));

                  if (result != null && result is Map<String, dynamic>) {
                    setState(() {
                      selectedCondition = result['value']!;
                      selectedConditionCode = result['code']!;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 8.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: selectedCondition == ''
                            ? Text(
                                'Select Condition',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 16,
                                ),
                              )
                            : Text(
                                selectedCondition,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Status *',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.pushNamed(
                      context, StringRouterUtil.dropDownScreenRoute,
                      arguments: DdlRequestScreen(title: 'status', source: ''));

                  if (result != null && result is Map<String, dynamic>) {
                    setState(() {
                      selectedStatus = result['value']!;
                      selectedStatusCode = result['code']!;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 8.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: selectedStatus == ''
                            ? Text(
                                'Select Status',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 16,
                                ),
                              )
                            : Text(
                                selectedStatus,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'PIC *',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.pushNamed(
                      context, StringRouterUtil.dropDownScreenRoute,
                      arguments: DdlRequestScreen(title: 'pic', source: ''));

                  if (result != null && result is Map<String, dynamic>) {
                    setState(() {
                      selectedPic = result['value']!;
                      selectedPicCode = result['code']!;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 8.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: selectedPic == ''
                            ? Text(
                                'Select PIC',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 16,
                                ),
                              )
                            : Text(
                                selectedPic,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Remarks *',
                  style: TextStyle(fontSize: 18, color: Colors.white),
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Opname Location',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsetsDirectional.only(bottom: 16),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.5, color: Color(0xFFE6E7E8)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Longitude  : ${widget.data.longitude}',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFFBFBFBF)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Latitude     : ${widget.data.latitude}',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFFBFBFBF)),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        MapUtil.openMap(
                            double.parse(widget.data.latitude!),
                            double.parse(widget.data.longitude!),
                            widget.data.locationName!);
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
              GestureDetector(
                onTap: () {
                  _showBottomAttachment(context);
                },
                child: DottedBorder(
                  color: Color(0xFFE6E7E8).withOpacity(0.5),
                  strokeWidth: 2,
                  radius: Radius.circular(cardRadius),
                  dashPattern: [10, 5],
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
                      children: [
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
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Text(attachmentList[index].fileName,
                                    style: const TextStyle(
                                        fontSize: 16,
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
                      child: const Center(
                        child: Text('Cancel',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  MultiBlocListener(
                    listeners: [
                      BlocListener(
                        bloc: submitOpnameBloc,
                        listener: (_, SubmitOpnameState state) {
                          if (state is SubmitOpnameLoading) {
                            setState(() {
                              isLoading = true;
                            });
                          }
                          if (state is SubmitOpnameLoaded) {
                            uploadDocOpnameBloc.add(UploadDocOpnameAttempt(
                                uploadDocRequestModelModel:
                                    UploadDocRequestModel(
                                        pAssetRegisterCode: widget.data.code!,
                                        filePath:
                                            attachmentList[counter].filePath,
                                        pFileName:
                                            attachmentList[counter].fileName),
                                opnameCode: widget.data.opnameCode!));
                          }
                          if (state is SubmitOpnameError) {
                            GeneralUtil()
                                .showSnackBarError(context, state.error!);
                            setState(() {
                              isLoading = false;
                            });
                          }
                          if (state is SubmitOpnameException) {
                            if (state.error.toLowerCase() ==
                                'unauthorized access') {
                              GeneralUtil().showSnackBarError(
                                  context, 'Session Expired');
                              var bottomBarProvider =
                                  Provider.of<NavbarProvider>(context,
                                      listen: false);
                              bottomBarProvider.setPage(1);
                              bottomBarProvider.setTab(1);
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
                        bloc: uploadDocOpnameBloc,
                        listener: (_, UploadDocOpnameState state) {
                          if (state is UploadDocOpnameLoading) {
                            setState(() {
                              isLoading = true;
                            });
                          }
                          if (state is UploadDocOpnameLoaded) {
                            counter++;
                            if (counter < attachmentList.length) {
                              uploadDocOpnameBloc.add(UploadDocOpnameAttempt(
                                  uploadDocRequestModelModel:
                                      UploadDocRequestModel(
                                          pAssetRegisterCode: widget.data.code!,
                                          filePath:
                                              attachmentList[counter].filePath,
                                          pFileName:
                                              attachmentList[counter].fileName),
                                  opnameCode: widget.data.opnameCode!));
                            } else {
                              setState(() {
                                isLoading = false;
                                isSubmit = true;
                              });
                              var bottomBarProvider =
                                  Provider.of<NavbarProvider>(context,
                                      listen: false);
                              bottomBarProvider.setPage(1);
                              bottomBarProvider.setTab(1);
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
                          if (state is UploadDocOpnameError) {
                            GeneralUtil()
                                .showSnackBarError(context, state.error!);
                            setState(() {
                              isLoading = false;
                            });
                          }
                          if (state is UploadDocOpnameException) {
                            if (state.error.toLowerCase() ==
                                'unauthorized access') {
                              GeneralUtil().showSnackBarError(
                                  context, 'Session Expired');
                              var bottomBarProvider =
                                  Provider.of<NavbarProvider>(context,
                                      listen: false);
                              bottomBarProvider.setPage(1);
                              bottomBarProvider.setTab(1);
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
                                    if (selectedLocation == '' ||
                                        selectedCondition == '' ||
                                        selectedStatus == '' ||
                                        selectedPic == '' ||
                                        _warrantyCtrl.text == '' ||
                                        _warrantyCtrl.text.isEmpty ||
                                        attachmentList.isEmpty) {
                                      GeneralUtil().showSnackBarError(context,
                                          'Required field cannot be empty');
                                    } else {
                                      submitOpnameBloc.add(SubmitOpnameAttempt(
                                          submitOpnameRequestModel:
                                              SubmitOpnameRequestModel(
                                                  pAssetCode: widget.data.code!,
                                                  pAssetStatusCode:
                                                      selectedStatusCode,
                                                  pConditionCode:
                                                      selectedConditionCode,
                                                  pLocationCode:
                                                      selectedLocationCode,
                                                  pOpnameCode:
                                                      widget.data.opnameCode!,
                                                  pPicCode: selectedPicCode,
                                                  pRemark:
                                                      _warrantyCtrl.text)));
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
                              child: const Center(
                                child: Text('Submit',
                                    style: TextStyle(
                                        fontSize: 18,
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
}
