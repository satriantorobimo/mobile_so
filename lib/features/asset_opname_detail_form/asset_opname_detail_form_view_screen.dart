import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/attachment_list.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/doc_preview_request_model.dart';
import 'package:mobile_so/features/asset_opname_detail/domain/repo/asset_grow_repo.dart';
import 'package:mobile_so/features/asset_opname_detail_form/bloc/opname_result_bloc/bloc.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/arguments_view_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/ddl_request_screen.dart';
import 'package:mobile_so/features/asset_opname_detail_form/domain/repo/opname_submit_repo.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/map_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:open_file/open_file.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

import '../asset_opname_detail/bloc/print/bloc.dart';

class AssetOpnameDetailFormViewScreen extends StatefulWidget {
  const AssetOpnameDetailFormViewScreen(
      {super.key, required this.argumentsViewModel});
  final ArgumentsViewModel argumentsViewModel;

  @override
  State<AssetOpnameDetailFormViewScreen> createState() =>
      _AssetOpnameDetailFormViewScreenState();
}

class _AssetOpnameDetailFormViewScreenState
    extends State<AssetOpnameDetailFormViewScreen> {
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
  String assetCode = '';
  List<AttachmentList> attachmentList = [];
  OpnameResultBloc opnameResultBloc =
      OpnameResultBloc(opnameSubmitRepo: OpnameSubmitRepo());
  PrintBloc printBloc = PrintBloc(assetGrowRepo: AssetGrowRepo());

  @override
  void initState() {
    opnameResultBloc.add(
        OpnameResultAttempt(argumentsViewModel: widget.argumentsViewModel));
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
              Text('Result Asset Opname',
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 20,
                      color: Colors.white)),
            ],
          ),
        ),
        BlocListener(
            bloc: opnameResultBloc,
            listener: (_, OpnameResultState state) {
              if (state is OpnameResultLoading) {}
              if (state is OpnameResultLoaded) {
                setState(() {
                  assetCode =
                      state.opnameResultResponseModel.data![0].assetCode!;
                });
              }
              if (state is OpnameResultError) {
                GeneralUtil().showSnackBarError(context, state.error!);
              }
              if (state is OpnameResultException) {
                if (state.error.toLowerCase() == 'unauthorized access') {
                  GeneralUtil().showSnackBarError(context, 'Session Expired');
                  var bottomBarProvider =
                      Provider.of<NavbarProvider>(context, listen: false);
                  bottomBarProvider.setPage(0);
                  bottomBarProvider.setTab(0);
                  SharedPrefUtil.clearSharedPref();
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        StringRouterUtil.loginScreenRoute, (route) => false);
                  });
                } else {
                  GeneralUtil().showSnackBarError(context, state.error);
                }
              }
            },
            child: BlocBuilder(
                bloc: opnameResultBloc,
                builder: (context, OpnameResultState state) {
                  if (state is OpnameResultLoading) {
                    return const Center(
                      child: SizedBox(
                        width: 45,
                        height: 45,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is OpnameResultLoaded) {
                    return Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        shrinkWrap: true,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 65,
                                          height: 65,
                                          child: PrettyQrView.data(
                                              data: state
                                                  .opnameResultResponseModel
                                                  .data![0]
                                                  .barcode!,
                                              decoration:
                                                  const PrettyQrDecoration(
                                                shape: PrettyQrSmoothSymbol(
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ),
                                        BlocListener(
                                            bloc: printBloc,
                                            listener: (_, PrintState state) {
                                              if (state is PrintLoading) {}
                                              if (state is PrintLoaded) {
                                                GeneralUtil()
                                                    .showSnackBarSuccess(
                                                        context,
                                                        'Print Successfully!');
                                              }
                                              if (state is PrintError) {
                                                GeneralUtil().showSnackBarError(
                                                    context, state.error!);
                                              }
                                              if (state is PrintException) {
                                                if (state.error.toLowerCase() ==
                                                    'unauthorized access') {
                                                  GeneralUtil()
                                                      .showSnackBarError(
                                                          context,
                                                          'Session Expired');
                                                  var bottomBarProvider =
                                                      Provider.of<
                                                              NavbarProvider>(
                                                          context,
                                                          listen: false);
                                                  bottomBarProvider.setPage(0);
                                                  bottomBarProvider.setTab(0);
                                                  SharedPrefUtil
                                                      .clearSharedPref();
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 1), () {
                                                    Navigator
                                                        .pushNamedAndRemoveUntil(
                                                            context,
                                                            StringRouterUtil
                                                                .loginScreenRoute,
                                                            (route) => false);
                                                  });
                                                } else {
                                                  GeneralUtil()
                                                      .showSnackBarError(
                                                          context, state.error);
                                                }
                                              }
                                            },
                                            child: BlocBuilder(
                                                bloc: printBloc,
                                                builder: (context,
                                                    PrintState state) {
                                                  if (state is PrintLoading) {
                                                    return const Center(
                                                      child: SizedBox(
                                                        width: 25,
                                                        height: 25,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    );
                                                  }
                                                  if (state is PrintLoaded) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        printBloc.add(
                                                            PrintAttempt(
                                                                assetCode:
                                                                    assetCode));
                                                      },
                                                      child: const Icon(
                                                        Icons.print_sharp,
                                                        size: 33,
                                                        color: Colors.white,
                                                      ),
                                                    );
                                                  }
                                                  return GestureDetector(
                                                    onTap: () {
                                                      printBloc.add(
                                                          PrintAttempt(
                                                              assetCode:
                                                                  assetCode));
                                                    },
                                                    child: const Icon(
                                                      Icons.print_sharp,
                                                      size: 33,
                                                      color: Colors.white,
                                                    ),
                                                  );
                                                })),
                                      ],
                                    ),
                                    Text(
                                      state.opnameResultResponseModel.data![0]
                                          .barcode!,
                                      style: TextStyle(
                                          fontSize:
                                              GeneralUtil.fontSize(context) *
                                                  0.4,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      state.opnameResultResponseModel.data![0]
                                          .itemName!,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.17,
                                        child: Text(
                                          'Asset No : ',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Text(
                                          state.opnameResultResponseModel
                                              .data![0].assetCode!,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Text(
                                          'Usefull life : ',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Text(
                                          '${state.opnameResultResponseModel.data![0].usefull!} years',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.22,
                                        child: Text(
                                          'Opname No : ',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Text(
                                          state.opnameResultResponseModel
                                              .data![0].opnameCode!,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        child: Text(
                                          'Opname Date : ',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Text(
                                          state.opnameResultResponseModel
                                              .data![0].opnameResultDate!,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.22,
                                        child: Text(
                                          'Opname By : ',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Text(
                                          state.opnameResultResponseModel
                                              .data![0].opnameByName!,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.255,
                                        child: Text(
                                          'Opname Scale : ',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Text(
                                          state.opnameResultResponseModel
                                              .data![0].opnameScale!,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                              'Location',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.5, color: Color(0xFFE6E7E8)),
                              ),
                            ),
                            child: Text(
                              '${state.opnameResultResponseModel.data![0].branchName!} - ${state.opnameResultResponseModel.data![0].locationName!}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Condition',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.5, color: Color(0xFFE6E7E8)),
                              ),
                            ),
                            child: Text(
                              state.opnameResultResponseModel.data![0]
                                  .conditionName!,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Status',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.5, color: Color(0xFFE6E7E8)),
                              ),
                            ),
                            child: Text(
                              state.opnameResultResponseModel.data![0]
                                  .opnameAssetStatusName!,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'PIC',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.5, color: Color(0xFFE6E7E8)),
                              ),
                            ),
                            child: Text(
                              '${state.opnameResultResponseModel.data![0].picAssetCode!} - ${state.opnameResultResponseModel.data![0].picAssetName!}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Remarks',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.5, color: Color(0xFFE6E7E8)),
                              ),
                            ),
                            child: Text(
                              state.opnameResultResponseModel.data![0]
                                  .opnameRemark!,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 16,
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsetsDirectional.only(bottom: 16),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.5, color: Color(0xFFE6E7E8)),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Longitude  : ${state.opnameResultResponseModel.data![0].latitude!}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFBFBFBF)),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '||',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFBFBFBF)),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Latitude     : ${state.opnameResultResponseModel.data![0].longitude!}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFBFBFBF)),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    MapUtil.openMap(
                                        double.parse(state
                                            .opnameResultResponseModel
                                            .data![0]
                                            .latitude!),
                                        double.parse(state
                                            .opnameResultResponseModel
                                            .data![0]
                                            .longitude!),
                                        state.opnameResultResponseModel.data![0]
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
                          state.opnameResultResponseModel.data![0].document!
                                  .isNotEmpty
                              ? const SizedBox(
                                  height: 8,
                                )
                              : Container(),
                          state.opnameResultResponseModel.data![0].document!
                                  .isNotEmpty
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    String extension = state
                                        .opnameResultResponseModel
                                        .data![0]
                                        .document![index]
                                        .path!
                                        .split('.')
                                        .last;
                                    return Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.75,
                                            child: Text(
                                                state
                                                    .opnameResultResponseModel
                                                    .data![0]
                                                    .document![index]
                                                    .fileName!,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Row(
                                            children: [
                                              extension.toLowerCase() ==
                                                          'pdf' ||
                                                      extension.toLowerCase() ==
                                                          'jpg' ||
                                                      extension.toLowerCase() ==
                                                          'png' ||
                                                      extension.toLowerCase() ==
                                                          'jpeg'
                                                  ? InkWell(
                                                      onTap: () async {
                                                        if (extension
                                                                .toLowerCase() ==
                                                            'pdf') {
                                                          Navigator.pushNamed(
                                                              context,
                                                              StringRouterUtil
                                                                  .docPreviewNetworkPdfScreenRoute,
                                                              arguments: DocPreviewRequestModel(
                                                                  pFileName: state
                                                                      .opnameResultResponseModel
                                                                      .data![0]
                                                                      .document![
                                                                          index]
                                                                      .fileName!,
                                                                  pFilePaths: state
                                                                      .opnameResultResponseModel
                                                                      .data![0]
                                                                      .document![
                                                                          index]
                                                                      .path!));
                                                        } else if (extension
                                                                    .toLowerCase() ==
                                                                'jpg' ||
                                                            extension
                                                                    .toLowerCase() ==
                                                                'png' ||
                                                            extension
                                                                    .toLowerCase() ==
                                                                'jpeg') {
                                                          Navigator.pushNamed(
                                                              context,
                                                              StringRouterUtil
                                                                  .docPreviewNetworkScreenRoute,
                                                              arguments: DocPreviewRequestModel(
                                                                  pFileName: state
                                                                      .opnameResultResponseModel
                                                                      .data![0]
                                                                      .document![
                                                                          index]
                                                                      .fileName!,
                                                                  pFilePaths: state
                                                                      .opnameResultResponseModel
                                                                      .data![0]
                                                                      .document![
                                                                          index]
                                                                      .path!));
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
                                  itemCount: state.opnameResultResponseModel
                                      .data![0].document!.length)
                              : Container(),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                })),
      ]),
    );
  }
}
