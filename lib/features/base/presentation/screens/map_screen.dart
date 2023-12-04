import 'package:app/config/config.dart';
import 'package:app/features/provider/auth_provider.dart';
import 'package:app/models/get_branch_map_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  LatLng? myPosition;
  List<BranchMap> branchMapData = [];

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void loadBranchMapData() async {
    final map = Provider.of<AuthProvider>(context);
    try {
      final response = await map.getAliado();
      branchMapData = response.data;
      addBranchMarkersToMap();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  bool _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      loadBranchMapData();
      getCurrentLocation();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        backgroundColor: colorPrimary,
      ),
      body: myPosition == null
          ? const Center(
              child: CupertinoActivityIndicator(
                color: colorPrimary,
              ),
            )
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: myPosition != null
                  ? CameraPosition(
                      target: myPosition!,
                      zoom: 12,
                    )
                  : const CameraPosition(
                      target: LatLng(
                        0.0,
                        0.0,
                      ),
                      zoom: 12,
                    ),
              onMapCreated: (
                GoogleMapController controller,
              ) {
                mapController = controller;
                addMarker(
                  'Your ubication',
                  myPosition ?? const LatLng(0.0, 0.0),
                );
              },
              markers: _markers.values.toSet(),
            ),
    );
  }

  addMarker(String id, LatLng location) async {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(title: id, snippet: 'Current ubication'),
    );
    _markers[id] = marker;
    setState(() {});
  }

  void addBranchMarkersToMap() {
    for (var branch in branchMapData) {
      LatLng branchLocation = LatLng(
        branch.coordinates[0],
        branch.coordinates[1],
      );
      addMarker(
        branch.name,
        branchLocation,
      );
    }
  }
}
