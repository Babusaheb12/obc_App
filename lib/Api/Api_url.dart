class ApiUrls {
  // BASE URL

  // static const baseUrl = 'https://node-salvaging.mobiloitte.io/api/';
  //saurabh
  //static const baseUrl = 'http://172.16.6.38:2221/api/';

  //vishal

  static const baseUrl = 'http://172.16.1.254:2221/api/';

  // google map key
  static const googleMap = 'AIzaSyCzU4XQ6D43-mEnHWZ5l3vobePxE6p2GRw';

  //stripe publishableKey key
  //test
  static const String publishableKey ='pk_test_51RqrU6AZsyU4dErWFyNiB5ZJU4QqwOStTifS6On1dKYo82XDn03oVL3SgqjUvNmGHxX4nCSZq91MbSQwoIHZ11by00SpoVOzDw';

  //live
  // static const String publishableKey = 'pk_live_51OgfPKRrtkUPPAVwaQ8kAZDN76Wx26PWRoIPM8XyY2VDXlsuNgYmByl9MVIwRnrYnjscpLFuIi9yKf2mS7yIWhUi00TTcczqX2';
  // END POINT URL

  static const String onboarding = '${baseUrl}onboarding';
  static const placesProxy = '${baseUrl}user/autocomplete';
  static const placeDetails = '${baseUrl}user/placeDetails';
  static const mapboxToken = '${baseUrl}maps/geocode';
  static const register = '${baseUrl}user/signup';
  // verify otp
  static const resetPassword = '${baseUrl}user/reset-password';
  static const forgetPassword = '${baseUrl}user/forgot-password';
  static const verifyOtp = '${baseUrl}user/verify-otp';
  static const resendOtp = '${baseUrl}user/resend-forgot-password-otp';
  static const resendOtp1 = '${baseUrl}user/resend-otp';
  static const verifyForgetOtp = '${baseUrl}user/verifyForgotPassword-otp';
  static const login = '${baseUrl}user/login';
  static const Signout = '${baseUrl}user/logout';
  static const delete = '${baseUrl}user';
  static const EditProfile = '${baseUrl}user/profile';
  static const profile = '${baseUrl}user/profile';
  static const profileImg = '${baseUrl}user/profile-picture';
  static const profileImgdelete = '${baseUrl}user/profile-picture-delete';
  static const exportDate = '${baseUrl}user/export-data';

  // marketplace
  static const marketPlace = '${baseUrl}item/all'; // use in marketplace,filter and sort..
  static const wishlist = '${baseUrl}item/saved/add';
  static const wishlistRemove = '${baseUrl}item/saved/remove';
  static const wishlistSave = '${baseUrl}item/saved';
  static const search = '${baseUrl}item/search';
  static const report = '${baseUrl}item/report';

  static const about = '${baseUrl}user/about';

  //items

  static const createSellerListing = '${baseUrl}item/create';
  static const sellerListings = '${baseUrl}item/my/items';
  static const getSellerListing = '${baseUrl}item';

  static const messagesSend = '${baseUrl}user/messages/send';
  static const messagesReply = '${baseUrl}user/messages/reply';
  static const getMessages = '${baseUrl}user/messages';
  static const replayGetMessages = '${baseUrl}user/replies';
  static const String delivaryFeeLocation = "${baseUrl}user/deliveryFee";

  static const createOrder = '${baseUrl}user/orders';
  static const payment = '${baseUrl}user/payment';
  static const paymentCheckoutSession = '${baseUrl}user/payment/checkout-session';
  static const transactionStatus = '${baseUrl}user/transactionStatus';

  static const getUserOrders = '${baseUrl}user/orders/my';
  static const getUserOrdersById = '${baseUrl}user/orders';
  static const getSupportTicketById = '${baseUrl}user/my-tickets/';

  static const notification = '${baseUrl}user/notification';
  static const supportTicket = '${baseUrl}user/ticket';
  static const getAllSupportTicket = '${baseUrl}user/my-tickets';
  // chat to admin
  static const replayTicket = '${baseUrl}user/tickets';

  static const archivedMessages = '${baseUrl}user/messages';
  static const fetchArchivedMessages = '${baseUrl}user/messages/archives';
  static const category = '${baseUrl}user/categories';
  static const transaction = '${baseUrl}user/transactions';
  static const bank = '${baseUrl}user/bank-details';

  // Chats
  static const String getOrCreateChat = "${baseUrl}chat/get-or-create";
  static const String sendChat = "${baseUrl}chat/send";
  static const String chatMessages = "${baseUrl}chat";
  static const String notify = '${baseUrl}user/notifications-enable';
  static const String chatMessagesHistory = "${baseUrl}chat/chatHistory";
  static const String soldItem = '${baseUrl}user/sold';
  static const String getShipdayOrderDetails = '${baseUrl}user/getShipdayOrderDetails';

  // Notifications
  static const String notificationCounts = '${baseUrl}user/notification-counts';
  static const String messageCounts = '${baseUrl}user/messages/counts';
}