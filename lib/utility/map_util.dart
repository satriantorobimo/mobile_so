import 'package:map_launcher/map_launcher.dart';

class MapUtil {
  MapUtil._();

  static Future<void> openMap(
      double latitude, double longitude, String title) async {
    try {
      if (await MapLauncher.isMapAvailable(MapType.google) != null) {
        await MapLauncher.showMarker(
          mapType: MapType.google,
          coords: Coords(latitude, longitude),
          title: title,
        );
      }
    } catch (error) {
      throw ('cannot open');
    }
  }
}
