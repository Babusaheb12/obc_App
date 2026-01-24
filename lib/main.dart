// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:obc_app/screen/Auth/login/login.dart';
// import 'package:obc_app/utils/size_config.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import 'Api/FirebaseFCMService.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   // Google Sign-In 7.x requires initialization on the singleton instance.
//   // Replace the placeholder with your actual Web Client ID if needed.
//   await GoogleSignIn.instance.initialize(
//     serverClientId: 'YOUR_WEB_CLIENT_ID_HERE',
//   );
//
//
//   // Get safe token
//   String token = await getSafeFCMToken();
//   print("🔥🔥🔥🔥 FINAL FCM TOKEN: $token");
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return LayoutBuilder(builder: (context, constraints) {
//       SizeConfig.init(context);
//       return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'obsessedbycar',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(
//             seedColor: const Color(0xFF00123C), // ✅ Your custom theme color
//           ),
//           useMaterial3: true, // optional, if you want Material 3 look
//         ),
//         home: MyLoginPage(),
//       );
//     });
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:obc_app/screen/Auth/login/login.dart';
import 'package:obc_app/utils/size_config.dart';
import 'Api/FirebaseFCMService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Firebase Init
  await Firebase.initializeApp();

  // 🔥 Google Sign-In Init
  await GoogleSignIn.instance.initialize(
    serverClientId: 'YOUR_WEB_CLIENT_ID_HERE',
  );

  // 🔥 FCM Token
  String token = await getSafeFCMToken();
  debugPrint("🔥 FINAL FCM TOKEN: $token");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 STATUS BAR ICONS → WHITE
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFF00123C), // Dark background
        statusBarIconBrightness: Brightness.light, // Android icons white
        statusBarBrightness: Brightness.dark, // iOS icons white
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig.init(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'obsessedbycar',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xFF00123C),
            ),
            scaffoldBackgroundColor:  Color(0xFF00123C),
          ),
          home:  MyLoginPage(),
        );
      },
    );
  }
}
