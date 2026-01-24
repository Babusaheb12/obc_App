// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// // Ensure this path matches your project structure
// import 'package:obc_app/screen/Auth/login/login.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   late VideoPlayerController _videoController;
//   bool _isVideoInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//   }
//
//   Future<void> _initializeVideo() async {
//     _videoController = VideoPlayerController.asset(
//       'assets/images/Image_To_Splash_GIF_Conversion.mp4',
//     );
//
//     try {
//       await _videoController.initialize();
//       if (!mounted) return;
//
//       setState(() {
//         _isVideoInitialized = true;
//       });
//
//       // Ensure the video does not loop so it ends naturally
//       _videoController.setLooping(false);
//       _videoController.play();
//
//       // Listen for the end of the video
//       _videoController.addListener(() {
//         if (_videoController.value.position >= _videoController.value.duration) {
//           _navigateToLogin();
//         }
//       });
//     } catch (e) {
//       debugPrint("Video Error: $e");
//       // Fallback: wait 3 seconds then navigate if video fails
//       Future.delayed(const Duration(seconds: 3), _navigateToLogin);
//     }
//   }
//
//   // Prevents multiple navigation triggers
//   bool _navigated = false;
//   void _navigateToLogin() {
//     if (!_navigated && mounted) {
//       _navigated = true;
//       Navigator.pushReplacement(
//         context,
//         // Using a FadeTransition makes the jump to the login screen smoother
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) => const MyLoginPage(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(opacity: animation, child: child);
//           },
//         ),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     // It is important to dispose before calling super.dispose()
//     _videoController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Changed from orange to match your login screen theme
//       backgroundColor: const Color(0xFF001233),
//       body: Center(
//         child: _isVideoInitialized
//             ? SizedBox.expand( // This makes the video fill the screen
//           child: FittedBox(
//             fit: BoxFit.contain, // Adjust to 'cover' if you want full-screen video
//             child: SizedBox(
//               width: _videoController.value.size.width,
//               height: _videoController.value.size.height,
//               child: VideoPlayer(_videoController),
//             ),
//           ),
//         )
//             : const CircularProgressIndicator(
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }