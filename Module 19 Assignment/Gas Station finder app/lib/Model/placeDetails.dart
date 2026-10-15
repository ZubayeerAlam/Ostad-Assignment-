class PlaceDetails {
  final String name;
  final String formattedAddress;
  final double rating;
  final int userRatingsTotal;
  final bool openNow;
  final String formattedPhoneNumber;

  PlaceDetails({
    required this.name,
    required this.formattedAddress,
    required this.rating,
    required this.userRatingsTotal,
    required this.openNow,
    required this.formattedPhoneNumber,
  });

  factory PlaceDetails.fromJson(Map<String, dynamic> json) {
    final result = json['result'] as Map<String, dynamic>? ?? {};

    return PlaceDetails(
      name: result['name'] as String? ?? "Unknown Name",

      formattedAddress:
      result['formatted_address'] as String? ?? "Unknown Address",

      rating: (result['rating'] as num?)?.toDouble() ?? 0.0,

      userRatingsTotal:
      (result['user_ratings_total'] as num?)?.toInt() ?? 0,

      openNow:
      (result['opening_hours']?['open_now'] as bool?) ?? false,

      formattedPhoneNumber:
      result['formatted_phone_number'] as String? ??
          "Unknown Phone Number",
    );
  }
}