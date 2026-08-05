import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as l;
import 'package:sakina/core/errors/exceptions.dart';
import 'package:sakina/features/prayer/data/models/location_model.dart';

abstract interface class LocationDataSrc {
  Future<LocationModel> getLocation();
}

class LocationDataSrcImpl implements LocationDataSrc {
  l.Location location = l.Location();

  late bool serviceEnable;
  late LocationPermission permission;
  @override
  Future<LocationModel> getLocation() async {
    serviceEnable = await location.serviceEnabled();
    // check service enable
    if (!serviceEnable) {
      serviceEnable = await location.requestService();
      if (!serviceEnable) {
        throw LocationNotEnabelException(
          message: 'Service location not enable !!',
        );
      }
    }
    // check location permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw GetLocationException(message: 'Location permission is denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw GetLocationException(message: 'Location permission is denied');
    }
    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    String address =
        '${placemarks[0].administrativeArea} ,${placemarks[0].locality}';
    return LocationModel(
      addressName: address,
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
