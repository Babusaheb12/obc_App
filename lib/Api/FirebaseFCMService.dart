
import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> getSafeFCMToken() async {
  final messaging = FirebaseMessaging.instance;

  try {
    // Request iOS notification permission
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional) {
      // Wait a short moment for APNs token to be ready
      await Future.delayed(const Duration(seconds: 1));
      final token = await messaging.getToken();
      print("✅✅✅✅ FCM Token: $token");
      return token ?? "SIMULATOR_DEVICE_TOKEN"; // fallback for simulator
    } else {
      print("❌ Notification permission denied");
      return "SIMULATOR_DEVICE_TOKEN"; // fallback if denied
    }
  } catch (e) {
    print("❌ Failed to get FCM token: $e");
    return "SIMULATOR_DEVICE_TOKEN"; // fallback on error
  }
}
/// initialize in main.dart file is
/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Get safe token
  String token = await getSafeFCMToken();
  print("🔥🔥🔥🔥 FINAL FCM TOKEN: $token");
  runApp(const MyApp());
}
 */