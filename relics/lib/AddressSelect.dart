import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class AddressSelectionPage extends StatefulWidget {
  final Function(String) onAddressSelected;

  AddressSelectionPage({required this.onAddressSelected});

  @override
  _AddressSelectionPageState createState() => _AddressSelectionPageState();
}

class _AddressSelectionPageState extends State<AddressSelectionPage> {
  late GoogleMapController mapController;
  LatLng _selectedLocation =
      LatLng(13.7563, 100.5018); // Default to center of the map
  String _fullAddress = '';
  bool _showMarker = false;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapTap(LatLng location) async {
    setState(() {
      _selectedLocation = location;
      _showMarker = true;
    });
    _getAddressFromLatLng();
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _selectedLocation.latitude,
        _selectedLocation.longitude,
      );
      Placemark place = placemarks.first;
      setState(() {
        _fullAddress =
            "${place.street}, ${place.subLocality}, ${place.postalCode}, ${place.country}";
      });
      // Pass the selected address back to the CheckoutPage
      widget.onAddressSelected(_fullAddress);
      print("$_fullAddress");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Address'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 40,
            ),
            onTap: _onMapTap,
            markers: _showMarker
                ? {
                    Marker(
                      markerId: MarkerId("selected-location"),
                      position: _selectedLocation,
                    )
                  }
                : {},
          ),
          if (_showMarker)
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: Card(
                elevation: 6.0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    _fullAddress,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
