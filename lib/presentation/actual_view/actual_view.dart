import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/app_expsrt.dart';
import '../../core/utils/image_constant.dart';
import '../more_screen/more_screen.dart'; // Import the more_screen

// ignore_for_file: must_be_immutable
class ActualviewScreen extends StatelessWidget {
  ActualviewScreen({Key? key}) : super(key: key);

  Completer<GoogleMapController> googleMapController = Completer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Container(
              width: double.infinity,
              decoration: Appdecoration.fillOnPrimaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder14,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMapMakerGirgaon(context),
                  const SizedBox(height: 16),
                  _buildLocationRow(context),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 10),
                  _buildWeatherRow(context, "Sunny/Rainy", Icons.sunny),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 12),
                  _buildWeatherRow(context, "28 °C", Icons.thermostat),
                  const SizedBox(height: 18),
                  const Divider(),
                  const SizedBox(height: 10),
                  _buildWeatherRow(context, "85%", Icons.water_drop),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 14),
                  _buildWeatherRow(context, "Sunset with time", Icons.sunny),
                  const SizedBox(height: 14),
                  const Divider(),
                  const SizedBox(height: 4),
                  _buildSettingsRow(context),
                  const Divider(),
                  const SizedBox(height: 54),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Map Widget
  Widget _buildMapMakerGirgaon(BuildContext context) {
    return SizedBox(
      height: 446,
      width: double.infinity,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.43296265331129, -122.08832357078792),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          googleMapController.complete(controller);
        },
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
      ),
    );
  }

  /// Location Row with Icon
  Widget _buildLocationRow(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 5, right: 38),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on, // Use the location icon
            size: 30, // Adjust the size as needed
            color: Theme.of(context).primaryColor, // Set the color
          ),
          const SizedBox(width: 22),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 2),
                child: Text(
                  "Chowpatty, Girgaon, Mumbai, Maharashtra",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.titleLargePrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Weather Row with Icon
  Widget _buildWeatherRow(BuildContext context, String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Theme.of(context).primaryColor),
        const SizedBox(width: 10),
        Text(
          label,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }

  /// Settings Row with Icons and Navigation to MoreScreen
  Widget _buildSettingsRow(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 16, right: 12),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.img2lvfi9kd1qh2kk1kg5u1azrlaii,
                height: 50,
                width: 50,
              ),
              const SizedBox(width: 20),
              CustomImageView(
                imagePath: ImageConstant.imgSettings,
                height: 50,
                width: 50,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                size: 25,
                color: Color(0xFF131313),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MoreScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
