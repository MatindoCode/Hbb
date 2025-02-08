part of 'map_bloc.dart';


@immutable
abstract class GoogleMapsEvent {}

// User enters text in search field -> Fetch suggestions
class SearchPlaces extends GoogleMapsEvent {
  final String query;
  SearchPlaces(this.query);
}

// User selects a place -> Fetch LatLng and mark it on the map
class SelectPlace extends GoogleMapsEvent {
  final String placeDescription;
  SelectPlace(this.placeDescription);
}

class UpdateMarker extends GoogleMapsEvent {
  final LatLng newLocation;
  UpdateMarker(this.newLocation);
}

class UpdateAddress extends GoogleMapsEvent {
  final String address;

  UpdateAddress(this.address);
}