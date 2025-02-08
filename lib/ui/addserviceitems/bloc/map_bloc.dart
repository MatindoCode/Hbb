import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

// Replace with your actual API key
const String apiKey = 'AIzaSyDzRJG8w6GhySwWmTmfLFEZ5SAgoW9kinY';

class GoogleMapsBloc extends Bloc<GoogleMapsEvent, GoogleMapsState> {
  GoogleMapsBloc() : super(GoogleMapsInitial()) {
    // Correct event handlers
    on<SearchPlaces>(_mapSearchPlacesToState);
    on<SelectPlace>(_mapSelectPlaceToState);
    on<UpdateMarker>(_mapUpdateMarkerToState);
      on<UpdateAddress>(_updateAddressToState); 
  }

  /// Fetch autocomplete suggestions from Google Places API
  Future<void> _mapSearchPlacesToState(
      SearchPlaces event, Emitter<GoogleMapsState> emit) async {
    final encodedInput = Uri.encodeComponent(event.query);
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$encodedInput&key=$apiKey&components=country:SG';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final predictions = jsonData['predictions'] as List;

      List<String> suggestions =
          predictions.map((prediction) => prediction['description'] as String).toList();

      emit(PlacesLoaded(suggestions));
    } else {
      emit(PlacesLoaded([])); // Empty suggestions on failure
    }
  }

  /// Fetch LatLng from selected place and update marker
  Future<void> _mapSelectPlaceToState(
      SelectPlace event, Emitter<GoogleMapsState> emit) async {
    final encodedQuery = Uri.encodeComponent(event.placeDescription);
    final placeSearchUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$encodedQuery&key=$apiKey&components=country:SG';

    final response = await http.get(Uri.parse(placeSearchUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['predictions'].isNotEmpty) {
        final placeId = jsonData['predictions'][0]['place_id'];
        final placeDetailsUrl =
            'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

        final detailsResponse = await http.get(Uri.parse(placeDetailsUrl));
        if (detailsResponse.statusCode == 200) {
          final detailsData = jsonDecode(detailsResponse.body);
          final location = detailsData['result']['geometry']['location'];
          final double lat = location['lat'];
          final double lng = location['lng'];

          LatLng newLatLng = LatLng(lat, lng);

          // Create marker
          Set<Marker> markers = {
            Marker(
              markerId: const MarkerId('selected_location'),
              position: newLatLng,
              infoWindow: InfoWindow(title: event.placeDescription),
            ),
          };

          emit(PlaceSelected(newLatLng, markers));
        }
      }
    }
  }

  Future<void> _mapUpdateMarkerToState(UpdateMarker event, Emitter<GoogleMapsState> emit) async {
     String address = "Unknown Location";
    Set<Marker> markers = {
    Marker(
      markerId: const MarkerId('selected_location'),
      position: event.newLocation,
      infoWindow: const InfoWindow(title: "Selected Location"),
    ),};
    final String url =
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${event.newLocation.latitude},${event.newLocation.longitude}&key=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    if (jsonData['results'].isNotEmpty) {
      address =  jsonData['results'][0]['formatted_address']; // Get first result
    }
  }
  
  emit(UpdatedMarker(address, markers));
}
  Future<void> _updateAddressToState(UpdateAddress event, Emitter<GoogleMapsState> emit)async {
      
     emit(AddressUpdated(event.address));

  }

}