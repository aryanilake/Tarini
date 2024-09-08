import 'package:flutter/material.dart';
import 'package:tarini/core/utils/image_constant.dart';
import '../../core/app_expsrt.dart';
import '../../widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          // Enable scrolling
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(
              left: 12,
              top: 12,
              right: 12,
            ),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: Appdecoration.fillOnPrimaryContainer.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder14,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.beach1_img,
                        height: 238,
                        width: double.maxFinite,
                        radius: BorderRadius.circular(14),
                      ),
                      const SizedBox(height: 36),
                      _buildFeedbackRow(context),
                      const SizedBox(height: 14),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 26,
                          right: 18,
                        ),
                        child: CustomSearchView(
                          controller: searchController,
                          hintText: "Type here....",
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.symmetric(horizontal: 34),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgChat,
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                "Read more....",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 395), // Adjust this as needed
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFeedbackRow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 58,
              width: 60,
              decoration: Appdecoration.fillOnPrimary.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "A",
                    style: CustomTextStyles.headlineLargeWhiteA700,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36, top: 2),
            child: Text(
              "Feedback",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ],
      ),
    );
  }
}
