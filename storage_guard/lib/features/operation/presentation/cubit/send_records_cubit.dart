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

  Future<void> sendSensorRecordings(Map<String, dynamic> sensorData) async {
    print(sensorData);
    emit(LoadingState());
    final either =
        await _operationRepositories.sendSensorRecordings(sensorData);
    either.fold((error) async {
      SensorModel model = sensorModelFromJson(sensorData, false);
      _preferences.setString(
          Preferences.sensorReadingsKey, sensorModelToJson(model).toString());
      final errorMessage = getErrorMessage(error);
      emit(ErrorState(errorMessage));
    }, (data) {
      SensorModel model = sensorModelFromJson(sensorData, true);
      _preferences.setString(
          Preferences.sensorReadingsKey, sensorModelToJson(model).toString());
      emit(SentRecordsState());
    });
  }
}
//  {
//         "readings": [
//           {
//             "temperature": temperature,
//             "humidity": humidity,
//             "read_at": timeStamp
//           }
//         ]
//       };