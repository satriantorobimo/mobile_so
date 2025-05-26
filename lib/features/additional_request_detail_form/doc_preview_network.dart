import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/bloc/detail_view_bloc/bloc.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/doc_preview_request_model.dart';

import 'package:mobile_so/features/additional_request_detail_form/domain/repo/additional_request_detail_repo.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:provider/provider.dart';

class DocPreviewNetworkScreen extends StatefulWidget {
  final DocPreviewRequestModel docPreviewRequestModel;
  const DocPreviewNetworkScreen(this.docPreviewRequestModel, {super.key});

  @override
  State<DocPreviewNetworkScreen> createState() => _DocPreviewAssetScreenState();
}

class _DocPreviewAssetScreenState extends State<DocPreviewNetworkScreen> {
  DetailViewBloc detailViewBloc = DetailViewBloc(
      additionalRequestDetailRepo: AdditionalRequestDetailRepo());

  @override
  void initState() {
    detailViewBloc.add(DocPreviewAttempt(
        pFileName: widget.docPreviewRequestModel.pFileName!,
        pFilePaths: widget.docPreviewRequestModel.pFilePaths!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocListener(
            bloc: detailViewBloc,
            listener: (_, DetailViewState state) {
              if (state is DetailViewLoading) {}
              if (state is DocPreviewLoaded) {}
              if (state is DetailViewError) {
                GeneralUtil().showSnackBarError(context, state.error!);
              }
              if (state is DetailViewException) {
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
                bloc: detailViewBloc,
                builder: (_, DetailViewState state) {
                  if (state is DetailViewLoading) {
                    return const Center(
                      child: SizedBox(
                        width: 45,
                        height: 45,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is DocPreviewLoaded) {
                    // Parse and group data into "Today" and "Yesterday"
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            mainContent(
                                state.docPreviewResponseModel.value!.data!),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const SizedBox(
                                width: double.infinity,
                                height: 80,
                                child: Center(
                                  child: Text(
                                    'BACK',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is DetailViewError) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Icon(
                              Icons.broken_image_rounded,
                              size: 100,
                              color: Colors.white,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const SizedBox(
                                width: double.infinity,
                                height: 80,
                                child: Center(
                                  child: Text(
                                    'BACK',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is DetailViewException) {
                    return Container();
                  }
                  return Container();
                })),
      ),
    );
  }

  Widget mainContent(String value) {
    try {
      Uint8List bytes = base64Decode(value);
      return Center(child: Image.memory(bytes));
    } catch (e) {
      return const Text("Failed to load image");
    }
  }
}
