import 'package:get/get.dart';
import '../../modules/account/account.dart';
import '../../modules/auctions/pages/auction_bid_live/auction_bid.dart';
import '../../modules/auctions/pages/auction_calender/auction_calender.dart';
import '../../modules/auctions/pages/auctions_list/auctions_list.dart';
import '../../modules/auth/auth.dart';
import '../../modules/bids/bids_view/bids_view.dart';
import '../../modules/career/career.dart';
import '../../modules/contact/contact.dart';
import '../../modules/dashboard/dashboard.dart';
import '../../modules/downloads/downloads.dart';
import '../../modules/file_preview/files_preview.dart';
import '../../modules/notification/notification.dart';
import '../../modules/payment/pages/deposit_account/deposit_accounts.dart';
import '../../modules/payment/pages/payment_due/payment_due.dart';
import '../../modules/payment/payment.dart';
import '../../modules/profile/profile.dart';
import '../../modules/sell_my_car/sell_my_car.dart';
import '../../modules/splash/splash.dart';
import '../../modules/vehicle/pages/add_vehicle/add_vehicle.dart';
import '../../modules/vehicle/pages/all_vehicles/all_vehicles.dart';
import '../../modules/vehicle/pages/filter_vehicle/filter_vehicle.dart';
import '../../modules/vehicle/pages/vehicle_details/vehicle_details.dart';
import '../../modules/vehicle/pages/watched_vehicles/watched_vehicles.dart';
import '../../modules/web_preview/web_preview.dart';

part '../app_routes/app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBindings(),
    ),

    //  AUTH
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInPage(),
      binding: SignInBindings(),
    ),
    GetPage(
        name: AppRoutes.signUp,
        page: () => const SignUpPage(),
        binding: SignUpBindings(),
        children: [
          GetPage(
            name: AppRoutes.signUpStepper,
            page: () => const SignUpStepperPage(),
            binding: SignUpBindings(),
          ),
        ]),

    // BOTTOM NAV
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBindings(),
    ),

    // VEHICLE
    GetPage(
      name: AppRoutes.allVehicle,
      page: () => const AllVehiclesPage(),
      binding: AllVehiclesBindings(),
    ),
    GetPage(
      name: AppRoutes.filterVehicles,
      page: () => const FilterVehiclePage(),
      binding: AllVehiclesBindings(),
    ),
    GetPage(
      name: AppRoutes.vehicleDetails,
      page: () => const VehicleDetailsPage(),
      binding: VehicleDetailsBindings(),
    ),
    GetPage(
      name: AppRoutes.watchedVehicle,
      page: () => const WatchedVehiclesPage(),
      binding: WatchedVehiclesBindings(),
    ),
    GetPage(
      name: AppRoutes.addVehicle,
      page: () => const AddVehiclePage(),
      binding: AddVehicleBindings(),
    ),

    //   ACCOUNT
    GetPage(
      name: AppRoutes.myDocuments,
      page: () => const MyDocumentsPage(),
      binding: MyDocumentsBindings(),
    ),

    GetPage(
      name: AppRoutes.filesPreview,
      page: () => const FilesPreviewPage(),
    ),
    GetPage(
      name: AppRoutes.websPreview,
      page: () => const WebPreviewPage(),
    ),

    //   AUCTIONS
    GetPage(
      name: AppRoutes.auctionBidLive,
      page: () => const AuctionBidLivePage(),
      binding: AuctionBidLiveBindings(),
    ),
    GetPage(
      name: AppRoutes.auctionCalender,
      page: () => const AuctionCalenderPage(),
      binding: AuctionCalenderBindings(),
    ),
    GetPage(
      name: AppRoutes.auctionList,
      page: () => const AuctionsListPage(),
      binding: AuctionsListBindings(),
    ),

    //   BIDS
    GetPage(
      name: AppRoutes.bidsView,
      page: () => const BidsViewPage(),
      binding: BidsViewBindings(),
      children: [
        GetPage(
          name: AppRoutes.bidsDetails,
          page: () => const BidsDetailsPage(),
        ),
      ],
    ),

    //   SELL MY CAR
    GetPage(
      name: AppRoutes.myCars,
      page: () => const SellMyCarPage(),
      binding: SellMyCarBindings(),
      children: [
        GetPage(
          name: AppRoutes.carDetails,
          page: () => const CarDetailsPage(),
          binding: SellMyCarBindings(),
        ),
      ],
    ),

    //   PROFILE
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBindings(),
    ),

    //   ACCOUNTS
    GetPage(
      name: AppRoutes.accounts,
      page: () => const AccountsPage(),
      binding: MyAccountBindings(),
    ),
    GetPage(
      name: AppRoutes.paymentDue,
      page: () => const PaymentDuePage(),
      binding: PaymentDueBindings(),
    ),
    GetPage(
      name: AppRoutes.depositPayment,
      page: () => const DepositAccountPage(),
      binding: DepositAccountBindings(),
    ),

    //   DOWNLOADS AND CAREER
    GetPage(
      name: AppRoutes.downloads,
      page: () => const DownloadsPage(),
      binding: DownloadsBindings(),
    ),

    GetPage(
      name: AppRoutes.career,
      page: () => const CareerPage(),
      binding: CareerBindings(),
      children: [
        GetPage(
          name: AppRoutes.careerDetails,
          page: () => const CareerDetailsPage(),
          binding: CareerBindings(),
        )
      ],
    ),
    GetPage(
      name: AppRoutes.contact,
      page: () => const ContactPage(),
      binding: ContactBindings(),
    ),

    // NOTIFICATION
    GetPage(
      name: AppRoutes.notification,
      page: () => const NotificationPage(),
      binding: NotificationBindings(),
    )
  ];
}
