import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_guard/app/constants/preferences.dart';
import 'package:storage_guard/core/funcs.dart';
import 'package:storage_guard/features/operation/data/operation_repositories.dart';
import 'package:storage_guard/features/operation/sensor_model.dart';

part 'send_records_state.dart';

class SendRecordsCubit extends Cubit<SendRecordState> {
  final OperationRepositories _operationRepositories;
  final SharedPreferences _preferences;
  SendRecordsCubit(this._operationRepositories, this._preferences)
      : super(SendRecordInitial());

  Future<void> sendSensorRecordings(
      List<Map<String, dynamic>> sensorData,int operationId) async {
    print(sensorData);
    emit(LoadingState());
    final either =
        await _operationRepositories.sendSensorRecordings(sensorData,operationId);
    either.fold((error) async {
      print("CUBIT ERROR$error");
      saveSensorReading(false, sensorData[0]);
      final errorMessage = getErrorMessage(error);
      emit(ErrorState(errorMessage));
    }, (data) {
      print("CUBIT DATA");
      saveSensorReading(true, sensorData[0]);
      emit(SentRecordsState());
    });
  }

  Future<void> saveSensorReading(
      bool wasSent, Map<String, dynamic> sensorData) async {
    //Getting SensorModel list saved in memory
    List<SensorModel> sensorList = getSensorReadingsFromMemory();
    //Test printing sript///
    List<String> wasSentListwithIndex = [];
    for (SensorModel sensorModel in sensorList) {
      wasSentListwithIndex.add("${sensorModel.wasSent}");
    }
    print('SensorListFromMemory$wasSentListwithIndex');/////
    //Adding the sensorData to sensorList
    SensorModel model = sensorModelFromBasicJson(sensorData, wasSent);
    sensorList.add(model);
    //Restoring sensorList to memory
    String jsonSensorModelList = sensorModelListToJson(sensorList);
    _preferences.setString(Preferences.sensorReadingsKey, jsonSensorModelList);
  }

  List<SensorModel> getSensorReadingsFromMemory() => sensorModelListFromJson(
      _preferences.getString(Preferences.sensorReadingsKey));
}
