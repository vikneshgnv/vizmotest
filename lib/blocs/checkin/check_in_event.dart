part of 'check_in_bloc.dart';

@immutable
abstract class CheckInEvent {}

class GetAllCheckIns extends CheckInEvent{
  int employeeId;
  GetAllCheckIns(this.employeeId);

}

class GetCheckInwithCheckInID extends CheckInEvent{
  int employeeId;
  int checkInId;
  GetCheckInwithCheckInID(this.employeeId,this.checkInId);

}