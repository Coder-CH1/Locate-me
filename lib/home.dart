import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final TextEditingController _controller;
  LatLng _currentLocation = const LatLng(9.0820, 8.6753);
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

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
                  options: const MapOptions(),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
