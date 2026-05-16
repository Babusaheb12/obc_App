class ApiUrls {
  // BASE URL
  // static const baseUrl = 'https://obsessedbycar.com/';
  static const baseUrl = 'https://obsessedbycar.com/';
  // static const baseUrl = 'https://obsessedbycar.com/obc/obc/';
  static const String imageBaseUrl = '${baseUrl}images/';

  // google map key
  static const googleMap = 'AIzaSyCzU4XQ6D43-mEnHWZ5l3vobePxE6p2GRw';
/// https://obsessedbycar.com/

  // END POINT URL
/// send mobile number
  static const String mobileLogin = '${baseUrl}obc/obc/send_otp.php';
  static const String verifyOtp = '${baseUrl}obc/obc/verify_otp.php';


  /// Dashboard img
  static const String slider = '${baseUrl}api-firebase/slider_all.php';
  static const String carBrandLogo = '${baseUrl}api-firebase/get-car-maker.php';

  static const String carModel = '${baseUrl}api-firebase/get-car-model.php';


  //categoty fetch
  static const String category = '${baseUrl}api-firebase/get-category.php';
  static const String subcategory = '${baseUrl}api-firebase/get-sub-category.php';

  //// carAccessories
  static const String carAccessories = '${baseUrl}api-firebase/get-accessories.php';
  static const String getSingleAccessories = '${baseUrl}api-firebase/get-acc-single.php';

// tyreAlloys
  static const String tyreAlloys = '${baseUrl}api-firebase/tyre.php';
  static const String tyreDetails = '${baseUrl}api-firebase/tyre_single.php';


  static const String getPreownedCars = '${baseUrl}api-firebase/get-preowned-cars.php';
  static const String getPreownedCarsDetails = '${baseUrl}api-firebase/get-preowned-cars.php';

}