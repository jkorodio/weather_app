import 'package:geolocator/geolocator.dart';

class LocationServices {
  Future<Position?> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, // Set the desired accuracy
      // distanceFilter:
      //     1 // Optional: Set the minimum distance (in meters) before updates are triggered
    );
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission are permanently denied, we cannot request permission');
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      bool isGpsEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isGpsEnabled) {
        print('Please enable GPS');
        return null;
      }
      return await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
    }

    return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings);
  }
}
