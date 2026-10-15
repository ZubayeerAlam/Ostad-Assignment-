import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Model/Place.dart';
import '../Model/placeDetails.dart';
import '../repository/Route_Repository.dart';
import '../repository/place_repository.dart';

class LocationProvider extends ChangeNotifier {
  LatLng _center = const LatLng(23.812468, 90.428911);
  LatLng get center => _center;

  GoogleMapController? mapController;
  GoogleMapController? get controller => mapController;

  List<Place> _places = [];
  List<Place> get places => _places;

  PlaceDetails? _placeDetails;
  PlaceDetails? get placeDetails => _placeDetails;
  bool isLoading = false;

  Set<Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines;

  final PlaceRepository _placeRepository;
  final RouteRepository _routeRepository;

  LocationProvider({
    PlaceRepository? placeRepository,
    RouteRepository? routeRepository,
  })  : _placeRepository = placeRepository ?? PlaceRepository(),
        _routeRepository = routeRepository ?? RouteRepository();

  void setMapController(GoogleMapController controller) {
    mapController = controller;
    notifyListeners();
  }

  Future<void> findMyLocation() async {
    bool permissionGranted = await _handleLocationPermission();
    if (permissionGranted) {
      Position position = await _getCurrentLocation();
      _center = LatLng(position.latitude, position.longitude);

      mapController?.animateCamera(CameraUpdate.newLatLngZoom(_center, 18.0));

      notifyListeners();

      await fetchNearbyGasStations(position);
    }
  }

  Future<void> fetchNearbyGasStations(Position position) async {
    try {
      _places = await _placeRepository.fetchNearbyGasStations(position);
      notifyListeners();
    } on Exception catch (e) {
      debugPrint("Error fetching nearby gas stations: $e");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool permissionEnabled = await Geolocator.isLocationServiceEnabled();
    if (!permissionEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  Future<void> fetchPlaceDetails(String placeID) async {
    isLoading = true;
    _placeDetails = null;
    notifyListeners();

    try {
      _placeDetails = await _placeRepository.fetchGasStationDetails(placeID);
    } on Exception catch (e) {
      debugPrint("Error fetching place details: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchRoute(LatLng destination) async {
    try {
      final route = await _routeRepository.fetchRoute(
        _center,
        destination,
      );

      if (route != null && route.geometry != null) {
        _polylines = {
          Polyline(
            polylineId: const PolylineId('route'),
            points: route.geometry!.coordinates,
            color: const Color(0xFF2196F3),
            width: 5,
          ),
        };
        notifyListeners();
      }
    } on Exception catch (e) {
      debugPrint("Error fetching route: $e");
    }
  }
}
