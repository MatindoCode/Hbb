part of 'map_bloc.dart';

@immutable
abstract class GoogleMapsState {}

class GoogleMapsInitial extends GoogleMapsState {}

// State when autocomplete results are loaded
class PlacesLoaded extends GoogleMapsState {
  final List<String> places;
  PlacesLoaded(this.places);
}

// State when a location is selected and marked on the map
class PlaceSelected extends GoogleMapsState {
  final LatLng location;
  final Set<Marker> markers;
  PlaceSelected(this.location, this.markers);
}

class UpdatedMarker extends GoogleMapsState {
  final String address;
  final Set<Marker> markers;
  
  UpdatedMarker(this.address, this.markers);
}

class AddressUpdated extends GoogleMapsState {
  final String address;

   AddressUpdated(this.address);

}