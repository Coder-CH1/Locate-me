import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

//HOME
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final TextEditingController _controller;
  late final MapController _mapController;
  LatLng _currentLocation = const LatLng(9.0820, 8.6753);//default location
  double _zoom = 6.0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _mapController = MapController();
  }

  Future<void> _searchPlace() async {
    final place = _controller.text.trim();
    if (place.isEmpty) return;

    try {
      List<Location> locations = await locationFromAddress(place);
      if (locations.isNotEmpty) {
        final location = locations.first;
        setState(() {
          _currentLocation = LatLng(location.latitude, location.longitude);
          _zoom = 14.0;
        });
        _mapController.move(_currentLocation, _zoom);
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
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) =>
                      _searchPlace(),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      hintText: 'Search places',
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: Colors.blueAccent,
                      suffixIcon: IconButton(
                          onPressed: () {
                            _controller.clear();
                            setState(() {
                              _currentLocation = const LatLng(9.0820, 8.6753);
                              _zoom = 6.0;
                            });
                            _mapController.move(_currentLocation, _zoom);
                          },
                          icon: const Icon(Icons.clear)),
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
                mapController: _mapController,
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
