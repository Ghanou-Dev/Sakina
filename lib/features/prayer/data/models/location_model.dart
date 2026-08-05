import 'package:sakina/core/constants/app_keys.dart';
import 'package:sakina/features/prayer/domain/entities/location_entity.dart';

class LocationModel {
  final double latitude;
  final double longitude;
  final String addressName;
  LocationModel({
    required this.addressName,
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromEntity(LocationEntity locationEntity) {
    return LocationModel(
      addressName: locationEntity.addressName,
      latitude: locationEntity.latitude,
      longitude: locationEntity.longitude,
    );
  }

  LocationEntity toEntity() {
    return LocationEntity(
      latitude: latitude,
      longitude: longitude,
      addressName: addressName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppKeys.latitude: latitude,
      AppKeys.longitude: longitude,
      AppKeys.addressName: addressName,
    };
  }
}
