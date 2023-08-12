import 'package:get/get.dart';
import 'package:storage_guard_dashboard/models/operation.dart';
import '../models/pie_data.dart';
import '../models/sensor_data.dart';
import '../services/operation_services.dart';

class HomePageController extends GetxController {
  @override
  onInit() async {
    super.onInit();
    await getALLOperations();
  }

  int numberOfOperation = 0;
  bool allSafe = true;

  List<OperationData> finishedoperationsList = [];
  List<OperationData> notfinishedoperationsList = [];
  List<OperationData> operationsList = [];
  List<int> operationsID = [];
  Future<void> getALLOperations() async {
    operationsList = await OperationService.getOperations();
    numberOfOperation = operationsList.length;
    allSafe = operationsList.every((element) => element.safetyStatus == 1);

    getNumberOfPackages();
    getNumberOfReadings();
    splitOperation(operationsList);

    update();
  }

  void splitOperation(List<OperationData> list) {
    for (var element in list) {
      element.finishedAt == null
          ? notfinishedoperationsList.add(element)
          : finishedoperationsList.add(element);
    }
 Get.snackbar("not finished", finishedoperationsList.length.toString());
    
  }

  List<SensorData> sensorReadings = [];
  Future<void> getAllSensorData(int id) async {
    sensorReadings = await OperationService.getSensorReadings(id);
    update();
  }

  List<PieData> productsCountList = [];
  getNumberOfPackages() {
    for (var element in operationsList) {
      productsCountList
          .add(PieData(element.name, element.productsCount as double));
    }
  }

  List<PieData> readingsCountList = [];
  getNumberOfReadings() {
    for (var element in operationsList) {
      readingsCountList
          .add(PieData(element.name, element.readingsCount as double));
    }
  }
}
