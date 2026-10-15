import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Core/services/api_services.dart';
import '../Model/routeModel.dart';

class RouteRepository {
  final ApiServices _apiServices;
  RouteRepository({ApiServices? apiServices})
      : _apiServices = apiServices ?? ApiServices();

  Future<RouteModel?> fetchRoute(LatLng origin, LatLng destination) async {
    final url =
        'http://router.project-osrm.org/route/v1/driving/${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}?overview=full&geometries=geojson';
    final data = await _apiServices.get(url);

    if (data is Map<String, dynamic> &&
        data['routes'] != null &&
        (data['routes'] as List).isNotEmpty) {
      return RouteModel.fromJson(data['routes'][0] as Map<String, dynamic>);
    } else if (data is String) {
      final decoded = jsonDecode(data);
      if (decoded['routes'] != null && (decoded['routes'] as List).isNotEmpty) {
        return RouteModel.fromJson(decoded['routes'][0] as Map<String, dynamic>);
      }
    }
    return null;
  }
}
