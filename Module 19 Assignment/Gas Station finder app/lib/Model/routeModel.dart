import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteModel {
  final double distance;
  final double duration;
  final Geometry? geometry;
  final List<Leg>? legs;

  RouteModel({
    required this.distance,
    required this.duration,
    this.geometry,
    this.legs,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
      geometry: json['geometry'] is Map<String, dynamic>
          ? Geometry.fromJson(json['geometry'] as Map<String, dynamic>)
          : null,
      legs: json['legs'] != null && json['legs'] is List
          ? (json['legs'] as List)
              .map((v) => Leg.fromJson(v as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'duration': duration,
      if (geometry != null) 'geometry': geometry!.toJson(),
      if (legs != null) 'legs': legs!.map((v) => v.toJson()).toList(),
    };
  }
}

class Geometry {
  final String? type;
  final List<LatLng> coordinates;

  Geometry({
    this.type,
    required this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    List<LatLng> points = [];

    if (json['coordinates'] != null && json['coordinates'] is List) {
      for (var point in json['coordinates']) {
        if (point is List && point.length >= 2) {
          // OSRM returns coordinates as [longitude, latitude]
          final double lng = (point[0] as num).toDouble();
          final double lat = (point[1] as num).toDouble();
          points.add(LatLng(lat, lng));
        }
      }
    }

    return Geometry(
      type: json['type'] as String?,
      coordinates: points,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates
          .map((point) => [point.longitude, point.latitude])
          .toList(),
    };
  }
}

class Leg {
  final double distance;
  final double duration;
  final List<Step>? steps;

  Leg({
    required this.distance,
    required this.duration,
    this.steps,
  });

  factory Leg.fromJson(Map<String, dynamic> json) {
    return Leg(
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
      steps: json['steps'] != null && json['steps'] is List
          ? (json['steps'] as List)
              .map((v) => Step.fromJson(v as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'duration': duration,
      if (steps != null) 'steps': steps!.map((v) => v.toJson()).toList(),
    };
  }
}

class Step {
  final double distance;
  final double duration;
  final String name;

  Step({
    required this.distance,
    required this.duration,
    required this.name,
  });

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'duration': duration,
      'name': name,
    };
  }
}
