part of 'send_records_cubit.dart';

abstract class SendRecordState {
  const SendRecordState();
}

class SendRecordInitial extends SendRecordState {}

class LoadingState extends SendRecordState {}

class SentRecordsState extends SendRecordState {
  // final UserModel user;

  // SentRecordsState(this.user);
  SentRecordsState();
}

class ErrorState extends SendRecordState {
  final String message;

  ErrorState(this.message);
}
