part of 'employee_bloc.dart';

@immutable
abstract class EmployeeEvent {}


//get all employees event
class GetEmployees extends EmployeeEvent{
  
}

//get empoyees by pagination
class GetEmployeesByPage extends EmployeeEvent{
  int pageNum,limit;

  GetEmployeesByPage(this.pageNum,this.limit);
}

//sort employees
class SortEmployees extends EmployeeEvent {
  String sortBy, order;

  SortEmployees(this.sortBy,this.order);

}

//search employees by name
class SearchEmployeesByName extends EmployeeEvent {
  String name;

  SearchEmployeesByName(this.name);

}

//filter employees by name
class FilterEmployeesByName extends EmployeeEvent {
  String name;

  FilterEmployeesByName(this.name);

}

//filter employees by name & country
class FilterEmployeesByNameandCountry extends EmployeeEvent {
  String name,country;

  FilterEmployeesByNameandCountry({required this.country,required this.name});

}
