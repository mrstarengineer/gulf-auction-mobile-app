enum MProfileType { individual, business }

enum MVehicleHasKeys { yes, no }

enum MVehicleDocumentType { vcc, hayaza }

enum MSelectedView { list, grid }

enum MSortOptions { priceLowToHigh, priceHighToLow, none }

enum MVehicleType { buyNow, auction }

enum MVehicleDetailsSelectedOptions { bidInfo, vehicleInfo, salesInfo }

enum MyCarDetailsSelectedOptions { vehicleInfo, auctionInfo, counterOffer }

enum MAccountOptions { myProfile, myDocuments, watchList }

enum MBidStatusOptions { preBid, vehiclesWon, vehiclesLoss, vehiclesOnApproval }

extension MBidStatusOptionsExtension on MBidStatusOptions {
  String get value =>
      const {
        MBidStatusOptions.preBid: 'My Prebids',
        MBidStatusOptions.vehiclesWon: 'Vehicles Won',
        MBidStatusOptions.vehiclesLoss: 'Vehicles Lost',
        MBidStatusOptions.vehiclesOnApproval: 'Vehicle On Approval',
      }[this] ??
      '';
}

enum MAuctionsOptions { todaysAuction, joinAuction, auctionCalender }

enum MSellMyCarOptions {
  pendingVehicle,
  documentStatus,
  inStock,
  inAuction,
  soldVehicle,
  unsoldVehicle,
  sellingApprovalVehicle,
  returnVehicle,
  rejectedVehicle,
  allVehicle,
}

MSellMyCarOptions getMSellMyCarOptions(int value) {
  switch (value) {
    case 0:
      return MSellMyCarOptions.pendingVehicle;
    case 26:
      return MSellMyCarOptions.documentStatus;
    case 1:
      return MSellMyCarOptions.inStock;

    case 5:
      return MSellMyCarOptions.inAuction;

    case 15:
      return MSellMyCarOptions.soldVehicle;

    case 17:
      return MSellMyCarOptions.unsoldVehicle;

    case 12:
      return MSellMyCarOptions.sellingApprovalVehicle;

    case 40:
      return MSellMyCarOptions.returnVehicle;

    default:
      return MSellMyCarOptions.allVehicle;
  }
}

enum MPaymentOptions {
  paymentDue,
  myAccount,
  paymentHistory,
  depositAccount,
  onlineAccount,
  bookedVehicleDue,
  bookedPaymentHistory
}

enum MMoreOptions { downloads, career, contact }

enum MFilterOptions {
  newlyAddedVehicles,
  odometer,
  startBidAmount,
  year,
  saleDate,
  fuelTypes,
  driveTrains,
  cylinders,
  bodyStyles,
  transmissions,
  makes,
  models,
  engineTypes,
  colors,
}

extension MFilterOptionsExtension on MFilterOptions {
  String get value =>
      const {
        MFilterOptions.newlyAddedVehicles: 'Newly Added Vehicles',
        MFilterOptions.odometer: 'Odometer',
        MFilterOptions.startBidAmount: 'Price Range',
        MFilterOptions.year: 'Year',
        MFilterOptions.saleDate: 'Sale Date',
        MFilterOptions.fuelTypes: 'Fuel Types',
        MFilterOptions.driveTrains: 'Drive Trains',
        MFilterOptions.cylinders: 'Cylinders',
        MFilterOptions.bodyStyles: 'Body Styles',
        MFilterOptions.transmissions: 'Transmissions',
        MFilterOptions.makes: 'Makes',
        MFilterOptions.models: 'Models',
        MFilterOptions.engineTypes: 'Engine Types',
        MFilterOptions.colors: 'Colors',
      }[this] ??
      '';
}
