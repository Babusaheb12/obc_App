import 'dart:async';
import 'package:flutter/material.dart';
import 'package:obc_app/utils/constants.dart';
import 'package:obc_app/utils/flutter_color_themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

import '../../../utils/ImageAssets.dart';
import '../../../utils/flutter_font_style.dart';
import '../../../widgets/BootomNavBar/homeScreen.dart';
import '../Bloc/verifyOtp/verify_otp_bloc.dart';

class MyOtpScreenPage extends StatefulWidget {
  final String mobileNumber;
  
   const MyOtpScreenPage({super.key, required this.mobileNumber});

  @override
  State<MyOtpScreenPage> createState() => _MyOtpScreenPageState();
}

class _MyOtpScreenPageState extends State<MyOtpScreenPage> {
  // Focus nodes to automatically move to the next box
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  
  // Timer variables
  int _start = 120;  // 2 minutes (120 seconds)
  bool _isTimerActive = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }
  
  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    _timer.cancel();
    super.dispose();
  }
  
  // Timer method
  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _isTimerActive = false;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  
  // Resend OTP method
  void _resendOtp() {
    setState(() {
      _start = 120;  // Reset to 2 minutes
      _isTimerActive = true;
    });
    _startTimer();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP resent successfully to ${widget.mobileNumber}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyOtpBloc(),
      child: BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
        listener: (context, state) {
          if (state is VerifyOtpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
            );
          } else if (state is VerifyOtpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                          ImageAssets.appLogo, 
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
                            if (_isTimerActive)
                              Text(
                                "Resend OTP in ${_formatTime(_start)}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              )
                            else
                              GestureDetector(
                                onTap: _resendOtp,
                                child: Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    color: Color(0xFF001233),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        SizedBox(height: 20),

                        // Verify Button
                        ElevatedButton(
                          onPressed: state is VerifyOtpLoading
                              ? null
                              : () {
                                  final otp = _controllers.map((e) => e.text).join();
                                  dev.log("Entered OTP: $otp", name: 'OTPScreen');
                                  
                                  if (otp.length < 4) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please enter 4-digit OTP')),
                                    );
                                    return;
                                  }

                                  context.read<VerifyOtpBloc>().add(SubmitOtpEvent(otp: otp, mobile: widget.mobileNumber));
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF001233),
                            minimumSize: Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: state is VerifyOtpLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : Text(
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
        },
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
  
  // Format time method
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}