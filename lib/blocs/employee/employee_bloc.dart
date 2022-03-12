import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vizmotest/repository/api/employeeApi.dart';
import 'package:vizmotest/repository/models/employeeModel.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
 //employee api
 EmployeeApi employeeApi;

  //employee list
 late  List<EmployeeModel> employeeModel;

  EmployeeBloc( this.employeeApi) : super(EmployeeInitial()) {
    on<GetEmployees>((event, emit) async {
      await getAllEmployees(emit);
      // TODO: implement event handler
    });

    on<GetEmployeesByPage>((event,emit) async {
      await getAllEmployeesByPage(emit, event.pageNum, event.limit);
    });
    on<SortEmployees>((event,emit) async {
      await sortAllEmployees(emit, event.sortBy, event.order);
    });

    on<SearchEmployeesByName>((event,emit) async {
      await searchEmployeesByName(emit, event.name);
    });

    on<FilterEmployeesByName>((event,emit) async {
      await filterEmployeesByName(emit, event.name);
    });

    on<FilterEmployeesByNameandCountry>((event,emit) async {
      await filterEmployeesByNameandCountry(emit, event.name,event.country);
    });

  }




// get all employees future
  Future<void> getAllEmployees(Emitter<EmployeeState> emit) async {
    emit (EmployeeLoading());
    try{
      employeeModel = await employeeApi.fetchEmployeeList();

      emit(EmployeeLoaded());
    } catch(e){
emit(EmployeeError());
    }
  }


  //get employees by page future
 Future<void> getAllEmployeesByPage(Emitter<EmployeeState> emit,int pageNum,int limit) async {
   emit (EmployeeLoading());
   try{
     employeeModel = await employeeApi.fetchEmployeeListByPagination(pageNum, limit);

     emit(EmployeeLoaded());
   } catch(e){
     emit(EmployeeError());
   }
 }


 //sort employees future
  Future<void> sortAllEmployees(Emitter<EmployeeState> emit,String sortBy,String order) async {
    emit (EmployeeLoading());
    try{
      employeeModel = await employeeApi.sortEmployeeList(sortBy, order);

      emit(EmployeeLoaded());
    } catch(e){
      emit(EmployeeError());
    }
  }

  //search employee by name future
  Future<void> searchEmployeesByName(Emitter<EmployeeState> emit,String name) async {
    emit (EmployeeLoading());
    try{
      employeeModel = await employeeApi.searchEmployeeListByName(name);

      emit(EmployeeLoaded());
    } catch(e){
      emit(EmployeeError());
    }
  }

  //filter employee by name future
  Future<void> filterEmployeesByName(Emitter<EmployeeState> emit,String name) async {
    emit (EmployeeLoading());
    try{
      employeeModel = await employeeApi.filterEmployeeListByName(name);

      emit(EmployeeLoaded());
    } catch(e){
      emit(EmployeeError());
    }
  }

  //filter employee by name & country future
  Future<void> filterEmployeesByNameandCountry(Emitter<EmployeeState> emit,String name,String country) async {
    emit (EmployeeLoading());
    try{
      employeeModel = await employeeApi.filterEmployeeListByNameandCountry(country, name);

      emit(EmployeeLoaded());
    } catch(e){
      emit(EmployeeError());
    }
  }

}
