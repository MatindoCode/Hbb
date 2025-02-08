import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/addserviceitems/bloc/map_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'map_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962), // Default location
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔍 Search Text Field
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocListener<GoogleMapsBloc, GoogleMapsState>(
              listener: (context, state) {
                if (state is UpdatedMarker) {
                  _searchController.text = state.address;
                }
              },
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Enter location...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      context
                          .read<GoogleMapsBloc>()
                          .add(SearchPlaces("")); // Clear results
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    context.read<GoogleMapsBloc>().add(SearchPlaces(query));
                  }
                },
              ),
            ),
          ),

          // 📌 Show Map & Suggestions
          Expanded(
            child: Stack(
              children: [
                // Google Map
                BlocBuilder<GoogleMapsBloc, GoogleMapsState>(
                  builder: (context, state) {
                    LatLng? selectedLocation;
                    Set<Marker> markers = {};

                    if (state is PlaceSelected) {
                      selectedLocation = state.location;
                      markers = state.markers;
                    } else if (state is UpdatedMarker) {
                     
                      markers = state.markers;
                    }

                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      if (mounted &&
                          _controller.isCompleted &&
                          selectedLocation != null) {
                        final GoogleMapController controller =
                            await _controller.future;
                        controller.animateCamera(
                          CameraUpdate.newLatLngZoom(selectedLocation, 14),
                        );
                      }
                    });

                    return GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: _initialPosition,
                      onMapCreated: (GoogleMapController controller) {
                        if (!_controller.isCompleted) {
                          _controller.complete(controller);
                        }
                      },
                      markers: markers,
                      onTap: (latLng) {
                        context
                            .read<GoogleMapsBloc>()
                            .add(UpdateMarker(latLng));
                      },
                    );
                  },
                ),

                // 🏠 Autocomplete Suggestions
                BlocBuilder<GoogleMapsBloc, GoogleMapsState>(
                  builder: (context, state) {
                    if (state is PlacesLoaded && state.places.isNotEmpty) {
                      return Container(
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: state.places.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(state.places[index]),
                              onTap: () {
                                _searchController.text = state.places[index];
                                context
                                    .read<GoogleMapsBloc>()
                                    .add(SelectPlace(state.places[index]));
                              },
                            );
                          },
                        ),
                      );
                    }
                    return Container(); // No results, show nothing
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        String selectedAddress = _searchController.text;
                        context
                            .read<GoogleMapsBloc>()
                            .add(UpdateAddress(selectedAddress));

                        Navigator.pop(context); //
                      },
                      child: Text("Save Address"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
