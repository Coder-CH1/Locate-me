import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final TextEditingController _controller;
  LatLng _currentLocation = const LatLng(9.0820, 8.6753);
  final String _searchQuery = '';
  double _zoom = 6.0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  Future<void> _searchPlace() async {
    final place = _controller.text.trim();
    if (_searchQuery.isEmpty) return;

    try {
     List<Location> locations = await locationFromAddress(place);
     if (locations.isNotEmpty) {
       final location = locations.first;
       setState(() {
         _currentLocation = LatLng(location.latitude, location.longitude);
         _zoom = 14.0;
       });
     }
    } catch (e) {
      throw Exception(Text('Error searching for place $e'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width/0.2,
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    _searchPlace();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    hintText: 'Search places',
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.blueAccent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    )
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
             Expanded(
                child:
                FlutterMap(
                  options: MapOptions(
                  initialCenter: _currentLocation,
                    initialZoom: _zoom,
                    maxZoom: 18.0,
                    minZoom: 2.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                        markers: [
                          Marker(
                            point: _currentLocation,
                            child: const Icon(Icons.pin_drop, color: Colors.red)
                          )
                        ]
                    )
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
