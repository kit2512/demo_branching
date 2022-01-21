import 'package:demo_branching/src/repositories/location_repository/location_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const mapStyle = """
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#263c3f"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6b9a76"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#38414e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#212a37"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9ca5b3"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1f2835"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#f3d19c"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2f3948"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#515c6d"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  }
]
  """;

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapView(),
    );
  }
}

class MapView extends StatefulWidget {
  const MapView({
    Key? key,
  }) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController _mapController;
  final LocationRepository locationRepository = LocationRepository();

  Marker? origin;
  Marker? destination;
  Marker? currentLocation;
  MapType mapType = MapType.normal;

  final _initalPosition = LatLng(20.100000, 106.126288);

  void _onCreate(GoogleMapController controller) async {
    _mapController = controller;
    _mapController.setMapStyle(mapStyle);
    final currentPosition = await locationRepository.getPosition();
    final currentLatLng =
        LatLng(currentPosition.latitude, currentPosition.longitude);
    currentLocation = Marker(
      markerId: MarkerId("currentLocation"),
      position: currentLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
    _mapController.animateCamera(CameraUpdate.newLatLng(currentLatLng));
    setState(() {});
  }

  void _onTap(LatLng latLng) {
    _mapController.animateCamera(CameraUpdate.newLatLng(latLng));
    setState(() {
      origin = Marker(
        markerId: MarkerId("origin"),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
      );
    });
  }

  void _onLongPressed(LatLng latLng) {
    _mapController.animateCamera(CameraUpdate.newLatLng(latLng));
    setState(() {
      destination = Marker(
        markerId: MarkerId("destination"),
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400,
          child: GoogleMap(
            onMapCreated: _onCreate,
            initialCameraPosition: CameraPosition(
              target: _initalPosition,
              zoom: 15,
            ),
            markers: {
              if (currentLocation != null) currentLocation!,
              if (origin != null) origin!,
              if (destination != null) destination!,
            },
            onTap: _onTap,
            onLongPress: _onLongPressed,
            mapType: mapType,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final position = await locationRepository.getPosition();
                  final latLng = LatLng(position.latitude, position.longitude);
                  _mapController.animateCamera(
                    CameraUpdate.newLatLngZoom(
                      latLng,
                      16.0,
                    ),
                  );
                },
                child: Icon(Icons.location_on),
              ),
              ElevatedButton(
                child: Text("Toggle map type"),
                onPressed: () {
                  setState(() {
                    mapType = mapType == MapType.normal
                        ? MapType.satellite
                        : MapType.normal;
                  });
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
