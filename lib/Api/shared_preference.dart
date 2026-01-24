import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

import 'Api_url.dart';

class Prefs {
  static SharedPreferences? _prefs;

  /// Call this once in `main()` before `runApp()`
  static Future<void> initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    // Ensure address storage consistency on app start
    await _synchronizeAddressOnInit();
  }

  /// Private method to synchronize address storage on app initialization
  static Future<void> _synchronizeAddressOnInit() async {
    if (_prefs == null) return;

    // Get address from all possible sources
    final mainAddress = _prefs!.getString('address');
    final locationAddress = _prefs!.getString('user_location');

    // Determine which address to use (prioritize main address)
    String? addressToSync;
    if (mainAddress != null && mainAddress.isNotEmpty) {
      addressToSync = mainAddress;
    } else if (locationAddress != null && locationAddress.isNotEmpty) {
      addressToSync = locationAddress;
    }

    // Sync the address to all storage methods if we found one
    if (addressToSync != null) {
      await _prefs!.setString('address', addressToSync);
      await _prefs!.setString('user_location', addressToSync);
      developer.log('Address synchronized on app init: $addressToSync', name: 'Prefs');
    }
  }

  // ----------------- Token Handling -----------------

  static Future<void> setToken(String token) async {
    await initPrefs();
    await _prefs!.setString('authToken', token);
  }

  static Future<void> setLocation(String address) async {
    await _prefs?.setString('user_location', address);
  }

  static Future<String?> getLocation() async {
    return _prefs?.getString('user_location');
  }

  static Future<void> clearLocation() async {
    await _prefs?.remove('user_location');
  }

  static String? getToken() {
    return _prefs?.getString('authToken');
  }

  static Future<void> clearToken() async {
    await initPrefs();
    await _prefs!.remove('authToken');
  }

  static Future<void> setFcmToken(String fcmToken) async {
    await _prefs?.setString('fcmToken', fcmToken);
  }

  static String? getFcmToken() {
    return _prefs?.getString('fcmToken');
  }

  static Future<void> setDeviceToken(String token) async {
    await initPrefs();
    await _prefs!.setString('deviceToken', token);
  }

  static Future<String?> getDeviceToken() async {
    await initPrefs();
    return _prefs?.getString('deviceToken');
  }

  static Future<void> setGeneralNotification(bool value) async {
    await initPrefs();
    await _prefs!.setBool('generalNotification', value);
  }

  static bool getGeneralNotification() {
    return _prefs?.getBool('generalNotification') ?? true;
  }

  static Future<void> setSound(bool value) async {
    await initPrefs();
    await _prefs!.setBool('sound', value);
  }

  static bool getSound() {
    return _prefs?.getBool('sound') ?? false;
  }

  static Future<void> setVibrate(bool value) async {
    await initPrefs();
    await _prefs!.setBool('vibrate', value);
  }

  static bool getVibrate() {
    return _prefs?.getBool('vibrate') ?? false;
  }

  static Future<void> clearDeviceToken() async {
    await initPrefs();

    final oldToken = _prefs?.getString('deviceToken');
    developer.log("Device token before remove: $oldToken", name: "Prefs");

    await _prefs!.remove('deviceToken');

    final afterRemove = _prefs?.getString('deviceToken');
    developer.log("Device token after remove: $afterRemove", name: "Prefs");
  }

  // ----------------- User Info -----------------

  static String notifi() {
    final userId = getUserId();
    return "${ApiUrls.baseUrl}user/notifications-enable/$userId";
  }

  static Future<void> setFullName(String fullName) async {
    await initPrefs();
    await _prefs!.setString('fullName', fullName);
  }

  static String? getFullName() {
    return _prefs?.getString('fullName');
  }

  static Future<void> setCity(String city) async {
    await initPrefs();
    await _prefs!.setString('city', city);
  }

  static String? getCity() {
    return _prefs?.getString('city');
  }

  static Future<void> setAddress(String address) async {
    await initPrefs();
    await _prefs!.setString('address', address);
  }

  static String? getAddress() {
    return _prefs?.getString('address');
  }

  /// Synchronized method to set address across all storage methods
  static Future<void> setSynchronizedAddress(String address) async {
    await initPrefs();
    // Set in all possible address storage locations for consistency
    await _prefs!.setString('address', address);
    await _prefs!.setString('user_location', address);
    developer.log('Address synchronized across all storage methods: $address', name: 'Prefs');
  }

  /// Get address from any available storage method
  static Future<String?> getSynchronizedAddress() async {
    await initPrefs();
    // Try multiple sources in priority order
    String? address = _prefs?.getString('address');
    if (address == null || address.isEmpty) {
      address = _prefs?.getString('user_location');
    }
    developer.log('Retrieved synchronized address: $address', name: 'Prefs');
    return address;
  }

  static Future<void> setPhone(String phone) async {
    await initPrefs();
    await _prefs!.setString('phone', phone);
  }

  static String? getPhone() {
    return _prefs?.getString('phone');
  }

  static Future<void> setEmail(String email) async {
    await initPrefs();
    await _prefs!.setString('email', email);
  }

  static String? getEmail() {
    return _prefs?.getString('email');
  }

  static Future<void> setAvatarUrl(String url) async {
    await initPrefs();
    await _prefs!.setString('avatarUrl', url);
  }

  static String? getAvatarUrl() {
    return _prefs?.getString('avatarUrl');
  }

  static Future<void> clearAvatarUrl() async {
    await initPrefs();
    await _prefs!.remove('avatarUrl');
    developer.log("Avatar URL cleared", name: "Prefs");
  }

  static Future<void> setProfileImage(String url) async {
    await initPrefs();
    await _prefs!.setString('avatarUrl', url);
  }

  static String? getProfileImage() {
    return _prefs?.getString('avatarUrl');
  }

  static Future<void> setUserId(String id) async {
    await initPrefs();
    await _prefs!.setString('userId', id);
  }

  static String? getUserId() {
    return _prefs?.getString('userId');
  }

  static Future<void> setProfileImageUrl(String url) async {
    await initPrefs();
    await _prefs!.setString('profileImageUrl', url);
  }

  static String? getProfileImageUrl() {
    return _prefs?.getString('profileImageUrl');
  }

  // Items

  // Set seller ID
  static Future<void> setSellerId(String id) async {
    await initPrefs();
    await _prefs!.setString('seller', id);
  }

  static Future<void> clearUserId() async {
    await initPrefs();
    final oldUserId = _prefs?.getString('userId');
    developer.log("User ID before remove: $oldUserId", name: "Prefs");
    await _prefs!.remove('userId');
    final afterRemove = _prefs?.getString('userId');
    developer.log("User ID after remove: $afterRemove", name: "Prefs");
  }

  static Future<void> clearUserData() async {
    await initPrefs();
    // Clear all user data but preserve route information for web
    final savedRoute = _prefs?.getString('last_route');
    final savedArgs = _prefs?.getString('last_route_arguments');

    await _prefs!.clear();

    // Restore route information after clearing (for web persistence)
    if (savedRoute != null) {
      await _prefs!.setString('last_route', savedRoute);
    }
    if (savedArgs != null) {
      await _prefs!.setString('last_route_arguments', savedArgs);
    }

    developer.log("User data cleared (routes preserved)", name: "Prefs");
  }

  // Get seller ID
  static Future<String?> getSellerId() async {
    await initPrefs();
    return _prefs?.getString('seller');
  }

  // Set product ID
  static Future<void> setProductId(String id) async {
    await initPrefs();
    await _prefs!.setString('_id', id);
  }

  // Get product ID
  static Future<String?> getProductId() async {
    await initPrefs();
    return _prefs?.getString('_id');
  }

  // ----------------- Enhanced Route Management -----------------

  /// Save the last visited route with timestamp
  static Future<void> setLastRoute(String route) async {
    await initPrefs();
    await _prefs!.setString('last_route', route);
    await _prefs!.setInt('last_route_timestamp', DateTime.now().millisecondsSinceEpoch);

  }

  /// Get the last visited route
  static String? getLastRoute() {
    return _prefs?.getString('last_route');
  }

  /// Get the timestamp when the route was saved
  static int? getLastRouteTimestamp() {
    return _prefs?.getInt('last_route_timestamp');
  }

  /// Check if the saved route is still valid (within 24 hours)
  static bool isLastRouteValid() {
    final timestamp = getLastRouteTimestamp();
    if (timestamp == null) return false;

    final now = DateTime.now().millisecondsSinceEpoch;
    final difference = now - timestamp;
    const twentyFourHours = 24 * 60 * 60 * 1000; // 24 hours in milliseconds

    return difference < twentyFourHours;
  }

  /// Save the arguments for the last visited route
  static Future<void> setLastRouteArguments(String argumentsJson) async {
    await initPrefs();
    await _prefs!.setString('last_route_arguments', argumentsJson);
    developer.log("Saved last route arguments: $argumentsJson", name: "Prefs");
  }

  /// Get the arguments for the last visited route
  static String? getLastRouteArguments() {
    return _prefs?.getString('last_route_arguments');
  }

  /// Save route with parameters (for complex routes like chat)
  static Future<void> setLastRouteWithParams(String route, Map<String, dynamic>? params) async {
    await initPrefs();
    await setLastRoute(route);

    if (params != null && params.isNotEmpty) {
      final paramsJson = params.entries.map((e) => '"${e.key}":"${e.value}"').join(',');
      await setLastRouteArguments('{$paramsJson}');
    } else {
      await setLastRouteArguments('');
    }
  }

  /// Clear the saved route and arguments (e.g., on logout or when navigating to login/onboarding)
  static Future<void> clearLastRoute() async {
    await initPrefs();
    await _prefs!.remove('last_route');
    await _prefs!.remove('last_route_arguments');
    await _prefs!.remove('last_route_timestamp');
    developer.log("Cleared last route and arguments", name: "Prefs");
  }

  /// Get valid route for restoration (returns null if route is expired or invalid)
  static String? getValidLastRoute() {
    if (!isLastRouteValid()) {
      developer.log("Last route expired, clearing...", name: "Prefs");
      clearLastRoute();
      return null;
    }

    final route = getLastRoute();
    // Don't restore login/onboarding routes
    if (route == '/LoginScreen' || route == '/onboarding' || route == '/' || route == null) {
      return null;
    }

    return route;
  }

  // ----------------- App State Management -----------------

  /// Set app state (for web session management)
  static Future<void> setAppState(String state) async {
    await initPrefs();
    await _prefs!.setString('app_state', state);
    await _prefs!.setInt('app_state_timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  /// Get app state
  static String? getAppState() {
    return _prefs?.getString('app_state');
  }

  /// Check if user was actively using the app (within last 30 minutes)
  static bool wasRecentlyActive() {
    final timestamp = _prefs?.getInt('app_state_timestamp');
    if (timestamp == null) return false;

    final now = DateTime.now().millisecondsSinceEpoch;
    final difference = now - timestamp;
    const thirtyMinutes = 30 * 60 * 1000; // 30 minutes in milliseconds

    return difference < thirtyMinutes;
  }

  /// Update last activity timestamp
  static Future<void> updateLastActivity() async {
    await initPrefs();
    await _prefs!.setInt('last_activity', DateTime.now().millisecondsSinceEpoch);
  }

  /// Clear app state
  static Future<void> clearAppState() async {
    await initPrefs();
    await _prefs!.remove('app_state');
    await _prefs!.remove('app_state_timestamp');
    await _prefs!.remove('last_activity');
  }

  // ----------------- Session Management -----------------

  /// Set session data
  static Future<void> setSessionData(Map<String, dynamic> sessionData) async {
    await initPrefs();
    final sessionJson = sessionData.entries.map((e) => '"${e.key}":"${e.value}"').join(',');
    await _prefs!.setString('session_data', '{$sessionJson}');
  }

  /// Get session data
  static String? getSessionData() {
    return _prefs?.getString('session_data');
  }

  /// Clear session data
  static Future<void> clearSessionData() async {
    await initPrefs();
    await _prefs!.remove('session_data');
  }

  /// Complete logout - clear everything except route persistence for web
  static Future<void> performCompleteLogout() async {
    await initPrefs();

    // Save current route for web before clearing (if valid)
    String? routeToSave;
    String? argsToSave;
    final currentRoute = getLastRoute();
    final currentArgs = getLastRouteArguments();

    if (currentRoute != null &&
        currentRoute != '/LoginScreen' &&
        currentRoute != '/onboarding' &&
        currentRoute != '/' &&
        isLastRouteValid()) {
      routeToSave = currentRoute;
      argsToSave = currentArgs;
    }

    // Clear everything
    await _prefs!.clear();

    // Restore route for web persistence
    if (routeToSave != null) {
      await _prefs!.setString('last_route', routeToSave);
      await _prefs!.setInt('last_route_timestamp', DateTime.now().millisecondsSinceEpoch);
      if (argsToSave != null && argsToSave.isNotEmpty) {
        await _prefs!.setString('last_route_arguments', argsToSave);
      }
    }

    developer.log("Complete logout performed", name: "Prefs");
  }
}