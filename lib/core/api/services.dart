import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class LocationServices {
  final Logger _logger = Logger();

  Future<Position?> get getLocation async {
    LocationPermission permission = await Geolocator.checkPermission();
    _logger.i('Permission status: $permission');

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _logger.e('Location permission is denied');
        return Future.error('Location permission is denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _logger.e(
          'Location permission is permanently denied, cannot request permission');
      return Future.error('Location permission is permanently denied');
    }

    bool isGpsEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isGpsEnabled) {
      _logger.w('Please enable GPS');
      return Future.error('GPS is disabled. Please enable it.');
    }

    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );
    } catch (e) {
      _logger.e('Error getting location: $e');
      return Future.error('Error getting location');
    }
  }
}
