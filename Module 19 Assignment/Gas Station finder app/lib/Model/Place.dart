class Place {
  final String name;
  final String placeID;
  final double lat;
  final double lng;

  Place({
    required this.name,
    required this.placeID,
    required this.lat,
    required this.lng,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'] as String? ?? "Unknown Name",
      placeID: json['place_id'] as String? ?? "Unknown ID",
      lat: (json['geometry']?['location']?['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['geometry']?['location']?['lng'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'place_id': placeID,
      'geometry': {
        'location': {'lat': lat, 'lng': lng},
      },
    };
  }
}
