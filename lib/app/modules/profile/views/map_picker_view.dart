import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapPickerView extends StatefulWidget {
  const MapPickerView({super.key});

  @override
  State<MapPickerView> createState() => _MapPickerViewState();
}

class _MapPickerViewState extends State<MapPickerView> {
  LatLng? _pickedLocation;
  LatLng _initialCenter =
      const LatLng(9.621, 125.967); // Surigao del Sur default
  bool _loading = true;
  String? _address;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position pos = await Geolocator.getCurrentPosition();
      setState(() {
        _initialCenter = LatLng(pos.latitude, pos.longitude);
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      debugPrint('Error getting location: $e');
    }
  }

  Future<void> _reverseGeocode(LatLng pos) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        setState(() {
          _address =
              "${p.street ?? ''}, ${p.subLocality ?? ''}, ${p.locality ?? ''}, ${p.administrativeArea ?? ''}, ${p.country ?? ''}"
                  .replaceAll(RegExp(r', ,'), ',');
        });
      }
    } catch (e) {
      debugPrint('Reverse geocoding failed: $e');
    }
  }

  void _onMapTap(TapPosition tapPosition, LatLng latlng) async {
    setState(() {
      _pickedLocation = latlng;
      _address = "Fetching address...";
    });
    await _reverseGeocode(latlng);
  }

  void _onSave() {
    if (_pickedLocation != null && _address != null) {
      Navigator.pop(context, {
        'lat': _pickedLocation!.latitude,
        'lng': _pickedLocation!.longitude,
        'address': _address,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Pin Your Location")),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _initialCenter,
              initialZoom: 15,
              onTap: _onMapTap,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              if (_pickedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _pickedLocation!,
                      width: 50,
                      height: 50,
                      child: const Icon(Icons.location_pin,
                          color: Colors.red, size: 40),
                    )
                  ],
                ),
            ],
          ),
          if (_address != null)
            Positioned(
              bottom: 80,
              left: 10,
              right: 10,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    _address!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onSave,
        label: const Text("Save Location"),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
