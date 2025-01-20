import 'package:mobile_so/features/asset_opname_detail/data/asset_grow_response_model.dart';

class DataContent {
  final String title;
  final String value;
  final bool isLocation;
  final bool isPropertyFacility;
  final List<PropertyFacility> propertyFacility;

  DataContent(this.title, this.value, this.isLocation, this.isPropertyFacility,
      this.propertyFacility);
}
