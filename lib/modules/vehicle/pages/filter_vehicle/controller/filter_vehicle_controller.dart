import 'package:get/get.dart';
import 'package:gulf_car_auction/modules/vehicle/pages/filter_vehicle/filter_vehicle.dart';

class FilterVehicleController extends GetxController {

  FilterVehicleController({required FilterVehicleRepository repo});

  final _selectedIndex = 0.obs;

  get selectedIndex => _selectedIndex.value;

  set selectedIndex (value) => _selectedIndex.value = value;

  updateSelectedIndex (value) => selectedIndex = value;


  final _newlyAddedVehicle = ''.obs;

  get newlyAddedVehicle => _newlyAddedVehicle.value;

  set newlyAddedVehicle (value) => _newlyAddedVehicle.value = value;

  final _odometer = ''.obs;

  get odometer => _odometer.value;

  set odometer (value) => _odometer.value = value;

  final _startBidAmount = ''.obs;

  get startBidAmount => _startBidAmount.value;

  set startBidAmount (value) => _startBidAmount.value = value;

  final _year = ''.obs;

  get year => _year.value;

  set year (value) => _year.value = value;

  final _saleDate = ''.obs;

  get saleDate => _saleDate.value;

  set saleDate (value) => _saleDate.value = value;

  RxList fuelTypes = [].obs;
  RxList driveTrains = [].obs;
  RxList cylinders = [].obs;
  RxList bodyStyles = [].obs;
  RxList transmissions = [].obs;
  RxList makes = [].obs;
  RxList models = [].obs;
  RxList engineTypes = [].obs;
  RxList colors = [].obs;

  clearAllFilters (){
    updateSelectedIndex(0);
    newlyAddedVehicle = '';
    odometer = '';
    startBidAmount = '';
    year = '';
    saleDate = '';
    fuelTypes.clear();
    driveTrains.clear();
    cylinders.clear();
    bodyStyles.clear();
    transmissions.clear();
    makes.clear();
    models.clear();
    engineTypes.clear();
    colors.clear();
  }

  String get searchParams => 'newly_added_vehicle=$newlyAddedVehicle&odometer=$odometer&start_bid_amount=$startBidAmount&year=$year&sale_date=$saleDate&fuel_type_ids=${fuelTypes.join(',')}&drive_train_ids=${driveTrains.join(',')}&cylinder_ids=${cylinders.join(',')}&transmission_ids=${transmissions.join(',')}&make_ids=${makes.join(',')}&model_ids=${models.join(',')}&engine_type_ids=${engineTypes.join(',')}&color_ids=${colors.join(',')}';

}