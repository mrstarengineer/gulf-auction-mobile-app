part of '../app_pages/app_pages.dart';

class AppRoutes {
  AppRoutes._();

  static const splash = '/';

  //   AUTH
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const signUpStepper = '/sign-up-stepper';

  // BOTTOM NAV
  static const dashboard = '/dashboard';

  // VEHICLE
  static const vehicleDetails = '/vehicle-details';
  static const allVehicle = '/all-vehicle';
  static const filterVehicles = '/filter-vehicle';
  static const watchedVehicle = '/watched-vehicle';
  static const addVehicle = '/add-vehicle';

  // AUCTIONS
  static const auctionBidLive = '/auction-bid-live';
  static const auctionCalender = '/auction-calender';
  static const auctionList = '/auction-list';

  // ACCOUNT
  static const myDocuments = '/my-documents';
  static const filesPreview = '/document-preview';
  static const websPreview = '/web-preview';

  // BIDS
  static const bidsView = '/bids-views';
  static const bidsDetails= '/bids-details';

  // SELL MY CARS
  static const myCars = '/my-cars';
  static const carDetails = '/car-details';

  // PROFILE
  static const profile = '/profile';

  // PAYMENT
  static const accounts = '/accounts';
  static const paymentDue = '/payment-payment_due';
  static const depositPayment = '/payment-deposit';

  // DOWNLOADS AND CAREER
  static const downloads = '/downloads';
  static const career = '/career';
  static const contact = '/contact';
  static const careerDetails = '/career_details';

  // NOTIFICATION
  static const notification = '/notification';
}
