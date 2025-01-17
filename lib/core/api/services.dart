import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class LocationServices {
  // Create a logger instance
  final Logger _logger = Logger();

  Future<Position?> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, // Set the desired accuracy
    );
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Log the error instead of using print
        _logger.e('Location permission is denied');
        return Future.error('Location permission is denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Log the error instead of using print
      _logger.e(
          'Location permission is permanently denied, we cannot request permission');
      return Future.error(
          'Location permission is permanently denied, we cannot request permission');
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      bool isGpsEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isGpsEnabled) {
        // Log the message instead of using print
        _logger.w('Please enable GPS');
        return null;
      }
      return await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
    }

    return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings);
  }
}
