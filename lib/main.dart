import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vizmotest/blocs/checkin/check_in_bloc.dart';
import 'package:vizmotest/blocs/employee/employee_bloc.dart';
import 'package:vizmotest/repository/api/checkInApi.dart';
import 'package:vizmotest/repository/api/employeeApi.dart';
import 'package:vizmotest/ui/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  //employee api
  EmployeeApi _employeeApi = EmployeeApi();
  CheckInApi _checkInApi = CheckInApi();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmployeeBloc(_employeeApi),
        ),
        BlocProvider(
          create: (context) => CheckInBloc(_checkInApi),
        ),
      ],
      child: MaterialApp(
        title: 'Vizmo Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

