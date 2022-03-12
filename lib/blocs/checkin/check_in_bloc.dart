import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vizmotest/repository/api/checkInApi.dart';
import 'package:vizmotest/repository/models/checkInModel.dart';

part 'check_in_event.dart';
part 'check_in_state.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  CheckInApi checkInApi;
  CheckInBloc(this.checkInApi) : super(CheckInInitial()) {
    on<GetAllCheckIns>((event, emit) async {
     await  getAllCheckIns(emit, event.employeeId);

      // TODO: implement event handler
    });

    on<GetCheckInwithCheckInID>((event, emit) async {
      await  getCheckInbyCheckInID(emit, event.employeeId, event.checkInId);

      // TODO: implement event handler
    });
  }
  /// list of all checkins
 late  List<CheckInModel> checkInList ;

  //single checkin
  late CheckInModel checkInModel;

// get all checkins by employee id future
  Future<void> getAllCheckIns(Emitter<CheckInState> emit,int employeeId) async {
    emit (CheckInLoading());
    try{

      checkInList = await  checkInApi.fetchAllCheckInList(employeeId);

      emit(CheckInLoaded());
    } catch(e){
      emit(CheckInError());
    }
  }

  // get all checkins by employee id future
  Future<void> getCheckInbyCheckInID(Emitter<CheckInState> emit,int employeeId,int checkInID) async {
    emit (CheckInLoading());
    try{

    checkInList = await checkInApi.fetchCheckInwithCheckInId(employeeId, checkInID);

      emit(CheckInLoaded());
    } catch(e){
      emit(CheckInError());
    }
  }
}
