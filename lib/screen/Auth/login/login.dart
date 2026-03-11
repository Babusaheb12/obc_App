import 'dart:developer' as dev;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:obc_app/utils/flutter_color_themes.dart';
import '../../../utils/ImageAssets.dart';
import '../../../utils/constants.dart';
import '../../../utils/flutter_font_style.dart';
import 'package:google_sign_in/google_sign_in.dart' as gsi;
import 'OTP.dart';
import '../Bloc/login/mobile_login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Api/ConnectivityService.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class MyLoginPage extends StatefulWidget {
   MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final TextEditingController _mobileController = TextEditingController();
  bool _isConnected = true;
  
  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    // Listen to connectivity changes
    ConnectivityService().connectivityStream.listen((result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
      });
    });
  }
  
  Future<void> _checkConnectivity() async {
    bool connected = await ConnectivityService.isConnected();
    if (mounted) {
      setState(() {
        _isConnected = connected;
      });
    }
  }
  
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
          body: BlocConsumer<MobileLoginBloc, MobileLoginState>(
            listener: (context, state) {
              if (state is MobileLoginSuccess) {
                // Navigate to OTP screen with mobile number
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyOtpScreenPage(
                      mobileNumber: _mobileController.text.trim(),
                    ),
                  ),
                );
              } else if (state is MobileLoginError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              bool isLoading = state is MobileLoginLoading;
              return SingleChildScrollView(
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
                                  print("✅ Google Sign-In successful: \${user.displayName}");
                                }
                              } catch (e) {
                                print("❌ Google Sign-In error: \$e");
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
                          // Connectivity status indicator
                          if (!_isConnected)
                            Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                border: Border.all(color: Colors.orange.shade200),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.wifi_off, color: Colors.orange, size: 20),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'No internet connection. Please check your network.',
                                      style: TextStyle(
                                        color: Colors.orange.shade800,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          
                          // Continue Button
                          ElevatedButton(
                            onPressed: isLoading || !_isConnected ? null : () {
                              // Validate mobile number first
                              String mobile = _mobileController.text.trim();
                              if (mobile.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please enter mobile number')),
                                );
                                return;
                              }
                              
                              // Clean the mobile number
                              String cleanMobile = mobile.replaceAll(RegExp(r'[^0-9]'), '');
                              dev.log('Login Screen - Input mobile: $mobile, Cleaned: $cleanMobile, Length: ${cleanMobile.length}', name: 'LoginValidation');
                              
                              if (cleanMobile.length != 10 || !RegExp(r'^[6-9]').hasMatch(cleanMobile)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please enter a valid mobile number.')),
                                );
                                return;
                              }
                              
                              // Trigger the bloc event to send OTP with cleaned number
                              context.read<MobileLoginBloc>().add(
                                SendOtpEvent(mobile: cleanMobile),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: !_isConnected ? Colors.grey : Color(0xFF001233),
                              minimumSize:Size(double.infinity, 55),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isLoading 
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
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
              );
            },
          ),
      ),
    );
  }
}