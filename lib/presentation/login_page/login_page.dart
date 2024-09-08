import 'package:flutter/material.dart';
import 'package:tarini/core/utils/image_constant.dart';
import '../../core/app_expsrt.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true; // Variable to toggle password visibility

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 130.0, horizontal: 44.0),
              decoration: Appdecoration.fillOnPrimaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder14,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.user_icon,
                    height: 80,
                    width: 65,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "User Login",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 12.0),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 18.0),
                    decoration: Appdecoration.fillWhiteA.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder5,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 26.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Email",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0, right: 8.0),
                          child: TextField(
                            controller: widget.emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              contentPadding: const EdgeInsets.fromLTRB(
                                  22.0, 22.0, 22.0, 26.0),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Password",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 4.0),
                          child: TextField(
                            controller: widget.passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintText: "Password",
                              contentPadding: const EdgeInsets.fromLTRB(
                                  22.0, 22.0, 22.0, 26.0),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        CustomElevatedButton(
                          text: "Login",
                          margin: const EdgeInsets.only(left: 8.0, right: 6.0),
                          onPressed: () {
                            onTapLogin(context);
                          },
                        ),
                        const SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: () {
                            // Implement the logic for "Forget Password" if needed
                          },
                          child: Text(
                            "New User? Forget Password",
                            style: CustomTextStyles.titleLargePrimary,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.registerationScreen);
                          },
                          child: Text(
                            "Register",
                            style: CustomTextStyles.titleLargePrimary,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        // Responsive Image with Padding
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 50.0), // Add padding to move image downward
                          child: SizedBox(
                            width: screenWidth *
                                0.6, // Set width as a percentage of screen width
                            child: Image.asset(
                              ImageConstant
                                  .incois, // Replace with your image path
                              fit: BoxFit
                                  .contain, // Adjusts image to fit the available space
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTapLogin(BuildContext context) {
    // Navigate to the Home screen on successful login
    Navigator.pushNamed(context, AppRoutes.homeScreen);
  }
}
