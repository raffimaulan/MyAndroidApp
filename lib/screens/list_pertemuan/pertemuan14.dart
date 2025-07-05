import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Pertemuan14 extends StatefulWidget {
  const Pertemuan14({super.key});

  @override
  State<Pertemuan14> createState() => _Pertemuan14State();
}

class _Pertemuan14State extends State<Pertemuan14> {
  late final MapController _mapController;
  LatLng? _currentPosition;
  List<LatLng> _routePoints = [];
  String _searchText = "Cari Alamat...";

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _determinePosition();
    _routePoints = [
      LatLng(-6.3548, 106.7282),
      LatLng(-6.3175, 106.7653),
    ];
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) return;

    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(pos.latitude, pos.longitude);
    });
  }

  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        _mapController.move(LatLng(loc.latitude, loc.longitude), 15);
      }
    } catch (e) {
      debugPrint("Lokasi tidak ditemukan: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pertemuan 14"),
        backgroundColor: isDark ? Colors.grey[900] : null,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(-6.35, 106.75),
              initialZoom: 12.5,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.apk_tugas',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routePoints,
                    color: const Color.fromARGB(255, 105, 176, 39),
                    strokeWidth: 5,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  ..._routePoints.map(
                    (point) => Marker(
                      point: point,
                      child: const Icon(Icons.location_on,
                          color: Colors.blue, size: 40),
                    ),
                  ),
                  if (_currentPosition != null)
                    Marker(
                      point: _currentPosition!,
                      child: const Icon(Icons.person_pin_circle,
                          color: Colors.green, size: 40),
                    ),
                ],
              ),
            ],
          ),

          // Search Box
          Positioned(
            top: 20,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[850] : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: TextField(
                onSubmitted: (val) {
                  setState(() => _searchText = val);
                  _searchLocation(val);
                },
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: "Cari Alamat...",
                  hintStyle: TextStyle(color: isDark ? Colors.grey : Colors.grey[700]),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.location_on, size: 24, color: isDark ? Colors.white70 : Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ),
          ),

          // Tombol
          Positioned(
            bottom: 30,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "locate",
                  mini: true,
                  onPressed: () {
                    if (_currentPosition != null) {
                      _mapController.move(_currentPosition!, 15);
                    }
                  },
                  backgroundColor: isDark ? Colors.teal[700] : null,
                  child: const Icon(Icons.my_location),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "search",
                  mini: true,
                  onPressed: () {
                    _searchLocation(_searchText);
                  },
                  backgroundColor: isDark ? Colors.deepOrange[700] : null,
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
