import 'package:flutter/material.dart';
import '../presentation/login_page/login_page.dart';
// Uncomment other screens as needed
import '../presentation/actual_view/actual_view.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/feedback_screen/feedback_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/more_screen/more_screen.dart';
import '../presentation/register_page/register_page.dart';

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String loginScreen = '/login_page';
  static const String registerationScreen = '/registeration_screen';
  static const String homeScreen = '/home_screen';
  static const String actualviewScreen =
      '/actualview_screen'; // Corrected variable name
  static const String moreScreen = '/more_screen';
  static const String feedbackScreen = '/feedback_screen';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginPage(),
    registerationScreen: (context) => RegisterationScreen(),
    homeScreen: (context) => HomeScreen(),
    actualviewScreen: (context) =>
        ActualviewScreen(), // Corrected the screen key
    moreScreen: (context) => MoreScreen(),
    feedbackScreen: (context) => FeedbackScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    initialRoute: (context) => LoginPage(),
  };
}
