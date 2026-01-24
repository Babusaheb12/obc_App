import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:obc_app/utils/flutter_color_themes.dart';
import '../../../utils/ImageAssets.dart';
import '../../../utils/constants.dart';
import '../../../utils/flutter_font_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart' as gsi;
import 'OTP.dart';


class MyLoginPage extends StatefulWidget {
   MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final TextEditingController _mobileController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:  SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.appThemes,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.appThemes,
        body: SingleChildScrollView(
          child: Column(
            children: [
               SizedBox(height: 80),
              // Logo Placeholder
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      ImageAssets.appLogo,
                      color: Colors.white,
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              Text(
                Constants.signInAccount,
                textAlign: TextAlign.center,
                style: FTextStyle.sin(context),
              ),

               SizedBox(height: 6),
              Text(
                Constants.enterEmailAndPhone,
                textAlign: TextAlign.center,
                style: FTextStyle.enterEmailAndPhone(context),
              ),

               SizedBox(height: 20),

              // White Card Section
              Container(
                margin:  EdgeInsets.symmetric(horizontal: 24),
                padding:  EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    // Google Sign-In Button
                    OutlinedButton.icon(
                      onPressed: () async {
                        try {
                          // Google Sign-In 7.x uses a singleton instance
                          final gsi.GoogleSignIn googleSignIn = gsi.GoogleSignIn.instance;
                          
                          // Use authenticate() instead of signIn() for 7.x
                          final gsi.GoogleSignInAccount? googleUser = await googleSignIn.authenticate();
                          if (googleUser == null) return; // User cancelled

                          final gsi.GoogleSignInAuthentication googleAuth = googleUser.authentication;

                          // In 7.x, accessToken is removed from GoogleSignInAuthentication on some platforms.
                          // It must be obtained via authorizationClient.
                          await googleSignIn.authorizationClient.authorizeScopes(['email', 'profile']);
                          final accessToken = (await googleSignIn.authorizationClient.authorizationForScopes(['email', 'profile']))?.accessToken;

                          // Create a new credential
                          final credential = GoogleAuthProvider.credential(
                            accessToken: accessToken,
                            idToken: googleAuth.idToken,
                          );

                          // Sign in with Firebase
                          final userCredential =
                          await FirebaseAuth.instance.signInWithCredential(credential);

                          final user = userCredential.user;
                          if (user != null) {
                            print("✅ Google Sign-In successful: ${user.displayName}");
                          }
                        } catch (e) {
                          print("❌ Google Sign-In error: $e");
                        }
                      },

                      icon: Image.asset(
                        ImageAssets.google, // ✅ Google logo image
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      label: Text(
                        Constants.continueGoogle,
                        style: FTextStyle.continueGoogle(context),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        side: BorderSide(color: Colors.black12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Or login with",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),

                    // Mobile Number TextField
                    TextField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Mobile Number",
                        hintStyle:TextStyle(color: AppColors.hintColour),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:BorderSide(color: Colors.grey),
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                    ),
                    SizedBox(height: 24),
                    // Continue Button
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to OTP screen with mobile number
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyOtpScreenPage(
                              mobileNumber: _mobileController.text.trim(),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Color(0xFF001233),
                        minimumSize:Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
      ),
    );
  }
}