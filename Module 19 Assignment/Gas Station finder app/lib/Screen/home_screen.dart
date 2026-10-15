import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../Model/Place.dart';
import '../Provider/locationProvider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Gas Station Finder"),
      ),

      body: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          Set<Marker> markers = {};

          // My Location Marker
          markers.add(
            Marker(
              markerId: const MarkerId("me"),
              position: locationProvider.center,
              infoWindow: const InfoWindow(title: "My Location"),
            ),
          );

          // Gas Station Markers
          for (var placeItem in locationProvider.places) {
            markers.add(
              Marker(
                markerId: MarkerId(placeItem.placeID),
                position: LatLng(placeItem.lat, placeItem.lng),
                infoWindow: InfoWindow(title: placeItem.name),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRose,
                ),
                onTap: () {
                  showPumpDetails(context, placeItem, locationProvider);
                },
              ),
            );
          }

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: locationProvider.center,
              zoom: 18.0,
            ),

            onMapCreated: (controller) {
              locationProvider.setMapController(controller);
            },

            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: markers,
            polylines: locationProvider.polylines,
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<LocationProvider>().findMyLocation();
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }
}

void showPumpDetails(
  BuildContext context,
  Place placeItem,
  LocationProvider locationProvider,
) {
  // Calculate distance
  final distanceMeters = Geolocator.distanceBetween(
    locationProvider.center.latitude,
    locationProvider.center.longitude,
    placeItem.lat,
    placeItem.lng,
  );

  final distanceKm = distanceMeters / 1000;

  // Fetch place details
  locationProvider.fetchPlaceDetails(placeItem.placeID);

  showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),

    context: context,
    builder: (context) {
      return Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          return Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${placeItem.name}"),
                        Text("Distance: ${distanceKm.toStringAsFixed(2)} km"),
                      ],
                    ),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        locationProvider.fetchRoute(
                          LatLng(placeItem.lat, placeItem.lng),
                        );
                      },
                      child: const Text("Direction"),
                    ),
                  ],
                ),

                const Divider(),

                if (locationProvider.isLoading)
                  const CircularProgressIndicator()
                else if (locationProvider.placeDetails != null) ...[
                  Text(
                    "Address: ${locationProvider.placeDetails!.formattedAddress}",
                  ),
                  Text(
                    "Phone: ${locationProvider.placeDetails!.formattedPhoneNumber}",
                  ),
                  Text("Rating: ${locationProvider.placeDetails!.rating}"),
                  Text(
                    "Total Ratings: ${locationProvider.placeDetails!.userRatingsTotal}",
                  ),
                ],
              ],
            ),
          );
        },
      );
    },
  );
}
