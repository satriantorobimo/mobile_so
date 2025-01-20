class SubmitRequestModel {
  final String? pItemCode;
  final String? pPurchaseCondition;
  final String? pPicCode;
  final String? pRemarksMobile;
  final String? pAssetCode;
  final String? pRequestProcessToCode;
  final String? pReasonCode;
  final String? pServiceCode;
  final String? pMaintenanceBy;
  final int? pSellingPrice;

  SubmitRequestModel(
      {this.pItemCode,
      this.pPurchaseCondition,
      this.pServiceCode,
      this.pMaintenanceBy,
      this.pPicCode,
      this.pAssetCode,
      this.pRequestProcessToCode,
      this.pReasonCode,
      this.pRemarksMobile,
      this.pSellingPrice});
}
