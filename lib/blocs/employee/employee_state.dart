part of 'employee_bloc.dart';

@immutable
abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}
class EmployeeLoading extends EmployeeState {}
class EmployeeLoaded extends EmployeeState {}
class EmployeeError extends EmployeeState {}