import '../../settings/enums/enums.dart';

enum VehicleDetailType {
  vin,
  title,
  reservedPrice,
  reservedAmount,
  docApproved,
  docReceived,
  counterOffer,
  runs,
  price,
  auction,
  sequence,
  soldPrice,
  soldDate,
  maxBid,
  statusName,
}

class VehicleDisplayHelper {
  static List<VehicleDetailType> getDetailsForPageType(
      MSellMyCarOptions pageType) {
    switch (pageType) {
      case MSellMyCarOptions.pendingVehicle:
        return [
          VehicleDetailType.vin,
          VehicleDetailType.title,
          VehicleDetailType.reservedPrice,
          VehicleDetailType.counterOffer,
          VehicleDetailType.docApproved,
        ];
      case MSellMyCarOptions.documentStatus:
        return [
          VehicleDetailType.vin,
          VehicleDetailType.title,
          VehicleDetailType.reservedPrice,
          VehicleDetailType.docReceived,
        ];
      case MSellMyCarOptions.inStock:
        return [
          VehicleDetailType.vin,
          VehicleDetailType.title,
          VehicleDetailType.docReceived,
          VehicleDetailType.runs,
          VehicleDetailType.price,
        ];
      case MSellMyCarOptions.inAuction:
        return [
          VehicleDetailType.vin,
          VehicleDetailType.title,
          VehicleDetailType.auction,
          VehicleDetailType.sequence,
          VehicleDetailType.reservedPrice
        ];
      case MSellMyCarOptions.soldVehicle:
        return [
          VehicleDetailType.vin,
          VehicleDetailType.title,
          VehicleDetailType.soldPrice,
          VehicleDetailType.soldDate
        ];
      case MSellMyCarOptions.unsoldVehicle:
        return [
          VehicleDetailType.vin,
          VehicleDetailType.title,
          VehicleDetailType.runs,
          VehicleDetailType.reservedPrice,
          VehicleDetailType.maxBid,
        ];
      case MSellMyCarOptions.sellingApprovalVehicle:
        return [
          VehicleDetailType.vin,
          VehicleDetailType.title,
          VehicleDetailType.runs,
          VehicleDetailType.reservedAmount,
          VehicleDetailType.maxBid,
        ];
      case MSellMyCarOptions.returnVehicle:
        return [
          VehicleDetailType.vin,
          VehicleDetailType.title,
          VehicleDetailType.statusName,
          VehicleDetailType.runs,
        ];
      case MSellMyCarOptions.rejectedVehicle:
        return [
          VehicleDetailType.vin,
          VehicleDetailType.title,
          VehicleDetailType.statusName,
          VehicleDetailType.runs,
        ];
      case MSellMyCarOptions.allVehicle:
        return [
          VehicleDetailType.vin,
          VehicleDetailType.title,
          VehicleDetailType.statusName,
          VehicleDetailType.runs,
        ];
    }
  }
}
