import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/argument_add_request.dart';
import 'package:mobile_so/features/asset_opname_detail/content_data_widget.dart';
import 'package:mobile_so/features/asset_opname_detail/data/arguments_asset_grow.dart';
import 'package:mobile_so/features/asset_opname_detail/data/data_content.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/map_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

class AdditionalRequestDetailScreen extends StatefulWidget {
  const AdditionalRequestDetailScreen(
      {super.key, required this.argumentAddReq});

  final ArgumentAddReq argumentAddReq;
  @override
  State<AdditionalRequestDetailScreen> createState() =>
      _AdditionalRequestDetailScreenState();
}

class _AdditionalRequestDetailScreenState
    extends State<AdditionalRequestDetailScreen> {
  List<DataContent> dataContent = [];
  double rating = 0.0;

  @override
  void initState() {
    setState(() {
      rating =
          widget.argumentAddReq.assetGrowResponseModel.data![0].averageRating!;
      if (widget.argumentAddReq.assetGrowResponseModel.data![0].assetTypeCode ==
          'VHCL') {
        setState(() {
          dataContent.add(DataContent(
              'Item',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].code!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].itemName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'FA Type & Category',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].categoryName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Merk - Model - Type',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].merkName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].modelName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].typeName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Colour',
              widget.argumentAddReq.assetGrowResponseModel.data![0].colourName!,
              false,
              false, []));
          dataContent.add(DataContent(
              'Manufacturing Year',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                  .manufactureYear!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Chasis No.',
              widget.argumentAddReq.assetGrowResponseModel.data![0].chassisNo!,
              false,
              false, []));
          dataContent.add(DataContent(
              'Engine No.',
              widget.argumentAddReq.assetGrowResponseModel.data![0].engineNo!,
              false,
              false, []));
          dataContent.add(DataContent(
              'Cylinder Capacity',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                  .cylinderCapacity!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Fuel Type',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].fuelTypeName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Passenger Capacity',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                  .passengerCapacity!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'License Plate',
              widget.argumentAddReq.assetGrowResponseModel.data![0].platNo!,
              false,
              false, []));
          dataContent.add(DataContent(
              'BPKB No. / SPPBPKB',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].bpkbNo!} / ${widget.argumentAddReq.assetGrowResponseModel.data![0].spbpkbNo!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'STNK No.',
              widget.argumentAddReq.assetGrowResponseModel.data![0].stnkNo!,
              false,
              false, []));
          dataContent.add(DataContent(
              'STNK Tax Date',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].stnkTaxDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'STNK Exp. Date',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                  .stnkExpiredDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Insured',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].isInsured!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].numberOfCoverage!} year',
              false,
              false, []));
          dataContent.add(DataContent(
              'Coverage Type',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].coverageType!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Factory Warranty',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                          .factoryWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyEndDate!}'
                  : widget.argumentAddReq.assetGrowResponseModel.data![0]
                              .factoryWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Warranty',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                          .vendorWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyEndDate!}'
                  : widget.argumentAddReq.assetGrowResponseModel.data![0]
                              .vendorWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Maintenance Routine',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceEndDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Purchase Date',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Purchase Asset Condition',
              widget.argumentAddReq.assetGrowResponseModel.data![0].condition!,
              false,
              false, []));
          dataContent.add(DataContent(
              'PO No. & PO Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'GRN No. & GRN Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].grnDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Invoice No. & Invoice Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor',
              widget.argumentAddReq.assetGrowResponseModel.data![0].vendorName!,
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor Rating',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].averageRating!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Depreciation',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentAddReq.assetGrowResponseModel.data![0].methodTypeComm!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Asset Location',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].locationName!}',
              true,
              false, []));
        });
      } else if (widget
              .argumentAddReq.assetGrowResponseModel.data![0].assetTypeCode ==
          'LAND') {
        dataContent.add(DataContent(
            'Item',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].code!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].itemName!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'FA Type & Category',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].itemName!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Certificate No.',
            widget
                .argumentAddReq.assetGrowResponseModel.data![0].certificateNo!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Certificate Type.',
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .certificateTypeName!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Land Type',
            widget.argumentAddReq.assetGrowResponseModel.data![0].landTypeName!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                        .certificateTypeCode ==
                    'SGS.2409.00014'
                ? 'Certificate Issue Date | Exp. Date'
                : 'Certificate Issue Date',
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                        .certificateTypeCode ==
                    'SGS.2409.00014'
                ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].issuanceDate!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].certificateExpiredDate!}'
                : widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .issuanceDate!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Length (m) | Width (m)',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].landL!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].landW!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Owner',
            widget.argumentAddReq.assetGrowResponseModel.data![0].owner!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Land Address',
            widget.argumentAddReq.assetGrowResponseModel.data![0].address!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Insured',
            widget.argumentAddReq.assetGrowResponseModel.data![0].isInsured! ==
                    'No'
                ? widget
                    .argumentAddReq.assetGrowResponseModel.data![0].isInsured!
                : '${widget.argumentAddReq.assetGrowResponseModel.data![0].isInsured!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].numberOfCoverage ?? '0'} year',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Coverage Type',
            widget.argumentAddReq.assetGrowResponseModel.data![0].coverageType!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Maintenance Routine',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceEndDate!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));

        dataContent.add(DataContent(
            'Purchase Date',
            widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Purchase Asset Condition',
            widget.argumentAddReq.assetGrowResponseModel.data![0].condition!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'PO No. & PO Date',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'GRN No. & GRN Date',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].grnDate!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Invoice No. & Invoice Date',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceDate!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Vendor',
            widget.argumentAddReq.assetGrowResponseModel.data![0].vendorName!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Vendor Rating',
            widget.argumentAddReq.assetGrowResponseModel.data![0].averageRating!
                .toString(),
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Depreciation',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentAddReq.assetGrowResponseModel.data![0].methodTypeComm!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Asset Location',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].locationName!}',
            true,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
      } else if (widget
              .argumentAddReq.assetGrowResponseModel.data![0].assetTypeCode ==
          'BLDG') {
        dataContent.add(DataContent(
            'Item',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].itemCode!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].itemName!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'FA Type & Category',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].categoryName!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Certificate No.',
            widget
                .argumentAddReq.assetGrowResponseModel.data![0].certificateNo!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Certificate Type.',
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .certificateTypeName!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                        .certificateTypeCode ==
                    'SGS.2409.00007'
                ? 'Certificate Issue Date | Exp. Date'
                : 'Certificate Issue Date',
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                        .certificateTypeCode ==
                    'SGS.2409.00007'
                ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].issuanceDate!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].certificateExpiredDate!}'
                : widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .issuanceDate!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));

        dataContent.add(DataContent(
            'IMB No.',
            widget.argumentAddReq.assetGrowResponseModel.data![0].imbNo!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'NIB No.',
            widget.argumentAddReq.assetGrowResponseModel.data![0].nibNo!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Building Area (m2) | Wide Site (m2)',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].buildingSizeLt!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].buildingSizeLb!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Building Type | Number of Floor',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].buildingTypeName!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].numberOfFloor!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Owner',
            widget.argumentAddReq.assetGrowResponseModel.data![0].owner!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Building Address',
            widget.argumentAddReq.assetGrowResponseModel.data![0].address!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Building Year | Acquisition Year',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].builtYear!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].acquisitionYear!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Property Facility Info',
            '-',
            false,
            true,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Insured',
            widget.argumentAddReq.assetGrowResponseModel.data![0].isInsured! ==
                    'No'
                ? widget
                    .argumentAddReq.assetGrowResponseModel.data![0].isInsured!
                : '${widget.argumentAddReq.assetGrowResponseModel.data![0].isInsured!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].numberOfCoverage ?? '0'} year',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Coverage Type',
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .coverageType ??
                '-',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));

        dataContent.add(DataContent(
            'Vendor Warranty',
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                        .vendorWarrantyPeriodTypeName!
                        .toUpperCase() ==
                    'PERIODIC'
                ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyEndDate!}'
                : widget.argumentAddReq.assetGrowResponseModel.data![0]
                            .vendorWarrantyPeriodTypeName!
                            .toUpperCase() ==
                        'LIFETIME'
                    ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyStartDate!}'
                    : '-',
            false,
            false,
            []));
        dataContent.add(DataContent(
            'Maintenance Routine',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceEndDate!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));

        dataContent.add(DataContent(
            'Purchase Date',
            widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Purchase Asset Condition',
            widget.argumentAddReq.assetGrowResponseModel.data![0].condition!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'PO No. & PO Date',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'GRN No. & GRN Date',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].grnDate!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Invoice No. & Invoice Date',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceDate!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Vendor',
            widget.argumentAddReq.assetGrowResponseModel.data![0].vendorName!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Vendor Rating',
            widget.argumentAddReq.assetGrowResponseModel.data![0].averageRating!
                .toString(),
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Depreciation',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentAddReq.assetGrowResponseModel.data![0].methodTypeComm!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
        dataContent.add(DataContent(
            'Asset Location',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].locationName!}',
            true,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                .propertyFacility!));
      } else if (widget
              .argumentAddReq.assetGrowResponseModel.data![0].assetTypeCode ==
          'FNTR') {
        setState(() {
          dataContent.add(DataContent(
              'Item',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].code!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].itemName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'FA Type & Category',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].categoryName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Merk - Model - Type',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].merkName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].modelName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].typeName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Colour',
              widget.argumentAddReq.assetGrowResponseModel.data![0].colourName!,
              false,
              false, []));
          dataContent.add(DataContent(
              'Length (cm)',
              widget.argumentAddReq.assetGrowResponseModel.data![0].length!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Width (cm)',
              widget.argumentAddReq.assetGrowResponseModel.data![0].width!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Height (cm)',
              widget.argumentAddReq.assetGrowResponseModel.data![0].height!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Weight (gram)',
              widget.argumentAddReq.assetGrowResponseModel.data![0].weight!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Factory Warranty',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                          .factoryWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyEndDate!}'
                  : widget.argumentAddReq.assetGrowResponseModel.data![0]
                              .factoryWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Warranty',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                          .vendorWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyEndDate!}'
                  : widget.argumentAddReq.assetGrowResponseModel.data![0]
                              .vendorWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Maintenance Routine',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceEndDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Purchase Date',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Purchase Asset Condition',
              widget.argumentAddReq.assetGrowResponseModel.data![0].condition!,
              false,
              false, []));
          dataContent.add(DataContent(
              'PO No. & PO Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'GRN No. & GRN Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].grnDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Invoice No. & Invoice Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor',
              widget.argumentAddReq.assetGrowResponseModel.data![0].vendorName!,
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor Rating',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].averageRating!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Depreciation',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentAddReq.assetGrowResponseModel.data![0].methodTypeComm!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Asset Location',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].locationName!}',
              true,
              false, []));
        });
      } else if (widget
              .argumentAddReq.assetGrowResponseModel.data![0].assetTypeCode ==
          'HEVQ') {
        setState(() {
          dataContent.add(DataContent(
              'Item',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].code!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].itemName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'FA Type & Category',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].categoryName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Merk - Model - Type',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].merkName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].modelName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].typeName!}',
              false,
              false, []));

          dataContent.add(DataContent(
              'Manufacturing Year',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                  .manufactureYear!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Fuel Type',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].fuelTypeName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Serial No.',
              widget.argumentAddReq.assetGrowResponseModel.data![0].serialNo!,
              false,
              false, []));
          dataContent.add(DataContent(
              'BPKB No.',
              widget.argumentAddReq.assetGrowResponseModel.data![0].bpkbNo!,
              false,
              false, []));
          dataContent.add(DataContent(
              'BPKB Name.',
              widget.argumentAddReq.assetGrowResponseModel.data![0].bpkbName!,
              false,
              false, []));
          dataContent.add(DataContent(
              'STNK No.',
              widget.argumentAddReq.assetGrowResponseModel.data![0].stnkNo!,
              false,
              false, []));
          dataContent.add(DataContent(
              'STNK Tax Date',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].stnkTaxDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'STNK Exp. Date',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                  .stnkExpiredDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Dimension - Length (cm)',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                  .dimensionLength!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Dimension - Width (cm)',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                  .dimensionWidth!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Dimension - Weight (cm)',
              widget.argumentAddReq.assetGrowResponseModel.data![0].weight!
                  .toString(),
              false,
              false,
              []));

          dataContent.add(DataContent(
              'Insured',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].isInsured!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].numberOfCoverage!} year',
              false,
              false, []));
          dataContent.add(DataContent(
              'Coverage Type',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].coverageType!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Factory Warranty',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                          .factoryWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyEndDate!}'
                  : widget.argumentAddReq.assetGrowResponseModel.data![0]
                              .factoryWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Warranty',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                          .vendorWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyEndDate!}'
                  : widget.argumentAddReq.assetGrowResponseModel.data![0]
                              .vendorWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Maintenance Routine',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceEndDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Purchase Date',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Purchase Asset Condition',
              widget.argumentAddReq.assetGrowResponseModel.data![0].condition!,
              false,
              false, []));
          dataContent.add(DataContent(
              'PO No. & PO Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'GRN No. & GRN Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].grnDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Invoice No. & Invoice Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor',
              widget.argumentAddReq.assetGrowResponseModel.data![0].vendorName!,
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor Rating',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].averageRating!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Depreciation',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentAddReq.assetGrowResponseModel.data![0].methodTypeComm!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Asset Location',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].locationName!}',
              true,
              false, []));
        });
      } else if (widget
              .argumentAddReq.assetGrowResponseModel.data![0].assetTypeCode ==
          'MCHN') {
        setState(() {
          dataContent.add(DataContent(
              'Item',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].code!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].itemName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'FA Type & Category',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].categoryName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Merk - Model - Type',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].merkName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].modelName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].typeName!}',
              false,
              false, []));

          dataContent.add(DataContent(
              'Manufacturing Year',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                  .manufactureYear!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Fuel Type',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].fuelTypeName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Serial No.',
              widget.argumentAddReq.assetGrowResponseModel.data![0].serialNo!,
              false,
              false, []));

          dataContent.add(DataContent(
              'Insured',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].isInsured!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].numberOfCoverage!} year',
              false,
              false, []));
          dataContent.add(DataContent(
              'Coverage Type',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].coverageType!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Factory Warranty',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                          .factoryWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyEndDate!}'
                  : widget.argumentAddReq.assetGrowResponseModel.data![0]
                              .factoryWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Warranty',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                          .vendorWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyEndDate!}'
                  : widget.argumentAddReq.assetGrowResponseModel.data![0]
                              .vendorWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Maintenance Routine',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceEndDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Purchase Date',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Purchase Asset Condition',
              widget.argumentAddReq.assetGrowResponseModel.data![0].condition!,
              false,
              false, []));
          dataContent.add(DataContent(
              'PO No. & PO Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'GRN No. & GRN Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].grnDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Invoice No. & Invoice Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor',
              widget.argumentAddReq.assetGrowResponseModel.data![0].vendorName!,
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor Rating',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].averageRating!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Depreciation',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentAddReq.assetGrowResponseModel.data![0].methodTypeComm!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Asset Location',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].locationName!}',
              true,
              false, []));
        });
      } else if (widget
              .argumentAddReq.assetGrowResponseModel.data![0].assetTypeCode ==
          'SOFT') {
        setState(() {
          dataContent.add(DataContent(
              'Item',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].code!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].itemName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'FA Type & Category',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].categoryName!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Software Version',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                  .softwareVersion!,
              false,
              false,
              []));

          dataContent.add(DataContent(
              'License Key',
              widget.argumentAddReq.assetGrowResponseModel.data![0].licenseKey!,
              false,
              false, []));
          dataContent.add(DataContent(
              'License Type',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                  .licenseTypeName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'License Qty',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                  .licenseQuantity!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'License Status',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                  .licenseStatusName!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'License Exp. Date',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                  .licenseExpDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Insured',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                          .isInsured! ==
                      'No'
                  ? widget
                      .argumentAddReq.assetGrowResponseModel.data![0].isInsured!
                  : '${widget.argumentAddReq.assetGrowResponseModel.data![0].isInsured!} -  ${widget.argumentAddReq.assetGrowResponseModel.data![0].numberOfCoverage ?? '0'} year',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Coverage Type',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                      .coverageType ??
                  '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Factory Warranty',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                          .factoryWarrantyPeriodTypeName !=
                      null
                  ? widget.argumentAddReq.assetGrowResponseModel.data![0]
                              .factoryWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'PERIODIC'
                      ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyEndDate!}'
                      : widget.argumentAddReq.assetGrowResponseModel.data![0]
                                  .factoryWarrantyPeriodTypeName!
                                  .toUpperCase() ==
                              'LIFETIME'
                          ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyStartDate!}'
                          : '-'
                  : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Vendor Warranty',
              widget.argumentAddReq.assetGrowResponseModel.data![0]
                          .vendorWarrantyPeriodTypeName!
                          .toUpperCase() ==
                      'PERIODIC'
                  ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyEndDate!}'
                  : widget.argumentAddReq.assetGrowResponseModel.data![0]
                              .vendorWarrantyPeriodTypeName!
                              .toUpperCase() ==
                          'LIFETIME'
                      ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyStartDate!}'
                      : '-',
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Maintenance Routine',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceEndDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Purchase Date',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!,
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Purchase Asset Condition',
              widget.argumentAddReq.assetGrowResponseModel.data![0].condition!,
              false,
              false, []));
          dataContent.add(DataContent(
              'PO No. & PO Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'GRN No. & GRN Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].grnDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Invoice No. & Invoice Date',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceDate!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor',
              widget.argumentAddReq.assetGrowResponseModel.data![0].vendorName!,
              false,
              false, []));
          dataContent.add(DataContent(
              'Vendor Rating',
              widget
                  .argumentAddReq.assetGrowResponseModel.data![0].averageRating!
                  .toString(),
              false,
              false,
              []));
          dataContent.add(DataContent(
              'Depreciation',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentAddReq.assetGrowResponseModel.data![0].methodTypeComm!}',
              false,
              false, []));
          dataContent.add(DataContent(
              'Asset Location',
              '${widget.argumentAddReq.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].locationName!}',
              true,
              false, []));
        });
      } else {
        dataContent.add(DataContent(
            'Item',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].code!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].itemName!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'FA Type & Category',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].typeAndCategoryName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].categoryName!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Merk - Model - Type',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].merkName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].modelName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].typeName!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Colour',
            widget.argumentAddReq.assetGrowResponseModel.data![0].colourName!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Serial No.',
            widget.argumentAddReq.assetGrowResponseModel.data![0].serialNo!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'IMEI',
            widget.argumentAddReq.assetGrowResponseModel.data![0].imei!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Insured',
            widget.argumentAddReq.assetGrowResponseModel.data![0].isInsured! ==
                    'No'
                ? widget
                    .argumentAddReq.assetGrowResponseModel.data![0].isInsured!
                : '${widget.argumentAddReq.assetGrowResponseModel.data![0].isInsured!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].numberOfCoverage!} year',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Factory Warranty',
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                        .factoryWarrantyPeriodTypeName!
                        .toUpperCase() ==
                    'PERIODIC'
                ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyEndDate!}'
                : widget.argumentAddReq.assetGrowResponseModel.data![0]
                            .factoryWarrantyPeriodTypeName!
                            .toUpperCase() ==
                        'LIFETIME'
                    ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].factoryWarrantyStartDate!}'
                    : '-',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Vendor Warranty',
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                        .vendorWarrantyPeriodTypeName!
                        .toUpperCase() ==
                    'PERIODIC'
                ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyEndDate!}'
                : widget.argumentAddReq.assetGrowResponseModel.data![0]
                            .vendorWarrantyPeriodTypeName!
                            .toUpperCase() ==
                        'LIFETIME'
                    ? '${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyPeriodTypeName!} |  ${widget.argumentAddReq.assetGrowResponseModel.data![0].vendorWarrantyStartDate!}'
                    : '-',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Maintenance Routine',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceStartDate!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].maintenanceEndDate!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Purchase Date',
            widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Purchase Asset Condition',
            widget.argumentAddReq.assetGrowResponseModel.data![0].condition!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'PO No. & PO Date',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseOrderNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].purchaseDate!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'GRN No. & GRN Date',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].grnNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].grnDate!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Invoice No. & Invoice Date',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceNo!} | ${widget.argumentAddReq.assetGrowResponseModel.data![0].invoiceDate!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Vendor',
            widget.argumentAddReq.assetGrowResponseModel.data![0].vendorName!,
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Vendor Rating',
            widget.argumentAddReq.assetGrowResponseModel.data![0].averageRating!
                .toString(),
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Depreciation',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].isDepre!} -  ${widget.argumentAddReq.assetGrowResponseModel.data![0].methodTypeComm!}',
            false,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
                    .propertyFacility ??
                []));
        dataContent.add(DataContent(
            'Asset Location',
            '${widget.argumentAddReq.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].locationName!}',
            true,
            false,
            widget.argumentAddReq.assetGrowResponseModel.data![0]
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
              Text('Additional Request',
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 20,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              children: [
                                AutoSizeText(
                                  widget.argumentAddReq.assetGrowResponseModel
                                      .data![0].itemName!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.asset(
                                    widget.argumentAddReq.assetGrowResponseModel
                                                .data![0].status!
                                                .toLowerCase() ==
                                            'available'
                                        ? 'assets/icons/available.png'
                                        : widget
                                                    .argumentAddReq
                                                    .assetGrowResponseModel
                                                    .data![0]
                                                    .status!
                                                    .toLowerCase() ==
                                                'new'
                                            ? 'assets/icons/new.png'
                                            : widget
                                                        .argumentAddReq
                                                        .assetGrowResponseModel
                                                        .data![0]
                                                        .status!
                                                        .toLowerCase() ==
                                                    'on progress'
                                                ? 'assets/icons/onprogres.png'
                                                : widget
                                                            .argumentAddReq
                                                            .assetGrowResponseModel
                                                            .data![0]
                                                            .status!
                                                            .toLowerCase() ==
                                                        'sold'
                                                    ? 'assets/icons/sold.png'
                                                    : widget
                                                                .argumentAddReq
                                                                .assetGrowResponseModel
                                                                .data![0]
                                                                .status!
                                                                .toLowerCase() ==
                                                            'disposed'
                                                        ? 'assets/icons/disposed.png'
                                                        : widget
                                                                    .argumentAddReq
                                                                    .assetGrowResponseModel
                                                                    .data![0]
                                                                    .status!
                                                                    .toLowerCase() ==
                                                                'onrepair'
                                                            ? 'assets/icons/onrepair.png'
                                                            : widget.argumentAddReq.assetGrowResponseModel.data![0].status!.toLowerCase() == 'maintenance'
                                                                ? 'assets/icons/maintenance.png'
                                                                : widget.argumentAddReq.assetGrowResponseModel.data![0].status!.toLowerCase() == 'used'
                                                                    ? 'assets/icons/used.png'
                                                                    : widget.argumentAddReq.assetGrowResponseModel.data![0].status!.toLowerCase() == 'booked'
                                                                        ? 'assets/icons/booked.png'
                                                                        : widget.argumentAddReq.assetGrowResponseModel.data![0].status!.toLowerCase() == 'rejected'
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
                                SizedBox(
                                  height: 32,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 65,
                                      height: 65,
                                      child: PrettyQrView.data(
                                          data: widget
                                              .argumentAddReq
                                              .assetGrowResponseModel
                                              .data![0]
                                              .barcode!,
                                          decoration: const PrettyQrDecoration(
                                            shape: PrettyQrSmoothSymbol(
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                    const Icon(
                                      Icons.print_sharp,
                                      size: 33,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                AutoSizeText(
                                  widget.argumentAddReq.assetGrowResponseModel
                                      .data![0].barcode!,
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Asset No : ${widget.argumentAddReq.assetGrowResponseModel.data![0].code!}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                            AutoSizeText(
                              'Usefull life : ${widget.argumentAddReq.assetGrowResponseModel.data![0].usefull!} Years',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                            AutoSizeText(
                              'Branch Location : ${widget.argumentAddReq.assetGrowResponseModel.data![0].regionName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].areaName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].branchName!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].locationName!}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AutoSizeText(
                                  'PIC :',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        ' ${widget.argumentAddReq.assetGrowResponseModel.data![0].picCode!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].picName!}',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                      AutoSizeText(
                                        ' ${widget.argumentAddReq.assetGrowResponseModel.data![0].picPositionName!}',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AutoSizeText(
                                  'User :',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.74,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        ' ${widget.argumentAddReq.assetGrowResponseModel.data![0].userCode!} - ${widget.argumentAddReq.assetGrowResponseModel.data![0].userName!}',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                      AutoSizeText(
                                        ' ${widget.argumentAddReq.assetGrowResponseModel.data![0].userPositionName!}',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                )
                              ],
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
                                    AutoSizeText(
                                      dataContent[index].title,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    ListView.separated(
                                        shrinkWrap: true,
                                        itemBuilder: ((context, indexes) {
                                          return AutoSizeText(
                                            '${dataContent[index].propertyFacility[indexes].no!}. ${dataContent[index].propertyFacility[indexes].propertyFacilityName!}',
                                            style: const TextStyle(
                                                fontSize: 16,
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
                                    AutoSizeText(
                                      dataContent[index].title,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
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
                                          child: AutoSizeText(
                                            dataContent[index].value,
                                            style: const TextStyle(
                                                fontSize: 16,
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
                                                      .argumentAddReq
                                                      .assetGrowResponseModel
                                                      .data![0]
                                                      .latitude!),
                                                  double.parse(widget
                                                      .argumentAddReq
                                                      .assetGrowResponseModel
                                                      .data![0]
                                                      .longitude!));
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
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context,
                      StringRouterUtil.addRequesteDetailFormScreenRoute,
                      arguments: ArgumentAddReq(
                          register: widget.argumentAddReq.register,
                          disposal: widget.argumentAddReq.disposal,
                          maintenance: widget.argumentAddReq.maintenance,
                          other: widget.argumentAddReq.other,
                          sell: widget.argumentAddReq.sell,
                          assetGrowResponseModel:
                              widget.argumentAddReq.assetGrowResponseModel));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 66,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFF5DE0E6), Color(0xFF004AAD)],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Next',
                            style: TextStyle(
                                fontSize: 18,
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
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
