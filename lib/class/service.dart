import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:geocoding/geocoding.dart'; 
import 'package:geolocator/geolocator.dart'; 

class Service {
  String id;
  String title;
  String description;
  String category;
  double price; 
  Position? location; 
  String? address; 
  bool isAvailable;
  List<String> images;
  String userId;
  String? providerName;
  String? providerContact;
  double? rating; 
  // ... other optional attributes

  Service({
    required this.id,
    required this.title,
    required this.description, 
    required this.category,
    required this.price,
    this.location, 
    this.address, 
    required this.isAvailable,
    required this.images,
    required this.userId,
    this.providerName,
    this.providerContact,
    this.rating,
    // ... other optional attributes
  });

  // Helper method to get address from coordinates
  Future<void> getAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location!.latitude, 
        location!.longitude
      );
      if (placemarks.isNotEmpty) {
        address = placemarks[0].street!; 
      }
    } catch (e) {
      print('Error getting address: $e');
    }
  }

  // ... other methods (e.g., fromJson, toJson for Firestore integration) 
}