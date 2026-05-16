import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:obc_app/screen/Auth/Bloc/verifyOtp/verify_otp_bloc.dart';

import 'package:obc_app/screen/Auth/login/login.dart';
import 'package:obc_app/utils/size_config.dart';
import 'package:obc_app/screen/Auth/Bloc/login/mobile_login_bloc.dart';
import 'package:obc_app/widgets/BootomNavBar/homeScreen.dart';
import 'Api/FirebaseFCMService.dart';
import 'Api/ConnectivityService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await GoogleSignIn.instance.initialize(
    serverClientId: 'YOUR_WEB_CLIENT_ID_HERE',
  );

  String token = await getSafeFCMToken();
  debugPrint("🔥 FINAL FCM TOKEN: $token");

  // Initialize Connectivity Service
  ConnectivityService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    // Dispose connectivity service when app is closed
    ConnectivityService().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF00123C),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig.init(context);
        return MultiBlocProvider(
          providers: [
            BlocProvider<MobileLoginBloc>(
              create: (_) => MobileLoginBloc(),
            ),
            BlocProvider<VerifyOtpBloc>(
              create: (_) => VerifyOtpBloc(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'obsessedbycar',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF00123C),
              ),
              scaffoldBackgroundColor: const Color(0xFF00123C),
            ),
            // home: MyLoginPage(),
            home: MainScreen(),
          ),
        );
      },
    );
  }
}
