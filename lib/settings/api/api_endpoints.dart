class ApiEndpoints {
  ApiEndpoints._();

  // AUTH
  static const String signIn = '/auth/member-login';
  static const String forgetPassword = '/auth/forget-password';
  static const String memberRegistration = '/auth/member-registration';
  static const String verifyOTP = '/auth/member-verify-otp';
  static const String createPassword = '/auth/member-create-password';

  // USER
  static const String me = '/auth/me';
  static const String changePass = '/users/change-password';
  static const String uploadProfilePhoto = '/users/upload-profile-photo';

  //Delete Account
  static const String accountDeletion = '/members/delete-account';

  // SEARCH
  static const String activeCountries = '/search/active-countries';
  static String vehicleStaticDataOptions =
      '/search/vehicle-static-data-options';
  static String searchMake = '/search/makes';

  static String searchModel({String? makeId}) =>
      '/search/vehicle-models?make_id=${makeId ?? ''}';
  static String searchVehicleCategory = '/search/vehicle-category';

  // MEMBER
  static const String uploadDocument = '/members/upload-document';
  static const String documents = '/members/documents';
  static const String storeDocument = '/members/store-document';
  static const String memberDashboard = '/member-dashboard';

  // AUCTION
  static const String upcomingAuction = '/upcoming-auctions';

  static String auctionVehicles(
          {int? auctionVehicleType = 1,
          String limit = '6',
          String page = '1',
          String? searchParams}) =>
      '/lot/in-auction-vehicles?auction_vehicle_type=$auctionVehicleType&limit=$limit&page=$page&$searchParams';
  static String auctionDashboard = '/auction-dashboard';

  static String upcomingVehicles({int? auctionId}) =>
      '/auctions/${auctionId ?? ''}/upcoming-vehicles';

  static String joinAuction({int? id}) => '/auctions/${id ?? ''}/join';

  static String auctionCalender() => '/auctions/calendar';

  // BUY NOW
  static String allBuyNowVehicles(
          {String limit = '10', String page = '1', String? searchParams}) =>
      '/lot/buy-now-vehicles?limit=$limit&page=$page&${searchParams ?? ''}';

  static String searchVehicle(
          {String limit = '10', String page = '1', String? searchParams}) =>
      '/lot/search/vehicles?limit=$limit&page=$page&${searchParams ?? ''}';

  static String filterVehicle() => '/lot/search/filter';

  // UI
  static const String heroBanner = '/hero-banners';

  // VEHICLE
  static String lotDetails({required String lotNo}) => '/lot-details/$lotNo';

  static String offlineBidByVehicle({required String vehicleId}) =>
      '/lot/$vehicleId/offline-bid';

  static String buyNowVehicle({required String vehicleId}) =>
      '/vehicles/$vehicleId/buy-now';

  static String vehicleWatch({int? vehicleId}) =>
      '/vehicles/${vehicleId ?? 0}/toggle-watch';

  static String watchedVehicles({String limit = '10', String page = '1'}) =>
      '/vehicles/watched-vehicles?limit=$limit&page=$page';

  static String memberAuctionVehicle(
          {String limit = '10', String page = '1', String? searchParams}) =>
      '/member-vehicles/auction?limit=$limit&page=$page&${searchParams ?? ''}';

  static String memberInStockVehicle(
          {String limit = '10', String page = '1', String? searchParams}) =>
      '/member-vehicles/inventory?limit=$limit&page=$page&${searchParams ?? ''}';

  static String memberAllVehicle(
          {String limit = '10', String page = '1', String? searchParams}) =>
      '/member-vehicles?limit=$limit&page=$page&${searchParams ?? ''}';

  static String memberPendingVehicle(
          {String limit = '10', String page = '1', String? searchParams}) =>
      '/seller-cars/pending-vehicles?limit=$limit&page=$page&${searchParams ?? ''}';

  static String documentPending(
          {String limit = '10', String page = '1', String? searchParams}) =>
      '/seller-cars/document-status?limit=$limit&page=$page&${searchParams ?? ''}';

  static String memberSellingApprovalVehicle(
          {String limit = '10', String page = '1', String? searchParams}) =>
      '/member-vehicles/selling-on-approval?limit=$limit&page=$page&${searchParams ?? ''}';

  static String memberReturnedVehicle(
          {String limit = '10', String page = '1', String? searchParams}) =>
      '/member-vehicles/returned?limit=$limit&page=$page&${searchParams ?? ''}';

  static String memberSoldVehicle(
          {String limit = '10', String page = '1', String? searchParams}) =>
      '/member-vehicles/sold?limit=$limit&page=$page&${searchParams ?? ''}';

  static String memberUnsoldVehicle(
          {String limit = '10', String page = '1', String? searchParams}) =>
      '/member-vehicles/unsold?limit=$limit&page=$page&${searchParams ?? ''}';

  static String memberRejectedVehicle(
          {String limit = '10', String page = '1', String? searchParams}) =>
      '/member-vehicles/rejected?limit=$limit&page=$page&${searchParams ?? ''}';

  static String memberSingleVehicle({int? vehicleId}) =>
      '/member-vehicles/$vehicleId';

  static String counterOffer({int? vehicleId}) =>
      '/vehicles/$vehicleId/change-member-status';
  static String createVehicle = '/member-vehicles';
  static String vehiclePhotoUpload = '/vehicles-photo-upload';
  static String vehicleDocUpload = '/vehicles-document-upload';

  // PUSHER
  static String pusherAuth = '/broadcasting/auth';

  static String newBid({int? id}) => '/auctions/${id ?? ''}/new-bid';

  // BIDS
  static String myBid(
          {String limit = '10', String page = '1', String searchParam = ''}) =>
      '/auctions/my-bids?limit=$limit&page=$page&$searchParam';

  static String lotsWon(
          {String limit = '10', String page = '1', String searchParam = ''}) =>
      '/auctions/vehicles-won?limit=$limit&page=$page&$searchParam';

  static String lotsLoss(
          {String limit = '10', String page = '1', String searchParam = ''}) =>
      '/auctions/vehicles-lost?limit=$limit&page=$page&$searchParam';

  static String vehiclesOnApproval(
          {String limit = '10', String page = '1', String searchParam = ''}) =>
      '/member-vehicles/buying-on-approval?limit=$limit&page=$page&$searchParam';

  // AUTO FILL
  static String autoFillByVin = '/vehicles/auto-fill-by-vin';

  //  PAYMENT
  static String paymentReceiptsList(
          {String? type,
          String limit = '10',
          String page = '1',
          String? searchParams}) =>
      '/payment-receipts?type=${type ?? ''}&limit=$limit&page=$page&${searchParams ?? ''}';

  static String pendingInvoiceList(
          {String limit = '10', String page = '1', String? searchParams}) =>
      '/pending-invoices?limit=$limit&page=$page&${searchParams ?? ''}';

  static String paymentHistoryList(
          {String limit = '10', String page = '1', String? searchParams}) =>
      '/payment-history?limit=$limit&page=$page&${searchParams ?? ''}';

  static String balanceSummary({String? type}) =>
      '/balance-summary?type=${type ?? ''}';
  static String paymentReceipt = '/payment-receipts';
  static String uploadReceipt = '/payment-receipts/upload-attachment';

  //  PUBLIC
  static String publicDownloads = '/public-downloads';

  static String publicJobs({String? jobId}) =>
      '/public-job-posts/${jobId ?? ''}';
  static String publicJobsUploadAttachment =
      '/public-job-posts/upload-attachment';
  static String publicJobPostApply = '/public-job-posts/apply';

  // NOTIFICATION
  static String notifications(
          {String limit = '10', String page = '1', bool? unreadyOnly}) =>
      '/notifications?limit=$limit&page=$page&unread_only=${unreadyOnly ?? ''}';

  static String notificationMarkAsRead({String? notificationId}) =>
      '/notifications/$notificationId/mark-as-read';
  static String notificationMarkAllAsRead = '/notifications/mark-all-as-read';
  static String termsAndConditions = '/page-frame/TERMS_AND_CONDITIONS';
  static String privacyPolicy = '/page-frame/PRIVACY_POLICY';
}
