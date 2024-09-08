import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tarini/core/utils/sizeutils.dart';
import 'package:dio/dio.dart';
import 'package:tarini/widgets/custom_search_view.dart';
import '../home_screen/direction_model.dart';
import '../home_screen/direction_repository.dart';
import '../actual_view/actual_view.dart'; // Import your actual view screen

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  Completer<GoogleMapController> googleMapController = Completer();

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(16.03412196235649, 73.48415516529604),
    zoom: 11.5,
  );

  GoogleMapController? _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Directions? _info;

  final Dio _dio = Dio(); // Create a Dio instance

  final List<LatLng> _beachLocations = [
    LatLng(17.1421, 73.2682), // Ganpatipule Beach, Maharashtra
    LatLng(16.0392, 73.4620), // Tarkarli Beach, Maharashtra
    LatLng(18.6435, 72.8721), // Alibaug Beach, Maharashtra
    LatLng(18.1761, 73.0274), // Diveagar Beach, Maharashtra
    LatLng(18.3137, 72.9660), // Murud Beach, Maharashtra
    LatLng(15.0097, 74.0234), // Palolem Beach, Goa
  ];

  final List<LatLng> _newCoastalRegions = [
    LatLng(17.1926, 73.3733), // Ratnagiri Beach, Maharashtra
    LatLng(15.4085, 73.8100), // Miramar Beach, Goa
    LatLng(14.9853, 74.0533), // Agonda Beach, Goa
    LatLng(18.2156, 72.8725), // Kihim Beach, Maharashtra
    LatLng(16.8494, 73.5012), // Vijaydurg Beach, Maharashtra
    LatLng(16.6842, 73.3645), // Devgad Beach, Maharashtra
  ];

  @override
  void initState() {
    super.initState();
    _beachMarkers;
    _newCoastalRegions;
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: SizeUtils.height,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 12, left: 12, right: 12, bottom: 12),
                        child: CustomSearchView(
                          controller: searchController,
                          hintText: "Search",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14.h,
                            vertical: 12.h,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _buildMap(), // Google Map integrated here
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: const Color.fromARGB(255, 252, 250, 250),
          onPressed: () => _googleMapController?.animateCamera(
            _info != null
                ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
                : CameraUpdate.newCameraPosition(_initialCameraPosition),
          ),
          child: const Icon(Icons.center_focus_strong),
        ),
      ),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition: _initialCameraPosition,
      onMapCreated: (controller) => _googleMapController = controller,
      markers: {
        if (_origin != null) _origin!,
        if (_destination != null) _destination!,
        ..._beachMarkers, // Add beach markers
        ..._newCoastalRegionMarkers, // Add new coastal region markers
      },
      polylines: {
        if (_info != null)
          Polyline(
            polylineId: const PolylineId('overview_polyline'),
            color: Colors.red,
            width: 5,
            points: _info!.polylinePoints
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          ),
      },
      onLongPress: _addMarker,
    );
  }

  Set<Marker> get _beachMarkers {
    return _beachLocations.map((location) {
      return Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        infoWindow: InfoWindow(
          title: 'Beach Location',
          snippet: 'Fetching weather data...',
          onTap: () async {
            // Fetch weather data before navigating
            final weatherData = await _fetchWeatherData(location);
            // Update marker info window and navigate to the actual view screen
            showModalBottomSheet(
              context: context,
              builder: (_) => generateInfoWindow(location),
            ).whenComplete(() => _renderViewScreen(context));
          },
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    }).toSet();
  }

  Set<Marker> get _newCoastalRegionMarkers {
    return _newCoastalRegions.map((location) {
      return Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        infoWindow: InfoWindow(
          title: 'New Coastal Region',
          snippet: 'Fetching weather data...',
          onTap: () async {
            // Fetch weather data before navigating
            final weatherData = await _fetchWeatherData(location);
            // Update marker info window and navigate to the actual view screen
            showModalBottomSheet(
              context: context,
              builder: (_) => generateInfoWindow(location),
            ).whenComplete(() => _renderViewScreen(context));
          },
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
    }).toSet();
  }

  Future<Map<String, dynamic>> _fetchWeatherData(LatLng location) async {
    final response = await _dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {
        'lat': location.latitude,
        'lon': location.longitude,
        'appid':
            'e7a8163628d3e50dea93b223f7eea0d1', // Replace with your OpenWeather API key
        'units': 'metric',
      },
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Widget generateInfoWindow(LatLng location) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchWeatherData(location),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error loading weather data'));
        }
        final weatherData = snapshot.data!;
        final temperature = weatherData['main']['temp'];
        final windSpeed = weatherData['wind']['speed'];
        final condition = weatherData['weather'][0]['description'];

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weather Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Condition: $condition',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'Temperature: $temperature°C',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'Wind Speed: $windSpeed m/s',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: InfoWindow(
            title: 'Origin',
            onTap: () {
              if (_destination != null) {
                // Navigate to actual view screen after both markers are set
                _renderViewScreen(context);
              }
            },
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // Reset destination
        _destination = null;
        // Reset info
        _info = null;
      });
    } else {
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: InfoWindow(
            title: 'Destination',
            onTap: () {
              if (_origin != null) {
                // Navigate to actual view screen after both markers are set
                _renderViewScreen(context);
              }
            },
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository(dio: _dio)
          .getDirections(origin: _origin!.position, destination: pos);
      setState(() => _info = directions);
    }
  }

  void _renderViewScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ActualviewScreen(), // No need to pass position now
      ),
    );
  }
}
