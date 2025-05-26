import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/asset_opname_detail/bloc/print/bloc.dart';
import 'package:mobile_so/features/asset_opname_detail/bloc/reserved/bloc.dart';
import 'package:mobile_so/features/asset_opname_detail/content_data_widget.dart';
import 'package:mobile_so/features/asset_opname_detail/data/arguments_asset_grow.dart';
import 'package:mobile_so/features/asset_opname_detail/data/data_content.dart';
import 'package:mobile_so/features/asset_opname_detail/domain/repo/asset_grow_repo.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/map_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

class AssetOpnameDetailScreen extends StatefulWidget {
  const AssetOpnameDetailScreen({super.key, required this.argumentsAssetGrow});

  final ArgumentsAssetGrow argumentsAssetGrow;

  @override
  State<AssetOpnameDetailScreen> createState() =>
      _AssetOpnameDetailScreenState();
}

class _AssetOpnameDetailScreenState extends State<AssetOpnameDetailScreen> {
  List<DataContent> dataContent = [];
  ReservedBloc reservedBloc = ReservedBloc(assetGrowRepo: AssetGrowRepo());
  PrintBloc printBloc = PrintBloc(assetGrowRepo: AssetGrowRepo());
  bool isLoading = false;
  double rating = 0.0;
  bool isFromReserve = false;

