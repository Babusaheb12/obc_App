import 'package:flutter/material.dart';
import 'package:obc_app/utils/constants.dart';
import 'package:obc_app/utils/flutter_color_themes.dart';

import '../../../utils/ImageAssets.dart';
import '../../../utils/flutter_font_style.dart';
import '../../../widgets/BootomNavBar/homeScreen.dart';

class MyOtpScreenPage extends StatefulWidget {
  final String mobileNumber;
  
   MyOtpScreenPage({super.key, required this.mobileNumber});

  @override
  State<MyOtpScreenPage> createState() => _MyOtpScreenPageState();
}

class _MyOtpScreenPageState extends State<MyOtpScreenPage> {
  // Focus nodes to automatically move to the next box
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Matching the deep navy background from the image
      backgroundColor: AppColors.appThemes,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),
            // Logo section
            Center(
              child: Column(
                children: [
                  Image.asset(
                    ImageAssets.appLogo, // Ensure this path is correct in your pubspec.yaml
                    color: AppColors.white,
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
            ),
            // Header Text
            Text(
              Constants.verifyOtp,
              style: FTextStyle.sin(context),
            ),
            SizedBox(height: 12),
            Text(
              Constants.enterOSentOtp,
              style: FTextStyle.enterEmailAndPhone(context),
            ),
            Text(
              widget.mobileNumber,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 40),

            // White Card Section
            Container(
              margin:  EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  // OTP Input Boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) => _buildOtpBox(index)),
                  ),
                  SizedBox(height: 20),
                  // Resend Timer Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive OTP? ",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Text(
                        "Resend OTP in 01:55",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Verify Button
                  ElevatedButton(
                    onPressed: () {
                      // 1️⃣ OTP collect kar lo (optional but best practice)
                      final otp = _controllers.map((e) => e.text).join();
                      print("Entered OTP: $otp");

                      // 2️⃣ Navigation (OTP verified maan ke)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF001233),
                      minimumSize: Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Verify",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for individual OTP squares
  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style:  TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: "", // Removes the character counter
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:  BorderSide(color: Colors.black26),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:  BorderSide(color: Color(0xFF001233), width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}