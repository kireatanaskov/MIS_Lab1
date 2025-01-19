import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/exam.dart';

class MapScreen extends StatefulWidget {
  final Exam exam;

  MapScreen({required this.exam});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LatLng _fixedStartingPoint = const LatLng(41.9981, 21.4254);
  List<LatLng> _routePoints = [];
  bool _isLoadingRoute = false;
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getRoute();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fitBounds();
    });
  }

  void _fitBounds() {
    if (_mapController != null) {
      final bounds = LatLngBounds(
        LatLng(
          min(_fixedStartingPoint.latitude, widget.exam.location.latitude),
          min(_fixedStartingPoint.longitude, widget.exam.location.longitude),
        ),
        LatLng(
          max(_fixedStartingPoint.latitude, widget.exam.location.latitude),
          max(_fixedStartingPoint.longitude, widget.exam.location.longitude),
        ),
      );

      _mapController.fitBounds(
        bounds,
        options: const FitBoundsOptions(
          padding: EdgeInsets.all(50.0),
        ),
      );
    }
  }

  Future<void> _getRoute() async {
    setState(() {
      _isLoadingRoute = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'http://router.project-osrm.org/route/v1/driving/'
          '${_fixedStartingPoint.longitude},${_fixedStartingPoint.latitude};'
          '${widget.exam.location.longitude},${widget.exam.location.latitude}'
          '?overview=full&geometries=geojson'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final coordinates =
              data['routes'][0]['geometry']['coordinates'] as List;

          setState(() {
            _routePoints = coordinates
                .map(
                    (coord) => LatLng(coord[1].toDouble(), coord[0].toDouble()))
                .toList();
          });
        }
      } else {
        print("Failed to load route");
        throw Exception('Failed to load route');
      }
    } catch (e) {
      print("Error getting route: $e");
    } finally {
      setState(() {
        _isLoadingRoute = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Локација на испит'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _fixedStartingPoint,
              initialZoom: 8.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: widget.exam.location,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  ),
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: _fixedStartingPoint,
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.blue,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              if (_routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      color: Colors.blue,
                      strokeWidth: 3.0,
                    ),
                  ],
                ),
            ],
          ),
          if (_isLoadingRoute)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
