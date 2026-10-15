import 'package:geolocator/geolocator.dart';

import '../Core/services/api_services.dart';
import '../Model/Place.dart';
import '../Model/placeDetails.dart';

class PlaceRepository {
  final ApiServices _apiServices;
  PlaceRepository({ApiServices? apiServices})
    : _apiServices = apiServices ?? ApiServices();

  Future<List<Place>> fetchNearbyGasStations(Position position) async {
    const apiKey = 'AIzaSyDATtsiRKwIQ2_ZL_ZO1raijYntkbHIBDI';
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude},${position.longitude}&radius=5000&type=gas_station&key=$apiKey';
    final data = await _apiServices.get(url);

    final results = data['results'] as List<dynamic>;
    return results.map((json) => Place.fromJson(json)).toList();
  }

  Future<PlaceDetails> fetchGasStationDetails(String placeID) async {
    const apiKey = 'AIzaSyDATtsiRKwIQ2_ZL_ZO1raijYntkbHIBDI';

    final url =
        'https://maps.googleapis.com/maps/api/place/details/json'
        '?place_id=$placeID&key=$apiKey';

    final data = await _apiServices.get(url);

    return PlaceDetails.fromJson(data);
  }
}