  @override
  void initState() {
    setState(() {
      rating = widget
          .argumentsAssetGrow.assetGrowResponseModel.data![0].averageRating!;
      if (widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
              .assetTypeCode ==
          'VHCL') {
        setState(() {
          dataContent.add(DataContent(
              'Item',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].code!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].itemName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'FA Type & Category',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].categoryName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Merk - Model - Type',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].merkName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].modelName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].typeName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Colour',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .colourName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Manufacturing Year',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .manufactureYear!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Chasis No.',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .chassisNo!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Engine No.',
              widget
                  .argumentsAssetGrow.assetGrowResponseModel.data![0].engineNo!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Cylinder Capacity',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .cylinderCapacity!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Fuel Type',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .fuelTypeName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Passenger Capacity',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .passengerCapacity!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'License Plate',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0].platNo!,
              false,
              false, []));
          dataContent.add(DataContent(
              'BPKB No. / SPPBPKB',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].bpkbNo!} / ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].spbpkbNo!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'STNK No.',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0].stnkNo!,
              false,
              false, []));
          dataContent.add(DataContent(
              'STNK Tax Date',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .stnkTaxDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'STNK Exp. Date',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .stnkExpiredDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Insured',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].isInsured!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].numberOfCoverage!} year',
              false,
              false, []));
          dataContent.add(DataContent(
              'Coverage Type',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .coverageType!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Factory Warranty',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                          .factoryWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyEndDate!}'
                  : widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                              .factoryWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Warranty',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                          .vendorWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyEndDate!}'
                  : widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                              .vendorWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Maintenance Routine',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceEndDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Purchase Date',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .purchaseDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Purchase Asset Condition',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .condition!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'PO No. & PO Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'GRN No. & GRN Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Invoice No. & Invoice Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .vendorName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Rating',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .averageRating!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Depreciation',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].methodTypeComm!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Asset Location',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].locationName!}',
              true,
              false, []));
        });
      } else if (widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
              .assetTypeCode ==
          'LAND') {
        dataContent.add(DataContent(
            'Item',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].code!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].itemName!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'FA Type & Category',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].itemName!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Certificate No.',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .certificateNo!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Certificate Type.',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .certificateTypeName!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Land Type',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .landTypeName!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                        .certificateTypeCode ==
                    'SGS.2409.00014'
                ? 'Certificate Issue Date | Exp. Date'
                : 'Certificate Issue Date',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                        .certificateTypeCode ==
                    'SGS.2409.00014'
                ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].issuanceDate!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].certificateExpiredDate!}'
                : widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .issuanceDate!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Length (m) | Width (m)',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].landL!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].landW!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Owner',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0].owner!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Land Address',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0].address!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Insured',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                        .isInsured! ==
                    'No'
                ? widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .isInsured!
                : '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].isInsured!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].numberOfCoverage ?? '0'} year',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Coverage Type',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .coverageType!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Maintenance Routine',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceEndDate!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));

        dataContent.add(DataContent(
            'Purchase Date',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .purchaseDate!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Purchase Asset Condition',
            widget
                .argumentsAssetGrow.assetGrowResponseModel.data![0].condition!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'PO No. & PO Date',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseDate!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'GRN No. & GRN Date',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnDate!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Invoice No. & Invoice Date',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceDate!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Vendor',
            widget
                .argumentsAssetGrow.assetGrowResponseModel.data![0].vendorName!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Vendor Rating',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .averageRating!
                .toString(),
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Depreciation',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].methodTypeComm!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Asset Location',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].locationName!}',
            true,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
      } else if (widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
              .assetTypeCode ==
          'BLDG') {
        dataContent.add(DataContent(
            'Item',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].itemCode!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].itemName!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'FA Type & Category',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].categoryName!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Certificate No.',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .certificateNo!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Certificate Type.',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .certificateTypeName!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                        .certificateTypeCode ==
                    'SGS.2409.00007'
                ? 'Certificate Issue Date | Exp. Date'
                : 'Certificate Issue Date',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                        .certificateTypeCode ==
                    'SGS.2409.00007'
                ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].issuanceDate!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].certificateExpiredDate!}'
                : widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .issuanceDate!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));

        dataContent.add(DataContent(
            'IMB No.',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0].imbNo!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'NIB No.',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0].nibNo!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Building Area (m2) | Wide Site (m2)',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].buildingSizeLt!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].buildingSizeLb!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Building Type | Number of Floor',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].buildingTypeName!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].numberOfFloor!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Owner',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0].owner!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Building Address',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0].address!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Building Year | Acquisition Year',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].builtYear!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].acquisitionYear!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Property Facility Info',
            '-',
            false,
            true,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Insured',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                        .isInsured! ==
                    'No'
                ? widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .isInsured!
                : '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].isInsured!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].numberOfCoverage ?? '0'} year',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Coverage Type',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .coverageType ??
                '-',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));

        dataContent.add(DataContent(
            'Vendor Warranty',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                        .vendorWarrantyPeriodTypeName!
                        .toUpperCase() ==
                    'PERIODIC'
                ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyEndDate!}'
                : widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                            .vendorWarrantyPeriodTypeName!
                            .toUpperCase() ==
                        'LIFETIME'
                    ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyStartDate!}'
                    : '-',
            false,
            false,
            []));
        dataContent.add(DataContent(
            'Maintenance Routine',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceEndDate!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));

        dataContent.add(DataContent(
            'Purchase Date',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .purchaseDate!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Purchase Asset Condition',
            widget
                .argumentsAssetGrow.assetGrowResponseModel.data![0].condition!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'PO No. & PO Date',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseDate!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'GRN No. & GRN Date',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnDate!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Invoice No. & Invoice Date',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceDate!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Vendor',
            widget
                .argumentsAssetGrow.assetGrowResponseModel.data![0].vendorName!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Vendor Rating',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .averageRating!
                .toString(),
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Depreciation',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].methodTypeComm!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Asset Location',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].locationName!}',
            true,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .propertyFacility!));
      } else if (widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
              .assetTypeCode ==
          'FNTR') {
        setState(() {
          dataContent.add(DataContent(
              'Item',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].code!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].itemName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'FA Type & Category',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].categoryName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Merk - Model - Type',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].merkName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].modelName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].typeName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Colour',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .colourName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Length (cm)',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0].length!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Width (cm)',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0].width!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Height (cm)',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0].height!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Weight (gram)',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0].weight!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Factory Warranty',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                          .factoryWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyEndDate!}'
                  : widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                              .factoryWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Warranty',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                          .vendorWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyEndDate!}'
                  : widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                              .vendorWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Maintenance Routine',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceEndDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Purchase Date',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .purchaseDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Purchase Asset Condition',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .condition!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'PO No. & PO Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'GRN No. & GRN Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Invoice No. & Invoice Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .vendorName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Rating',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .averageRating!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Depreciation',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].methodTypeComm!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Asset Location',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].locationName!}',
              true,
              false, []));
        });
      } else if (widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
              .assetTypeCode ==
          'HEVQ') {
        setState(() {
          dataContent.add(DataContent(
              'Item',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].code!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].itemName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'FA Type & Category',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].categoryName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Merk - Model - Type',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].merkName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].modelName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].typeName!}',
              false,
              false, []));

          dataContent.add(DataContent(
              'Manufacturing Year',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .manufactureYear!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Fuel Type',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .fuelTypeName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Serial No.',
              widget
                  .argumentsAssetGrow.assetGrowResponseModel.data![0].serialNo!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'BPKB No.',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0].bpkbNo!,
              false,
              false, []));
          dataContent.add(DataContent(
              'BPKB Name.',
              widget
                  .argumentsAssetGrow.assetGrowResponseModel.data![0].bpkbName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'STNK No.',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0].stnkNo!,
              false,
              false, []));
          dataContent.add(DataContent(
              'STNK Tax Date',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .stnkTaxDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'STNK Exp. Date',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .stnkExpiredDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Dimension - Length (cm)',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .dimensionLength!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Dimension - Width (cm)',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .dimensionWidth!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Dimension - Weight (cm)',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0].weight!
                  .toString(),
              false,
              false,
              []));

          dataContent.add(DataContent(
              'Insured',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].isInsured!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].numberOfCoverage!} year',
              false,
              false, []));
          dataContent.add(DataContent(
              'Coverage Type',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .coverageType!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Factory Warranty',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                          .factoryWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyEndDate!}'
                  : widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                              .factoryWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Warranty',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                          .vendorWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyEndDate!}'
                  : widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                              .vendorWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Maintenance Routine',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceEndDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Purchase Date',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .purchaseDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Purchase Asset Condition',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .condition!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'PO No. & PO Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'GRN No. & GRN Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Invoice No. & Invoice Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .vendorName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Rating',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .averageRating!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Depreciation',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].methodTypeComm!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Asset Location',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].locationName!}',
              true,
              false, []));
        });
      } else if (widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
              .assetTypeCode ==
          'MCHN') {
        setState(() {
          dataContent.add(DataContent(
              'Item',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].code!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].itemName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'FA Type & Category',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].categoryName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Merk - Model - Type',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].merkName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].modelName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].typeName!}',
              false,
              false, []));

          dataContent.add(DataContent(
              'Manufacturing Year',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .manufactureYear!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Fuel Type',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .fuelTypeName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Serial No.',
              widget
                  .argumentsAssetGrow.assetGrowResponseModel.data![0].serialNo!,
              false,
              false,
              []));

          dataContent.add(DataContent(
              'Insured',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].isInsured!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].numberOfCoverage!} year',
              false,
              false, []));
          dataContent.add(DataContent(
              'Coverage Type',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .coverageType!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Factory Warranty',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                          .factoryWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyEndDate!}'
                  : widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                              .factoryWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Warranty',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                          .vendorWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyEndDate!}'
                  : widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                              .vendorWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Maintenance Routine',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceEndDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Purchase Date',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .purchaseDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Purchase Asset Condition',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .condition!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'PO No. & PO Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'GRN No. & GRN Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Invoice No. & Invoice Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .vendorName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Rating',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .averageRating!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Depreciation',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].methodTypeComm!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Asset Location',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].locationName!}',
              true,
              false, []));
        });
      } else if (widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
              .assetTypeCode ==
          'SOFT') {
        setState(() {
          dataContent.add(DataContent(
              'Item',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].code!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].itemName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'FA Type & Category',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].categoryName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Software Version',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .softwareVersion!,
              false,
              false,
              []));

          dataContent.add(DataContent(
              'License Key',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .licenseKey!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'License Type',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .licenseTypeName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'License Qty',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .licenseQuantity!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'License Status',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .licenseStatusName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'License Exp. Date',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .licenseExpDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Insured',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                          .isInsured! ==
                      'No'
                  ? widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                      .isInsured!
                  : '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].isInsured!} -  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].numberOfCoverage ?? '0'} year',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Coverage Type',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                      .coverageType ??
                  '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Factory Warranty',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                          .factoryWarrantyPeriodTypeName !=
                      null
                  ? widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                              .factoryWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'PERIODIC'
                      ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyEndDate!}'
                      : widget.argumentsAssetGrow.assetGrowResponseModel
                                  .data![0].factoryWarrantyPeriodTypeName!
                                  .toUpperCase() ==
                              'LIFETIME'
                          ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyStartDate!}'
                          : '-'
                  : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Warranty',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                          .vendorWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyEndDate!}'
                  : widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                              .vendorWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Maintenance Routine',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceEndDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Purchase Date',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .purchaseDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Purchase Asset Condition',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .condition!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'PO No. & PO Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'GRN No. & GRN Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Invoice No. & Invoice Date',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .vendorName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Rating',
              widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                  .averageRating!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Depreciation',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].methodTypeComm!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Asset Location',
              '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].locationName!}',
              true,
              false, []));
        });
      } else {
        dataContent.add(DataContent(
            'Item',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].code!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].itemName!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'FA Type & Category',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].categoryName!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Merk - Model - Type',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].merkName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].modelName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].typeName!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Asset Specification',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .assetSpecification ??
                '-',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));

        dataContent.add(DataContent(
            'Insured',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                        .isInsured! ==
                    'No'
                ? widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .isInsured!
                : '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].isInsured!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].numberOfCoverage!} year',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Coverage Type',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .coverageType!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Factory Warranty',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                        .factoryWarrantyPeriodTypeName!
                        .toUpperCase() ==
                    'PERIODIC'
                ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyEndDate!}'
                : widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                            .factoryWarrantyPeriodTypeName!
                            .toUpperCase() ==
                        'LIFETIME'
                    ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].factoryWarrantyStartDate!}'
                    : '-',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Vendor Warranty',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                        .vendorWarrantyPeriodTypeName!
                        .toUpperCase() ==
                    'PERIODIC'
                ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyEndDate!}'
                : widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                            .vendorWarrantyPeriodTypeName!
                            .toUpperCase() ==
                        'LIFETIME'
                    ? '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].vendorWarrantyStartDate!}'
                    : '-',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Maintenance Routine',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].maintenanceEndDate!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Depreciation Commercial',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].depreCategoryCommName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].depreCategoryCommName!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Depreciation Commercial',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].depreCategoryFiscalName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].depreCategoryFiscalName!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Purchase Date',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .purchaseDate!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Purchase Asset Condition',
            widget
                .argumentsAssetGrow.assetGrowResponseModel.data![0].condition!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'PO No. & PO Date',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].purchaseDate!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'GRN No. & GRN Date',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].grnDate!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Invoice No. & Invoice Date',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].invoiceDate!}',
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Vendor',
            widget
                .argumentsAssetGrow.assetGrowResponseModel.data![0].vendorName!,
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Vendor Rating',
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                .averageRating!
                .toString(),
            false,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));

        dataContent.add(DataContent(
            'Asset Location',
            '${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].locationName!}',
            true,
            false,
            widget.argumentsAssetGrow.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
      }
    });
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
              Text('Asset Opname',
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: GeneralUtil.fontSize(context) * 0.65,
                      color: Colors.white)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            shrinkWrap: true,
            children: [
              Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFbfbfbf), width: 2.5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.argumentsAssetGrow.assetGrowResponseModel
                            .data![0].itemName!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: GeneralUtil.fontSize(context) * 0.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              children: [
                                Image.asset(
                                    widget.argumentsAssetGrow.assetGrowResponseModel.data![0].status!
                                                .toLowerCase() ==
                                            'available'
                                        ? 'assets/icons/available.png'
                                        : widget
                                                    .argumentsAssetGrow
                                                    .assetGrowResponseModel
                                                    .data![0]
                                                    .status!
                                                    .toLowerCase() ==
                                                'new'
                                            ? 'assets/icons/new.png'
                                            : widget
                                                        .argumentsAssetGrow
                                                        .assetGrowResponseModel
                                                        .data![0]
                                                        .status!
                                                        .toLowerCase() ==
                                                    'on progress'
                                                ? 'assets/icons/onprogres.png'
                                                : widget
                                                            .argumentsAssetGrow
                                                            .assetGrowResponseModel
                                                            .data![0]
                                                            .status!
                                                            .toLowerCase() ==
                                                        'sold'
                                                    ? 'assets/icons/sold.png'
                                                    : widget
                                                                .argumentsAssetGrow
                                                                .assetGrowResponseModel
                                                                .data![0]
                                                                .status!
                                                                .toLowerCase() ==
                                                            'disposed'
                                                        ? 'assets/icons/disposed.png'
                                                        : widget
                                                                    .argumentsAssetGrow
                                                                    .assetGrowResponseModel
                                                                    .data![0]
                                                                    .status!
                                                                    .toLowerCase() ==
                                                                'on repair'
                                                            ? 'assets/icons/onrepair.png'
                                                            : widget.argumentsAssetGrow.assetGrowResponseModel.data![0].status!.toLowerCase() == 'maintenance'
                                                                ? 'assets/icons/maintenance.png'
                                                                : widget.argumentsAssetGrow.assetGrowResponseModel.data![0].status!.toLowerCase() == 'used'
                                                                    ? 'assets/icons/used.png'
                                                                    : widget.argumentsAssetGrow.assetGrowResponseModel.data![0].status!.toLowerCase() == 'booked'
                                                                        ? 'assets/icons/booked.png'
                                                                        : widget.argumentsAssetGrow.assetGrowResponseModel.data![0].status!.toLowerCase() == 'rejected'
                                                                            ? 'assets/icons/rejected.png'
                                                                            : 'assets/icons/cancel.png',
                                    width: 90),
                                SizedBox(
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 65,
                                      height: 65,
                                      child: PrettyQrView.data(
                                          data: widget
                                              .argumentsAssetGrow
                                              .assetGrowResponseModel
                                              .data![0]
                                              .barcode!,
                                          decoration: const PrettyQrDecoration(
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
                                            GeneralUtil().showSnackBarSuccess(
                                                context,
                                                'Request print successfully');
                                          }
                                          if (state is PrintError) {
                                            GeneralUtil().showSnackBarError(
                                                context, state.error!);
                                          }
                                          if (state is PrintException) {
                                            if (state.error.toLowerCase() ==
                                                'unauthorized access') {
                                              GeneralUtil().showSnackBarError(
                                                  context, 'Session Expired');
                                              var bottomBarProvider =
                                                  Provider.of<NavbarProvider>(
                                                      context,
                                                      listen: false);
                                              bottomBarProvider.setPage(0);
                                              bottomBarProvider.setTab(0);
                                              SharedPrefUtil.clearSharedPref();
                                              Future.delayed(
                                                  const Duration(seconds: 1),
                                                  () {
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        StringRouterUtil
                                                            .loginScreenRoute,
                                                        (route) => false);
                                              });
                                            } else {
                                              GeneralUtil().showSnackBarError(
                                                  context, state.error);
                                            }
                                          }
                                        },
                                        child: BlocBuilder(
                                            bloc: printBloc,
                                            builder:
                                                (context, PrintState state) {
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
                                                    printBloc.add(PrintAttempt(
                                                        assetCode: widget
                                                            .argumentsAssetGrow
                                                            .assetGrowResponseModel
                                                            .data![0]
                                                            .code!));
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
                                                  printBloc.add(PrintAttempt(
                                                      assetCode: widget
                                                          .argumentsAssetGrow
                                                          .assetGrowResponseModel
                                                          .data![0]
                                                          .code!));
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
                                  widget.argumentsAssetGrow
                                      .assetGrowResponseModel.data![0].barcode!,
                                  style: TextStyle(
                                      fontSize:
                                          GeneralUtil.fontSize(context) * 0.4,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Asset No : ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].code!}',
                              style: TextStyle(
                                  fontSize:
                                      GeneralUtil.fontSize(context) * 0.45,
                                  color: Colors.white),
                            ),
                            Text(
                              'Usefull life : ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].usefull!} Years',
                              style: TextStyle(
                                  fontSize:
                                      GeneralUtil.fontSize(context) * 0.45,
                                  color: Colors.white),
                            ),
                            Text(
                              'Branch Location : ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].locationName!}',
                              style: TextStyle(
                                  fontSize:
                                      GeneralUtil.fontSize(context) * 0.45,
                                  color: Colors.white),
                            ),
                            Text(
                              'PIC : ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].picCode!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].picName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].picPositionName!}',
                              style: TextStyle(
                                  fontSize:
                                      GeneralUtil.fontSize(context) * 0.45,
                                  color: Colors.white),
                            ),
                            Text(
                              'User : ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].userCode!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].userName!} - ${widget.argumentsAssetGrow.assetGrowResponseModel.data![0].userPositionName!}',
                              style: TextStyle(
                                  fontSize:
                                      GeneralUtil.fontSize(context) * 0.45,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListView.separated(
                itemCount: dataContent.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                itemBuilder: (context, index) {
                  return dataContent.isEmpty
                      ? Container()
                      : dataContent[index].isLocation == false &&
                              dataContent[index].isPropertyFacility == false
                          ? ContentDataWidget(
                              title: dataContent[index].title,
                              content: dataContent[index].value,
                              rating: rating,
                            )
                          : dataContent[index].isPropertyFacility == true &&
                                  dataContent[index].isLocation == false
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataContent[index].title,
                                      style: TextStyle(
                                          fontSize:
                                              GeneralUtil.fontSize(context) *
                                                  0.6,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    ListView.separated(
                                        shrinkWrap: true,
                                        itemBuilder: ((context, indexes) {
                                          return Text(
                                            '${dataContent[index].propertyFacility[indexes].no!}. ${dataContent[index].propertyFacility[indexes].propertyFacilityName!}',
                                            style: TextStyle(
                                                fontSize: GeneralUtil.fontSize(
                                                        context) *
                                                    0.5,
                                                color: Color(0xFFbfbfbf)),
                                          );
                                        }),
                                        separatorBuilder: ((context, index) {
                                          return const SizedBox(height: 4);
                                        }),
                                        itemCount: dataContent[index]
                                            .propertyFacility
                                            .length),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(bottom: 8),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Color(0xFFE6E7E8)),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataContent[index].title,
                                      style: TextStyle(
                                          fontSize:
                                              GeneralUtil.fontSize(context) *
                                                  0.6,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFE6E7E8)),
                                            ),
                                          ),
                                          child: Text(
                                            dataContent[index].value,
                                            style: TextStyle(
                                                fontSize: GeneralUtil.fontSize(
                                                        context) *
                                                    0.5,
                                                color: Color(0xFFbfbfbf)),
                                          ),
                                        ),
                                        Positioned(
                                          right: 8,
                                          top: 0,
                                          bottom: 8,
                                          child: GestureDetector(
                                            onTap: () {
                                              MapUtil.openMap(
                                                  double.parse(widget
                                                      .argumentsAssetGrow
                                                      .assetGrowResponseModel
                                                      .data![0]
                                                      .latitude!),
                                                  double.parse(widget
                                                      .argumentsAssetGrow
                                                      .assetGrowResponseModel
                                                      .data![0]
                                                      .longitude!),
                                                  widget
                                                      .argumentsAssetGrow
                                                      .assetGrowResponseModel
                                                      .data![0]
                                                      .locationName!);
                                            },
                                            child: Image.asset(
                                              'assets/imgs/map.png',
                                              width: 40,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Visibility(
                  visible: !widget.argumentsAssetGrow.isInput,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocListener(
                          bloc: reservedBloc,
                          listener: (_, ReservedState state) {
                            if (state is ReservedLoading) {
                              setState(() {
                                isLoading = true;
                              });
                            }
                            if (state is ReservedLoaded) {
                              setState(() {
                                isLoading = false;
                              });
                              GeneralUtil().showSnackBarSuccess(
                                  context, 'Reserved Successfully!');
                              if (!isFromReserve) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                Navigator.pushNamed(
                                    context,
                                    StringRouterUtil
                                        .assetOpnameDetailFormScreenRoute,
                                    arguments: widget.argumentsAssetGrow
                                        .assetGrowResponseModel.data![0]);
                              }
                            }
                            if (state is ReservedError) {
                              GeneralUtil()
                                  .showSnackBarError(context, state.error!);
                              setState(() {
                                isLoading = false;
                              });
                            }
                            if (state is ReservedException) {
                              if (state.error.toLowerCase() ==
                                  'unauthorized access') {
                                GeneralUtil().showSnackBarError(
                                    context, 'Session Expired');
                                var bottomBarProvider =
                                    Provider.of<NavbarProvider>(context,
                                        listen: false);
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
                                setState(() {
                                  isLoading = false;
                                });
                                GeneralUtil()
                                    .showSnackBarError(context, state.error);
                              }
                            }
                          },
                          child: BlocBuilder(
                              bloc: reservedBloc,
                              builder: (_, ReservedState state) {
                                return isLoading
                                    ? const Center(
                                        child: SizedBox(
                                          width: 66,
                                          height: 66,
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: widget
                                                        .argumentsAssetGrow
                                                        .assetGrowResponseModel
                                                        .data![0]
                                                        .isOpnameReserved! ==
                                                    '' ||
                                                widget
                                                        .argumentsAssetGrow
                                                        .assetGrowResponseModel
                                                        .data![0]
                                                        .isOpnameReserved! ==
                                                    '0' ||
                                                isFromReserve
                                            ? null
                                            : () {
                                                setState(() {
                                                  isFromReserve = true;
                                                });
                                                reservedBloc.add(ReservedAttempt(
                                                    assetCode: widget
                                                        .argumentsAssetGrow
                                                        .assetGrowResponseModel
                                                        .data![0]
                                                        .code!));
                                              },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          height: 66,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: widget
                                                                .argumentsAssetGrow
                                                                .assetGrowResponseModel
                                                                .data![0]
                                                                .isOpnameReserved! ==
                                                            '' ||
                                                        widget
                                                                .argumentsAssetGrow
                                                                .assetGrowResponseModel
                                                                .data![0]
                                                                .isOpnameReserved! ==
                                                            '0' ||
                                                        isFromReserve
                                                    ? [Colors.grey, Colors.grey]
                                                    : [
                                                        const Color(0xFF5DE0E6),
                                                        const Color(0xFF004AAD)
                                                      ],
                                                begin: const FractionalOffset(
                                                    0.0, 0.0),
                                                end: const FractionalOffset(
                                                    1.0, 0.0),
                                                stops: const [0.0, 1.0],
                                                tileMode: TileMode.clamp),
                                            borderRadius:
                                                BorderRadius.circular(28),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('RESERVED',
                                                  style: TextStyle(
                                                      fontSize:
                                                          GeneralUtil.fontSize(
                                                                  context) *
                                                              0.6,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ],
                                          ),
                                        ),
                                      );
                              })),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: widget.argumentsAssetGrow.assetGrowResponseModel
                                    .data![0].isOpnameReserved! ==
                                ''
                            ? null
                            : () {
                                if (widget
                                            .argumentsAssetGrow
                                            .assetGrowResponseModel
                                            .data![0]
                                            .isOpnameReserved! ==
                                        '1' &&
                                    !isFromReserve) {
                                  reservedBloc.add(ReservedAttempt(
                                      assetCode: widget
                                          .argumentsAssetGrow
                                          .assetGrowResponseModel
                                          .data![0]
                                          .code!));
                                } else {
                                  Navigator.pushNamed(
                                      context,
                                      StringRouterUtil
                                          .assetOpnameDetailFormScreenRoute,
                                      arguments: widget.argumentsAssetGrow
                                          .assetGrowResponseModel.data![0]);
                                }
                              },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 66,
                          decoration: BoxDecoration(
                            color: widget
                                        .argumentsAssetGrow
                                        .assetGrowResponseModel
                                        .data![0]
                                        .isOpnameReserved! ==
                                    ''
                                ? Colors.grey
                                : Colors.green,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('OPNAME',
                                  style: TextStyle(
                                      fontSize:
                                          GeneralUtil.fontSize(context) * 0.6,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ]),
    );
  }
}
