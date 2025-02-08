import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_application_1/ui/addserviceitems/bloc/map.dart';
import 'package:flutter_application_1/ui/addserviceitems/bloc/map_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Addlocation extends StatelessWidget {
  final VoidCallback onPressed;
  final Completer<GoogleMapController> controller;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  const Addlocation(
      {super.key, required this.controller, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 150,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MapScreen()), // Navigate to MapScreen
                      );
                    },
                    child: Text("data"))),
            SizedBox(height: 30),
            BlocBuilder<GoogleMapsBloc, GoogleMapsState>(
              builder: (context, state) {
                if (state is AddressUpdated) {
                  return Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200], // Optional: Background color
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      state.address,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300], // Optional: Placeholder color
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "No address selected",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        Spacer(),
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // Black border
              width: 4.0, // Border width (adjust as needed)
            ),
          ),
          child: Hero(
            tag: "mapHero",
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                this.controller.complete(controller);
              },
            ),
          ),
        )
      ],
    );
  }
}
