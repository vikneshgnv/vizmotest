part of 'check_in_bloc.dart';

@immutable
abstract class CheckInState {}

class CheckInInitial extends CheckInState {}
class CheckInLoading extends CheckInState {}
class CheckInLoaded extends CheckInState {}
class CheckInError extends CheckInState {}
