import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tarini/core/utils/image_constant.dart';
import '../../core/app_expsrt.dart';
import 'widgets/moreplaces_item_widget.dart';

// ignore_for_file: must_be_immutable
class MoreScreen extends StatelessWidget {
  MoreScreen({Key? key}) : super(key: key);

  Completer<GoogleMapController> googleMapController = Completer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 12.0),
                child: Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(right: 2),
                  decoration: Appdecoration.fillOnPrimaryContainer.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder14,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildMapMakerGirgaon(context),
                      const SizedBox(height: 20),
                      _buildGraphSection(context),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 20),
                      _buildSectionTitle("Nearby places", context),
                      const SizedBox(height: 10),
                      _buildMorePlaces(context),
                      const SizedBox(height: 26),
                      _buildSectionTitle("Dining places", context),
                      const SizedBox(height: 4),
                      _buildMapMakerRow(context),
                      const SizedBox(height: 74),
                    ],
                  ),
                ),
              ),
              // Positioned Floating Action Button for feedback
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    // Navigate to the feedback page
                    Navigator.pushNamed(context, '/feedback_screen');
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.feedback),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Map Widget
  Widget _buildMapMakerGirgaon(BuildContext context) {
    return SizedBox(
      height: 238,
      width: 404,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(
            37.43296265331129,
            -122.08832357078792,
          ),
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

  /// Graph Section Widget
  Widget _buildGraphSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.graph,
            height: 50,
            width: 50,
            alignment: Alignment.center,
          ),
          const SizedBox(width: 32),
          Text(
            "Graph",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }

  /// More Places Widget
  Widget _buildMorePlaces(BuildContext context) {
    return SizedBox(
      height: 184,
      width: double.maxFinite,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemCount: 2,
        itemBuilder: (context, index) {
          return MoreplacesItemWidget();
        },
      ),
    );
  }

  /// Dining Section Widget
  /// Dining Section Widget
  /// Dining Section Widget
  Widget _buildMapMakerRow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CustomImageView(
              imagePath: ImageConstant.restaurant_img, // First image
              height: 184,
              width: double.infinity, // Allow it to take available space
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 8),
            ),
          ),
          SizedBox(width: 10), // Add some spacing between the images
          Flexible(
            child: CustomImageView(
              imagePath: ImageConstant.restaurant_img, // Second image
              height: 184,
              width: double.infinity, // Allow it to take available space
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 8),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper for Section Titles
  Widget _buildSectionTitle(String title, BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 22),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
